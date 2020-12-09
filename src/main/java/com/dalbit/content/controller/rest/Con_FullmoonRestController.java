package com.dalbit.content.controller.rest;

import com.dalbit.content.service.Con_FullmoonService;
import com.dalbit.content.vo.procedure.P_FullmoonConditionVo;
import com.dalbit.content.vo.procedure.P_FullmoonTextVo;
import com.dalbit.member.vo.MemberVo;
import com.dalbit.util.GsonUtil;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@Slf4j
@RestController
@RequestMapping("rest/content/fullmoon")
public class Con_FullmoonRestController {

    @Autowired
    Con_FullmoonService con_fullmoonService;

    @Autowired
    GsonUtil gsonUtil;

    @PostMapping("/info/condition")
    public String fullmoonManagementSelect(P_FullmoonConditionVo pFullmoonConditionVo) {
        String result = con_fullmoonService.callFullmoonManagementSelect(pFullmoonConditionVo);
        return result;
    }

    @PostMapping("/info/conditionEdit")
    public String fullmoonManagementEdit(P_FullmoonConditionVo pFullmoonConditionVo) {
        pFullmoonConditionVo.setOpName(MemberVo.getMyMemNo());
        String result = con_fullmoonService.callFullmoonManagementEdit(pFullmoonConditionVo);
        return result;
    }

    @PostMapping("/info/text")
    public String fullmoonTextSelect(P_FullmoonTextVo pFullmoonConditionVo) {
        String result = con_fullmoonService.callFullmoonTextSelect(pFullmoonConditionVo);
        return result;
    }

    @PostMapping("/info/textEdit")
    public String fullmoonTextEdit(P_FullmoonTextVo pFullmoonConditionVo) {
        String result = con_fullmoonService.callFullmoonTextEdit(pFullmoonConditionVo);
        return result;
    }

}