package com.dalbit.money.controller.rest;

import com.dalbit.common.code.Status;
import com.dalbit.common.vo.JsonOutputVo;
import com.dalbit.excel.service.ExcelService;
import com.dalbit.exception.GlobalException;
import com.dalbit.member.vo.MemberVo;
import com.dalbit.money.service.Mon_ExchangeService;
import com.dalbit.money.vo.Mon_EnableSummaryVo;
import com.dalbit.money.vo.Mon_ExchangeInputVo;
import com.dalbit.money.vo.Mon_ExchangeOutputVo;
import com.dalbit.util.GsonUtil;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@Slf4j
@RestController
@RequestMapping("rest/money/exchange")
public class Mon_ExchangeRestController {

    @Autowired
    Mon_ExchangeService monExchangeService;

    @Autowired
    ExcelService excelService;

    @Autowired
    GsonUtil gsonUtil;

    @PostMapping("list")
    public String list(Mon_ExchangeInputVo monExchangeInputVo) throws GlobalException {
        String result = monExchangeService.selectExchangeList(monExchangeInputVo);
        return result;
    }

    @PostMapping("listExcel")
    public String listExcel(HttpServletRequest request, HttpServletResponse response, Mon_ExchangeInputVo monExchangeInputVo, Model model) throws GlobalException {

        monExchangeInputVo.setExcelYn("Y");
        Model resultModel = monExchangeService.getListExcel(monExchangeInputVo, model);

        int listSize = (int) resultModel.getAttribute("listSize");
        if(0 == listSize){
            return gsonUtil.toJson(new JsonOutputVo(Status.데이터없음));
        }
        excelService.renderMergedOutputModel(resultModel.asMap(), request, response);
        return gsonUtil.toJson(new JsonOutputVo(Status.엑셀다운로드성공));
    }

    @PostMapping("summary")
    public String summary(Mon_ExchangeInputVo monExchangeInputVo) throws GlobalException {
        String result = monExchangeService.selectExchangeSummary(monExchangeInputVo);
        return result;
    }

    @PostMapping("stat/summary")
    public String statSummary(Mon_ExchangeInputVo monExchangeInputVo) throws GlobalException {
        String result = monExchangeService.selectStatSummaryInfo(monExchangeInputVo);
        return result;
    }

    @PostMapping("detail")
    public String detail(Mon_ExchangeInputVo monExchangeInputVo) throws GlobalException {
        String result = monExchangeService.selectExchangeDetail(monExchangeInputVo);
        return result;
    }

    @PostMapping("update")
    public String update(Mon_ExchangeOutputVo monExchangeOutputVo) throws GlobalException {
        monExchangeOutputVo.setOp_name(MemberVo.getMyMemNo());
        String result = monExchangeService.updateExchangeDetail(monExchangeOutputVo);
        return result;
    }

    @PostMapping("complete")
    public String complete(Mon_ExchangeOutputVo monExchangeOutputVo) throws GlobalException {
        monExchangeOutputVo.setOp_name(MemberVo.getMyMemNo());
        String result = monExchangeService.updateExchangeComplete(monExchangeOutputVo);
        return result;
    }

    @PostMapping("multiComplete")
    public String multiComplete(Mon_ExchangeInputVo monExchangeInputVo) throws GlobalException {
        monExchangeInputVo.setOpName(MemberVo.getMyMemNo());
        monExchangeInputVo.setState(1);

        String[] intArr = monExchangeInputVo.getIdxs().split("@");
        monExchangeInputVo.setIdxArr(intArr);
        String result = monExchangeService.updateExchangeMultiComplete(monExchangeInputVo);
        return result;
    }

    @PostMapping("enable/summary")
    public String enableSummary(Mon_EnableSummaryVo monEnableSummaryVo) throws GlobalException {
        String result = monExchangeService.selectEnableSummary(monEnableSummaryVo);
        return result;
    }

    @PostMapping("exchange/list")
    public String callExchangeList(Mon_ExchangeInputVo monExchangeInputVo) throws GlobalException {
        String result = monExchangeService.callExchangeList(monExchangeInputVo);
        return result;
    }
}
