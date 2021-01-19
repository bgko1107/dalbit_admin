package com.dalbit.enter.controller.rest;

import com.dalbit.enter.service.Ent_JoinService;
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
@RequestMapping("rest/enter/join")
public class Ent_JoinRestController {

    @Autowired
    GsonUtil gsonUtil;

    @Autowired
    MessageUtil messageUtil;

    @Autowired
    Ent_JoinService entJoinService;

    @PostMapping("info/total")
    public String infoTotal(P_StatVo pStatVo){
        if(DalbitUtil.isEmpty(pStatVo.getStartDate())){
            pStatVo.setStartDate(null);
        }

        if(DalbitUtil.isEmpty(pStatVo.getEndDate())){
            pStatVo.setEndDate(null);
        }

        String result = entJoinService.callJoinTotal(pStatVo);
        return result;
    }

    @PostMapping("info/gender")
    public String infoGender(P_StatVo pStatVo){

        if(DalbitUtil.isEmpty(pStatVo.getStartDate())){
            pStatVo.setStartDate(null);
        }

        if(DalbitUtil.isEmpty(pStatVo.getEndDate())){
            pStatVo.setEndDate(null);
        }

        String result = entJoinService.callJoinGender(pStatVo);
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

        String result = entJoinService.callJoinPlatformGender(pStatVo);
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

        String result = entJoinService.callJoinPlatformAge(pStatVo);
        return result;
    }

    @PostMapping("info/withdraw")
    public String infoWithdraw(P_StatVo pStatVo){

        if(DalbitUtil.isEmpty(pStatVo.getStartDate())){
            pStatVo.setStartDate(null);
        }

        if(DalbitUtil.isEmpty(pStatVo.getEndDate())){
            pStatVo.setEndDate(null);
        }

        String result = entJoinService.callJoinWithdraw(pStatVo);
        return result;
    }

    @PostMapping("stat/join")
    public String statJoin(){
        String result = entJoinService.callStatJoin();
        return result;
    }

    @PostMapping("stat/withdraw")
    public String statWithdraw(){
        String result = entJoinService.callStatWithdraw();
        return result;
    }
}
