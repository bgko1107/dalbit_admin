package com.dalbit.content.service;

import com.dalbit.broadcast.dao.Bro_BroadcastDao;
import com.dalbit.broadcast.vo.procedure.P_StoryDeleteVo;
import com.dalbit.common.code.Status;
import com.dalbit.common.vo.JsonOutputVo;
import com.dalbit.common.vo.PagingVo;
import com.dalbit.common.vo.ProcedureVo;
import com.dalbit.content.dao.Con_BoardAdmDao;
import com.dalbit.content.vo.*;
import com.dalbit.member.dao.Mem_MemberDao;
import com.dalbit.member.dao.Mem_NoticeDao;
import com.dalbit.member.vo.MemberVo;
import com.dalbit.member.vo.procedure.*;
import com.dalbit.util.GsonUtil;
import com.google.gson.Gson;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Slf4j
@Service
public class Con_BoardAdmService {

    @Autowired
    GsonUtil gsonUtil;

    @Autowired
    Con_BoardAdmDao conBoardAdmDao;

    @Autowired
    Mem_NoticeDao mem_NoticeDao;

    @Autowired
    Bro_BroadcastDao bro_BroadcastDao;

    @Autowired
    Mem_MemberDao mem_MemberDao;

    /**
     * 팬보드 조회
     */
    public String selectFanBoardList(BoardAdmFanBoardVo boardAdmFanBoardVo) {
        int fanBoardCount = conBoardAdmDao.selectFanBoardListCnt(boardAdmFanBoardVo);
        boardAdmFanBoardVo.setTotalCnt(fanBoardCount);
        ArrayList<BoardAdmFanBoardVo> fanBoardList = conBoardAdmDao.selectFanBoardList(boardAdmFanBoardVo);

        String result;
        result = gsonUtil.toJson(new JsonOutputVo(Status.Fan목록보기성공, fanBoardList, new PagingVo(boardAdmFanBoardVo.getTotalCnt(), boardAdmFanBoardVo.getPageStart(), boardAdmFanBoardVo.getPageCnt())));

        return result;
    }

    /**
     * 팬보드 통계
     */
    public String selectFanBoardSummary(BoardAdmFanBoardVo boardAdmFanBoardVo) {
        BoardAdmFanBoardVo fanBoardSummaryList = conBoardAdmDao.selectFanBoardSummary(boardAdmFanBoardVo);

//        BoardAdmFanBoardVo fanBoardSummary = new BoardAdmFanBoardVo();
//        for(int i=0;i<fanBoardSummaryList.size();i++){
//            if(fanBoardSummaryList.get(i).getType().equals("nomal")) {
//                fanBoardSummary.setTotalCnt(fanBoardSummaryList.get(i).getTotalCnt());
//                fanBoardSummary.setAvgTotalCnt(fanBoardSummaryList.get(i).getAvgTotalCnt());
//                fanBoardSummary.setTotalDelCnt(fanBoardSummaryList.get(i).getTotalDelCnt());
//                fanBoardSummary.setAvgTotalDelCnt(fanBoardSummaryList.get(i).getAvgTotalDelCnt());
//                fanBoardSummary.setMaleCnt(fanBoardSummaryList.get(i).getMaleCnt());
//                fanBoardSummary.setFemaleCnt(fanBoardSummaryList.get(i).getFemaleCnt());
//                fanBoardSummary.setNoneCnt(fanBoardSummaryList.get(i).getNoneCnt());
//            }else{
//                fanBoardSummary.setSecretTotalCnt(fanBoardSummaryList.get(i).getTotalCnt());
//                fanBoardSummary.setSecretAvgTotalCnt(fanBoardSummaryList.get(i).getAvgTotalCnt());
//                fanBoardSummary.setSecretTotalDelCnt(fanBoardSummaryList.get(i).getTotalDelCnt());
//                fanBoardSummary.setSecretAvgTotalDelCnt(fanBoardSummaryList.get(i).getAvgTotalDelCnt());
//                fanBoardSummary.setSecretMaleCnt(fanBoardSummaryList.get(i).getMaleCnt());
//                fanBoardSummary.setSecretFemaleCnt(fanBoardSummaryList.get(i).getFemaleCnt());
//                fanBoardSummary.setSecretNoneCnt(fanBoardSummaryList.get(i).getNoneCnt());
//            }
//        }

        String result;
        result = gsonUtil.toJson(new JsonOutputVo(Status.Fan목록보기성공, fanBoardSummaryList));

        return result;
    }

    /**
     * 팬보드 삭제
     */
    public String deleteFanBoard(BoardAdmFanBoardDeleteVo boardAdmFanBoardDeleteVo) {
        boardAdmFanBoardDeleteVo.setOpName(MemberVo.getMyMemNo());
        int result = conBoardAdmDao.deleteFanBoard(boardAdmFanBoardDeleteVo);
        if(result > 0) {
            return gsonUtil.toJson(new JsonOutputVo(Status.Fanboard삭제성공));
        } else {
            return gsonUtil.toJson(new JsonOutputVo(Status.Fanboard삭제실패));
        }
    }

    /**
     * 팬보드 리플 조회
     */
    public String selectReply(BoardAdmFanBoardReplyVo boardAdmFanBoardReplyVo) {
        ArrayList<BoardAdmFanBoardReplyVo> replyList = conBoardAdmDao.selectReply(boardAdmFanBoardReplyVo);
        return gsonUtil.toJson(new JsonOutputVo(Status.FanboardReply목록보기성공, replyList));
    }

    /**
     * 사연 조회
     */
    public String selectStoryList(BoardAdmStoryVo boardAdmStoryVo) {
        int storyCount = conBoardAdmDao.selectStoryListCnt(boardAdmStoryVo);
        boardAdmStoryVo.setTotalCnt(storyCount);
        ArrayList<BoardAdmStoryVo> storyList = conBoardAdmDao.selectStoryList(boardAdmStoryVo);

        String result = gsonUtil.toJson(new JsonOutputVo(Status.조회, storyList, new PagingVo(boardAdmStoryVo.getTotalCnt(), boardAdmStoryVo.getPageStart(), boardAdmStoryVo.getPageCnt())));

        return result;
    }

    /**
     * 팬보드 통계
     */
    public String selectStorySummary(BoardAdmStoryVo boardAdmStoryVo) {
        BoardAdmStoryVo storySummaryList = conBoardAdmDao.selectStoryListSummary(boardAdmStoryVo);
        String result;
        result = gsonUtil.toJson(new JsonOutputVo(Status.조회, storySummaryList));

        return result;
    }

    /**
     * 사연 삭제
     */
    public String callStoryDelete(P_StoryDeleteVo pStoryDeleteVo) {
//        ProcedureVo procedureVo = new ProcedureVo(pStoryDeleteVo);
//        conBoardAdmDao.callStoryDelete(procedureVo);
        int resultInt = conBoardAdmDao.callStoryDelete(pStoryDeleteVo.getStoryIdx());

        String result = "";
        if(resultInt != 0){
            result = gsonUtil.toJson(new JsonOutputVo(Status.생방송_사연삭제_성공));
//        } else if(Status.생방송_사연삭제_번호없음.getMessageCode().equals(procedureVo.getRet())){
//            result = gsonUtil.toJson(new JsonOutputVo(Status.생방송_사연삭제_번호없음));
        } else {
            result = gsonUtil.toJson(new JsonOutputVo(Status.생방송_사연삭제_방번호틀림));
        }
        return result;
    }

    /**
     * 회원/방송공지 조회
     */
    public String selectNoticeList(P_MemberNoticeInputVo pMemberNoticeInputVo) {
        pMemberNoticeInputVo.setPageNo(pMemberNoticeInputVo.getPageNo() -1);
        pMemberNoticeInputVo.setPageNo(pMemberNoticeInputVo.getPageNo() * pMemberNoticeInputVo.getPageCnt());
        int totalCnt = mem_NoticeDao.callNoticeHistory_totalCnt(pMemberNoticeInputVo);
        ArrayList<P_MemberNoticeOutputVo> noticeList = mem_NoticeDao.callNoticeHistory(pMemberNoticeInputVo);

        String result;
        result = gsonUtil.toJson(new JsonOutputVo(Status.공지보기성공, noticeList, new PagingVo(totalCnt)));
        return result;

    }

    /**
     * 회원공지 리플 조회 (회원공지 탭 목록에서의 리플 조회)
     */
    public String selectNoticeReply(BoardAdmNoticeReplyVo boardAdmNoticeReplyVo) {
        ArrayList<BoardAdmNoticeReplyVo> reply = mem_NoticeDao.selectNoticeReply(boardAdmNoticeReplyVo);
        int replyCnt=0;
        for(int i=0; i<reply.size(); i++) {
            if(reply.get(i).getDepthType() == 1) {
                replyCnt++;
            }
        }

        if(replyCnt > 0) {
            return gsonUtil.toJson(new JsonOutputVo(Status.공지댓글조회_성공, reply));
        } else {
            return gsonUtil.toJson(new JsonOutputVo(Status.공지댓글조회_실패, reply));
        }
    }

    /**
     * 회원공지댓글 조회 (회원공지댓글 탭)
     */
    public String selectNoticeReplyList(BoardAdmNoticeReplyListInputVo boardAdmNoticeReplyListInputVo) {
        int totalCnt = mem_NoticeDao.selectNoticeReplyListCnt(boardAdmNoticeReplyListInputVo);
        boardAdmNoticeReplyListInputVo.setTotalCnt(totalCnt);
        ArrayList<BoardAdmNoticeReplyListOutputVo> replyList = mem_NoticeDao.selectNoticeReplyList(boardAdmNoticeReplyListInputVo);

        return gsonUtil.toJson(new JsonOutputVo(Status.공지댓글조회_성공, replyList, new PagingVo(boardAdmNoticeReplyListInputVo.getTotalCnt(), boardAdmNoticeReplyListInputVo.getPageStart(), boardAdmNoticeReplyListInputVo.getPageCnt())));
    }

    /**
     * 회원공지댓글 삭제
     */
    public String deleteNoticeReplyList(BoardAdmNoticeReplyDeleteVo boardAdmNoticeReplyDeleteVo) {
        boardAdmNoticeReplyDeleteVo.setOpName(MemberVo.getMyMemNo());
        int result = mem_NoticeDao.deleteNoticeReplyList(boardAdmNoticeReplyDeleteVo);
        if(result > 0) {
            return gsonUtil.toJson(new JsonOutputVo(Status.공지댓글삭제_성공));
        } else {
            return gsonUtil.toJson(new JsonOutputVo(Status.공지댓글삭제_실패));
        }
    }

    /**
     * 공지 통계
     */
    public String selectNoticeSummary(P_MemberNoticeInputVo pMemberNoticeInputVo) {
        P_MemberNoticeOutputVo noticeSummaryList = mem_NoticeDao.selectNoticeSummary(pMemberNoticeInputVo);
        String result;
        result = gsonUtil.toJson(new JsonOutputVo(Status.조회, noticeSummaryList));

        return result;
    }

    /**
     * 공지댓글 통계
     */
    public String selectNoticeReplyListSummary(BoardAdmNoticeReplyListInputVo boardAdmNoticeReplyListInputVo) {
        BoardAdmNoticeReplyListOutputVo replySummary = mem_NoticeDao.selectNoticeReplyListSummary(boardAdmNoticeReplyListInputVo);
        return gsonUtil.toJson(new JsonOutputVo(Status.조회, replySummary));
    }

    /**
     * 프로필메세지 조회
     */
    public String selectprofileMsgList(P_MemberProfileInputVo pMemberNoticeInputVo) {
        int profileMsgCount = conBoardAdmDao.selectprofileMsgListCnt(pMemberNoticeInputVo);
        pMemberNoticeInputVo.setTotalCnt(profileMsgCount);
        List<P_MemberProfileOutputVo> profileMsgList = conBoardAdmDao.selectProfileMsgList(pMemberNoticeInputVo);

        String result = gsonUtil.toJson(new JsonOutputVo(Status.조회, profileMsgList, new PagingVo(profileMsgCount)));
        return result;

    }

    /**
     * 프로필메시지 삭제
     */
    public String profileDelete(P_MemberProfileInputVo pMemberNoticeInputVo) {

        // befor 프로필메시지
        P_MemberProfileOutputVo pMemberProfileOutputVo = conBoardAdmDao.callMemberProfileMsg(pMemberNoticeInputVo);

        // 수정이력
        P_MemberEditorVo pMemberEditorVo = new P_MemberEditorVo();
        pMemberEditorVo.setOpName(MemberVo.getMyMemNo());
        pMemberEditorVo.setMem_no(pMemberNoticeInputVo.getMem_no());
        pMemberEditorVo.setEditContents("프로필메세지 변경 : " + pMemberProfileOutputVo.getMsg_profile() + " >> ");
        pMemberEditorVo.setType(0);
        mem_MemberDao.callMemberEditHistoryAdd(pMemberEditorVo);

        // 프로필 메시지 삭제
        int resultInt = conBoardAdmDao.callProfileMsgDelete(pMemberNoticeInputVo);

        String result;
        if(resultInt != 0){
            result = gsonUtil.toJson(new JsonOutputVo(Status.삭제));
        } else {
            result = gsonUtil.toJson(new JsonOutputVo(Status.비즈니스로직오류));
        }
        return result;
    }

    /**
     * 공지 통계
     */
    public String profileMsgListSummary(P_MemberProfileInputVo pMemberProfileInputVo) {
        P_MemberProfileOutputVo profileMsgSummaryList = conBoardAdmDao.profileMsgListSummary(pMemberProfileInputVo);
        String result;
        result = gsonUtil.toJson(new JsonOutputVo(Status.조회, profileMsgSummaryList));

        return result;
    }


    /**
     * 클립댓글 조회
     */
    public String selectClipReplyList(ClipReplyListVo clipReplyListVo) {

        clipReplyListVo.setPageStart(clipReplyListVo.getPageStart() -1);
        clipReplyListVo.setPageStart(clipReplyListVo.getPageStart() * clipReplyListVo.getPageCnt());

        int clipReplyListCount = conBoardAdmDao.selectClipReplyListCnt(clipReplyListVo);
        clipReplyListVo.setTotalCnt(clipReplyListCount);
        List<ClipReplyListVo> clipReplyList = conBoardAdmDao.selectClipReplyList(clipReplyListVo);

        String result = gsonUtil.toJson(new JsonOutputVo(Status.클립댓글조회_성공, clipReplyList, new PagingVo(clipReplyListCount)));
        return result;
    }

    /**
     * 클립댓글 통계
     */
    public String clipReplyListSummary(ClipReplyListVo clipReplyListVo) {
        ClipReplyListVo clipReplyListSummary = conBoardAdmDao.clipReplyListSummary(clipReplyListVo);
        String result;
        result = gsonUtil.toJson(new JsonOutputVo(Status.클립댓글조회_성공, clipReplyListSummary));

        return result;
    }

    /**
     * 클립댓글 삭제
     */
    public String clipReplyListDel(ClipReplyListVo clipReplyListVo) {
        int resultInt = conBoardAdmDao.clipReplyDelete(clipReplyListVo);

        String result;
        if(resultInt != 0){
            result = gsonUtil.toJson(new JsonOutputVo(Status.클립댓글삭제_성공));
        } else {
            result = gsonUtil.toJson(new JsonOutputVo(Status.클립댓글삭제_실패));
        }
        return result;
    }

    /**
     * 수정이력
     */
    public String editList(P_MemberEditHistInputVo pMemberEditHistInputVo) {
        int editListCount = conBoardAdmDao.editListCnt(pMemberEditHistInputVo);
        pMemberEditHistInputVo.setTotalCnt(editListCount);
        List<P_MemberEditHistOutputVo> editList = conBoardAdmDao.editList(pMemberEditHistInputVo);

        String result = gsonUtil.toJson(new JsonOutputVo(Status.조회, editList, new PagingVo(editListCount)));
        return result;
    }



    /**
     * Tab Count Select
     */
    public String tabCount(BoardAdmTabCountVo boardAdmTabCountVo) {

        BoardAdmTabCountVo outVo = conBoardAdmDao.tabCount(boardAdmTabCountVo);

        String result;
        result = gsonUtil.toJson(new JsonOutputVo(Status.TabCount조회_성공, outVo, new PagingVo(0, 0,0)));

        return result;
    }

    public String callMailbox(MailboxVo mailboxVo){

        ProcedureVo procedureVo = new ProcedureVo(mailboxVo);
        ArrayList<MailboxVo> list = conBoardAdmDao.callMailbox(procedureVo);
        MailboxVo summary = new Gson().fromJson(procedureVo.getExt(), MailboxVo.class);
        if(list.size() > 0){
            return gsonUtil.toJson(new JsonOutputVo(Status.조회, list, new PagingVo(summary.getTotalCnt()),summary));
        }else{
            return gsonUtil.toJson(new JsonOutputVo(Status.데이터없음, list, new PagingVo(summary.getTotalCnt()),summary));
        }

    }
}
