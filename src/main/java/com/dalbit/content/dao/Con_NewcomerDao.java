package com.dalbit.content.dao;

import com.dalbit.common.vo.ProcedureVo;
import com.dalbit.content.vo.NewcomerVo;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;

@Repository
public interface Con_NewcomerDao {

    @Transactional(readOnly = true)
    ArrayList<NewcomerVo> callNewcomerList(ProcedureVo procedureVo);

    @Transactional(readOnly = true)
    NewcomerVo callNewcomerDetail(ProcedureVo procedureVo);

    ProcedureVo callNewcomerEdit(ProcedureVo procedureVo);

    ProcedureVo callNewcomerDel(ProcedureVo procedureVo);


}
