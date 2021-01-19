package com.dalbit.security.handler;

import com.dalbit.common.code.Status;
import com.dalbit.common.vo.JsonOutputVo;
import com.dalbit.security.vo.InforexLoginLayoutVo;
import com.dalbit.util.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.web.authentication.SimpleUrlAuthenticationSuccessHandler;
import org.springframework.stereotype.Component;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.HashMap;

@Component("authSuccessHandler")
public class AuthenticationSuccessHandler extends SimpleUrlAuthenticationSuccessHandler {

    @Autowired GsonUtil gsonUtil;

    /**
     * 로그인 성공 시
     * @param request
     * @param response
     * @param authentication
     * @throws ServletException
     * @throws IOException
     */
    public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response, Authentication authentication) throws ServletException, IOException {

        HashMap map = new HashMap();
        map.put("returnUrl", "index.html");

        String memId = request.getParameter("memId");
        String memPwd = request.getParameter("memPwd");

        String encCookieValue = AES.encrypt(memId+DalbitUtil.getProperty("dalbit.cookie.seperate")+memPwd, DalbitUtil.getProperty("aes.crypto.key"));

        //cookie 생성
        response.addCookie(CookieUtil.createCookie(DalbitUtil.getProperty("dalbit.cookie.name"), encCookieValue, "/", 31536000));

        InforexLoginLayoutVo inforexLoginLayoutVo = (InforexLoginLayoutVo)SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        gsonUtil.responseJsonOutputVoToJson(response, new JsonOutputVo(Status.로그인성공, inforexLoginLayoutVo));
    }

}
