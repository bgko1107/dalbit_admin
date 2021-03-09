package com.dalbit.event.service;

import com.dalbit.clip.dao.Cli_ClipStatusDao;
import com.dalbit.clip.vo.procedure.*;
import com.dalbit.common.code.Status;
import com.dalbit.common.vo.JsonOutputVo;
import com.dalbit.common.vo.PagingVo;
import com.dalbit.common.vo.ProcedureVo;
import com.dalbit.event.dao.Eve_GGamGGamEDao;
import com.dalbit.event.vo.GGamGGamEVo;
import com.dalbit.member.vo.MemberVo;
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
        ArrayList<GGamGGamEVo> list = eve_GGamGGamEDao.callNewRecordDetail(procedureVo);
        GGamGGamEVo totalInfo = new Gson().fromJson(procedureVo.getExt(), GGamGGamEVo.class);

        return gsonUtil.toJson(new JsonOutputVo(Status.조회, list, new PagingVo(0), totalInfo));
    }

    /**
     * 신기록 이벤트 상세정보 수정
     */
    public String callNewRecordEdit(GGamGGamEVo gGamGGamEVo){
        gGamGGamEVo.setOpName(MemberVo.getMyMemNo());
        ProcedureVo procedureVo = new ProcedureVo(gGamGGamEVo);

        eve_GGamGGamEDao.callNewRecordEdit(procedureVo);
        ProcedureVo outvo = new Gson().fromJson(procedureVo.getExt(), ProcedureVo.class);

        if(Integer.parseInt(procedureVo.getRet()) < 0){
            return gsonUtil.toJson(new JsonOutputVo(Status.비즈니스로직오류));
        }
        return gsonUtil.toJson(new JsonOutputVo(Status.처리완료));
    }

    /**
     * 신기록 이벤트 상세정보 삭제
     */
    public String callNewRecordDelete(GGamGGamEVo gGamGGamEVo){
        String[] idxList = gGamGGamEVo.getIdxList().split("@@");

        for(int i=0; i<idxList.length;i++){
            gGamGGamEVo.setIdx(Integer.parseInt(idxList[i]));
            ProcedureVo procedureVo = new ProcedureVo(gGamGGamEVo);

            try {
                eve_GGamGGamEDao.callNewRecordDelete(procedureVo);
            }catch (Exception e){
                return gsonUtil.toJson(new JsonOutputVo(Status.비즈니스로직오류));
            }
        }
        return gsonUtil.toJson(new JsonOutputVo(Status.처리완료));

    }





}
