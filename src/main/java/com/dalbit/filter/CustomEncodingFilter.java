package com.dalbit.filter;

import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Component;
import org.springframework.web.filter.CharacterEncodingFilter;

import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@Slf4j
@Component
public class CustomEncodingFilter extends CharacterEncodingFilter {

    @Override
    protected void doFilterInternal(HttpServletRequest request, HttpServletResponse response, FilterChain filterChain) throws ServletException, IOException {

        if (request.getRequestURI().endsWith("/rest/sample/sendEmail")) {
            request.setCharacterEncoding("euc-kr");
            response.setCharacterEncoding("euc-kr");
            filterChain.doFilter(request, response);
        } else {
            request.setCharacterEncoding("utf-8");
            response.setCharacterEncoding("utf-8");
            filterChain.doFilter(request, response);
        }

    }

}
