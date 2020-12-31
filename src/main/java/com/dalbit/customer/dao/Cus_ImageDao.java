package com.dalbit.customer.dao;

import com.dalbit.clip.vo.ClipHistoryVo;
import com.dalbit.common.vo.ProcedureVo;
import com.dalbit.customer.vo.procedure.P_ImageBroadcastListInputVo;
import com.dalbit.customer.vo.procedure.P_ImageBroadcastListOutputVo;
import com.dalbit.customer.vo.procedure.P_ImageProfileListInputVo;
import com.dalbit.customer.vo.procedure.P_ImageProfileListOutputVo;
import com.dalbit.member.vo.MemberNoticeImgDeleteVo;
import com.dalbit.member.vo.procedure.P_MailboxImgListVo;
import com.dalbit.member.vo.procedure.P_MemberNoticeInputVo;
import com.dalbit.member.vo.procedure.P_MemberNoticeOutputVo;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;

@Repository
public interface Cus_ImageDao {

    @Transactional(readOnly = true)
    int callCustomerImageProfileListCnt(P_ImageProfileListInputVo pImageProfileListInputVo);

    @Transactional(readOnly = true)
    ArrayList<P_ImageProfileListOutputVo> callCustomerImageProfileList(P_ImageProfileListInputVo pImageProfileListInputVo);

    @Transactional(readOnly = true)
    int callCustomerImageBroadcastListCnt(P_ImageBroadcastListInputVo pImageBroadcastListInputVo);

    @Transactional(readOnly = true)
    ArrayList<P_ImageBroadcastListOutputVo> callCustomerImageBroadcastList(P_ImageBroadcastListInputVo pImageBroadcastListInputVo);

    @Transactional(readOnly = true)
    ArrayList<ClipHistoryVo> callClipList(ProcedureVo procedureVo);

    @Transactional(readOnly = true)
    int getNoticeHistory_totalCnt(P_MemberNoticeInputVo pMemberNoticeInputVo);

    @Transactional(readOnly = true)
    ArrayList<P_MemberNoticeOutputVo> getNoticeHistory(P_MemberNoticeInputVo pMemberNoticeInputVo);

    int deleteNoticeImg(MemberNoticeImgDeleteVo memberNoticeImgDeleteVo);

    @Transactional(readOnly = true)
    ArrayList<P_MailboxImgListVo> callMailboxImgList(ProcedureVo procedureVo);
}