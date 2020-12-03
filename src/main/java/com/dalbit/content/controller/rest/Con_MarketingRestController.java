package com.dalbit.content.controller.rest;

import com.dalbit.content.service.Con_MarketingService;
import com.dalbit.content.vo.procedure.*;
import com.dalbit.excel.service.ExcelService;
import com.dalbit.util.GsonUtil;
import com.dalbit.util.MessageUtil;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;


@Slf4j
@RestController
@RequestMapping("rest/content/marketing")
public class Con_MarketingRestController {

    @Autowired
    Con_MarketingService conMarketingService;

    @Autowired
    ExcelService excelService;

    @Autowired
    GsonUtil gsonUtil;

    @Autowired
    MessageUtil messageUtil;

    /**
     * 위클리픽 목록
     */
    @PostMapping("/weekly/list")
    public String weekly(P_MarketingVo pMarketingVo) {
        pMarketingVo.setSlctType(1);
        String result = conMarketingService.callMarketingList(pMarketingVo);
        return result;
    }

    /**
     * 15초 광고모델
     */
    @PostMapping("/second/list")
    public String modelList(P_MarketingVo pMarketingVo) {
        pMarketingVo.setSlctType(2);
        String result = conMarketingService.callMarketingList(pMarketingVo);
        return result;
    }

    /**
     * 마케팅관리 상세
     */
    @PostMapping("/detail")
    public String detail(P_MarketingVo pMarketingVo) {
        String result = conMarketingService.callMarketingDetail(pMarketingVo);
        return result;
    }

    /**
     * 마케팅관리 수정
     */
    @PostMapping("/update")
    public String update(P_MarketingVo pMarketingVo) {
        String result = conMarketingService.callMarketingUpdate(pMarketingVo);
        return result;
    }

    /**
     * 마케팅관리 등록
     */
    @PostMapping("/insert")
    public String insert(P_MarketingVo pMarketingVo) {
        String result = conMarketingService.callMarketingInsert(pMarketingVo);
        return result;
    }

    /**
     * 마케팅관리 삭제
     */
    @PostMapping("/delete")
    public String delete(P_MarketingVo pMarketingVo) {
        String result = conMarketingService.callMarketingDelete(pMarketingVo);
        return result;
    }

}
