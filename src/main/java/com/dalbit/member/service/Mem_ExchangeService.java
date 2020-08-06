package com.dalbit.member.service;

import com.dalbit.common.code.Status;
import com.dalbit.common.vo.JsonOutputVo;
import com.dalbit.common.vo.PagingVo;
import com.dalbit.member.dao.Mem_ExchangeDao;
import com.dalbit.member.dao.Mem_MemberDao;
import com.dalbit.member.vo.procedure.P_MemberExchangeInputVo;
import com.dalbit.member.vo.procedure.P_MemberParentsAgreeInputVo;
import com.dalbit.member.vo.procedure.P_MemberParentsAgreeOutputVo;
import com.dalbit.money.vo.Mon_ExchangeOutputVo;
import com.dalbit.util.*;
import lombok.extern.slf4j.Slf4j;
import lombok.var;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.HashMap;

@Slf4j
@Service
public class Mem_ExchangeService {

    @Autowired
    Mem_ExchangeDao mem_ExchangeDao;
    @Autowired
    GsonUtil gsonUtil;
    @Autowired
    SocketUtil socketUtil;
    @Autowired
    JwtUtil jwtUtil;
    @Autowired
    Mem_MemberDao mem_MemberDao;

    public String getExchangeHistory(P_MemberExchangeInputVo pMemberExchangeInputVo){

        pMemberExchangeInputVo.setPageNo(pMemberExchangeInputVo.getPageNo() -1);
        pMemberExchangeInputVo.setPageNo(pMemberExchangeInputVo.getPageNo() * pMemberExchangeInputVo.getPageCnt());

        ArrayList<Mon_ExchangeOutputVo> exchangeList = mem_ExchangeDao.getExchangeHistory(pMemberExchangeInputVo);
        int totalCnt = mem_ExchangeDao.getExchangeHistory_totalCnt(pMemberExchangeInputVo);

        String result;
        if(exchangeList.size() > 0) {
            result = gsonUtil.toJson(new JsonOutputVo(Status.환전내역보기성공, exchangeList, new PagingVo(totalCnt)));
        }else{
            result = gsonUtil.toJson(new JsonOutputVo(Status.환전내역보기실패));
        }
        return result;
    }

    public String getExchangeHistory_detail(P_MemberExchangeInputVo pMemberExchangeInputVo){
        Mon_ExchangeOutputVo exchangeInfo = mem_ExchangeDao.getExchangeHistory_detail(pMemberExchangeInputVo);
        exchangeInfo.setSocial_no(AES.decrypt(exchangeInfo.getSocial_no(), DalbitUtil.getProperty("social.secret.key")));

        P_MemberParentsAgreeInputVo pMemberParentsAgreeInputVo = new P_MemberParentsAgreeInputVo();
        pMemberParentsAgreeInputVo.setMemNo(pMemberExchangeInputVo.getMem_no());
        P_MemberParentsAgreeOutputVo memberParentsAgreeOutputVo = mem_MemberDao.getParentsAgreeInfo(pMemberParentsAgreeInputVo);

        String result;
        if(DalbitUtil.isEmpty(exchangeInfo)) {
            result = gsonUtil.toJson(new JsonOutputVo(Status.환전내역보기실패));
        }else{
            var resultMap = new HashMap<>();
            resultMap.put("detail", exchangeInfo);
            resultMap.put("parentInfo", memberParentsAgreeOutputVo);
            result = gsonUtil.toJson(new JsonOutputVo(Status.환전내역보기성공, resultMap));
        }
        return result;
    }

}
