package com.dalbit.administrate.dao;

import com.dalbit.administrate.vo.TestDalByeolListVo;
import com.dalbit.administrate.vo.TestIdVo;
import com.dalbit.administrate.vo.TestResourceSendListVo;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;

@Repository
public interface Adm_TestDalByeolDao {

    @Transactional(readOnly = true)
    ArrayList<TestDalByeolListVo> getTestDalByeolList(TestIdVo testIdVo);

    @Transactional(readOnly = true)
    int getTestDalByeolList_totalCnt(TestIdVo testIdVo);

    @Transactional(readOnly = true)
    TestDalByeolListVo getTestDalByeolSummary1(TestIdVo testIdVo);

    @Transactional(readOnly = true)
    TestDalByeolListVo getTestDalByeolSummary2(TestIdVo testIdVo);


    @Transactional(readOnly = true)
    ArrayList<TestResourceSendListVo> getDalSendList(TestIdVo testIdVo);

    @Transactional(readOnly = true)
    int getDalSendList_totalCnt(TestIdVo testIdVo);

    @Transactional(readOnly = true)
    ArrayList<TestResourceSendListVo> getByeolSendList(TestIdVo testIdVo);

    @Transactional(readOnly = true)
    int getByeolSendList_totalCnt(TestIdVo testIdVo);
}