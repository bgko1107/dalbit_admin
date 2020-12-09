package com.dalbit.content.dao;

import com.dalbit.common.vo.ProcedureVo;
import com.dalbit.content.vo.procedure.P_FullmoonConditionVo;
import com.dalbit.content.vo.procedure.P_FullmoonTextVo;
import org.springframework.stereotype.Repository;

import java.util.ArrayList;


@Repository
public interface Con_FullmoonDao {

    ArrayList<P_FullmoonConditionVo> callFullmoonManagementSelect(ProcedureVo procedureVo);

    P_FullmoonConditionVo callFullmoonManagementEdit(ProcedureVo procedureVo);

    ArrayList<P_FullmoonTextVo> callFullmoonTextSelect(ProcedureVo procedureVo);

    P_FullmoonTextVo callFullmoonTextEdit(ProcedureVo procedureVo);
}
