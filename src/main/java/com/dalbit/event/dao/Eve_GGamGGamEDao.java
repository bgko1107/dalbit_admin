package com.dalbit.event.dao;

import com.dalbit.common.vo.ProcedureVo;
import com.dalbit.event.vo.GGamGGamEVo;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;

@Repository
public interface Eve_GGamGGamEDao {

    @Transactional(readOnly = true)
    ArrayList<GGamGGamEVo> callNewRecordList(ProcedureVo procedureVo);

}
