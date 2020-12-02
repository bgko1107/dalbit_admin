package com.dalbit.content.dao;

import com.dalbit.broadcast.vo.procedure.P_BroadcastListOutputVo;
import com.dalbit.content.vo.MarketingVo;
import com.dalbit.content.vo.procedure.*;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.List;

@Repository
public interface Con_MarketingDao {
    @Transactional(readOnly = true)
    ArrayList<P_WeeklyListOutputVo> callWeeklyList(MarketingVo marketingVo);
}
