package com.dalbit.content.service;

import com.dalbit.common.code.Status;
import com.dalbit.common.vo.JsonOutputVo;
import com.dalbit.common.vo.PagingVo;
import com.dalbit.content.dao.Con_MarketingDao;
import com.dalbit.content.dao.Con_TimeEventDao;
import com.dalbit.content.vo.MarketingVo;
import com.dalbit.content.vo.TimeEventVo;
import com.dalbit.content.vo.procedure.P_WeeklyListOutputVo;
import com.dalbit.content.vo.procedure.P_bannerInsertVo;
import com.dalbit.content.vo.procedure.P_bannerUpdateVo;
import com.dalbit.member.vo.MemberVo;
import com.dalbit.util.DalbitUtil;
import com.dalbit.util.GsonUtil;
import com.dalbit.util.MessageUtil;
import lombok.extern.slf4j.Slf4j;
import lombok.var;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Slf4j
@Service
public class Con_MarketingService {

    @Autowired
    Con_MarketingDao con_MarketingDao;
    @Autowired
    MessageUtil messageUtil;
    @Autowired
    GsonUtil gsonUtil;

    /**
     * 위클리픽 목록 조회
     */
    public String callWeeklyList(MarketingVo marketingVo) {
        List<P_WeeklyListOutputVo> list = con_MarketingDao.callWeeklyList(marketingVo);
        String result = gsonUtil.toJson(new JsonOutputVo(Status.조회, list, new PagingVo(marketingVo.getTotalCnt(), marketingVo.getPageStart(), marketingVo.getPageCnt())));

        return result;
    }


}
