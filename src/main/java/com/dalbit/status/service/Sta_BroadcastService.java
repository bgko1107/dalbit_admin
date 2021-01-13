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
     * 방송 총계
     */
    public String callBroadcastTotal(P_StatVo pStatVo){
        ProcedureVo procedureVo = new ProcedureVo(pStatVo);
        ArrayList<P_BroadcastTotalOutDetailVo> detailList = sta_BroadcastDao.callBroadcastTotal(procedureVo);

        P_BroadcastTotalOutVo totalInfo = new Gson().fromJson(procedureVo.getExt(), P_BroadcastTotalOutVo.class);

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
    public String callBroadcastPlatform(P_StatVo pStatVo){
        ProcedureVo procedureVo = new ProcedureVo(pStatVo);
        ArrayList<P_BroadcastPlatformOutDetailVo> detailList = sta_BroadcastDao.callBroadcastPlatform(procedureVo);

        P_BroadcastPlatformOutVo totalInfo = new Gson().fromJson(procedureVo.getExt(), P_BroadcastPlatformOutVo.class);

        if(Integer.parseInt(procedureVo.getRet()) <= 0){
            return gsonUtil.toJson(new JsonOutputVo(Status.데이터없음));
        }

        var result = new HashMap<String, Object>();
        result.put("totalInfo", totalInfo);
        result.put("detailList", detailList);

        return gsonUtil.toJson(new JsonOutputVo(Status.조회, result));
    }

    /**
     * 방송개설 방송주제
     */
    public String callBroadcastSubjectCreate(P_StatVo pStatVo){
        ProcedureVo procedureVo = new ProcedureVo(pStatVo);
        ArrayList<P_BroadcastSubjectCreateOutDetailVo> detailList = sta_BroadcastDao.callBroadcastSubjectCreate(procedureVo);

        P_BroadcastSubjectCreateOutVo totalInfo = new Gson().fromJson(procedureVo.getExt(), P_BroadcastSubjectCreateOutVo.class);

        if(Integer.parseInt(procedureVo.getRet()) <= 0){
            return gsonUtil.toJson(new JsonOutputVo(Status.데이터없음));
        }

        var result = new HashMap<String, Object>();
        result.put("totalInfo", totalInfo);
        result.put("detailList", detailList);

        return gsonUtil.toJson(new JsonOutputVo(Status.조회, result));
    }

    /**
     * 방송개설 방송주제
     */
    public String callBroadcastSubjectTime(P_StatVo pStatVo){
        ProcedureVo procedureVo = new ProcedureVo(pStatVo);
        ArrayList<P_BroadcastSubjectTimeOutDetailVo> detailList = sta_BroadcastDao.callBroadcastSubjectTime(procedureVo);

        P_BroadcastSubjectTimeOutVo totalInfo = new Gson().fromJson(procedureVo.getExt(), P_BroadcastSubjectTimeOutVo.class);

        if(Integer.parseInt(procedureVo.getRet()) <= 0){
            return gsonUtil.toJson(new JsonOutputVo(Status.데이터없음));
        }

        var result = new HashMap<String, Object>();
        result.put("totalInfo", totalInfo);
        result.put("detailList", detailList);

        return gsonUtil.toJson(new JsonOutputVo(Status.조회, result));
    }

    /**
     * 방송DJ
     */
    public String callBroadcastDj(P_StatVo pStatVo){
        ProcedureVo procedureVo = new ProcedureVo(pStatVo);
        ArrayList<P_BroadcastDjOutDetailVo> detailList = sta_BroadcastDao.callBroadcastDj(procedureVo);

        P_BroadcastDjOutVo totalInfo = new Gson().fromJson(procedureVo.getExt(), P_BroadcastDjOutVo.class);

        if(Integer.parseInt(procedureVo.getRet()) <= 0){
            return gsonUtil.toJson(new JsonOutputVo(Status.데이터없음));
        }

        var result = new HashMap<String, Object>();
        result.put("totalInfo", totalInfo);
        result.put("detailList", detailList);

        return gsonUtil.toJson(new JsonOutputVo(Status.조회, result));
    }

    /**
     * 방송DJ
     */
    public String callBroadcastListenerSubject(P_StatVo pStatVo){
        ProcedureVo procedureVo = new ProcedureVo(pStatVo);
        ArrayList<P_BroadcastListenerSubjectOutDetailVo> detailList = sta_BroadcastDao.callBroadcastListenerSubject(procedureVo);

        P_BroadcastListenerSubjectOutVo totalInfo = new Gson().fromJson(procedureVo.getExt(), P_BroadcastListenerSubjectOutVo.class);

        if(Integer.parseInt(procedureVo.getRet()) <= 0){
            return gsonUtil.toJson(new JsonOutputVo(Status.데이터없음));
        }

        var result = new HashMap<String, Object>();
        result.put("totalInfo", totalInfo);
        result.put("detailList", detailList);

        return gsonUtil.toJson(new JsonOutputVo(Status.조회, result));
    }


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

    public String callBroadcastGiftHistory(P_StatVo pStatVo){
        ProcedureVo procedureVo = new ProcedureVo(pStatVo);
        ArrayList<P_BroadcastGiftHistoryOutputDetailVo> broadList = sta_BroadcastDao.callBroadcastGiftHistory(procedureVo);

//        for(int i=0;i<broadList.size();i ++ ) {
//            MemberVo memInfoOutVo = DalbitUtil.getMemInfo(broadList.get(i).getMem_no());
//            if (!DalbitUtil.isEmpty(memInfoOutVo)) {
//                broadList.get(i).setMem_sex(memInfoOutVo.getMem_sex());
//                broadList.get(i).setMem_birth_year(memInfoOutVo.getMem_birth_year());
//                broadList.get(i).setMem_birth_month(memInfoOutVo.getMem_birth_month());
//                broadList.get(i).setMem_birth_day(memInfoOutVo.getMem_birth_day());
//            }
//        }

        P_BroadcastGiftHistoryOutputVo totalInfo = new Gson().fromJson(procedureVo.getExt(), P_BroadcastGiftHistoryOutputVo.class);
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
