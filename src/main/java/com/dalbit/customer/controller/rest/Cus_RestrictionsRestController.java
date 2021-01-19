package com.dalbit.customer.controller.rest;

import com.dalbit.customer.service.Cus_RestrictionsService;
import com.dalbit.customer.vo.procedure.P_ForcedListInputVo;
import com.dalbit.customer.vo.procedure.P_WithdrawalListInputVo;
import com.dalbit.excel.service.ExcelService;
import com.dalbit.util.GsonUtil;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@Slf4j
@RestController
@RequestMapping("rest/customer/restrictions")
public class Cus_RestrictionsRestController {

    @Autowired
    Cus_RestrictionsService cusRestrictionsService;

    @Autowired
    ExcelService excelService;

    @Autowired
    GsonUtil gsonUtil;

    /**
     * 경고/정지 회원 리스트 조회
     */
    @PostMapping("/withdrawal/list")
    public String getWithdrawalList(P_WithdrawalListInputVo pWithdrawalListInputVo) {
        String result = cusRestrictionsService.getWithdrawalList(pWithdrawalListInputVo);
        return result;
    }


    /**
     * 강제퇴장 회원 리스트 조회
     */
    @PostMapping("/forced/list")
    public String getForcedList(P_ForcedListInputVo pForcedListInputVo) {
        String result = cusRestrictionsService.getForcedList(pForcedListInputVo);
        return result;
    }

}
