package com.dalbit.security.filter;

import com.dalbit.security.service.InforexAdminLoginService;
import com.dalbit.security.service.UserDetailsServiceImpl;
import com.dalbit.security.vo.InforexLoginLayoutVo;
import com.dalbit.security.vo.SecurityUserVo;
import com.dalbit.util.AES;
import com.dalbit.util.CookieUtil;
import com.dalbit.util.DalbitUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContext;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Component;

import javax.servlet.*;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@Component
public class SsoAuthenticationFilter implements Filter {

    @Autowired
    UserDetailsServiceImpl userDetailsService;

    @Autowired
    InforexAdminLoginService inforexAdminLoginService;

    @Value("${dalbit.cookie.name}")
    private String KEY_NAME;
    private final String[] IGNORE_URLS = {"/login", "/logout", "/template", "/css", "/js", "/socket/dbCheck/bySocket"};

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {

    }

    @Override
    public void doFilter(ServletRequest servletRequest, ServletResponse servletResponse, FilterChain filterChain) throws IOException, ServletException {
        HttpServletRequest request = (HttpServletRequest) servletRequest;

        if(!isIgnore(request)) {
            Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
            if (authentication == null) {
                CookieUtil cookieUtil = new CookieUtil(request);

                if (cookieUtil.exists(KEY_NAME)) {
                    String dalbitCookie = cookieUtil.getValue(KEY_NAME);
                    String cookieValue = AES.decrypt(dalbitCookie, DalbitUtil.getProperty("aes.crypto.key"));

                    // Inquiry member information
                    UserDetails userDetails = userDetailsService.loadUserByUsername(cookieValue);
                    if (userDetails != null) {
                        SecurityUserVo securityUserVo = (SecurityUserVo) userDetails;

                        // Verify SSO token value
                        String[] cookieValues = cookieValue.split(DalbitUtil.getProperty("dalbit.cookie.seperate"));

                        InforexLoginLayoutVo inforexLoginLayoutVo = inforexAdminLoginService.cookieLogin(cookieValues[0], cookieValues[1]);

                        Authentication auth = new UsernamePasswordAuthenticationToken(
                                inforexLoginLayoutVo
                                , inforexLoginLayoutVo.getUserInfo().getUserid()
                                , securityUserVo.getAuthorities());

                        SecurityContext securityContext = SecurityContextHolder.getContext();
                        securityContext.setAuthentication(auth);

                        HttpSession session = request.getSession(true);
                        session.setAttribute("SPRING_SECURITY_CONTEXT", securityContext);

                        // SSO Cookie update
                        Cookie ssoCookie = CookieUtil.createCookie(KEY_NAME, cookieUtil.getValue(KEY_NAME),"/", 31536000); // 60 * 60 * 24 * 365 = 1 year

                        HttpServletResponse response = (HttpServletResponse)servletResponse;
                        response.addCookie(ssoCookie);
                    }
                }
            }
        }
        filterChain.doFilter(servletRequest, servletResponse);
    }

    @Override
    public void destroy() {

    }

    private boolean isIgnore(HttpServletRequest request) {
        /*if(request.getSession().getAttribute("logout") != null) {
            request.getSession().removeAttribute("logout");
            return true;
        }*/

        String uri = request.getRequestURI();

        boolean result = false;
        for(String ignoreUri : IGNORE_URLS) {
            if(uri.startsWith(ignoreUri)) {
                result = true;
                break;
            }
        }

        return result;
    }
}
