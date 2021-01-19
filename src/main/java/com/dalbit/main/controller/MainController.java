package com.dalbit.main.controller;

import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

@Slf4j
@Controller
public class MainController {
    @GetMapping("/main")
    public String mainList(HttpServletRequest request, HttpSession httpSession) {
        return "main/main";
    }

    @GetMapping("/main/new")
    public String newMain(HttpServletRequest request, HttpSession httpSession) {
        return "main/new_main";
    }

    @GetMapping("index")
    public String indexList(HttpServletRequest request, HttpSession httpSession) {
        return "index";
    }
}
