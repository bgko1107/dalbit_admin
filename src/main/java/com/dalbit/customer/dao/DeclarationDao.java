package com.dalbit.customer.dao;

import com.dalbit.common.vo.ProcedureVo;
import com.dalbit.customer.vo.procedure.*;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.HashMap;

@Repository
public interface DeclarationDao {

    @Transactional(readOnly = true)
    ArrayList<P_DeclarationListOutputVo> callServiceCenterReportList(ProcedureVo procedureVo);

    @Transactional(readOnly = true)
    P_DeclarationListOutputVo getReportCount(String reported_mem_no);

    @Transactional(readOnly = true)
    ArrayList<P_DeclarationDetailOutputVo> callServiceCenterReportDetail(ProcedureVo procedureVo);

    ProcedureVo callServiceCenterReportOperate(ProcedureVo procedureVo);

    @Transactional(readOnly = true)
    ProcedureVo callServiceCenterReportOpCount(ProcedureVo procedureVo);

    @Transactional(readOnly = true)
    HashMap<P_DeclarationOpCountVo,String> callServiceCenterReportOpCountTarget(P_DeclarationOperateCntInputVo pDeclarationOperateCntInputVo);

    @Transactional(readOnly = true)
    ArrayList<P_DeclarationListOutputVo> callImageList(ProcedureVo procedureVo);

    ProcedureVo callImageOperate(ProcedureVo procedureVo);
}
