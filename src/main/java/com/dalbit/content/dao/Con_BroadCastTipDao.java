package com.dalbit.content.dao;

import com.dalbit.common.vo.ProcedureVo;
import com.dalbit.content.vo.procedure.P_BroadCastTipOutputVo;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;

@Repository
public interface Con_BroadCastTipDao {

    @Transactional(readOnly = true)
    ArrayList<P_BroadCastTipOutputVo> callBroadcastTipList(ProcedureVo procedureVo);

    @Transactional(readOnly = true)
    P_BroadCastTipOutputVo callBroadcastTipDetail(ProcedureVo procedureVo);

    ProcedureVo callbroadCastTipEdit(ProcedureVo procedureVo);

    ProcedureVo callbroadCastTipAdd(ProcedureVo procedureVo);

    ProcedureVo callbroadCastTipDel(ProcedureVo procedureVo);


}
