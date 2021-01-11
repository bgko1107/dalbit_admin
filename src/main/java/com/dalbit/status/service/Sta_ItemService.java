package com.dalbit.status.service;


import com.dalbit.common.code.Status;
import com.dalbit.common.vo.JsonOutputVo;
import com.dalbit.common.vo.ProcedureVo;
import com.dalbit.common.vo.StatVo;
import com.dalbit.status.dao.Sta_ItemDao;
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
public class Sta_ItemService {

    @Autowired
    MessageUtil messageUtil;
    @Autowired
    GsonUtil gsonUtil;
    @Autowired
    Sta_ItemDao sta_ItemDao;


    /**
     * 아이템 고정
     */
    public String callItemLive(){
        ProcedureVo procedureVo = new ProcedureVo();
        sta_ItemDao.callItemLive(procedureVo);
        P_ItemLiveOutputVo itemLive = new Gson().fromJson(procedureVo.getExt(), P_ItemLiveOutputVo.class);

        var result = new HashMap<String, Object>();
        result.put("liveInfo", itemLive);
        return gsonUtil.toJson(new JsonOutputVo(Status.조회, result));
    }

    /**
     * 아이템 총계
     */
    public String callItemTotal(StatVo StatVo){
        ProcedureVo procedureVo = new ProcedureVo(StatVo);
        ArrayList<P_ItemTotalOutDetailVo> detailList = sta_ItemDao.callItemTotal(procedureVo);
        P_ItemTotalOutVo totalInfo = new Gson().fromJson(procedureVo.getExt(), P_ItemTotalOutVo.class);

        if(Integer.parseInt(procedureVo.getRet()) <= 0){
            return gsonUtil.toJson(new JsonOutputVo(Status.데이터없음));
        }

        var result = new HashMap<String, Object>();
        result.put("totalInfo", totalInfo);
        result.put("detailList", detailList);

        return gsonUtil.toJson(new JsonOutputVo(Status.조회, result));
    }

    /**
     * 성별 총계
     */
    public String callItemGender(StatVo StatVo){
        ProcedureVo procedureVo = new ProcedureVo(StatVo);
        ArrayList<P_ItemGenderOutDetailVo> detailList = sta_ItemDao.callItemGender(procedureVo);
        P_ItemGenderOutVo totalInfo = new Gson().fromJson(procedureVo.getExt(), P_ItemGenderOutVo.class);

        if(Integer.parseInt(procedureVo.getRet()) <= 0){
            return gsonUtil.toJson(new JsonOutputVo(Status.데이터없음));
        }

        var result = new HashMap<String, Object>();
        result.put("totalInfo", totalInfo);
        result.put("detailList", detailList);

        return gsonUtil.toJson(new JsonOutputVo(Status.조회, result));
    }

    /**
     * 연령별 총계
     */
    public String callItemAge(StatVo StatVo){
        ProcedureVo procedureVo = new ProcedureVo(StatVo);
        ArrayList<P_ItemAgeOutDetailVo> detailList = sta_ItemDao.callItemAge(procedureVo);
        P_ItemAgeOutVo totalInfo = new Gson().fromJson(procedureVo.getExt(), P_ItemAgeOutVo.class);

        if(Integer.parseInt(procedureVo.getRet()) <= 0){
            return gsonUtil.toJson(new JsonOutputVo(Status.데이터없음));
        }

        var result = new HashMap<String, Object>();
        result.put("totalInfo", totalInfo);
        result.put("detailList", detailList);

        return gsonUtil.toJson(new JsonOutputVo(Status.조회, result));
    }

    /**
     * 방송별별 총계
     */
    public String callItemBroad(P_ItemBroadInputVo pItemBroadInputVo){
        ProcedureVo procedureVo = new ProcedureVo(pItemBroadInputVo);
        ArrayList<P_ItemBroadOutDetailVo> detailList = sta_ItemDao.callItemBroad(procedureVo);
        P_ItemBroadOutVo totalInfo = new Gson().fromJson(procedureVo.getExt(), P_ItemBroadOutVo.class);

        if(Integer.parseInt(procedureVo.getRet()) <= 0){
            return gsonUtil.toJson(new JsonOutputVo(Status.데이터없음));
        }

        var result = new HashMap<String, Object>();
        result.put("totalInfo", totalInfo);
        result.put("detailList", detailList);

        return gsonUtil.toJson(new JsonOutputVo(Status.조회, result));
    }

    /**
     * 클립별 총계
     */
    public String callItemClip(P_ItemClipInputVo pItemClipInputVo){
        ProcedureVo procedureVo = new ProcedureVo(pItemClipInputVo);
        ArrayList<P_ItemClipOutDetailVo> detailList = sta_ItemDao.callItemClip(procedureVo);
        P_ItemBroadOutVo totalInfo = new Gson().fromJson(procedureVo.getExt(), P_ItemBroadOutVo.class);

        if(Integer.parseInt(procedureVo.getRet()) <= 0){
            return gsonUtil.toJson(new JsonOutputVo(Status.데이터없음));
        }

        var result = new HashMap<String, Object>();
        result.put("totalInfo", totalInfo);
        result.put("detailList", detailList);

        return gsonUtil.toJson(new JsonOutputVo(Status.조회, result));
    }

    /**
     * 우체통 총계
     */
    public String callMailboxList(P_MailboxVo pMailboxVo){
        ProcedureVo procedureVo = new ProcedureVo(pMailboxVo);
        ArrayList<P_MailboxVo> detailList = sta_ItemDao.callMailboxList(procedureVo);
        P_MailboxVo totalInfo = new Gson().fromJson(procedureVo.getExt(), P_MailboxVo.class);

        if(Integer.parseInt(procedureVo.getRet()) <= 0){
            return gsonUtil.toJson(new JsonOutputVo(Status.데이터없음));
        }

        var result = new HashMap<String, Object>();
        result.put("totalInfo", totalInfo);
        result.put("detailList", detailList);

        return gsonUtil.toJson(new JsonOutputVo(Status.조회, result));
    }
}
