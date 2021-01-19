package com.dalbit.content.controller.rest;

import com.dalbit.content.service.Con_TimeEventService;
import com.dalbit.content.vo.TimeEventVo;
import com.dalbit.util.GsonUtil;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@Slf4j
@RestController
@RequestMapping("rest/content/event/time")
public class Con_TimeEventRestController {

    @Autowired
    Con_TimeEventService con_timeEventService;

    @Autowired
    GsonUtil gsonUtil;

    @PostMapping("/list")
    public String timeList(TimeEventVo timeEventVo) {
        String result = con_timeEventService.selectTimeList(timeEventVo);
        return result;
    }

    @PostMapping("/detail")
    public String timeDetail(TimeEventVo timeEventVo) {
        String result = con_timeEventService.selectTimeDetail(timeEventVo);
        return result;
    }

    @PostMapping("/save")
    public String saveTimeEvent(TimeEventVo timeEventVo) {
        String result = con_timeEventService.saveTimeEvent(timeEventVo);
        return result;
    }

    @PostMapping("/stop")
    public String stopTimeEvent(TimeEventVo timeEventVo) {
        String result = con_timeEventService.stopTimeEvent(timeEventVo);
        return result;
    }

    @PostMapping("/delete")
    public String deleteTimeEvent(TimeEventVo timeEventVo) {
        String result = con_timeEventService.deleteTimeEvent(timeEventVo);
        return result;
    }

    @PostMapping("/copy")
    public String copyTimeEvent(TimeEventVo timeEventVo) {
        String result = con_timeEventService.copyTimeEvent(timeEventVo);
        return result;
    }

}