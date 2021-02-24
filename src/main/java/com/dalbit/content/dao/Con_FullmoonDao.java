package com.dalbit.content.dao;

import com.dalbit.common.vo.ProcedureVo;
import com.dalbit.content.vo.procedure.P_FullmoonConditionVo;
import com.dalbit.content.vo.procedure.P_FullmoonEventVo;
import com.dalbit.content.vo.procedure.P_FullmoonRankingVo;
import com.dalbit.content.vo.procedure.P_FullmoonTextVo;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;


@Repository
public interface Con_FullmoonDao {

    @Transactional(readOnly = true)
    ArrayList<P_FullmoonConditionVo> callFullmoonManagementSelect(ProcedureVo procedureVo);

    P_FullmoonConditionVo callFullmoonManagementEdit(ProcedureVo procedureVo);

    @Transactional(readOnly = true)
    ArrayList<P_FullmoonTextVo> callFullmoonTextSelect(ProcedureVo procedureVo);

    P_FullmoonTextVo callFullmoonTextEdit(ProcedureVo procedureVo);

    @Transactional(readOnly = true)
    ArrayList<P_FullmoonEventVo> callFullmoonEventList(ProcedureVo procedureVo);

    @Transactional(readOnly = true)
    P_FullmoonEventVo callFullmoonEventDetail(ProcedureVo procedureVo);

    P_FullmoonEventVo callFullmoonEventUpdate(ProcedureVo procedureVo);

    ArrayList<P_FullmoonRankingVo> callFullmoonEventRanking(ProcedureVo procedureVo);
}
