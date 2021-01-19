package com.dalbit.broadcast.dao;

import com.dalbit.broadcast.vo.procedure.P_ListenForceLeaveVo;
import com.dalbit.broadcast.vo.procedure.P_ListenListOutputVo;
import com.dalbit.common.vo.ProcedureVo;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;

@Repository
public interface Bro_ListenerDao {

    @Transactional(readOnly = true)
    ArrayList<P_ListenListOutputVo> callListenerList(ProcedureVo procedureVo);

    @Transactional(readOnly = true)
    ArrayList<P_ListenListOutputVo> callListenerList_withdrawal(String mem_no);
    ProcedureVo callForceLeave(ProcedureVo procedureVo);
    int callForceLeave_roomBlock(P_ListenForceLeaveVo pListenForceLeaveVo);
    int callListen_exitMemo(P_ListenForceLeaveVo pListenForceLeaveVo);
}
