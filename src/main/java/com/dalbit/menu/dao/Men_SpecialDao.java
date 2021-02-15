package com.dalbit.menu.dao;

import com.dalbit.common.vo.ProcedureVo;
import com.dalbit.menu.vo.*;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import java.util.HashMap;
import java.util.List;

@Repository
public interface Men_SpecialDao {

    SpecialSummaryVo summary(SpecialSummaryVo specialSummaryVo);

    @Transactional(readOnly = true)
    List<SpecialReqVo> getReqSpecialList(SpecialReqVo specialReqVo);

    @Transactional(readOnly = true)
    Double getSpecialDjAddpoint(SpecialReqVo specialReqVo);

    @Transactional(readOnly = true)
    int getReqSpecialListCnt(SpecialReqVo specialReqVo);

    @Transactional(readOnly = true)
    HashMap checkSpecialDjCnt(SpecialReqVo specialReqVo);

    @Transactional(readOnly = true)
    SpecialReqVo getReqSpecialDetail(SpecialReqVo specialReqVo);

    int reqOk(SpecialReqVo specialReqVo);

    int opLastUpdDate(SpecialReqVo specialReqVo);

    int reqOkUpdate(SpecialReqVo specialReqVo);

    int profileUpdate(SpecialReqVo specialReqVo);

    @Transactional(readOnly = true)
    List<SpecialVo> getSpecialList(SpecialVo specialVo);

    @Transactional(readOnly = true)
    int getSpecialListCnt(SpecialVo specialVo);

    @Transactional(readOnly = true)
    SpecialVo getSpecialDetail(SpecialVo specialVo);

    int reqCancel(SpecialVo specialVo);

    int updateOrder(SpecialDjOrderVo specialDjOrderVo);

    SpecialDjManageVo selectManageInfo(SpecialDjManageVo specialDjManageVo);

    List<SpecialDjContentVo> selectManageContentList(SpecialDjManageVo specialDjManageVo);

    int insertManageInfo(SpecialDjManageVo specialDjManageVo);

    int updateManageInfo(SpecialDjManageVo specialDjManageVo);

    int deleteManageContent(SpecialDjManageVo specialDjManageVo);

    int insertManageContent(SpecialDjContentVo specialDjContentVo);

    List<SpecialDjManageVo> selectManageList(SpecialDjManageVo specialDjManageVo);

    @Transactional(readOnly = true)
    List<SpecialReqVo> reqAbleSpecialDjList(SpecialReqVo specialReqVo);

    @Transactional(readOnly = true)
    int reqAbleSpecialDjCnt(SpecialReqVo specialReqVo);

    @Transactional(readOnly = true)
    List<SpecialDjBestVo> callBestAbleList(ProcedureVo procedureVo);

}
