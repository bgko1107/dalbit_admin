package com.dalbit.enter.controller.rest;

import com.dalbit.enter.service.Ent_NewJoinService;
import com.dalbit.enter.vo.procedure.P_StatVo;
import com.dalbit.util.DalbitUtil;
import com.dalbit.util.GsonUtil;
import com.dalbit.util.MessageUtil;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@Slf4j
@RestController
@RequestMapping("rest/enter/newJoin")
public class Ent_NewJoinRestController {

    @Autowired
    GsonUtil gsonUtil;

    @Autowired
    MessageUtil messageUtil;

    @Autowired
    Ent_NewJoinService ent_NewJoinService;

    @PostMapping("info/live")
    public String infoLive(P_StatVo pStatVo){
        String result = ent_NewJoinService.callInfoLive(pStatVo);
        return result;
    }

    @PostMapping("info/calender")
    public String calender(P_StatVo pStatVo){
        String result = ent_NewJoinService.callCalender(pStatVo);
        return result;
    }

    @PostMapping("info/month")
    public String month(P_StatVo pStatVo){
        if(DalbitUtil.isEmpty(pStatVo.getStartDate())){
            pStatVo.setStartDate(null);
        }
        if(DalbitUtil.isEmpty(pStatVo.getEndDate())){
            pStatVo.setEndDate(null);
        }
        String result = ent_NewJoinService.callMonth(pStatVo);
        return result;
    }

    @PostMapping("platform/age")
    public String platformAge(P_StatVo pStatVo){
        if(DalbitUtil.isEmpty(pStatVo.getStartDate())){
            pStatVo.setStartDate(null);
        }
        if(DalbitUtil.isEmpty(pStatVo.getEndDate())){
            pStatVo.setEndDate(null);
        }
        String result = ent_NewJoinService.callJoinPlatformAge(pStatVo);
        return result;
    }

    @PostMapping("platform/gender")
    public String platformGender(P_StatVo pStatVo){
        if(DalbitUtil.isEmpty(pStatVo.getStartDate())){
            pStatVo.setStartDate(null);
        }
        if(DalbitUtil.isEmpty(pStatVo.getEndDate())){
            pStatVo.setEndDate(null);
        }
        String result = ent_NewJoinService.callJoinPlatformGender(pStatVo);
        return result;
    }

}
