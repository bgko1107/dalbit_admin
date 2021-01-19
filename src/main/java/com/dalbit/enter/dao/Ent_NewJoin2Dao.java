package com.dalbit.enter.dao;

import com.dalbit.common.vo.ProcedureVo;
import com.dalbit.enter.vo.procedure.*;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;

@Repository
public interface Ent_NewJoin2Dao {

    @Transactional(readOnly = true)
    ArrayList<P_NewJoin2OutDetailVo> callInfoDay(ProcedureVo procedureVo);

}
