package com.dalbit.member.controller.rest;

import com.dalbit.excel.service.ExcelService;
import com.dalbit.member.service.Mem_GGamGGamEService;
import com.dalbit.member.service.Mem_QuestService;
import com.dalbit.member.vo.procedure.P_MemberGGamGGamEVo;
import com.dalbit.member.vo.procedure.P_QuestVo;
import com.dalbit.util.GsonUtil;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@Slf4j
@RestController
@RequestMapping("rest/member/quest")
public class Mem_QuestRestController {

    @Autowired
    Mem_QuestService mem_QuestService;
    @Autowired
    ExcelService excelService;
    @Autowired
    GsonUtil gsonUtil;

    /**
     * 회원 Mystar 목록
     */
    @PostMapping("list")
    public String list(P_QuestVo pQuestVo){
        return mem_QuestService.callQuestList(pQuestVo);
    }

    @PostMapping("detail/list")
    public String detailList(P_QuestVo pQuestVo){
        return mem_QuestService.callQuestDetailList(pQuestVo);
    }

}
