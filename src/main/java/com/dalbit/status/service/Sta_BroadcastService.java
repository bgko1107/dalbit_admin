package com.dalbit.status.service;


import com.dalbit.common.code.Status;
import com.dalbit.common.vo.JsonOutputVo;
import com.dalbit.common.vo.ProcedureVo;
import com.dalbit.status.dao.Sta_BroadcastDao;
import com.dalbit.status.vo.procedure.*;
import com.dalbit.util.GsonUtil;
import com.dalbit.util.MessageUtil;
import com.google.gson.Gson;
import lombok.extern.slf4j.Slf4j;
import lombok.var;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.HashMap;

@Slf4j
@Service
public class Sta_BroadcastService {

    @Autowired
    MessageUtil messageUtil;
    @Autowired
    GsonUtil gsonUtil;
    @Autowired
    Sta_BroadcastDao sta_BroadcastDao;

    /**
     * 방송 고정
     */
    public String callBroadcastLive(){
        ProcedureVo procedureVo = new ProcedureVo();
        sta_BroadcastDao.callBroadcastLive(procedureVo);
        P_BroadcastLiveOutputVo broadCastLive = new Gson().fromJson(procedureVo.getExt(), P_BroadcastLiveOutputVo.class);

        var result = new HashMap<String, Object>();
        result.put("broadCastLiveInfo", broadCastLive);
        return gsonUtil.toJson(new JsonOutputVo(Status.조회, result));
    }

    /**
     * 방송 선물 통계 현황
     */
    public String callBroadcastGift(P_StatVo pStatVo){
        ProcedureVo procedureVo = new ProcedureVo(pStatVo);
        ArrayList<P_BroadcastGiftOutputVo> broadList = sta_BroadcastDao.callBroadcastGift(procedureVo);

        P_BroadcastGiftOutVo totalInfo = new Gson().fromJson(procedureVo.getExt(), P_BroadcastGiftOutVo.class);
        if(Integer.parseInt(procedureVo.getRet()) <= 0){
            return gsonUtil.toJson(new JsonOutputVo(Status.데이터없음));
        }

        var result = new HashMap<String, Object>();
        result.put("totalInfo", totalInfo);
        result.put("detailList", broadList);

        return gsonUtil.toJson(new JsonOutputVo(Status.조회, result));
    }














    /**
     * 방송 통계 현황
     */
    public String callBroadcastSumStatus(P_StatVo pStatVo){
        ProcedureVo procedureVo = new ProcedureVo(pStatVo);
        ArrayList<P_BroadcastStatusOutputVo> broadList = sta_BroadcastDao.callBroadcastSumStatus(procedureVo);

        P_BroadcastStatusOutVo totalInfo = new Gson().fromJson(procedureVo.getExt(), P_BroadcastStatusOutVo.class);
        if(Integer.parseInt(procedureVo.getRet()) <= 0){
            return gsonUtil.toJson(new JsonOutputVo(Status.데이터없음));
        }

        var result = new HashMap<String, Object>();
        result.put("totalInfo", totalInfo);
        result.put("detailList", broadList);

        return gsonUtil.toJson(new JsonOutputVo(Status.조회, result));
    }

}
