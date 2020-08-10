package com.dalbit.sample.controller.rest;

import com.dalbit.common.code.Status;
import com.dalbit.common.service.EmailService;
import com.dalbit.common.vo.EmailVo;
import com.dalbit.common.vo.JsonOutputVo;
import com.dalbit.excel.service.ExcelService;
import com.dalbit.exception.GlobalException;
import com.dalbit.sample.service.SampleService;
import com.dalbit.sample.vo.ErrorVo;
import com.dalbit.util.DalbitUtil;
import com.dalbit.util.GsonUtil;
import com.dalbit.util.OkHttpClientUtil;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.HashMap;

@Slf4j
@RestController
@RequestMapping("rest/sample")
public class SampleRestController {

    @Autowired
    SampleService sampleService;

    @Autowired
    ExcelService excelService;

    @Autowired
    EmailService emailService;

    @Autowired
    GsonUtil gsonUtil;

    @PostMapping("list")
    public String list(Model model){

        ArrayList<HashMap> list = new ArrayList<HashMap>();
        for(int i = 0; i++ < 20;){
            HashMap map = new HashMap();
            map.put("renderingEngine", DalbitUtil.randomValue("string", 10));
            map.put("browser", DalbitUtil.randomValue("string", 6));
            map.put("platform", DalbitUtil.randomValue("string", 9));
            map.put("version", DalbitUtil.randomValue("number", 4));
            map.put("grade", DalbitUtil.randomValue("string", 1));
            list.add(map);
        }

        return gsonUtil.toJson(new JsonOutputVo(Status.조회, list));
    }

    @PostMapping("menu")
    public String menu(HttpServletRequest request) throws Exception {
        String url = (String)request.getParameter("url");

        OkHttpClientUtil okHttpClientUtil = new OkHttpClientUtil();
        String result = okHttpClientUtil.sendGet(url, request, "/", ".inforex.co.kr");

        return result;
    }

    /**
     * 에러 데이터 로그 조회
     */
    @PostMapping("errorList")
    public String errorList(ErrorVo errorVo) {
        String result = sampleService.getLogErrorData(errorVo);
        return result;
    }

    /**
     * 에러 데이터 로그 엑셀 출력
     */
    @PostMapping("errorListExcel")
    public String errorListExcel(HttpServletRequest request, HttpServletResponse response, Model model, ErrorVo errorVo) throws GlobalException {
        Model resultModel = sampleService.getErrorListExcel(errorVo, model);

        excelService.renderMergedOutputModel(resultModel.asMap(), request, response);
        return gsonUtil.toJson(new JsonOutputVo(Status.엑셀다운로드성공));
    }

    @PostMapping("sendEmail")
    public String sendEmail(EmailVo emailVo) throws UnsupportedEncodingException {
        int result = emailService.sendEmail(emailVo);
        return gsonUtil.toJson(new JsonOutputVo(Status.조회));
    }
}
