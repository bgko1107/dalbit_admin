package com.dalbit.content.controller;

import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Slf4j
@Controller
@RequestMapping("/content/marketing")
public class Con_MarketingController {

    @GetMapping("/info")
    public String info() {
        return "content/marketing/info";
    }
}
