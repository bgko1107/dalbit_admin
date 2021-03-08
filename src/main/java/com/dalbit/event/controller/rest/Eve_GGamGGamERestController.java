package com.dalbit.event.controller.rest;

import com.dalbit.event.service.Eve_GGamGGamEService;
import com.dalbit.event.vo.GGamGGamEVo;
import com.dalbit.util.GsonUtil;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@Slf4j
@RestController
@RequestMapping("rest/event/ggamggame")
public class Eve_GGamGGamERestController {

    @Autowired
    GsonUtil gsonUtil;

    @Autowired
    Eve_GGamGGamEService eve_GGamGGamEService;

    /**
     * 클립 등록 현황 조회
     */
    @PostMapping("ggamggame/newrecord")
    public String newRecordList(GGamGGamEVo gGamGGamEVo) {
        String result = eve_GGamGGamEService.callNewRecordList(gGamGGamEVo);
        return result;
    }

}
