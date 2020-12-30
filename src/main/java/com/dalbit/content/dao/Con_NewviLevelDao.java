package com.dalbit.content.dao;

import com.dalbit.common.vo.ProcedureVo;
import com.dalbit.content.vo.procedure.P_NewviLevelListOutputVo;
import com.dalbit.content.vo.procedure.P_NewviLevelStateOutputVo;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;

@Repository
public interface Con_NewviLevelDao {

    @Transactional(readOnly = true)
    ArrayList<P_NewviLevelStateOutputVo> callDay(ProcedureVo procedureVo);

    @Transactional(readOnly = true)
    ArrayList<P_NewviLevelListOutputVo> callDetailList(ProcedureVo procedureVo);


}
