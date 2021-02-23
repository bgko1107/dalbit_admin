package com.dalbit.customer.dao;

import com.dalbit.customer.vo.BlockAdmVo;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;

@Repository
public interface Cus_BlockAdmDao {

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
    BlockAdmVo selectAdminMemo(BlockAdmVo blockAdmVo);

    int adminMemoIns(BlockAdmVo blockAdmVo);
    int adminMemoUpd(BlockAdmVo blockAdmVo);
    int adminMemoDel(BlockAdmVo blockAdmVo);
}
