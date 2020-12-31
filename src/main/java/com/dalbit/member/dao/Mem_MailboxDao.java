package com.dalbit.member.dao;

import com.dalbit.common.vo.ProcedureVo;
import com.dalbit.member.vo.procedure.P_MailboxListVo;
import com.dalbit.member.vo.procedure.P_MailboxMsgVo;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;

@Repository
public interface Mem_MailboxDao {

    @Transactional(readOnly = true)
    ArrayList<P_MailboxListVo> callMailboxList(ProcedureVo procedureVo);

    @Transactional(readOnly = true)
    ArrayList<P_MailboxMsgVo> callMailboxMsg(ProcedureVo procedureVo);

    @Transactional(readOnly = true)
    ArrayList<P_MailboxMsgVo> callMailboxMember(ProcedureVo procedureVo);
}
