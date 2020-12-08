package com.dalbit.menu.controller.rest;

import com.dalbit.common.code.Status;
import com.dalbit.common.vo.JsonOutputVo;
import com.dalbit.excel.service.ExcelService;
import com.dalbit.exception.GlobalException;
import com.dalbit.menu.service.Men_ShiningService;
import com.dalbit.menu.service.Men_SpecialService;
import com.dalbit.menu.service.RecommendService;
import com.dalbit.menu.vo.*;
import com.dalbit.util.GsonUtil;
import com.google.gson.Gson;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.List;

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
     * 스페셜 달D 신청 목록 조회
     */
    @PostMapping("expectedList")
    public String expectedList(ShiningVo shiningVo){
        String result = menShiningService.callExpectedList(shiningVo);
        return result;
    }

    /**
     * 스페셜 달D 신청 목록 조회
     */
    @PostMapping("expectedListExcel")
    public String expectedListExcel(HttpServletRequest request, HttpServletResponse response, Model model, ShiningVo shiningVo) throws GlobalException {

        Model resultModel = menShiningService.getExpectedListExcel(shiningVo, model);

        excelService.renderMergedOutputModel(resultModel.asMap(), request, response);
        return gsonUtil.toJson(new JsonOutputVo(Status.엑셀다운로드성공));
    }


}
