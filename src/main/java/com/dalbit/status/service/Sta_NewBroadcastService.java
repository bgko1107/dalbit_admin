package com.dalbit.status.service;


import com.dalbit.common.code.Status;
import com.dalbit.common.vo.JsonOutputVo;
import com.dalbit.common.vo.ProcedureVo;
import com.dalbit.status.dao.Sta_NewBroadcastDao;
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
public class Sta_NewBroadcastService {

    @Autowired
    MessageUtil messageUtil;
    @Autowired
    GsonUtil gsonUtil;
    @Autowired
    Sta_NewBroadcastDao sta_NewBroadcastDao;


    /**
     * 방송 시간/월간/연간
     */
    public String callNewBroadcastTime(P_StatVo pStatVo){
        ProcedureVo procedureVo = new ProcedureVo(pStatVo);
        ArrayList<P_NewBroadcastTimeOutVo> detailList = sta_NewBroadcastDao.callNewBroadcastTime(procedureVo);
        P_NewBroadcastTimeOutVo totalInfo = new Gson().fromJson(procedureVo.getExt(), P_NewBroadcastTimeOutVo.class);

        if(Integer.parseInt(procedureVo.getRet()) <= 0){
            return gsonUtil.toJson(new JsonOutputVo(Status.데이터없음));
        }

        var result = new HashMap<String, Object>();
        result.put("totalInfo", totalInfo);
        result.put("detailList", detailList);

        return gsonUtil.toJson(new JsonOutputVo(Status.조회, result));
    }

    /**
     * 방송 new 시간/월간
     */
    public String callNewBroadcastTimeNew(P_StatVo pStatVo){
        ProcedureVo procedureVo = new ProcedureVo(pStatVo);
        ArrayList<P_NewBroadcastTimeNewOutVo> detailList = sta_NewBroadcastDao.callNewBroadcastTimeNew(procedureVo);
        P_NewBroadcastTimeNewOutVo totalInfo = new Gson().fromJson(procedureVo.getExt(), P_NewBroadcastTimeNewOutVo.class);
        if(Integer.parseInt(procedureVo.getRet()) <= 0){
            return gsonUtil.toJson(new JsonOutputVo(Status.데이터없음));
        }
        var result = new HashMap<String, Object>();
        result.put("totalInfo", totalInfo);
        result.put("detailList", detailList);
        return gsonUtil.toJson(new JsonOutputVo(Status.조회, result));
    }

    /**
     * 방송 플랫폼
     */
    public String callNewBroadcastType(P_StatVo pStatVo){
        ProcedureVo procedureVo = new ProcedureVo(pStatVo);
        ArrayList<P_NewBroadcastTypeOutVo> detailList = sta_NewBroadcastDao.callNewBroadcastType(procedureVo);
        P_NewBroadcastTypeOutVo totalInfo = new Gson().fromJson(procedureVo.getExt(), P_NewBroadcastTypeOutVo.class);

        if(Integer.parseInt(procedureVo.getRet()) <= 0){
            return gsonUtil.toJson(new JsonOutputVo(Status.데이터없음));
        }

        var result = new HashMap<String, Object>();
        result.put("totalInfo", totalInfo);
        result.put("detailList", detailList);

        return gsonUtil.toJson(new JsonOutputVo(Status.조회, result));
    }

    public String callNewBroadcastGift(P_StatVo pStatVo){
        ProcedureVo procedureVo = new ProcedureVo(pStatVo);
        ArrayList<P_NewBroadcastGiftOutputVo> broadList = sta_NewBroadcastDao.callNewBroadcastGift(procedureVo);

        P_NewBroadcastGiftOutputVo totalInfo = new Gson().fromJson(procedureVo.getExt(), P_NewBroadcastGiftOutputVo.class);
        if(broadList.size() < 1){
            return gsonUtil.toJson(new JsonOutputVo(Status.데이터없음));
        }

        var result = new HashMap<String, Object>();
        result.put("totalInfo", totalInfo);
        result.put("detailList", broadList);

        return gsonUtil.toJson(new JsonOutputVo(Status.조회, result));
    }


}
