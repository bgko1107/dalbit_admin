package com.dalbit.status.dao;

import com.dalbit.common.vo.ProcedureVo;
import com.dalbit.content.vo.procedure.P_pushDetailOutputVo;
import com.dalbit.member.vo.procedure.P_MemberListOutputVo;
import com.dalbit.status.vo.procedure.P_NoticeOutDetailVo;
import com.dalbit.status.vo.procedure.P_PushHistoryInputVo;
import com.dalbit.status.vo.procedure.P_PushHistoryOutputVo;
import com.dalbit.status.vo.procedure.P_PushTotalOutDetailVo;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.List;

@Repository
public interface Sta_PushDao {

    @Transactional(readOnly = true)
    ArrayList<P_PushTotalOutDetailVo> callPushTotal(ProcedureVo procedureVo);

    @Transactional(readOnly = true)
    ArrayList<P_NoticeOutDetailVo> callNotice (ProcedureVo procedureVo);

    @Transactional(readOnly = true)
    int callPushHistoryListCnt(P_PushHistoryInputVo pPushHistoryInputVo);
    @Transactional(readOnly = true)
    ArrayList<P_PushHistoryOutputVo> callPushHistoryList(P_PushHistoryInputVo pPushHistoryInputVo);
    @Transactional(readOnly = true)
    P_PushHistoryOutputVo callPushHistorySummary(P_PushHistoryInputVo pPushHistoryInputVo);

    @Transactional(readOnly = true)
    P_pushDetailOutputVo callPushHistoryDetail(P_PushHistoryInputVo pPushHistoryInputVo);
    @Transactional(readOnly = true)
    List<P_MemberListOutputVo> selectTargetMemInfo(P_PushHistoryInputVo pPushHistoryInputVo);
}
