package com.dalbit.content.controller.rest;

import com.dalbit.content.service.Con_MarketingService;
import com.dalbit.content.vo.MarketingVo;
import com.dalbit.util.GsonUtil;
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
    GsonUtil gsonUtil;
    @Autowired
    Con_MarketingService con_MarketingRestService;


    /**
     * 위클리픽 목록 조회
     */
    @PostMapping("/weekly/list")
    public String weeklyList(MarketingVo marketingVo) {
        String result = con_MarketingRestService.callWeeklyList(marketingVo);
        return result;
    }

}
