package com.dalbit.event.dao;

import com.dalbit.common.vo.ProcedureVo;
import com.dalbit.event.vo.QuestVo;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;

@Repository
public interface Eve_QuestDao {

    @Transactional(readOnly = true)
    ArrayList<QuestVo> callList(ProcedureVo procedureVo);

    @Transactional(readOnly = true)
    ArrayList<QuestVo> callDetail(ProcedureVo procedureVo);

    QuestVo callEdit(ProcedureVo procedureVo);

    @Transactional(readOnly = true)
    ArrayList<QuestVo> callMember(ProcedureVo procedureVo);
}
