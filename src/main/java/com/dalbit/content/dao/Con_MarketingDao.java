package com.dalbit.content.dao;

import com.dalbit.common.vo.ProcedureVo;
import com.dalbit.content.vo.procedure.P_MarketingVo;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;

@Repository
public interface Con_MarketingDao {

    @Transactional(readOnly = true)
    ArrayList<P_MarketingVo> callMarketingList(ProcedureVo procedureVo);

    P_MarketingVo callMarketingDetail(ProcedureVo procedureVo);

    P_MarketingVo callMarketingUpdate(ProcedureVo procedureVo);

    P_MarketingVo callMarketingInsert(ProcedureVo procedureVo);

    P_MarketingVo callMarketingDelete(ProcedureVo procedureVo);

}
