package com.dalbit.member.dao;

import com.dalbit.common.vo.ProcedureVo;
import com.dalbit.member.vo.procedure.P_MemberListenInputVo;
import com.dalbit.member.vo.procedure.P_MemberListenOutputVo;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;

@Repository
public interface Mem_ListenDao {

    @Transactional(readOnly = true)
    ArrayList<P_MemberListenOutputVo> callListenHistory(ProcedureVo procedureVo);

    @Transactional(readOnly = true)
    ArrayList<P_MemberListenOutputVo> callListenList(P_MemberListenInputVo pMemberListenInputVo);

    @Transactional(readOnly = true)
    void updateExitRoomMember(P_MemberListenInputVo pMemberListenInputVo);

}
