package com.dalbit.member.dao;

import com.dalbit.common.vo.ProcedureVo;
import com.dalbit.member.vo.MemberVo;
import com.dalbit.member.vo.procedure.P_AuthVo;
import com.dalbit.member.vo.procedure.P_MemberBroadcastOutputVo;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;

@Repository
public interface Mem_BroadcastDao {

    @Transactional(readOnly = true)
    ArrayList<P_MemberBroadcastOutputVo> callBroadHistory(ProcedureVo procedureVo);

    @Transactional(readOnly = true)
    ArrayList<P_MemberBroadcastOutputVo> callbroadCastList(MemberVo MemberVo);

    @Transactional(readOnly = true)
    ArrayList<P_MemberBroadcastOutputVo> getLiveBroadCastList(P_AuthVo pAuthVo);

    int setInspectionHistory(P_AuthVo pAuthVo);
    int setUpdateCodeDefine(P_AuthVo pAuthVo);

}
