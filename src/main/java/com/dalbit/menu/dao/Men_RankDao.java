package com.dalbit.menu.dao;

import com.dalbit.common.vo.ProcedureVo;
import com.dalbit.menu.vo.AddDjPointVo;
import com.dalbit.menu.vo.DjRankingVo;
import com.dalbit.menu.vo.FanRankingVo;
import com.dalbit.menu.vo.procedure.P_MainDjRankingVo;
import com.dalbit.menu.vo.procedure.P_MainFanRankingVo;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Repository
public interface Men_RankDao {
    @Transactional(readOnly = true)
    List<P_MainDjRankingVo> callMainDjRanking(ProcedureVo procedureVo);

    @Transactional(readOnly = true)
    List<P_MainFanRankingVo> callMainFanRanking(ProcedureVo procedureVo);

    /* DJ 랭킹 */
    @Transactional(readOnly = true)
    DjRankingVo getDjLiveCheck(DjRankingVo djRankingVo);

    @Transactional(readOnly = true)
    List<DjRankingVo> getMainDjRankingList(DjRankingVo djRankingVo);
    @Transactional(readOnly = true)
    int getMainDjRankingListCnt(DjRankingVo djRankingVo);

    /* fan 랭킹*/
    @Transactional(readOnly = true)
    FanRankingVo getFanLiveCheck(FanRankingVo fanRankingVo);

    @Transactional(readOnly = true)
    List<FanRankingVo> getMainFanRankingList(FanRankingVo fanRankingVo);
    @Transactional(readOnly = true)
    int getMainFanRankingListCnt(FanRankingVo fanRankingVo);


    /* DJ 랭킹 라이브 여부 체크*/
    @Transactional(readOnly = true)
    AddDjPointVo getAddDjLiveCheck(AddDjPointVo addDjPointVo);

    @Transactional(readOnly = true)
    int getAddDjPointListCnt(AddDjPointVo addDjPointVo);

    @Transactional(readOnly = true)
    List<AddDjPointVo> getAddDjPointList(AddDjPointVo addDjPointVo);

}
