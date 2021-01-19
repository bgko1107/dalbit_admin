package com.dalbit.security.service;

import com.dalbit.security.vo.SecurityUserVo;
import com.dalbit.util.DalbitUtil;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import javax.servlet.http.HttpServletRequest;
import java.util.ArrayList;
import java.util.Collection;

@Slf4j
@Service("userDetailsService")
public class UserDetailsServiceImpl implements UserDetailsService {

    @Autowired
    HttpServletRequest request;

    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {

        //MemberVo memberVo;
        /*P_LoginVo pLoginVo = new P_LoginVo(
            "p"
            , DalbitUtil.convertRequestParamToString(request,"memId")
            , DalbitUtil.convertRequestParamToString(request,"memPwd")
            , 1
            , "deviceId"
            , "deviceToken"
            , "appVer"
            , "appAdId"
        );

        ProcedureVo procedureVo = mMemberService.callMemberLogin(pLoginVo);
        log.debug("로그인 결과 : {}", new Gson().toJson(procedureVo));

        if(procedureVo.getRet().equals(Status.로그인실패_회원가입필요.getMessageCode())) {
            throw new CustomUsernameNotFoundException(Status.로그인실패_회원가입필요);

        }else if(procedureVo.getRet().equals(Status.로그인실패_패스워드틀림.getMessageCode())) {
            throw new CustomUsernameNotFoundException(Status.로그인실패_패스워드틀림);

        }else if(procedureVo.getRet().equals(Status.로그인실패_파라메터이상.getMessageCode())) {
            throw new CustomUsernameNotFoundException(Status.로그인실패_파라메터이상.getMessageKey());
        }*/

        /*try {

            var map = new HashMap();
            map.put("userid", DalbitUtil.convertRequestParamToString(request,"memId"));
            map.put("password", DalbitUtil.convertRequestParamToString(request,"memPwd"));
            map.put("mode", "login");
            map.put("where", "dalbit");

            OkHttpClientUtil okHttpClientUtil = new OkHttpClientUtil();

            Response response = okHttpClientUtil.sendPost("http://admin.inforex.co.kr/loginout.html", new Gson().toJson(map));
            log.info("로그인결과 : {}", response.body().string());

        }catch (GlobalException | IOException e){

        }*/

        if(username.contains(DalbitUtil.getProperty("dalbit.cookie.seperate"))){
            String[] cookieValues = username.split(DalbitUtil.getProperty("dalbit.cookie.seperate"));
            username = cookieValues[0];
        }

        Collection<GrantedAuthority> authorities = new ArrayList<GrantedAuthority>();
        authorities.add(new SimpleGrantedAuthority("ROLE_ADMIN"));

        SecurityUserVo securityUserVo = new SecurityUserVo(
                username
                , username
                , authorities);

        return securityUserVo;
    }
}
