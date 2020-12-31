package com.dalbit.member.controller;

import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Slf4j
@Controller
@RequestMapping("member")
public class MemberController {

    /**
     * 회원리스트
     * @param model
     * @return
     */
    @GetMapping("/member/list")
    public String memberList(Model model) {
        log.info("회원정보입니다.");
        return "member/member/list";
    }

    @RequestMapping("/member/popup/memberPopup")
    public String memberPopup(Model model) { return "member/member/popup/memberPopup"; }

    @RequestMapping("/member/popup/reportPopup")
    public String reportPopup(Model model) { return "member/member/popup/reportPopup"; }

    @RequestMapping("/member/popup/memberTestid")
    public String memberTestid(Model model) { return "member/member/popup/memberTestid"; }

    @RequestMapping("/member/login/history")
    public String loginHistory(Model model) { return "member/login/history"; }

    @RequestMapping("/mailbox/popup/mailboxMsg")
    public String mailboxMsg(Model model) { return "member/mailbox/popup/mailboxMsg"; }


    /**
     * 회원리스트
     * @param model
     * @return
     */
    @GetMapping("/join/list")
    public String joinList(Model model) {
        log.info("가입/탈퇴 회원정보입니다.");
        return "member/join/list";
    }
}
