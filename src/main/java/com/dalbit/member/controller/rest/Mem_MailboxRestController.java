package com.dalbit.member.controller.rest;

import com.dalbit.member.service.Mem_MailboxService;
import com.dalbit.member.vo.procedure.P_MailboxListVo;
import com.dalbit.member.vo.procedure.P_MailboxMsgVo;
import com.dalbit.util.GsonUtil;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@Slf4j
@RestController
@RequestMapping("rest/member/mailbox")
public class Mem_MailboxRestController {

    @Autowired
    Mem_MailboxService mem_MailboxService;

    @Autowired
    GsonUtil gsonUtil;

    /**
     * 우체통 목록
     */
    @PostMapping("list")
    public String list(P_MailboxListVo pMailboxListVo){
        String result = mem_MailboxService.getMailboxList(pMailboxListVo);
        return result;
    }

    /**
     * 우체통 대화 목록
     */
    @PostMapping("msg")
    public String msg(P_MailboxMsgVo P_MailboxMsgVo){
        String result = mem_MailboxService.getMailboxMsg(P_MailboxMsgVo);
        return result;
    }

}
