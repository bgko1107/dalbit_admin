package com.dalbit.member.service;

import com.dalbit.common.code.Status;
import com.dalbit.common.vo.JsonOutputVo;
import com.dalbit.common.vo.PagingVo;
import com.dalbit.common.vo.ProcedureVo;
import com.dalbit.member.dao.Mem_QuestDao;
import com.dalbit.member.vo.procedure.P_QuestVo;
import com.dalbit.util.GsonUtil;
import com.google.gson.Gson;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;

@Slf4j
@Service
public class Mem_QuestService {

    @Autowired
    Mem_QuestDao mem_QuestDao;
    @Autowired
    GsonUtil gsonUtil;

    public String callQuestList(P_QuestVo pQuestVo){

        ProcedureVo procedureVo = new ProcedureVo(pQuestVo);
        ArrayList<P_QuestVo> list = mem_QuestDao.callQuestList(procedureVo);
        P_QuestVo outVo = new Gson().fromJson(procedureVo.getExt(), P_QuestVo.class);

        if(list.size() < 1){
            return gsonUtil.toJson(new JsonOutputVo(Status.데이터없음));
        }

        String result;
        if(list.size() > 0) {
            result = gsonUtil.toJson(new JsonOutputVo(Status.조회, list, new PagingVo(0),outVo));
        }else{
            result = gsonUtil.toJson(new JsonOutputVo(Status.비즈니스로직오류));
        }
        return result;
    }

    public String callQuestDetailList(P_QuestVo pQuestVo){
        ProcedureVo procedureVo = new ProcedureVo(pQuestVo);
        ArrayList<P_QuestVo> list = mem_QuestDao.callQuestList(procedureVo);
        P_QuestVo outVo = new Gson().fromJson(procedureVo.getExt(), P_QuestVo.class);
        return gsonUtil.toJson(new JsonOutputVo(Status.조회, list, new PagingVo(0), outVo));
    }



}
