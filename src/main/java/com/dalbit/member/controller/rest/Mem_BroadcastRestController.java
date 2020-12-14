package com.dalbit.member.controller.rest;

import com.dalbit.excel.service.ExcelService;
import com.dalbit.exception.GlobalException;
import com.dalbit.member.service.Mem_BroadcastService;
import com.dalbit.member.vo.MemberVo;
import com.dalbit.member.vo.procedure.P_AuthVo;
import com.dalbit.member.vo.procedure.P_MemberBroadcastInputVo;
import com.dalbit.util.GsonUtil;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@Slf4j
@RestController
@RequestMapping("rest/member/broadcast")
public class Mem_BroadcastRestController {

    @Autowired
    Mem_BroadcastService mem_BroadcastService;

    @Autowired
    ExcelService excelService;

    @Autowired
    GsonUtil gsonUtil;

    /**
     * 회원 방송 목록
     */
    @PostMapping("list")
    public String list(P_MemberBroadcastInputVo pMemberBroadcastInputVo){
        String result = mem_BroadcastService.getBroadHistory(pMemberBroadcastInputVo);
        return result;

    }

    /**
     * 회원 방송 강제 종료
     */
    @PostMapping("forcedEnd")
    public String forcedEnd(MemberVo MemberVo) throws GlobalException {
        String result = mem_BroadcastService.forcedEnd(MemberVo);
        return result;

    }

    /**
     * 임시점검 체크
     */
    @PostMapping("inspection/check")
    public String inspectionCheck(P_AuthVo pAuthVo){
        String result = mem_BroadcastService.inspectionCheck(pAuthVo);
        return result;

    }

    /**
     * 임시점검 (전체 방 강제종료, 생성 제한)
     */
    @PostMapping("inspection")
    public String inspection(P_AuthVo pAuthVo) throws GlobalException {
        String result = mem_BroadcastService.inspection(pAuthVo);
        return result;

    }
}
