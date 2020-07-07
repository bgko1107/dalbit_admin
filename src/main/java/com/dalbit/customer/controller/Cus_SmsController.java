package com.dalbit.customer.controller;

import org.springframework.ui.Model;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;

@Slf4j
@Controller
@RequestMapping("/customer/sms")
public class Cus_SmsController {

    @GetMapping("/list")
    public String list(Model model) {
        return "customer/sms/list";
    }
    
    @RequestMapping("/popup/smsSendPopup")
    public String popup(Model model, HttpServletRequest request) {
        return "customer/sms/popup/smsSendPopup";
    }
}
