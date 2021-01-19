package com.dalbit.config;

import com.dalbit.security.filter.SsoAuthenticationFilter;
import com.dalbit.security.handler.LogoutHandlerImpl;
import com.dalbit.security.service.UserDetailsServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.AuthenticationProvider;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.method.configuration.EnableGlobalMethodSecurity;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.builders.WebSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.factory.PasswordEncoderFactories;
import org.springframework.security.crypto.password.DelegatingPasswordEncoder;
import org.springframework.security.web.authentication.AuthenticationFailureHandler;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;
import org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter;


/**
 * spring Security 설정
 */
@Configuration
@EnableWebSecurity
@EnableGlobalMethodSecurity(
        prePostEnabled = true,
        securedEnabled = true,
        jsr250Enabled = true)
public class WebSecurityConfig extends WebSecurityConfigurerAdapter {

    @Autowired private AuthenticationSuccessHandler authSuccessHandler;
    @Autowired private AuthenticationFailureHandler authFailureHandler;
    @Autowired private LogoutHandlerImpl logoutHandler;
    @Autowired private UserDetailsServiceImpl userDetailsService;
    @Autowired private AuthenticationProvider authProvider;
    @Autowired private SsoAuthenticationFilter ssoAuthenticationFilter;

    //private final static String REMEMBER_ME_KEY = "INFOREX_ADMIN_REMEMBER_ME";

    @Bean
    public DelegatingPasswordEncoder passwordEncoder() {
        DelegatingPasswordEncoder delegatingPasswordEncoder = (DelegatingPasswordEncoder) PasswordEncoderFactories.createDelegatingPasswordEncoder();
        delegatingPasswordEncoder.setDefaultPasswordEncoderForMatches(new BCryptPasswordEncoder());
        return delegatingPasswordEncoder;
    }

    @Override
    public void configure(WebSecurity web) throws Exception {
        web
            //Spring Security ignores request to static resources such as CSS or JS files.
            .ignoring()
            .antMatchers(
                "/**.html"
                    , "/favicon.ico"
                    , "/robots.txt"
                    , "/js/**"
                    , "/template/**"
                    , "/postman/**"
                    , "**.css"
                    , "**.js"
                    , "**.map"
                    , "/login"
                    , "/common/ctrl/check/service"
                    , "/socket/dbCheck/bySocket"
            );
    }

    @Override
    protected void configure(HttpSecurity http) throws Exception {

        http
            .headers()
                .frameOptions().sameOrigin()

            .and()

            .csrf().disable() // 기본값이 on인 csrf 취약점 보안을 해제한다. on으로 설정해도 되나 설정할경우 웹페이지에서 추가처리가 필요함.
            .formLogin() // 권한없이 페이지 접근하면 로그인 페이지로 이동한다.
            .loginPage("/login")
            .loginProcessingUrl("/login/authenticate")
            .defaultSuccessUrl("/login/success")

            .usernameParameter("memId")       //id
            .passwordParameter("memPwd")      //password

            .successHandler(authSuccessHandler) //로그인 성공 시 처리
            .failureHandler(authFailureHandler) //로그인 실패 시 처리

            .and()
                .addFilterBefore(ssoAuthenticationFilter, UsernamePasswordAuthenticationFilter.class)
            /*.and()
            .exceptionHandling().accessDeniedPage("/login")*/

                .userDetailsService(userDetailsService)
                .authorizeRequests()
                .antMatchers(
                    "/login"
                ).permitAll()
                .antMatchers("/**").hasRole("ADMIN")
                .anyRequest().authenticated()

            /*.and()
                *//*.rememberMe()
                .key(REMEMBER_ME_KEY)
                .rememberMeParameter("remember-me-new")
                .rememberMeCookieName("rememberMe1234")
                .tokenValiditySeconds(604800)
                .userDetailsService(userDetailsService)
                .authenticationSuccessHandler(authSuccessHandler)*//*

                .rememberMe()
                .key(REMEMBER_ME_KEY)
                .rememberMeServices(tokenBasedRememberMeServices())*/

            .and()
                .logout()
                    .logoutUrl("/logout")
                    .addLogoutHandler(logoutHandler)
                    .clearAuthentication(true)
                    .invalidateHttpSession(true)

            .and()
                .sessionManagement()
                .maximumSessions(1)
                .expiredUrl("/login")
        ;
    }

    @Override
    protected void configure(AuthenticationManagerBuilder auth) throws Exception {
        auth.authenticationProvider(authProvider);
    }

    @Bean
    @Override
    public AuthenticationManager authenticationManagerBean() throws Exception {
        return super.authenticationManagerBean();
    }

    /*@Bean
    public TokenBasedRememberMeServices tokenBasedRememberMeServices() {
        TokenBasedRememberMeServices rememberMeServices = new TokenBasedRememberMeServices(REMEMBER_ME_KEY, userDetailsService);
        rememberMeServices.setAlwaysRemember(true);
        rememberMeServices.setParameter("remember-me-new");
        rememberMeServices.setTokenValiditySeconds(31536000);
        rememberMeServices.setCookieName(REMEMBER_ME_KEY);
        return rememberMeServices;
    }*/
}
