package com.dalbit.member.controller.rest;

import com.dalbit.excel.service.ExcelService;
import com.dalbit.member.service.Mem_GGamGGamEService;
import com.dalbit.member.service.Mem_MystarService;
import com.dalbit.member.vo.procedure.P_MemberGGamGGamEVo;
import com.dalbit.member.vo.procedure.P_MemberMystarInputVo;
import com.dalbit.util.GsonUtil;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@Slf4j
@RestController
@RequestMapping("rest/member/ggamggame")
public class Mem_GGamGGamERestController {

    @Autowired
    Mem_GGamGGamEService mem_GGamGGamEService;
    @Autowired
    ExcelService excelService;
    @Autowired
    GsonUtil gsonUtil;

    /**
     * 회원 Mystar 목록
     */
    @PostMapping("newrecord/list")
    public String list(P_MemberGGamGGamEVo pMemberGGamGGamEVo){
        return mem_GGamGGamEService.callNewRecodHistory(pMemberGGamGGamEVo);

    }

}
