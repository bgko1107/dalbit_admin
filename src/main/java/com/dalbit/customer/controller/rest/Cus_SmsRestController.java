package com.dalbit.customer.controller.rest;

import com.dalbit.common.vo.JsonOutputVo;
import com.dalbit.customer.service.Cus_SmsService;
import com.dalbit.customer.vo.SmsHistoryVo;
import com.dalbit.excel.service.ExcelService;
import com.dalbit.exception.GlobalException;
import com.dalbit.util.GsonUtil;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.ui.Model;
import com.dalbit.common.code.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@Slf4j
@RestController
@RequestMapping("rest/customer/sms")
public class Cus_SmsRestController {

    @Autowired
    Cus_SmsService cusSmsService;

    @Autowired
    ExcelService excelService;

    @Autowired
    GsonUtil gsonUtil;

    /**
     * sms 리스트 조회
     */
    @PostMapping("list")
    public String getSmsList(SmsHistoryVo smsHistoryVo) {
        String result = cusSmsService.getSmsList(smsHistoryVo);
        return result;
    }

    /**
     * sms 상세 조회
     */
    @PostMapping("detail")
    public String getSmsDetail(SmsHistoryVo smsHistoryVo) {
        String result = cusSmsService.getSmsDetail(smsHistoryVo);
        return result;
    }

    /**
     * sms 발송
     */
    @PostMapping("send")
    public String smsSend(SmsHistoryVo smsHistoryVo, HttpServletRequest request) {
        String result = cusSmsService.smsSend(smsHistoryVo);
        return result;
    }

    /**
     * sms 예약 삭제
     */
    @PostMapping("del")
    public String smsDel(SmsHistoryVo smsHistoryVo) {
        String result = cusSmsService.smsDel(smsHistoryVo);
        return result;
    }

    /**
     * sms 엑셀 출력
     */
    @PostMapping("listExcel")
    public String listExcel(HttpServletRequest request, HttpServletResponse response, Model model, SmsHistoryVo smsHistoryVo) throws GlobalException {
        Model resultModel = cusSmsService.getListExcel(smsHistoryVo, model);

        excelService.renderMergedOutputModel(resultModel.asMap(), request, response);
        return gsonUtil.toJson(new JsonOutputVo(Status.엑셀다운로드성공));
    }
}
