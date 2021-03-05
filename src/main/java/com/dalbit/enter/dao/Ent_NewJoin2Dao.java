package com.dalbit.enter.dao;

import com.dalbit.common.vo.ProcedureVo;
import com.dalbit.enter.vo.procedure.*;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.HashMap;

@Repository
public interface Ent_NewJoin2Dao {

    @Transactional(readOnly = true)
    ArrayList<P_NewJoin2OutDetailVo> callInfoDay(ProcedureVo procedureVo);

    int callAdbrixAdd(ArrayList<HashMap<String, String>> list);

    @Transactional(readOnly = true)
    ArrayList<P_JoinAdbirxOutVo> callStateAdbrix(ProcedureVo procedureVo);

    @Transactional(readOnly = true)
    P_JoinAdbirxOutVo callStateAdbrixMemo(P_StatVo pStatVo);

    int adbrixMemoAdd(P_StatVo pStatVo);
    int adbrixMemoUpd(P_StatVo pStatVo);
    int adbrixMemoDel(P_StatVo pStatVo);
}
