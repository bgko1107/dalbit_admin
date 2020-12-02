package com.dalbit.connect.controller;

import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Slf4j
@Controller
@RequestMapping("/connect")
public class ConnectController {

    @GetMapping("/connect/info")
    public String connectList() {
        return "connect/connect/info";
    }

    @GetMapping("/login/info")
    public String loginList() {
        return "connect/login/info";
    }

    @GetMapping("/user/info")
    public String userList() {
        return "connect/user/info";
    }
}
