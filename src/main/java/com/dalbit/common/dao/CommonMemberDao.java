package com.dalbit.common.dao;

import com.dalbit.common.vo.FanBadgeVo;
import com.dalbit.common.vo.ProcedureVo;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import java.util.HashMap;
import java.util.List;

@Repository
public interface CommonMemberDao {

    ProcedureVo callMemberBadgeAdd(ProcedureVo procedureVo);

    ProcedureVo callMemberBadgeDelete(ProcedureVo procedureVo);

    ProcedureVo callMemberSettingSelect(ProcedureVo procedureVo);

    @Transactional(readOnly = true)
    List<FanBadgeVo> callMemberBadgeSelect(HashMap param);

    //API가 master라서 같이 마스터 바라보도록 주석처리 2021.01.19
    /*@Transactional(readOnly = true)*/
    List<FanBadgeVo> callLiveBadgeSelect(HashMap param);

    List<FanBadgeVo> callMemberBadgeListServer(HashMap param);
}
