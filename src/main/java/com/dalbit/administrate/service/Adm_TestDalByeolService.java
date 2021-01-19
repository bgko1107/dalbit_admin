package com.dalbit.administrate.service;

import com.dalbit.administrate.dao.Adm_TestDalByeolDao;
import com.dalbit.administrate.vo.*;
import com.dalbit.common.code.Status;
import com.dalbit.common.vo.JsonOutputVo;
import com.dalbit.common.vo.PagingVo;
import com.dalbit.util.DalbitUtil;
import com.dalbit.util.GsonUtil;
import com.dalbit.util.MessageUtil;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.*;

@Slf4j
@Service
public class Adm_TestDalByeolService {

    @Autowired
    Adm_TestDalByeolDao adm_TestDalByeolDao;

    @Autowired
    MessageUtil messageUtil;
    @Autowired
    GsonUtil gsonUtil;


    public String getTestDalByeolList(TestIdVo testIdVo){
        testIdVo.setPageStart(testIdVo.getPageStart() -1);
        testIdVo.setPageStart(testIdVo.getPageStart() * testIdVo.getPageCnt());
        ArrayList<TestDalByeolListVo> list = adm_TestDalByeolDao.getTestDalByeolList(testIdVo);
        int totalCnt = adm_TestDalByeolDao.getTestDalByeolList_totalCnt(testIdVo);

        TestDalByeolListVo summary1 = adm_TestDalByeolDao.getTestDalByeolSummary1(testIdVo);
        TestDalByeolListVo summary2 = adm_TestDalByeolDao.getTestDalByeolSummary2(testIdVo);

        HashMap map = new HashMap();
        map.put("list",list);
        map.put("totalCnt",totalCnt);
        map.put("summary1",summary1);       // 인원
        map.put("summary2",summary2);       // 수량

        String result;
        if(list.size() > 0) {
            result = gsonUtil.toJson(new JsonOutputVo(Status.테스트아이디달별지급목록조회_성공, map, new PagingVo(totalCnt, testIdVo.getPageStart(), testIdVo.getPageCnt())));
        }else{
            result = gsonUtil.toJson(new JsonOutputVo(Status.테스트아이디달별지급목록조회_실패));
        }

        return result;
    }

    public String getDalSendList(TestIdVo testIdVo) {

        List<TestResourceSendListVo> outVoList = adm_TestDalByeolDao.getDalSendList(testIdVo);
        int totalCnt = adm_TestDalByeolDao.getDalSendList_totalCnt(testIdVo);

        if(DalbitUtil.isEmpty(outVoList) || outVoList.size() <= 0){
            return gsonUtil.toJson(new JsonOutputVo(Status.내지갑_달사용내역조회_없음));
        }

        String result;
        if(outVoList.size() > 0) {
            result = gsonUtil.toJson(new JsonOutputVo(Status.내지갑_달사용내역조회_성공, outVoList, new PagingVo(totalCnt, testIdVo.getPageStart(), testIdVo.getPageCnt())));
        }else{
            result = gsonUtil.toJson(new JsonOutputVo(Status.내지갑_달사용내역조회_실패));
        }
        return result;
    }

    public String getByeolSendList(TestIdVo testIdVo) {

        List<TestResourceSendListVo> outVoList = adm_TestDalByeolDao.getByeolSendList(testIdVo);
        int totalCnt = adm_TestDalByeolDao.getByeolSendList_totalCnt(testIdVo);

        if(DalbitUtil.isEmpty(outVoList) || outVoList.size() <= 0){
            return gsonUtil.toJson(new JsonOutputVo(Status.내지갑_별사용내역조회_없음));
        }

        String result;
        if(outVoList.size() > 0) {
            result = gsonUtil.toJson(new JsonOutputVo(Status.내지갑_별사용내역조회_성공, outVoList, new PagingVo(totalCnt, testIdVo.getPageStart(), testIdVo.getPageCnt())));
        }else{
            result = gsonUtil.toJson(new JsonOutputVo(Status.내지갑_별사용내역조회_실패));
        }
        return result;
    }

}
