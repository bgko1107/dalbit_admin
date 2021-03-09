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
     * 신기록 이벤트 목록
     */
    @PostMapping("newrecord/list")
    public String newRecordList(GGamGGamEVo gGamGGamEVo) {
        String result = eve_GGamGGamEService.callNewRecordList(gGamGGamEVo);
        return result;
    }

    /**
     * 신기록 이벤트 상세 정보
     */
    @PostMapping("newrecord/detail")
    public String newRecordDetail(GGamGGamEVo gGamGGamEVo) {
        String result = eve_GGamGGamEService.callNewRecordDetail(gGamGGamEVo);
        return result;
    }

    /**
     * 신기록 이벤트 상세 정보 수정
     */
    @PostMapping("newrecord/edit")
    public String newRecordEdit(GGamGGamEVo gGamGGamEVo) {
        String result = eve_GGamGGamEService.callNewRecordEdit(gGamGGamEVo);
        return result;
    }

    /**
     * 신기록 이벤트 상세 정보 삭제
     */
    @PostMapping("newrecord/delete")
    public String newRecordDelete(GGamGGamEVo gGamGGamEVo) {
        String result = eve_GGamGGamEService.callNewRecordDelete(gGamGGamEVo);
        return result;
    }

}
