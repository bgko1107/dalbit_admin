package com.dalbit.member.controller.rest;

import com.dalbit.common.code.Status;
import com.dalbit.common.vo.JsonOutputVo;
import com.dalbit.excel.service.ExcelService;
import com.dalbit.exception.GlobalException;
import com.dalbit.member.service.Mem_JoinService;
import com.dalbit.member.vo.procedure.P_DormancyInputVo;
import com.dalbit.member.vo.procedure.P_MemberJoinInputVo;
import com.dalbit.util.GsonUtil;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.ui.Model;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@Slf4j
@RestController
@RequestMapping("rest/member/join")
public class Mem_JoinRestController {

    @Autowired
    Mem_JoinService mem_JoinService;

    @Autowired
    ExcelService excelService;

    @Autowired
    GsonUtil gsonUtil;

    /**
     * 회원가입 목록
     */
    @PostMapping("list")
    public String list(P_MemberJoinInputVo pMemberJoinInputVo){
        return mem_JoinService.getJoinList(pMemberJoinInputVo);
    }

    /**
    * 회원탈퇴 목록
    */
     @PostMapping("withdrawalList")
     public String withdrawalList(P_MemberJoinInputVo pMemberJoinInputVo){
         return mem_JoinService.getWithdrawalList(pMemberJoinInputVo);
     }


    /**
     * 회원 가입 엑셀
     */
    @PostMapping("listExcel")
    public String listExcel(HttpServletRequest request, HttpServletResponse response, Model model, P_MemberJoinInputVo pMemberJoinInputVo) throws GlobalException {
        Model resultModel = mem_JoinService.getJoinListExcel(pMemberJoinInputVo, model);
        excelService.renderMergedOutputModel(resultModel.asMap(), request, response);

        return gsonUtil.toJson(new JsonOutputVo(Status.엑셀다운로드성공));
    }
    /**
     * 회원 가입 엑셀
     */
    @PostMapping("withdrawalListExcel")
    public String withdrawalListExcel(HttpServletRequest request, HttpServletResponse response, Model model, P_MemberJoinInputVo pMemberJoinInputVo) throws GlobalException {
        Model resultModel = mem_JoinService.getWithdrawalListExcel(pMemberJoinInputVo, model);
        excelService.renderMergedOutputModel(resultModel.asMap(), request, response);

        return gsonUtil.toJson(new JsonOutputVo(Status.엑셀다운로드성공));
    }
    /**
    * 휴면/해제 회원 내역
    */
     @PostMapping("dormancyList")
     public String dormancyList(P_DormancyInputVo pDormancyInputVo){
         return mem_JoinService.callDormancyList(pDormancyInputVo);
     }

    /**
     * 휴면 해제
     */
    @PostMapping("member/return")
    public String memberReturn(P_DormancyInputVo pDormancyInputVo){
        return mem_JoinService.callMemberReturn(pDormancyInputVo);
    }
}
