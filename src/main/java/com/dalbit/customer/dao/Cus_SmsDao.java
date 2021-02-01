package com.dalbit.customer.dao;

import com.dalbit.customer.vo.SmsHistoryVo;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Repository
public interface Cus_SmsDao {

    @Transactional(readOnly = true)
    List<SmsHistoryVo> getSmsList(SmsHistoryVo smsHistoryVo);

    @Transactional(readOnly = true)
    int getSmsListCnt(SmsHistoryVo smsHistoryVo);

    int smsDel(SmsHistoryVo smsHistoryVo);

    @Transactional(readOnly = true)
    SmsHistoryVo getSmsDetail(SmsHistoryVo smsHistoryVo);
}
