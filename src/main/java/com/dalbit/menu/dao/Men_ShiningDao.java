package com.dalbit.menu.dao;

import com.dalbit.common.vo.ProcedureVo;
import com.dalbit.menu.vo.*;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Repository
public interface Men_ShiningDao {

    @Transactional(readOnly = true)
    List<ShiningVo> callExpectedList(ProcedureVo procedureVo);

}
