package com.dalbit.money.controller;

import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Slf4j
@Controller
@RequestMapping("money/resource")
public class Mon_ResourceController {

    @GetMapping("info")
    public String info() {
        return "money/resource/info";
    }

    @GetMapping("popup/dal")
    public String dal() {
        return "money/resource/popup/dal";
    }

    @GetMapping("popup/byeol")
    public String byeol() {
        return "money/resource/popup/byeol";
    }


}
