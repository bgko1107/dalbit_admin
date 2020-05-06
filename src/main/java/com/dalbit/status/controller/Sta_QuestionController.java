package com.dalbit.status.controller;

import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Slf4j
@Controller
@RequestMapping("/status/question")
public class Sta_QuestionController {

    @GetMapping("/info")
    public String list() {
        return "status/question/info";
    }


}
