package com.dalbit.administrate.controller;

import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Slf4j
@Controller
@RequestMapping("/administrate")
public class AdministrateController {

    @GetMapping("/target/alarmtalk/list")
    public String alarmtalkTargetList() {
        return "administrate/alarmtalk/list";
    }

    @GetMapping("/log/alarmtalk/list")
    public String alarmtalkLogList() {
        return "sample/alarmTalkLog";
    }

    @GetMapping("/authority/list")
    public String authorityList() {
        return "administrate/authority/list";
    }

    @GetMapping("/category/list")
    public String categoryList() {
        return "administrate/category/list";
    }

    @GetMapping("/faq/list")
    public String faqList() {
        return "administrate/faq/list";
    }

    @GetMapping("/terms/list")
    public String termsList() {
        return "administrate/terms/list";
    }

    @GetMapping("/testDalByeol/list")
    public String testDalByeolList() {
        return "administrate/testDalByeol/list";
    }

    @GetMapping("/testDalByeol/popup/resourceList")
    public String testDalByeolPopupList() {
        return "administrate/testDalByeol/popup/resourceList";
    }

    @GetMapping("/testId/list")
    public String testIdList() {
        return "administrate/testId/list";
    }


}
