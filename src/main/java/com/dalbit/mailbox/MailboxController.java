package com.dalbit.mailbox;

import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Slf4j
@Controller
@RequestMapping("/mailbox")
public class MailboxController {

    @Autowired

    @GetMapping("/mailbox/info")
    public String info() {
        return "mailbox/mailbox/info";
    }


}
