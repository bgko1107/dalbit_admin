package com.dalbit.member.service;

import com.dalbit.common.code.Status;
import com.dalbit.common.vo.JsonOutputVo;
import com.dalbit.common.vo.PagingVo;
import com.dalbit.member.dao.Mem_MemberDao;
import com.dalbit.member.dao.Mem_MystarDao;
import com.dalbit.member.vo.procedure.P_MemberMystarInputVo;
import com.dalbit.member.vo.procedure.P_MemberMystarOutputVo;
import com.dalbit.util.GsonUtil;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;

@Slf4j
@Service
public class Mem_MystarService {

    @Autowired
    Mem_MystarDao mem_MystarDao;
    @Autowired
    GsonUtil gsonUtil;
    @Autowired
    Mem_MemberDao mem_MemberDao;

    public String getMystarHistory(P_MemberMystarInputVo pMemberMystarInputVo){

        pMemberMystarInputVo.setPageNo(pMemberMystarInputVo.getPageNo() -1);
        pMemberMystarInputVo.setPageNo(pMemberMystarInputVo.getPageNo() * pMemberMystarInputVo.getPageCnt());

        ArrayList<P_MemberMystarOutputVo> mystarList = mem_MystarDao.callMystarHistory(pMemberMystarInputVo);
        int totalCnt = mem_MystarDao.callMystarHistory_totalCnt(pMemberMystarInputVo);

//        for(int i=0;i<mystarList.size();i++){
//            MemberVo outVo = mem_MemberDao.getMemberInfo(mystarList.get(i).getMem_no_star());
//            if(!DalbitUtil.isEmpty(outVo)) {
//                mystarList.get(i).setStar_sex(outVo.getMem_sex());
//                mystarList.get(i).setMem_birth_year(outVo.getMem_birth_year());
//                mystarList.get(i).setMem_birth_month(outVo.getMem_birth_month());
//                mystarList.get(i).setMem_birth_day(outVo.getMem_birth_day());
//            }
//        }
        int liveTotalCnt = mem_MystarDao.callMystar_totalCnt(pMemberMystarInputVo);
        String result;
        result = gsonUtil.toJson(new JsonOutputVo(Status.MyStar목록보기성공, mystarList, new PagingVo(totalCnt), liveTotalCnt));
        log.info(result);
        return result;
    }


    public String getFanHistory(P_MemberMystarInputVo pMemberMystarInputVo){

        pMemberMystarInputVo.setPageNo(pMemberMystarInputVo.getPageNo() -1);
        pMemberMystarInputVo.setPageNo(pMemberMystarInputVo.getPageNo() * pMemberMystarInputVo.getPageCnt());

        ArrayList<P_MemberMystarOutputVo> myfanList = mem_MystarDao.callMyfanHistory(pMemberMystarInputVo);
        int totalCnt = mem_MystarDao.callMyfanHistory_totalCnt(pMemberMystarInputVo);

//        for(int i=0;i<myfanList.size();i++){
//            MemberVo outVo = mem_MemberDao.getMemberInfo(myfanList.get(i).getMem_no_fan());
//            if(!DalbitUtil.isEmpty(outVo)) {
//                myfanList.get(i).setFan_sex(outVo.getMem_sex());
//                myfanList.get(i).setMem_birth_year(outVo.getMem_birth_year());
//                myfanList.get(i).setMem_birth_month(outVo.getMem_birth_month());
//                myfanList.get(i).setMem_birth_day(outVo.getMem_birth_day());
//            }
//        }

        int liveTotalCnt = mem_MystarDao.callMyfan_totalCnt(pMemberMystarInputVo);
        String result;
        result = gsonUtil.toJson(new JsonOutputVo(Status.Fan목록보기성공, myfanList, new PagingVo(totalCnt), liveTotalCnt));
        log.info(result);
        return result;
    }
}
