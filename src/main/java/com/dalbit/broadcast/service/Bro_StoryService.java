package com.dalbit.broadcast.service;


import com.dalbit.broadcast.dao.Bro_StoryDao;
import com.dalbit.broadcast.vo.procedure.P_StoryDeleteVo;
import com.dalbit.broadcast.vo.procedure.P_StoryListInputVo;
import com.dalbit.broadcast.vo.procedure.P_StoryListOutputVo;
import com.dalbit.common.code.Status;
import com.dalbit.common.vo.JsonOutputVo;
import com.dalbit.common.vo.PagingVo;
import com.dalbit.common.vo.ProcedureVo;
import com.dalbit.member.dao.Mem_MemberDao;
import com.dalbit.member.vo.MemberVo;
import com.dalbit.util.DalbitUtil;
import com.dalbit.util.GsonUtil;
import com.dalbit.util.MessageUtil;
import com.google.gson.Gson;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;

@Slf4j
@Service
public class Bro_StoryService {

    @Autowired
    Bro_StoryDao bro_StoryDao;
    @Autowired
    MessageUtil messageUtil;
    @Autowired
    GsonUtil gsonUtil;
    @Autowired
    Mem_MemberDao mem_MemberDao;

    /**
     * 생방송 선물 목록 조회
     */
    public String getStoryList(P_StoryListInputVo pStoryListInputVo){
        ProcedureVo procedureVo = new ProcedureVo(pStoryListInputVo);
        ArrayList<P_StoryListOutputVo> StoryList = bro_StoryDao.callStoryList(procedureVo);
        P_StoryListOutputVo summary = new Gson().fromJson(procedureVo.getExt(), P_StoryListOutputVo.class);

        for(int i=0;i<StoryList.size();i++){
            MemberVo memInfoOutVo = mem_MemberDao.getMemberInfo(StoryList.get(i).getMem_no());
            if(!DalbitUtil.isEmpty(memInfoOutVo)) {
                StoryList.get(i).setMem_sex(memInfoOutVo.getMem_sex());
                StoryList.get(i).setMem_birth_year(memInfoOutVo.getMem_birth_year());
                StoryList.get(i).setMem_birth_month(memInfoOutVo.getMem_birth_month());
                StoryList.get(i).setMem_birth_day(memInfoOutVo.getMem_birth_day());
            }
        }

        String result;
        if(Integer.parseInt(procedureVo.getRet()) > 0) {
            result = gsonUtil.toJson(new JsonOutputVo(Status.생방송_사연목록조회_성공, StoryList, new PagingVo(procedureVo.getRet()),summary));
        }else{
            result = gsonUtil.toJson(new JsonOutputVo(Status.생방송_사연목록조회_실패));
        }
        return result;
    }

    /**
     * 생방송 사연 내역 삭제
     */
    public String getStoryDelete(P_StoryDeleteVo pStoryDeleteVo){
        ProcedureVo procedureVo = new ProcedureVo(pStoryDeleteVo);
        bro_StoryDao.callStoryDelete(procedureVo);

        String result = "";
        if(Status.생방송_사연삭제_성공.getMessageCode().equals(procedureVo.getRet())){
            result = gsonUtil.toJson(new JsonOutputVo(Status.생방송_사연삭제_성공));
        } else if(Status.생방송_사연삭제_번호없음.getMessageCode().equals(procedureVo.getRet())){
            result = gsonUtil.toJson(new JsonOutputVo(Status.생방송_사연삭제_번호없음));
        } else if(Status.생방송_사연삭제_방번호틀림.getMessageCode().equals(procedureVo.getRet())){
            result = gsonUtil.toJson(new JsonOutputVo(Status.생방송_사연삭제_방번호틀림));
        }
        return result;
    }

}
