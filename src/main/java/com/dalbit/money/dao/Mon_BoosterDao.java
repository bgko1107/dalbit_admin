package com.dalbit.money.dao;

import com.dalbit.common.vo.ProcedureVo;
import com.dalbit.money.vo.procedure.P_memberBoostHistListOutputVo;
import com.dalbit.money.vo.procedure.P_memberBoostStatOutputVo;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;

@Repository
public interface Mon_BoosterDao {

    @Transactional(readOnly = true)
    ArrayList<P_memberBoostStatOutputVo> callBoosterStat(ProcedureVo procedureVo);

    @Transactional(readOnly = true)
    ArrayList<P_memberBoostHistListOutputVo> callBoosterHistList(ProcedureVo procedureVo);
}
