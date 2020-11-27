package com.dalbit.member.dao;

import com.dalbit.common.vo.ProcedureVo;
import com.dalbit.member.vo.procedure.P_MemberExchangeInputVo;
import com.dalbit.money.vo.Mon_ExchangeOutputVo;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;

@Repository
public interface Mem_ExchangeDao {

    @Transactional(readOnly = true)
    ArrayList<Mon_ExchangeOutputVo> getExchangeHistory(P_MemberExchangeInputVo pMemberExchangeInputVo);
    @Transactional(readOnly = true)
    int getExchangeHistory_totalCnt(P_MemberExchangeInputVo pMemberExchangeInputVo);
    @Transactional(readOnly = true)
    Mon_ExchangeOutputVo getExchangeHistory_detail(P_MemberExchangeInputVo pMemberExchangeInputVo);


    @Transactional(readOnly = true)
    ArrayList<Mon_ExchangeOutputVo> callExchangeHistory(ProcedureVo procedureVo);

}
