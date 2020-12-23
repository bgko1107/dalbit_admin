package com.dalbit.content.controller.rest;

import com.dalbit.content.service.Con_RouletteEventService;
import com.dalbit.content.vo.AttendanceCalendarVo;
import com.dalbit.content.vo.RouletteApplyVo;
import com.dalbit.content.vo.RouletteCalendarVo;
import com.dalbit.content.vo.procedure.P_RouletteRateVo;
import com.dalbit.util.GsonUtil;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@Slf4j
@RestController
@RequestMapping("rest/content/event/roulette")
public class Con_RouletteEventRestController {

    @Autowired
    Con_RouletteEventService con_rouletteEventService;

    @Autowired
    GsonUtil gsonUtil;

    /**
     * 선물지급관리
     */
    @PostMapping("/selectRouletteRate")
    public String selectRouletteRate(P_RouletteRateVo pRouletteRateVo) {
        String result = con_rouletteEventService.selectRouletteRate(pRouletteRateVo);
        return result;
    }

    /**
     * 선물지급관리
     */
    @PostMapping("/updateRouletteRate")
    public String updateRouletteRate(P_RouletteRateVo pRouletteRateVo) {
        String result = con_rouletteEventService.updateRouletteRate(pRouletteRateVo);
        return result;
    }

    /**
     * 참여자 목록
     */
    @PostMapping("/selectApplyList")
    public String selectApplyList(RouletteApplyVo rouletteApplyVo){
        String result = con_rouletteEventService.selectRouletteApplyList(rouletteApplyVo);
        return result;
    }

    /**
     * 이벤트 현황 summary
     */
    @PostMapping("/calendar/week")
    public String attendanceCalendarWeek(RouletteCalendarVo rouletteCalendarVo) {
        String result = con_rouletteEventService.selectRouletteWeekCalendarList(rouletteCalendarVo);
        return result;
    }

    /**
     * 룰렛이벤트 달력 조회
     */
    @PostMapping("/calendar/list")
    public String attendanceCalendarList(RouletteCalendarVo rouletteCalendarVo) {
        String result = con_rouletteEventService.selectRouletteCalendarList(rouletteCalendarVo);
        return result;
    }

}