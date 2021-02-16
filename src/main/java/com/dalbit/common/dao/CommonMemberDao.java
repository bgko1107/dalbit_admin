package com.dalbit.common.dao;

import com.dalbit.common.vo.ProcedureVo;
import org.springframework.stereotype.Repository;

import java.util.HashMap;
import java.util.List;

@Repository
public interface CommonMemberDao {

    ProcedureVo callMemberBadgeAdd(ProcedureVo procedureVo);

    ProcedureVo callMemberBadgeDelete(ProcedureVo procedureVo);

}
