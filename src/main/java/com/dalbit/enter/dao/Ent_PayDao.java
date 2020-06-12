package com.dalbit.enter.dao;

import com.dalbit.common.vo.ProcedureVo;
import com.dalbit.enter.vo.procedure.*;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;


@Repository
public interface Ent_PayDao {

    @Transactional(readOnly = true)
    List<P_PayInfoOutVo> callPayInfo(ProcedureVo procedureVo);

    @Transactional(readOnly = true)
    P_PayInfoOutVo callPayCancelInfo(P_StatVo pStatVo);

    @Transactional(readOnly = true)
    List<P_PayTotalOutDetailVo> callPayTotal(ProcedureVo procedureVo);

    @Transactional(readOnly = true)
    List<P_PayAgeOutDetailVo> callPayAge(ProcedureVo procedureVo);

    @Transactional(readOnly = true)
    List<P_PayWayOutDetailVo> callPayWay(ProcedureVo procedureVo);

    @Transactional(readOnly = true)
    List<P_PayCodeOutDetailVo> callPayCode(ProcedureVo procedureVo);

    @Transactional(readOnly = true)
    List<P_PayCancelOutDetailVo> callPayCancel(ProcedureVo procedureVo);

    @Transactional(readOnly = true)
    List<P_PayTryOutDetailVo> callPayTry(ProcedureVo procedureVo);
}
