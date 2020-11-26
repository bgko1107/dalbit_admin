package com.dalbit.content.dao;

import com.dalbit.content.vo.TimeEventVo;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import java.sql.Time;
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

}
