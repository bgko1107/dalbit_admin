package com.dalbit.common.dao;

import com.dalbit.common.vo.CodeListVo;
import com.dalbit.common.vo.FanBadgeVo;
import com.dalbit.common.vo.MenuVo;
import com.dalbit.common.vo.ProcedureVo;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Repository
public interface CommonStatDao {

    List<HashMap> callStatLoginCnt(ProcedureVo procedureVo);

}
