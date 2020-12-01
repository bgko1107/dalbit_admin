package com.dalbit.enter.controller;

import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Slf4j
@Controller
@RequestMapping("/enter")
public class EnterController {

    @GetMapping("/exchange/info")
    public String exchangeList() {
        return "enter/exchange/info";
    }

    @GetMapping("/join/info")
    public String joinList() {
        return "enter/join/info";
    }

    @GetMapping("/newJoin2/join/info")
    public String newJoin2List() {
        return "enter/newJoin2/join/info";
    }

    @GetMapping("/newJoin2/withdrawal/info")
    public String newJoin2withdrawalList() {
        return "enter/newJoin2/withdrawal/info";
    }

    @GetMapping("/newJoin/info")
    public String newJoinList() {
        return "enter/newJoin/info";
    }

    @GetMapping("/newPay/info")
    public String newPayList() {
        return "enter/newPay/info";
    }

    @RequestMapping("/newPay/popup/history")
    public String newPayHistory() {
        return "enter/newPay/popup/history";
    }

    @GetMapping("/pay/info")
    public String payList() {
        return "enter/pay/info";
    }

}
