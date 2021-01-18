package com.dalbit.enter.controller.rest;

import com.dalbit.common.code.Status;
import com.dalbit.common.vo.JsonOutputVo;
import com.dalbit.enter.service.Ent_PayService;
import com.dalbit.enter.vo.procedure.*;
import com.dalbit.excel.service.ExcelService;
import com.dalbit.exception.GlobalException;
import com.dalbit.util.DalbitUtil;
import com.dalbit.util.GsonUtil;
import com.dalbit.util.MessageUtil;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@Slf4j
@RestController
@RequestMapping("rest/enter/pay")
public class Ent_PayRestController {

    @Autowired
    GsonUtil gsonUtil;

    @Autowired
    MessageUtil messageUtil;

    @Autowired
    Ent_PayService ent_PayService;

    @Autowired
    ExcelService excelService;

    @PostMapping("info")
    public String payInfo(P_StatVo pStatVo){
        if(DalbitUtil.isEmpty(pStatVo.getStartDate())){
            pStatVo.setStartDate(null);
        }
        if(DalbitUtil.isEmpty(pStatVo.getEndDate())){
            pStatVo.setEndDate(null);
        }
        String result = ent_PayService.callPayInfo(pStatVo);
        return result;
    }

    // 결제 현황 총계
    @PostMapping("total")
    public String payTotal(P_PayTotalInPutVo pPayTotalInPutVo){
        String result = ent_PayService.callPayTotal(pPayTotalInPutVo);
        return result;
    }

    // 결제 현황 연령별
    @PostMapping("age")
    public String payAge(P_StatVo pStatVo){
        if(DalbitUtil.isEmpty(pStatVo.getStartDate())){
            pStatVo.setStartDate(null);
        }
        if(DalbitUtil.isEmpty(pStatVo.getEndDate())){
            pStatVo.setEndDate(null);
        }
        String result = ent_PayService.callPayAge(pStatVo);
        return result;
    }

    // 결제 현황 결제 수단 별
    @PostMapping("way")
    public String payWay(P_StatVo pStatVo){
        if(DalbitUtil.isEmpty(pStatVo.getStartDate())){
            pStatVo.setStartDate(null);
        }
        if(DalbitUtil.isEmpty(pStatVo.getEndDate())){
            pStatVo.setEndDate(null);
        }
        String result = ent_PayService.callPayWay(pStatVo);
        return result;
    }

    // 결제 현황 결제 상품 별
    @PostMapping("code")
    public String payCode(P_StatVo pStatVo){
        if(DalbitUtil.isEmpty(pStatVo.getStartDate())){
            pStatVo.setStartDate(null);
        }
        if(DalbitUtil.isEmpty(pStatVo.getEndDate())){
            pStatVo.setEndDate(null);
        }
        String result = ent_PayService.callPayCode(pStatVo);
        return result;
    }

    // 결제 현황 취소
    @PostMapping("cancel")
    public String payCancel(P_StatVo pStatVo){
        if(DalbitUtil.isEmpty(pStatVo.getStartDate())){
            pStatVo.setStartDate(null);
        }
        if(DalbitUtil.isEmpty(pStatVo.getEndDate())){
            pStatVo.setEndDate(null);
        }
        String result = ent_PayService.callPayCancel(pStatVo);
        return result;
    }

    // 결제 현황 총계
    @PostMapping("try")
    public String payTry(P_PayTryInPutVo pPayTryInPutVo){
        String result = ent_PayService.callPayTry(pPayTryInPutVo);
        return result;
    }

    // 결제 현황 월별_수단별
    @PostMapping("/month/way")
    public String payMonthWay(P_PayTotalWayInPutVo pPayTotalWayInPutVo){
        String result = ent_PayService.callPayMonthWay(pPayTotalWayInPutVo);
        return result;
    }

    // 수익인식 프로세스 ---------------------------------------------------------
    // 달 양식
    @PostMapping("/dalForm")
    public String dalForm(P_RevenueProcessVo pRevenueProcessVo){
        String result = ent_PayService.callDalForm(pRevenueProcessVo);
        return result;
    }

    // 달 수
    @PostMapping("/dal/count")
    public String dalCount(P_RevenueProcessVo pRevenueProcessVo){
        String result = ent_PayService.callDalCount(pRevenueProcessVo);
        return result;
    }

    // 달 금액
    @PostMapping("/dal/amt")
    public String dalAmt(P_RevenueProcessVo pRevenueProcessVo){
        String result = ent_PayService.callDalAmt(pRevenueProcessVo);
        return result;
    }

    // 달 금액 엑셀 다운로드
    @PostMapping("/dal/amtListExcel")
    public String dalAmtListExcel(HttpServletRequest request, HttpServletResponse response, Model model, P_RevenueProcessVo pRevenueProcessVo) throws GlobalException {
        Model resultModel = ent_PayService.callDalAmtListExcel(pRevenueProcessVo, model);
        excelService.renderMergedOutputModel(resultModel.asMap(), request, response);
        return gsonUtil.toJson(new JsonOutputVo(Status.엑셀다운로드성공));
    }

    // 별 수
    @PostMapping("/byeol/count")
    public String byeolCount(P_RevenueProcessVo pRevenueProcessVo){
        String result = ent_PayService.callByeolCount(pRevenueProcessVo);
        return result;
    }

    // 별 금액 엑셀 다운로드
    @PostMapping("/byeol/amtListExcel")
    public String byeolAmtListExcel(HttpServletRequest request, HttpServletResponse response, Model model, P_RevenueProcessVo pRevenueProcessVo) throws GlobalException {
        Model resultModel = ent_PayService.callByeolAmtListExcel(pRevenueProcessVo, model);
        excelService.renderMergedOutputModel(resultModel.asMap(), request, response);
        return gsonUtil.toJson(new JsonOutputVo(Status.엑셀다운로드성공));
    }

    // 별 금액
    @PostMapping("/byeol/amt")
    public String byeolAmt(P_RevenueProcessVo pRevenueProcessVo){
        String result = ent_PayService.callByeolAmt(pRevenueProcessVo);
        return result;
    }

    // 달 금액
    @PostMapping("/dal/sales")
    public String dalSales(P_RevenueProcessVo pRevenueProcessVo){
        String result = ent_PayService.callDalSales(pRevenueProcessVo);
        return result;
    }
}
