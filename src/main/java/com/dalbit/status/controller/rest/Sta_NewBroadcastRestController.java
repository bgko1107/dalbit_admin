package com.dalbit.status.controller.rest;

import com.dalbit.status.service.Sta_NewBroadcastService;
import com.dalbit.status.vo.procedure.P_StatVo;
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
@RequestMapping("rest/status/newBroadcast")
public class Sta_NewBroadcastRestController {

    @Autowired
    GsonUtil gsonUtil;
    @Autowired
    MessageUtil messageUtil;
    @Autowired
    Sta_NewBroadcastService sta_NewBroadcastService;

    /**
     * 방송 시간/월간/연간
     * @param pStatVo
     * @return
     */
    @PostMapping("info/time")
    public String time(P_StatVo pStatVo){
        if(DalbitUtil.isEmpty(pStatVo.getStartDate())){
            pStatVo.setStartDate(null);
        }

        if(DalbitUtil.isEmpty(pStatVo.getEndDate())){
            pStatVo.setEndDate(null);
        }

        String result = sta_NewBroadcastService.callNewBroadcastTime(pStatVo);
        return result;
    }

    /**
     * 방송 주제별
     * @param pStatVo
     * @return
     */
    @PostMapping("info/type")
    public String type(P_StatVo pStatVo){
        if(DalbitUtil.isEmpty(pStatVo.getStartDate())){
            pStatVo.setStartDate(null);
        }

        if(DalbitUtil.isEmpty(pStatVo.getEndDate())){
            pStatVo.setEndDate(null);
        }

        String result = sta_NewBroadcastService.callNewBroadcastType(pStatVo);
        return result;
    }

    /**
     * 방송 선물 통계 현황
     */
    @PostMapping("info/gift")
    public String gift(P_StatVo pStatVo){
        String result = sta_NewBroadcastService.callNewBroadcastGift(pStatVo);
        return result;
    }
}
