package com.dalbit.content.dao;

import com.dalbit.common.vo.ProcedureVo;
import com.dalbit.content.vo.*;
import com.dalbit.content.vo.procedure.P_RouletteRateVo;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.List;

@Repository
public interface Con_RouletteEventDao {

    @Transactional(readOnly = true)
    ArrayList<P_RouletteRateVo> callRouletteRate(ProcedureVo procedureVo);

    P_RouletteRateVo callEditRouletteRate(ProcedureVo procedureVo);

    @Transactional(readOnly = true)
    ArrayList<RouletteApplyVo> selectRouletteApplyList(RouletteApplyVo rouletteApplyVo);

    @Transactional(readOnly = true)
    int selectRouletteApplyCnt(RouletteApplyVo rouletteApplyVo);

    @Transactional(readOnly = true)
    RouletteCalendarVo selectRouletteWeekCalendarList(RouletteCalendarVo rouletteCalendarVo);

    /**
     * 어드민 쿼리 개선작업
     *
     * selectRouletteWeekCalendarList 쿼리를
     *
     * selectRouletteWeekCalendarList_item, selectRouletteWeekCalendarList_member 두개로 분리시킴
     *
     */
    @Transactional(readOnly = true)
    RouletteCalendarVo selectRouletteWeekCalendarList_item(RouletteCalendarVo rouletteCalendarVo);

    @Transactional(readOnly = true)
    List<RouletteCalendarVo> selectRouletteWeekCalendarList_member(RouletteCalendarVo rouletteCalendarVo);

    @Transactional(readOnly = true)
    List<RouletteCalendarVo> selectRouletteCalendarList(RouletteCalendarVo rouletteCalendarVo);
}
