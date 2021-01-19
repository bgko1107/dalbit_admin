package com.dalbit.menu.controller.rest;

import com.dalbit.common.code.Status;
import com.dalbit.common.vo.JsonOutputVo;
import com.dalbit.excel.service.ExcelService;
import com.dalbit.exception.GlobalException;
import com.dalbit.menu.service.Men_ShiningService;
import com.dalbit.menu.service.RecommendService;
import com.dalbit.menu.vo.*;
import com.dalbit.util.GsonUtil;
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
@RequestMapping("rest/menu/shining")
public class Men_ShiningRestController {

    @Autowired
    GsonUtil gsonUtil;

    @Autowired
    RecommendService recommendService;

    @Autowired
    Men_ShiningService menShiningService;

    @Autowired
    ExcelService excelService;

    /**
     * 샤이닝 DJ 목록
     */
    @PostMapping("list")
    public String list(ShiningVo shiningVo){
        String result = menShiningService.callShiningList(shiningVo);
        return result;
    }

    /**
     * 샤이닝 DJ 대상 삭제
     */
    @PostMapping("delete")
    public String delete(ShiningVo shiningVo){
        String result = menShiningService.callShiningDelete(shiningVo);
        return result;
    }

    /**
     * 샤이닝 DJ 예상 후보 파악 목록
     */
    @PostMapping("expectedList")
    public String expectedList(ShiningVo shiningVo){
        String result = menShiningService.callExpectedList(shiningVo);
        return result;
    }

    /**
     * 샤이닝 DJ 예상 후보 엑셀 저장
     */
    @PostMapping("expectedListExcel")
    public String expectedListExcel(HttpServletRequest request, HttpServletResponse response, Model model, ShiningVo shiningVo) throws GlobalException {

        Model resultModel = menShiningService.getExpectedListExcel(shiningVo, model);

        excelService.renderMergedOutputModel(resultModel.asMap(), request, response);
        return gsonUtil.toJson(new JsonOutputVo(Status.엑셀다운로드성공));
    }


    /**
     * 샤이닝 DJ 등록
     */
    @PostMapping("add")
    public String addShining(ShiningVo shiningVo){
        String result = menShiningService.callAddShining(shiningVo);
        return result;
    }


}
