package com.dalbit.content.dao;

import com.dalbit.common.vo.ProcedureVo;
import com.dalbit.content.vo.procedure.P_ServicePolicyVo;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;

@Repository
public interface Con_ServicePolicyDao {

    @Transactional(readOnly = true)
    ArrayList<P_ServicePolicyVo> callServicePolicyList(ProcedureVo procedureVo);

    P_ServicePolicyVo callServicePolicyEdit(ProcedureVo procedureVo);

    @Transactional(readOnly = true)
    ArrayList<P_ServicePolicyVo> callServicePolicyDetail(ProcedureVo procedureVo);

    P_ServicePolicyVo callServicePolicyDelete(ProcedureVo procedureVo);

}
