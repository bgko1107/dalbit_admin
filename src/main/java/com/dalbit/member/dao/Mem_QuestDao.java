package com.dalbit.member.dao;

import com.dalbit.common.vo.ProcedureVo;
import com.dalbit.member.vo.procedure.P_QuestVo;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;

@Repository
public interface Mem_QuestDao {

    @Transactional(readOnly = true)
    ArrayList<P_QuestVo> callQuestList(ProcedureVo procedureVo);

}
