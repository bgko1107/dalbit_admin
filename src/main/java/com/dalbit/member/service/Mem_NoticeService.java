package com.dalbit.member.service;

import com.dalbit.broadcast.dao.Bro_BroadcastDao;
import com.dalbit.broadcast.vo.procedure.P_BroadcastEditInputVo;
import com.dalbit.common.code.Status;
import com.dalbit.common.vo.JsonOutputVo;
import com.dalbit.common.vo.PagingVo;
import com.dalbit.member.dao.Mem_NoticeDao;
import com.dalbit.member.vo.MemberVo;
import com.dalbit.member.vo.procedure.P_MemberNoticeDeleteVo;
import com.dalbit.member.vo.procedure.P_MemberNoticeInputVo;
import com.dalbit.member.vo.procedure.P_MemberNoticeOutputVo;
import com.dalbit.util.GsonUtil;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;

@Slf4j
@Service
public class Mem_NoticeService {

    @Autowired
    Mem_NoticeDao mem_NoticeDao;
    @Autowired
    Bro_BroadcastDao bro_BroadcastDao;
    @Autowired
    GsonUtil gsonUtil;

    public String getNoticeHistory(P_MemberNoticeInputVo pMemberNoticeInputVo){
        pMemberNoticeInputVo.setPageNo(pMemberNoticeInputVo.getPageNo() -1);
        pMemberNoticeInputVo.setPageNo(pMemberNoticeInputVo.getPageNo() * pMemberNoticeInputVo.getPageCnt());
        ArrayList<P_MemberNoticeOutputVo> noticeList = mem_NoticeDao.callNoticeHistory(pMemberNoticeInputVo);
        int totalCnt = mem_NoticeDao.callNoticeHistory_totalCnt(pMemberNoticeInputVo);

        String result;
        result = gsonUtil.toJson(new JsonOutputVo(Status.공지보기성공, noticeList, new PagingVo(totalCnt)));
        log.info(result);
        return result;
    }



    /**
     * 회원 공지 삭제
     */
    public String getNoticeDelete(P_MemberNoticeDeleteVo pMemberNoticeDeleteVo){
        pMemberNoticeDeleteVo.setOpName(MemberVo.getMyMemNo());

        if(pMemberNoticeDeleteVo.getNoticeType().equals("1")) {
            mem_NoticeDao.callMemberNoticeDelete(pMemberNoticeDeleteVo);
        }else if(pMemberNoticeDeleteVo.getNoticeType().equals("2")) {
            // befor 공지내용
            P_MemberNoticeOutputVo pMemberNoticeOutputVo = mem_NoticeDao.callBroadBeforNotice(pMemberNoticeDeleteVo);

            // 수정이력
            P_BroadcastEditInputVo pBroadcastEditInputVo = new P_BroadcastEditInputVo();
            pBroadcastEditInputVo.setOpName(MemberVo.getMyMemNo());
            pBroadcastEditInputVo.setRoom_no(pMemberNoticeDeleteVo.getRoomNo());
            pBroadcastEditInputVo.setEditContents("방송방공지변경 : " + pMemberNoticeOutputVo.getContents() + " >> ");
            bro_BroadcastDao.callBroadCastEditHistoryAdd(pBroadcastEditInputVo);

            // 삭제
            mem_NoticeDao.callBroadNoticeDelete(pMemberNoticeDeleteVo);
        }

        String result;
            result = gsonUtil.toJson(new JsonOutputVo(Status.공지삭제_성공));
        return result;
    }
}