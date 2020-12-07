package com.dalbit.clip.dao;

import com.dalbit.clip.vo.procedure.P_ClipRankListOutPut;
import com.dalbit.clip.vo.procedure.P_ClipRecommend;
import com.dalbit.clip.vo.procedure.P_ClipRecommendDetailOutPut;
import com.dalbit.clip.vo.procedure.P_ClipRecommendListOutPut;
import com.dalbit.common.vo.ProcedureVo;
import com.dalbit.customer.vo.BlockAdmVo;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;

@Repository
public interface Cli_ClipCategoryDao {

    @Transactional(readOnly = true)
    ArrayList<BlockAdmVo> selectBlockList(BlockAdmVo blockAdmVo);

    @Transactional(readOnly = true)
    int selectBlockListCnt(BlockAdmVo blockAdmVo);

    @Transactional(readOnly = true)
    BlockAdmVo selectBlockDetail(BlockAdmVo blockAdmVo);

    int insertBlock(BlockAdmVo blockAdmVo);
    int insertBlockHistory(BlockAdmVo blockAdmVo);

    int deleteBlock(BlockAdmVo blockAdmVo);
    int insertDelBlockHistory(BlockAdmVo blockAdmVo);

    BlockAdmVo selectBlockInfo(String idx);

    @Transactional(readOnly = true)
    ArrayList<BlockAdmVo> selectBlockHistList(BlockAdmVo blockAdmVo);

    @Transactional(readOnly = true)
    int selectBlockHistListCnt(BlockAdmVo blockAdmVo);


    @Transactional(readOnly = true)
    ArrayList<P_ClipRankListOutPut> callClipRankList(ProcedureVo procedureVo);

    @Transactional(readOnly = true)
    ArrayList<P_ClipRecommendListOutPut> callClipRecommendList(ProcedureVo procedureVo);

    ProcedureVo callClipRecommendEdit(ProcedureVo procedureVo);

    @Transactional(readOnly = true)
    ArrayList<P_ClipRecommendDetailOutPut> callClipRecommendDetail(ProcedureVo procedureVo);

    ProcedureVo callClipRecommendDelete(ProcedureVo procedureVo);

    @Transactional(readOnly = true)
    P_ClipRecommendDetailOutPut getLeaderCheck(P_ClipRecommend pClipRecommend);
}
