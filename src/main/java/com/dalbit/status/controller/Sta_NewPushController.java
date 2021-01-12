package com.dalbit.status.controller;

import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Slf4j
@Controller
@RequestMapping("/status/newPush")
public class Sta_NewPushController {

    @GetMapping("/info")
    public String list() {
        return "status/newPush/info";
    }

    @GetMapping("/popup/detail")
    public String popupDetail() {
        return "status/newPush/popup/detail";
    }


}
