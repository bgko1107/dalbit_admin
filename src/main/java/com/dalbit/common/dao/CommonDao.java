package com.dalbit.common.dao;

import com.dalbit.common.vo.*;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Repository
public interface CommonDao {

    @Transactional(readOnly = true)
    List<Map> callCodeDefineSelect();

    @Transactional(readOnly = true)
    List<MenuVo> getMenuInfo(MenuVo menuVo);

    @Transactional(readOnly = true)
    ArrayList<CodeListVo> getCodeList(CodeListVo codeListVo);

    @Transactional(readOnly = true)
    CodeListVo getCodeDefine(CodeListVo codeListVo);

    ProcedureVo saveErrorLog(ProcedureVo procedureVo);

    @Transactional(readOnly = true)
    List<FanBadgeVo> callMemberBadgeSelect(HashMap param);

    @Transactional(readOnly = true)
    List<FanBadgeVo> callLiveBadgeSelect(HashMap param);

    int updateCodeDefine(CodeListVo codeListVo);

    List<HashMap> callBroadCastRoomList(ProcedureVo procedureVo);

    List<HashMap> callMainRankingPage(ProcedureVo procedureVo);

}
