package com.dalbit.security.service;

import com.dalbit.common.code.Status;
import com.dalbit.common.vo.ProcedureVo;
import com.dalbit.exception.CustomUsernameNotFoundException;
import com.dalbit.member.service.MemberService;
import com.dalbit.member.vo.MemberVo;
import com.dalbit.member.vo.P_LoginVo;
import com.dalbit.security.dao.LoginDao;
import com.dalbit.security.vo.SecurityUserVo;
import com.dalbit.util.DalbitUtil;
import com.dalbit.util.RedisUtil;
import com.google.gson.Gson;
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
    private LoginDao loginDao;

    @Autowired
    private MemberService memberService;

    @Autowired
    private RedisUtil redisUtil;

    @Autowired
    HttpServletRequest request;

    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {

        //MemberVo memberVo;
        P_LoginVo pLoginVo = new P_LoginVo(
            DalbitUtil.convertRequestParamToString(request,"memType")
            , DalbitUtil.convertRequestParamToString(request,"memId")
            , DalbitUtil.convertRequestParamToString(request,"memPwd")
            , DalbitUtil.convertRequestParamToInteger(request,"os")
            , DalbitUtil.convertRequestParamToString(request,"deviceId")
            , DalbitUtil.convertRequestParamToString(request,"deviceToken")
            , DalbitUtil.convertRequestParamToString(request,"appVer")
            , DalbitUtil.convertRequestParamToString(request,"appAdId")
        );

        ProcedureVo procedureVo = memberService.callMemberLogin(pLoginVo);
        log.debug("로그인 결과 : {}", new Gson().toJson(procedureVo));

        if(procedureVo.getRet().equals(Status.로그인실패.getMessageCode())) {
            throw new CustomUsernameNotFoundException(Status.로그인실패);

        }else if(procedureVo.getRet().equals(Status.로그인실패.getMessageCode())) {
            throw new CustomUsernameNotFoundException(Status.로그인실패);

        }else if(procedureVo.getRet().equals(Status.로그인실패.getMessageCode())) {
            throw new CustomUsernameNotFoundException(Status.로그인실패.getMessageKey());
        }

        MemberVo paramMemberVo = new MemberVo();
        paramMemberVo.setMemId(DalbitUtil.convertRequestParamToString(request,"memId"));
        paramMemberVo.setMemSlct(DalbitUtil.convertRequestParamToString(request, "memType"));

        MemberVo memberVo = loginDao.loginUseMemId(paramMemberVo);
        if(memberVo == null) {
            throw new CustomUsernameNotFoundException(Status.로그인실패);
        }

        Collection<GrantedAuthority> authorities = new ArrayList<GrantedAuthority>();
        authorities.add(new SimpleGrantedAuthority("ROLE_USER"));

        SecurityUserVo securityUserVo = new SecurityUserVo(memberVo.getMemId(), memberVo.getMemPasswd(), authorities);
        securityUserVo.setMemberVo(memberVo);

        return securityUserVo;
    }


    public UserDetails loadUserBySsoCookieFromDb(String memNo) throws UsernameNotFoundException {

        MemberVo memberVo = loginDao.loginUseMemNo(memNo);

        if(memberVo == null) {
            throw new CustomUsernameNotFoundException(Status.로그인실패);
        }

        Collection<GrantedAuthority> authorities = new ArrayList<GrantedAuthority>();
        authorities.add(new SimpleGrantedAuthority("ROLE_USER"));

        SecurityUserVo securityUserVo = new SecurityUserVo(memberVo.getMemId(), memberVo.getMemPasswd(), authorities);
        securityUserVo.setMemberVo(memberVo);

        return securityUserVo;
    }

    public UserDetails loadUserBySsoCookieFromRedis(String memNo) throws UsernameNotFoundException {

        MemberVo memberVo = redisUtil.getMemberInfoFromRedis(memNo);

        if(memberVo == null) {
            return null;
        }

        Collection<GrantedAuthority> authorities = new ArrayList<GrantedAuthority>();
        authorities.add(new SimpleGrantedAuthority("ROLE_USER"));

        SecurityUserVo securityUserVo = new SecurityUserVo(memberVo.getMemId(), memberVo.getMemPasswd(), authorities);
        securityUserVo.setMemberVo(memberVo);

        return securityUserVo;
    }
}
