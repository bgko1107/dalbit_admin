package com.dalbit.content.service;


import com.dalbit.common.code.Status;
import com.dalbit.common.vo.JsonOutputVo;
import com.dalbit.common.vo.ProcedureVo;
import com.dalbit.content.dao.Con_FullmoonDao;
import com.dalbit.content.vo.procedure.P_FullmoonConditionVo;
import com.dalbit.content.vo.procedure.P_FullmoonEventVo;
import com.dalbit.content.vo.procedure.P_FullmoonRankingVo;
import com.dalbit.content.vo.procedure.P_FullmoonTextVo;
import com.dalbit.member.vo.MemberVo;
import com.dalbit.util.GsonUtil;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;


@Slf4j
@Service
public class Con_FullmoonService {

    @Autowired
    GsonUtil gsonUtil;

    @Autowired
    Con_FullmoonDao con_fullmoonDao;

    public String callFullmoonManagementSelect(P_FullmoonConditionVo pFullmoonConditionVo) {
        ProcedureVo procedureVo = new ProcedureVo(pFullmoonConditionVo);
        ArrayList<P_FullmoonConditionVo> list = con_fullmoonDao.callFullmoonManagementSelect(procedureVo);
        return gsonUtil.toJson(new JsonOutputVo(Status.조회, list));
    }

    public String callFullmoonManagementEdit(P_FullmoonConditionVo pFullmoonConditionVo) {
        pFullmoonConditionVo.setOpName(MemberVo.getMyMemNo());
        ProcedureVo procedureVo = new ProcedureVo(pFullmoonConditionVo);
        con_fullmoonDao.callFullmoonManagementEdit(procedureVo);
        return gsonUtil.toJson(new JsonOutputVo(Status.수정));
    }

    public String callFullmoonTextSelect(P_FullmoonTextVo pFullmoonTextVo) {
        ProcedureVo procedureVo = new ProcedureVo(pFullmoonTextVo);
        ArrayList<P_FullmoonTextVo> list = con_fullmoonDao.callFullmoonTextSelect(procedureVo);
        return gsonUtil.toJson(new JsonOutputVo(Status.조회, list));
    }

    public String callFullmoonTextEdit(P_FullmoonTextVo pFullmoonTextVo) {
        pFullmoonTextVo.setOpName(MemberVo.getMyMemNo());
        ProcedureVo procedureVo = new ProcedureVo(pFullmoonTextVo, true);
        con_fullmoonDao.callFullmoonTextEdit(procedureVo);
        return gsonUtil.toJson(new JsonOutputVo(Status.수정));
    }

    public String callFullmoonEventList(P_FullmoonEventVo pFullmoonEventVo) {
        pFullmoonEventVo.setOpName(MemberVo.getMyMemNo());
        ProcedureVo procedureVo = new ProcedureVo(pFullmoonEventVo);
        ArrayList<P_FullmoonEventVo> list = con_fullmoonDao.callFullmoonEventList(procedureVo);
        return gsonUtil.toJson(new JsonOutputVo(Status.조회, list));
    }

    public String callFullmoonEventDetail(P_FullmoonEventVo pFullmoonEventVo) {
        pFullmoonEventVo.setOpName(MemberVo.getMyMemNo());
        ProcedureVo procedureVo = new ProcedureVo(pFullmoonEventVo);
        P_FullmoonEventVo detail = con_fullmoonDao.callFullmoonEventDetail(procedureVo);
        return gsonUtil.toJson(new JsonOutputVo(Status.조회, detail));
    }

    public String callFullmoonEventUpdate(P_FullmoonEventVo pFullmoonEventVo) {
        pFullmoonEventVo.setOpName(MemberVo.getMyMemNo());
        ProcedureVo procedureVo = new ProcedureVo(pFullmoonEventVo);
        P_FullmoonEventVo detail = con_fullmoonDao.callFullmoonEventUpdate(procedureVo);

        String result = "";
        String ret = procedureVo.getRet();
        if(ret.equals("-1")){
            result = gsonUtil.toJson(new JsonOutputVo(Status.타임이벤트_이벤트시간중복));
        }else if(ret.equals("-9")){
            result = gsonUtil.toJson(new JsonOutputVo(Status.비즈니스로직오류));
        }else{
                result = gsonUtil.toJson(new JsonOutputVo(pFullmoonEventVo.getIdx() == 0 ? Status.생성 : Status.수정, detail));
        }
        return result;
    }

    public String callFullmoonEventRanking(P_FullmoonRankingVo pFullmoonRankingVo){
        pFullmoonRankingVo.setOpName(MemberVo.getMyMemNo());
        ProcedureVo procedureVo = new ProcedureVo(pFullmoonRankingVo);
        ArrayList<P_FullmoonRankingVo> list = con_fullmoonDao.callFullmoonEventRanking(procedureVo);
        return gsonUtil.toJson(new JsonOutputVo(Status.조회, list));
    }

}
