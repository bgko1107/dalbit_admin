package com.dalbit.content.controller.rest;

import com.dalbit.common.code.Status;
import com.dalbit.common.service.CommonService;
import com.dalbit.common.vo.CodeVo;
import com.dalbit.common.vo.JsonOutputVo;
import com.dalbit.content.service.ThemeService;
import com.dalbit.content.vo.ThemeVo;
import com.dalbit.util.GsonUtil;
import com.google.gson.Gson;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

@Slf4j
@RestController
@RequestMapping("rest/content/theme")
public class ThemeRestController {

    @Autowired
    ThemeService service;

    @Autowired
    CommonService commonService;

    @Autowired
    GsonUtil gsonUtil;

    @PostMapping("broadcast/list")
    public String broadcastList(HttpServletRequest request, ThemeVo splashVo) {
        List<CodeVo> roomTypeList = commonService.getCodeList("roomType");

        return gsonUtil.toJson(new JsonOutputVo(Status.조회, roomTypeList));
    }

    @PostMapping("broadcast/submit")
    public String broadcastUpdate(HttpServletRequest request) {
        String codeType = request.getParameter("codeType");
        String codeVoArr = request.getParameter("codeVoArr");

        CodeVo[] codeVos = new Gson().fromJson(codeVoArr, CodeVo[].class);

        service.callContentsThemeEdit(codeType, codeVos);
        //API splash Reload
        service.sendSplashApi();

        return gsonUtil.toJson(new JsonOutputVo(Status.수정));
    }


    @PostMapping("cast")
    public String castList(HttpServletRequest request, ThemeVo splashVo) {
        List<CodeVo> roomTypeList = commonService.getCodeList("roomType");

        return gsonUtil.toJson(new JsonOutputVo(Status.조회, roomTypeList));
    }
}
