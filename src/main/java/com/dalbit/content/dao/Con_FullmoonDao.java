package com.dalbit.content.dao;

import com.dalbit.common.vo.ProcedureVo;
import com.dalbit.content.vo.procedure.P_FullmoonConditionOutputVo;
import org.springframework.stereotype.Repository;

import java.util.ArrayList;


@Repository
public interface Con_FullmoonDao {

    ArrayList<P_FullmoonConditionOutputVo> callFullmoonManagementSelect(ProcedureVo procedureVo);
}
