package com.dalbit.member.service;

import com.dalbit.common.code.Status;
import com.dalbit.common.vo.JsonOutputVo;
import com.dalbit.common.vo.PagingVo;
import com.dalbit.common.vo.ProcedureVo;
import com.dalbit.member.dao.Mem_GGamGGamEDao;
import com.dalbit.member.dao.Mem_MemberDao;
import com.dalbit.member.dao.Mem_MystarDao;
import com.dalbit.member.vo.procedure.P_MemberGGamGGamEVo;
import com.dalbit.member.vo.procedure.P_MemberMystarInputVo;
import com.dalbit.member.vo.procedure.P_MemberMystarOutputVo;
import com.dalbit.util.GsonUtil;
import com.google.gson.Gson;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;

@Slf4j
@Service
public class Mem_GGamGGamEService {

    @Autowired
    Mem_GGamGGamEDao mem_GGamGGamEDao;
    @Autowired
    GsonUtil gsonUtil;

    public String callNewRecodHistory(P_MemberGGamGGamEVo pMemberGGamGGamEVo){

        ProcedureVo procedureVo = new ProcedureVo(pMemberGGamGGamEVo);
        ArrayList<P_MemberGGamGGamEVo> list = mem_GGamGGamEDao.callNewRecodHistory(procedureVo);
        P_MemberGGamGGamEVo outVo = new Gson().fromJson(procedureVo.getExt(), P_MemberGGamGGamEVo.class);

        if(list.size() < 1){
            return gsonUtil.toJson(new JsonOutputVo(Status.데이터없음));
        }

        String result;
        if(list.size() > 0) {
            result = gsonUtil.toJson(new JsonOutputVo(Status.조회, list, new PagingVo(outVo.getTotalCnt(), outVo.getPageNo(), outVo.getPageCnt()),outVo));
        }else{
            result = gsonUtil.toJson(new JsonOutputVo(Status.비즈니스로직오류));
        }
        return result;
    }



}
