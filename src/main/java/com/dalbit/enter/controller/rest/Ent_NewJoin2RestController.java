package com.dalbit.enter.controller.rest;

import com.dalbit.common.code.Status;
import com.dalbit.common.vo.JsonOutputVo;
import com.dalbit.enter.service.Ent_NewJoin2Service;
import com.dalbit.enter.vo.procedure.P_StatVo;
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
@RequestMapping("rest/enter/newjoin2")
public class Ent_NewJoin2RestController {

    @Autowired
    GsonUtil gsonUtil;

    @Autowired
    MessageUtil messageUtil;

    @Autowired
    Ent_NewJoin2Service ent_NewJoin2Service;

    @Autowired
    ExcelService excelService;

    @PostMapping("/info/state")
    public String state(P_StatVo pStatVo){
        if(DalbitUtil.isEmpty(pStatVo.getStartDate())){
            pStatVo.setStartDate(null);
        }

        if(DalbitUtil.isEmpty(pStatVo.getEndDate())){
            pStatVo.setEndDate(null);
        }

        String result = ent_NewJoin2Service.callInfoDay(pStatVo);
        return result;
    }


    @PostMapping("/adbrix/add")
    public String adbrixAdd(P_StatVo pStatVo){

        String result = ent_NewJoin2Service.callAdbrixAdd(pStatVo);
        return result;
    }

    @PostMapping("/adbrix/excel")
    public String adbrixExcel(HttpServletRequest request, HttpServletResponse response, Model model, P_StatVo pStatVo) throws GlobalException {

        Model resultModel = ent_NewJoin2Service.adbrixExcel(pStatVo, model);

        excelService.renderMergedOutputModel(resultModel.asMap(), request, response);
        return gsonUtil.toJson(new JsonOutputVo(Status.엑셀다운로드성공));

    }

    @PostMapping("/info/state/adbrix")
    public String stateAdbrix(P_StatVo pStatVo){
        if(DalbitUtil.isEmpty(pStatVo.getStartDate())){
            pStatVo.setStartDate(null);
        }

        if(DalbitUtil.isEmpty(pStatVo.getEndDate())){
            pStatVo.setEndDate(null);
        }

        String result = ent_NewJoin2Service.callStateAdbrix(pStatVo);
        return result;
    }

    @PostMapping("/info/state/adbrix/memo")
    public String stateAdbrixMemo(P_StatVo pStatVo){
        String result = ent_NewJoin2Service.callStateAdbrixMemo(pStatVo);
        return result;
    }


    @PostMapping("/info/state/adbrix/memo/edit")
    public String adbrixMemoEdit(P_StatVo pStatVo){

        String result = ent_NewJoin2Service.adbrixMemoEdit(pStatVo);
        return result;
    }



    @PostMapping("/info/state/memo")
    public String stateMemo(P_StatVo pStatVo){
        String result = ent_NewJoin2Service.callStateMemo(pStatVo);
        return result;
    }


    @PostMapping("/info/state/memo/edit")
    public String memoEdit(P_StatVo pStatVo){

        String result = ent_NewJoin2Service.memoEdit(pStatVo);
        return result;
    }


}
