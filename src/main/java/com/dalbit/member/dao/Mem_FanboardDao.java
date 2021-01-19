package com.dalbit.member.dao;

import com.dalbit.member.vo.procedure.P_MemberFanboardDeleteVo;
import com.dalbit.member.vo.procedure.P_MemberFanboardInputVo;
import com.dalbit.member.vo.procedure.P_MemberFanboardOutputVo;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;

@Repository
public interface Mem_FanboardDao {

//    ArrayList<P_MemberFanboardOutputVo> callFanboardHistory(ProcedureVo procedureVo);

    @Transactional(readOnly = true)
    ArrayList<P_MemberFanboardOutputVo> callFanboardHistory(P_MemberFanboardInputVo pMemberFanboardInputVo);

    @Transactional(readOnly = true)
    int callFanboardHistory_totalCnt(P_MemberFanboardInputVo pMemberFanboardInputVo);

    @Transactional(readOnly = true)
    ArrayList<P_MemberFanboardOutputVo> callFanboardReplyList(P_MemberFanboardInputVo pMemberFanboardInputVo);
    int callFanboardDelete(P_MemberFanboardDeleteVo pMemberFanboardDeleteVo);

}
