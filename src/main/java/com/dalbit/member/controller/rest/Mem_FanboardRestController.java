package com.dalbit.member.controller.rest;

import com.dalbit.excel.service.ExcelService;
import com.dalbit.member.service.Mem_FanboardService;
import com.dalbit.member.vo.procedure.P_MemberFanboardDeleteVo;
import com.dalbit.member.vo.procedure.P_MemberFanboardInputVo;
import com.dalbit.util.GsonUtil;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@Slf4j
@RestController
@RequestMapping("rest/member/fanboard")
public class Mem_FanboardRestController {

    @Autowired
    Mem_FanboardService mem_FanboardService;

    @Autowired
    ExcelService excelService;

    @Autowired
    GsonUtil gsonUtil;

    /**
     * 회원 팬보드 목록
     */
    @PostMapping("list")
    public String list(P_MemberFanboardInputVo pMemberFanboardInputVo){
        return mem_FanboardService.getFanboardHistory(pMemberFanboardInputVo);

    }

    /**
     * 회원 팬보드 리플 목록
     */
    @PostMapping("replyList")
    public String replyList(P_MemberFanboardInputVo pMemberFanboardInputVo){
        return mem_FanboardService.getFanboardReplyList(pMemberFanboardInputVo);

    }

    /**
     * 회원 팬보드 삭제
     */
    @PostMapping("delete")
    public String delete(P_MemberFanboardDeleteVo pMemberFanboardDeleteVo){
        return mem_FanboardService.getFanboardDelete(pMemberFanboardDeleteVo);

    }
}
