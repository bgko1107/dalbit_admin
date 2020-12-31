package com.dalbit.member.service;


import com.dalbit.common.code.Status;
import com.dalbit.common.vo.*;
import com.dalbit.member.dao.Mem_MailboxDao;
import com.dalbit.member.vo.procedure.*;
import com.dalbit.util.*;
import com.google.gson.Gson;
import lombok.extern.slf4j.Slf4j;
import lombok.var;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.*;

@Slf4j
@Service
public class Mem_MailboxService {

    @Autowired
    Mem_MailboxDao mem_MailboxDao;
    @Autowired
    MessageUtil messageUtil;
    @Autowired
    GsonUtil gsonUtil;

    /**
     * 회원상세 우체통 방 목록
     * @param pMailboxListVo
     * @return
     */
    public String getMailboxList(P_MailboxListVo pMailboxListVo){
        ProcedureVo procedureVo = new ProcedureVo(pMailboxListVo);
        ArrayList<P_MailboxListVo> list = mem_MailboxDao.callMailboxList(procedureVo);
        P_MailboxListVo summary = new Gson().fromJson(procedureVo.getExt(), P_MailboxListVo.class);
        if(list.size() > 0){
            return gsonUtil.toJson(new JsonOutputVo(Status.조회, list, new PagingVo(summary.getTotalCnt()),summary));
        }else{
            return gsonUtil.toJson(new JsonOutputVo(Status.데이터없음, list, new PagingVo(summary.getTotalCnt()),summary));
        }
    }

    /**
     * 우체통 대화 목록
     * @param pMailboxMsgVo
     * @return
     */
    public String getMailboxMsg(P_MailboxMsgVo pMailboxMsgVo){
        ProcedureVo procedureVo = new ProcedureVo(pMailboxMsgVo);
        ArrayList<P_MailboxMsgVo> list = mem_MailboxDao.callMailboxMsg(procedureVo);
        P_MailboxMsgVo summary = new Gson().fromJson(procedureVo.getExt(), P_MailboxMsgVo.class);

        ArrayList<P_MailboxMsgVo> mailboxMember = mem_MailboxDao.callMailboxMember(procedureVo);

        var resultMap = new HashMap<>();
        resultMap.put("list", list);
        resultMap.put("mailboxMember", mailboxMember);

        if(list.size() > 0){
            return gsonUtil.toJson(new JsonOutputVo(Status.조회, resultMap, new PagingVo(summary.getTotalCnt()),summary));
        }else{
            return gsonUtil.toJson(new JsonOutputVo(Status.데이터없음, resultMap, new PagingVo(summary.getTotalCnt()),summary));
        }
    }
}
