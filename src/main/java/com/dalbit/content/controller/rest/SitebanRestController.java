package com.dalbit.content.controller.rest;

import com.dalbit.common.code.Status;
import com.dalbit.common.service.CommonService;
import com.dalbit.common.vo.JsonOutputVo;
import com.dalbit.content.service.SitebanService;
import com.dalbit.content.vo.SitebanVo;
import com.dalbit.excel.service.ExcelService;
import com.dalbit.exception.GlobalException;
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
@RequestMapping("rest/content/siteban")
public class SitebanRestController {

    @Autowired
    SitebanService sitebanService;

    @Autowired
    CommonService commonService;

    @Autowired
    ExcelService excelService;

    @Autowired
    GsonUtil gsonUtil;

    @PostMapping("list")
    public String list(SitebanVo paramSitebanVo) {
        SitebanVo sitebanVo = sitebanService.selectBanword(paramSitebanVo);

        return gsonUtil.toJson(new JsonOutputVo(Status.조회, sitebanVo));
    }

    @PostMapping("update")
    public String update(SitebanVo sitebanVo) {
        sitebanService.updateBanword(sitebanVo);

        return gsonUtil.toJson(new JsonOutputVo(Status.수정, sitebanService.selectBanword(sitebanVo)));
    }

    /**
     * 엑셀
     */
    @PostMapping("listExcel")
    public String listExcel(HttpServletRequest request, HttpServletResponse response, Model model, SitebanVo sitebanVo) throws GlobalException {
        Model resultModel = sitebanService.getListExcel(model, sitebanVo);

        excelService.renderMergedOutputModel(resultModel.asMap(), request, response);
        return gsonUtil.toJson(new JsonOutputVo(Status.엑셀다운로드성공));
    }

}
