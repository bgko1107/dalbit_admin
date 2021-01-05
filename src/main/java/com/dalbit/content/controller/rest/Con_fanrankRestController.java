package com.dalbit.content.controller.rest;

import com.dalbit.content.service.Con_EventService;
import com.dalbit.content.service.Con_FanrankService;
import com.dalbit.content.vo.procedure.P_EventManagementListInputVo;
import com.dalbit.exception.GlobalException;
import com.dalbit.util.GsonUtil;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.util.HashMap;

@Slf4j
@RestController
@RequestMapping("rest/content/fanrank")
public class Con_fanrankRestController {

    @Autowired
    Con_FanrankService conFanrankService;

    @Autowired
    GsonUtil gsonUtil;

    @PostMapping("/onOffList")
    public String fanrankOnOffList(@RequestParam HashMap<String, Object> hashMap) throws GlobalException {
        String result = conFanrankService.callFanrankOnOffList(hashMap);
        return result;
    }
}
