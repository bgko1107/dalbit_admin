package com.dalbit.member.controller.rest;

import com.dalbit.excel.service.ExcelService;
import com.dalbit.member.service.Mem_ListenService;
import com.dalbit.member.vo.procedure.P_MemberListenInputVo;
import com.dalbit.util.GsonUtil;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@Slf4j
@RestController
@RequestMapping("rest/member/listen")
public class Mem_ListenRestController {

    @Autowired
    Mem_ListenService mem_ListenService;

    @Autowired
    ExcelService excelService;

    @Autowired
    GsonUtil gsonUtil;

    /**
     * 회원 청취 목록
     */
    @PostMapping("list")
    public String list(P_MemberListenInputVo pMemberListenInputVo) {
        String result = mem_ListenService.getListenHistory(pMemberListenInputVo);
        return result;
    }

    /*
    *  회원 청취 강제 종료
    */
    @PostMapping("forcedExit")
    public String forcedExit(P_MemberListenInputVo pMemberListenInputVo){
        return mem_ListenService.forcedExit(pMemberListenInputVo);
    }
}
