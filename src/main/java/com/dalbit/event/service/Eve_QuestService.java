package com.dalbit.event.service;

import com.dalbit.common.code.Status;
import com.dalbit.common.vo.JsonOutputVo;
import com.dalbit.common.vo.PagingVo;
import com.dalbit.common.vo.ProcedureVo;
import com.dalbit.event.dao.Eve_QuestDao;
import com.dalbit.event.vo.QuestVo;
import com.dalbit.member.vo.MemberVo;
import com.dalbit.util.GsonUtil;
import com.google.gson.Gson;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;

@Slf4j
@Service
public class Eve_QuestService {

    @Autowired
    GsonUtil gsonUtil;

    @Autowired
    Eve_QuestDao eve_QuestDao;

    /**
     * 퀘스트 이벤트 목록
     */
    public String callList(QuestVo QuestVo){
        ProcedureVo procedureVo = new ProcedureVo(QuestVo);
        ArrayList<QuestVo> detailList = eve_QuestDao.callList(procedureVo);
        QuestVo totalInfo = new Gson().fromJson(procedureVo.getExt(), QuestVo.class);

        return gsonUtil.toJson(new JsonOutputVo(Status.조회, detailList, new PagingVo(totalInfo.getTotalCnt(), QuestVo.getPageStart(), QuestVo.getPageCnt()), totalInfo));
    }

    /**
     * 퀘스트 이벤트 상세정보
     */
    public String callDetail(QuestVo QuestVo){
        ProcedureVo procedureVo = new ProcedureVo(QuestVo);
        ArrayList<QuestVo> list = eve_QuestDao.callDetail(procedureVo);
        QuestVo totalInfo = new Gson().fromJson(procedureVo.getExt(), QuestVo.class);

        return gsonUtil.toJson(new JsonOutputVo(Status.조회, list, new PagingVo(0), totalInfo));
    }

    /**
     * 퀘스트 이벤트 상세정보 수정
     */
    public String callEdit(QuestVo QuestVo){
        QuestVo.setOpName(MemberVo.getMyMemNo());
        ProcedureVo procedureVo = new ProcedureVo(QuestVo);

        eve_QuestDao.callEdit(procedureVo);
        ProcedureVo outvo = new Gson().fromJson(procedureVo.getExt(), ProcedureVo.class);

        if(Integer.parseInt(procedureVo.getRet()) < 0){
            return gsonUtil.toJson(new JsonOutputVo(Status.비즈니스로직오류));
        }
        return gsonUtil.toJson(new JsonOutputVo(Status.처리완료));
    }

    /**
     * 퀘스트 참여자 목록
     */
    public String callMember(QuestVo QuestVo){
        ProcedureVo procedureVo = new ProcedureVo(QuestVo);
        ArrayList<QuestVo> detailList = eve_QuestDao.callMember(procedureVo);
        QuestVo totalInfo = new Gson().fromJson(procedureVo.getExt(), QuestVo.class);

        return gsonUtil.toJson(new JsonOutputVo(Status.조회, detailList, new PagingVo(totalInfo.getTotalCnt(), QuestVo.getPageStart(), QuestVo.getPageCnt()), totalInfo));
    }

}
