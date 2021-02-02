package com.dalbit.menu.dao;

import com.dalbit.common.vo.ProcedureVo;
import com.dalbit.menu.vo.RecommVo;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Repository
public interface Men_RecommDao {

    @Transactional(readOnly = true)
    List<RecommVo> callRecommList(ProcedureVo procedureVo);

    @Transactional(readOnly = true)
    ProcedureVo callRecommDetail(ProcedureVo procedureVo);

    ProcedureVo callEditRecomm(ProcedureVo procedureVo);

    ProcedureVo callDeleteRecomm(ProcedureVo procedureVo);

    @Transactional(readOnly = true)
    List<RecommVo> callRecommFanList(ProcedureVo procedureVo);

}
