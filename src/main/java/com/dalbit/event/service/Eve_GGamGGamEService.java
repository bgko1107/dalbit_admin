package com.dalbit.event.service;

import com.dalbit.clip.dao.Cli_ClipStatusDao;
import com.dalbit.clip.vo.procedure.*;
import com.dalbit.common.code.Status;
import com.dalbit.common.vo.JsonOutputVo;
import com.dalbit.common.vo.PagingVo;
import com.dalbit.common.vo.ProcedureVo;
import com.dalbit.event.dao.Eve_GGamGGamEDao;
import com.dalbit.event.vo.GGamGGamEVo;
import com.dalbit.util.GsonUtil;
import com.google.gson.Gson;
import lombok.extern.slf4j.Slf4j;
import lombok.var;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.HashMap;

@Slf4j
@Service
public class Eve_GGamGGamEService {

    @Autowired
    GsonUtil gsonUtil;

    @Autowired
    Eve_GGamGGamEDao eve_GGamGGamEDao;

    /**
     * 신기록 이벤트 목록
     */
    public String callNewRecordList(GGamGGamEVo gGamGGamEVo){
        ProcedureVo procedureVo = new ProcedureVo(gGamGGamEVo);
        ArrayList<GGamGGamEVo> detailList = eve_GGamGGamEDao.callNewRecordList(procedureVo);
        GGamGGamEVo totalInfo = new Gson().fromJson(procedureVo.getExt(), GGamGGamEVo.class);

        return gsonUtil.toJson(new JsonOutputVo(Status.조회, detailList, new PagingVo(totalInfo.getTotalCnt(), gGamGGamEVo.getPageStart(), gGamGGamEVo.getPageCnt()), totalInfo));
    }

    /**
     * 신기록 이벤트 상세정보
     */
    public String callNewRecordDetail(GGamGGamEVo gGamGGamEVo){
        ProcedureVo procedureVo = new ProcedureVo(gGamGGamEVo);
        eve_GGamGGamEDao.callNewRecordDetail(procedureVo);
        GGamGGamEVo totalInfo = new Gson().fromJson(procedureVo.getExt(), GGamGGamEVo.class);

        return gsonUtil.toJson(new JsonOutputVo(Status.조회, totalInfo));
    }



}
