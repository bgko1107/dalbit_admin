package com.dalbit.content.dao;

import com.dalbit.content.vo.TimeEventVo;
import com.dalbit.content.vo.procedure.P_bannerUpdateVo;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;

@Repository
public interface Con_TimeEventDao {

    @Transactional(readOnly = true)
    ArrayList<TimeEventVo> selectTimeList(TimeEventVo timeEventVo);

    @Transactional(readOnly = true)
    int selectTimeListCnt(TimeEventVo timeEventVo);

    @Transactional(readOnly = true)
    TimeEventVo selectTimeDetail(TimeEventVo timeEventVo);

    int insertTimeEvent(TimeEventVo timeEventVo);

    int updateTimeEvent(TimeEventVo timeEventVo);

    int stopTimeEvent(TimeEventVo timeEventVo);

    int stopTimeEventBanner(P_bannerUpdateVo pBannerUpdateVo);

    @Transactional(readOnly = true)
    int selectTimeEventDuplTimeCheck(TimeEventVo timeEventVo);

    @Transactional(readOnly = true)
    int copyBanner(P_bannerUpdateVo pBannerUpdateVo);

    int copyTimeEvent(TimeEventVo timeEventVo);

}
