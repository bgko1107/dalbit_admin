package com.dalbit.status.dao;

import com.dalbit.common.vo.ProcedureVo;
import com.dalbit.status.vo.procedure.*;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;

@Repository
public interface Sta_NewBroadcastDao {

    @Transactional(readOnly = true)
    ArrayList<P_NewBroadcastTimeOutVo> callNewBroadcastTime(ProcedureVo procedureVo);

    @Transactional(readOnly = true)
    ArrayList<P_NewBroadcastTimeNewOutVo> callNewBroadcastTimeNew(ProcedureVo procedureVo);

    @Transactional(readOnly = true)
    ArrayList<P_NewBroadcastTypeOutVo> callNewBroadcastType(ProcedureVo procedureVo);

    @Transactional(readOnly = true)
    ArrayList<P_NewBroadcastGiftOutputVo> callNewBroadcastGift(ProcedureVo procedureVo);
}
