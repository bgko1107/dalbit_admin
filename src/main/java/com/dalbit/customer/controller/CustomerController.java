package com.dalbit.customer.controller;

import com.dalbit.customer.service.DeclarationService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;

@Slf4j
@Controller
@RequestMapping("/customer")
public class CustomerController {

    @Autowired
    DeclarationService declarationService;

    @GetMapping("/blockAdm/list")
    public String blockAdmList() {
        return "customer/blockAdm/list";
    }

    /**
     * profile List
     * @param model
     * @return
     */
    @GetMapping("/image/list")
    public String imageList(Model model) {
        return "customer/image/list";
    }

    @RequestMapping("/image/popup/imagePopup")
    public String imageReportPopup(Model model) { return "customer/image/popup/imagePopup"; }

    /**
     * Question List
     * @param model
     * @return
     */
    @GetMapping("/question/list")
    public String list(Model model) {
        return "customer/question/list";
    }

    @GetMapping("/restrictions/list")
    public String restrictionsList(Model model) {
        return "customer/restrictions/list";
    }

    @GetMapping("/sms/list")
    public String smsList(Model model) {
        return "customer/sms/list";
    }

    @RequestMapping("/sms/popup/smsSendPopup")
    public String smsPopup(Model model, HttpServletRequest request) {
        return "customer/sms/popup/smsSendPopup";
    }

    @GetMapping("/question/macro")
    public String macro(Model model) {
        return "customer/question/macro";
    }

    /**
     * Declaration List
     * @param model
     * @return
     */
    @GetMapping("/declaration/list")
    public String declarationList(Model model) {
        return "customer/declaration/list";
    }

    @RequestMapping("/declaration/popup/declarationPopup")
    public String declarationPopup(Model model) {
        return "customer/declaration/popup/declarationPopup";
    }
}
