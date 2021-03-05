package com.dalbit.member.dao;

import com.dalbit.common.vo.ProcedureVo;
import com.dalbit.member.vo.procedure.*;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import java.util.HashMap;
import java.util.List;

@Repository
public interface Mem_WalletDao {

    @Transactional(readOnly = true)
    int callMemberWalletDal_totalCnt(P_WalletDalVo pDalVo);
    @Transactional(readOnly = true)
    List<P_WalletDalListOutVo> callMemberWalletDal(P_WalletDalVo pDalVo);
    @Transactional(readOnly = true)
    HashMap getResultDalSummary(P_WalletDalVo pDalVo);


    @Transactional(readOnly = true)
    int callMemberWalletByeol_totalCnt(P_WalletByeolVo pByeolVo);
    @Transactional(readOnly = true)
    List<P_WalletByeolListOutVo> callMemberWalletByeol(P_WalletByeolVo pByeolVo);
    @Transactional(readOnly = true)
    HashMap getResultByeolSummary(P_WalletByeolVo pDalVo);


    // new wallet
//    @Transactional(readOnly = true)
//    int callNewWalletDal_totalCnt(P_WalletDalVo pDalVo);
//    @Transactional(readOnly = true)
//    List<P_NewWalletDalListOutVo> callNewWalletDal(P_WalletDalVo pDalVo);
    @Transactional(readOnly = true)
    List<P_NewWalletDalListOutVo> callNewWalletProDal(ProcedureVo procedureVo);

    @Transactional(readOnly = true)
    HashMap getResultNewDalSummary(P_WalletDalVo pDalVo);


    // new wallet
//    @Transactional(readOnly = true)
//    int callNewWalletByeol_totalCnt(P_WalletByeolVo pByeolVo);
//    @Transactional(readOnly = true)
//    List<P_NewWalletByeolListOutVo> callNewWalletByeol(P_WalletByeolVo pByeolVo);
    @Transactional(readOnly = true)
    List<P_NewWalletByeolListOutVo> callNewWalletProByeol(ProcedureVo procedureVo);
    @Transactional(readOnly = true)
    HashMap getResultNewByeolSummary(P_WalletByeolVo pByeolVo);

}
