package com.dalbit.member.dao;

import com.dalbit.member.vo.procedure.P_MemberChargeInputVo;
import com.dalbit.member.vo.procedure.P_MemberChargeOutputVo;
import com.dalbit.member.vo.procedure.P_MemberGiftInputVo;
import com.dalbit.member.vo.procedure.P_MemberGiftOutputVo;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;

@Repository
public interface Mem_GiftDao {

//    ArrayList<P_MemberGiftOutputVo> callGiftHistory(ProcedureVo procedureVo);
    @Transactional(readOnly = true)
    ArrayList<P_MemberGiftOutputVo> callGiftHistory_all(P_MemberGiftInputVo pMemberGiftInputVo);

    @Transactional(readOnly = true)
    ArrayList<P_MemberGiftOutputVo> callGiftHistory(P_MemberGiftInputVo pMemberGiftInputVo);

    @Transactional(readOnly = true)
    int callGiftHistory_all_totalCnt(P_MemberGiftInputVo pMemberGiftInputVo);

    @Transactional(readOnly = true)
    int callGiftHistory_totalCnt(P_MemberGiftInputVo pMemberGiftInputVo);
    @Transactional(readOnly = true)
    ArrayList<P_MemberGiftOutputVo> callGiftHistory_allGiftDalCnt(P_MemberGiftInputVo pMemberGiftInputVo);
    @Transactional(readOnly = true)
    ArrayList<P_MemberGiftOutputVo> callGiftHistory_allReceivedDalCnt(P_MemberGiftInputVo pMemberGiftInputVo);
    @Transactional(readOnly = true)
    ArrayList<P_MemberGiftOutputVo> callGiftHistory_allGiftSecretDalCnt(P_MemberGiftInputVo pMemberGiftInputVo);
    @Transactional(readOnly = true)
    ArrayList<P_MemberGiftOutputVo> callGiftHistory_allReceivedSecretDalCnt(P_MemberGiftInputVo pMemberGiftInputVo);


    @Transactional(readOnly = true)
    ArrayList<P_MemberChargeOutputVo> callChargeHistory_all(P_MemberChargeInputVo pMemberChargeInputVo);

    @Transactional(readOnly = true)
    ArrayList<P_MemberChargeOutputVo> callChargeHistory(P_MemberChargeInputVo pMemberChargeInputVo);

    @Transactional(readOnly = true)
    int callChargeHistory_all_totalCnt(P_MemberChargeInputVo pMemberChargeInputVo);

    @Transactional(readOnly = true)
    int callChargeHistory_totalCnt(P_MemberChargeInputVo pMemberChargeInputVo);

    @Transactional(readOnly = true)
    int callChargeHistory_allDalGiftCnt(P_MemberChargeInputVo pMemberChargeInputVo);

    @Transactional(readOnly = true)
    int callChargeHistory_allDalReceivedCnt(P_MemberChargeInputVo pMemberChargeInputVo);

    @Transactional(readOnly = true)
    int callChargeHistory_allByeolReceivedCnt(P_MemberChargeInputVo pMemberChargeInputVo);


}
