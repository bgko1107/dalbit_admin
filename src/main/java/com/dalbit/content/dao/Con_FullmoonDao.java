package com.dalbit.content.dao;

import com.dalbit.common.vo.ProcedureVo;
import com.dalbit.content.vo.procedure.P_FullmoonConditionOutputVo;
import org.springframework.stereotype.Repository;


@Repository
public interface Con_FullmoonDao {

    P_FullmoonConditionOutputVo callFullmoonManagementSelect(ProcedureVo procedureVo);
}
