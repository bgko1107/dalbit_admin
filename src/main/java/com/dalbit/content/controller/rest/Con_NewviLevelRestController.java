package com.dalbit.content.controller.rest;

import com.dalbit.content.service.Con_BannerService;
import com.dalbit.content.service.Con_NewviLevelService;
import com.dalbit.content.vo.procedure.*;
import com.dalbit.util.GsonUtil;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@Slf4j
@RestController
@RequestMapping("rest/content/newvilevel")
public class Con_NewviLevelRestController {

    @Autowired
    GsonUtil gsonUtil;

    @Autowired
    Con_NewviLevelService con_NewviLevelService;

    /**
     * 5,10 레벨 보상 현황
     */
    @PostMapping("day")
    public String day(P_NewviLevelInputVo pNewviLevelInputVo) {
        String result = con_NewviLevelService.callDay(pNewviLevelInputVo);
        return result;
    }

    /**
     * 5,10 레벨 보상 받은 대상
     */
    @PostMapping("detail")
    public String detailList(P_NewviLevelInputVo pNewviLevelInputVo) {
        String result = con_NewviLevelService.callDetailList(pNewviLevelInputVo);
        return result;
    }


}
