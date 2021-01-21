package com.dalbit.content.controller.rest;

import com.dalbit.broadcast.vo.procedure.P_StoryDeleteVo;
import com.dalbit.content.service.Con_BoardAdmService;
import com.dalbit.content.vo.*;
import com.dalbit.member.vo.procedure.P_MemberEditHistInputVo;
import com.dalbit.member.vo.procedure.P_MemberNoticeInputVo;
import com.dalbit.member.vo.procedure.P_MemberProfileInputVo;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@Slf4j
@RestController
@RequestMapping("/rest/content/boardAdm")
public class Con_BoardAdmRestController {

    @Autowired
    Con_BoardAdmService conBoardAdmService;


    /**
     * 팬보드 조회
     */
    @PostMapping("/fanBoardList")
    public String selectFanBoardList(BoardAdmFanBoardVo boardAdmFanBoardVo) {
        return conBoardAdmService.selectFanBoardList(boardAdmFanBoardVo);
    }

    /**
     * 팬보드 통계
     */
    @PostMapping("/fanBoardList/summary")
    public String selectFanBoardSummary(BoardAdmFanBoardVo boardAdmFanBoardVo) {
        return conBoardAdmService.selectFanBoardSummary(boardAdmFanBoardVo);
    }

    /**
     * 팬보드 삭제
     */
    @PostMapping("/deleteFanBoard")
    public String deleteFanBoard(BoardAdmFanBoardDeleteVo boardAdmFanBoardDeleteVo) {
        return conBoardAdmService.deleteFanBoard(boardAdmFanBoardDeleteVo);
    }

    /**
     * 팬보드 리플 조회
     */
    @PostMapping("/selectReply")
    public String selectReply(BoardAdmFanBoardReplyVo boardAdmFanBoardReplyVo) {
        return conBoardAdmService.selectReply(boardAdmFanBoardReplyVo);
    }

    /**
     * 사연 조회
     */
    @PostMapping("/storyList")
    public String selectStoryList(BoardAdmStoryVo boardAdmStoryVo) {
        return conBoardAdmService.selectStoryList(boardAdmStoryVo);
    }

    /**
     * 사연 통계
     */
    @PostMapping("/storyList/summary")
    public String selectstoryListSummary(BoardAdmStoryVo boardAdmStoryVo) {
        return conBoardAdmService.selectStorySummary(boardAdmStoryVo);
    }

    /**
     * 사연 삭제
     */
    @PostMapping("/deleteStory")
    public String deleteStory(P_StoryDeleteVo pStoryDeleteVo) {
        return conBoardAdmService.callStoryDelete(pStoryDeleteVo);
    }

    /**
     * 사연 여러개 삭제
     */
    @PostMapping("/multi/deleteStory")
    public String multiDeleteStory(P_StoryDeleteVo pStoryDeleteVo) {
        return conBoardAdmService.callStoryMultiDelete(pStoryDeleteVo);
    }

    /**
     * 회원/방송공지 조회
     */
    @PostMapping("/noticeList")
    public String noticeList(P_MemberNoticeInputVo pMemberNoticeInputVo) {
        return conBoardAdmService.selectNoticeList(pMemberNoticeInputVo);
    }

    /**
     * 회원공지 리플 조회 (회원공지 탭 목록에서의 리플 조회)
     */
    @PostMapping("/selectNoticeReply")
    public String noticeReply(BoardAdmNoticeReplyVo boardAdmNoticeReplyVo) {
        return conBoardAdmService.selectNoticeReply(boardAdmNoticeReplyVo);
    }

    /**
     * 회원공지댓글 조회 (회원공지댓글 탭)
     */
    @PostMapping("/noticeReplyList")
    public String noticeReplyList(BoardAdmNoticeReplyListInputVo boardAdmNoticeReplyListInputVo) {
        return conBoardAdmService.selectNoticeReplyList(boardAdmNoticeReplyListInputVo);
    }

    /**
     * 회원공지댓글 삭제
     */
    @PostMapping("/noticeReplyList/delete")
    public String noticeReplyListDelete(BoardAdmNoticeReplyDeleteVo boardAdmNoticeReplyDeleteVo) {
        return conBoardAdmService.deleteNoticeReplyList(boardAdmNoticeReplyDeleteVo);
    }

    /**
     * 회원공지댓글 여러개 삭제
     */
    @PostMapping("/noticeReplyList/multi/delete")
    public String noticeReplyListMultiDelete(BoardAdmNoticeReplyDeleteVo boardAdmNoticeReplyDeleteVo) {
        return conBoardAdmService.deleteMultiNoticeReplyList(boardAdmNoticeReplyDeleteVo);
    }

    /**
     * 공지 통계
     * @param pMemberNoticeInputVo
     * @return
     */
    @PostMapping("/noticeList/summary")
    public String noticeListSummary(P_MemberNoticeInputVo pMemberNoticeInputVo) {
        return conBoardAdmService.selectNoticeSummary(pMemberNoticeInputVo);
    }

    /**
     * 공지댓글 통계
     */
    @PostMapping("/noticeReplyList/summary")
    public String noticeReplyListSummary(BoardAdmNoticeReplyListInputVo boardAdmNoticeReplyListInputVo) {
        return conBoardAdmService.selectNoticeReplyListSummary(boardAdmNoticeReplyListInputVo);
    }

    /**
     * 프로필메세지 조회
     */
    @PostMapping("/profileMsgList")
    public String profileMsgList(P_MemberProfileInputVo pMemberNoticeInputVo) {
        return conBoardAdmService.selectprofileMsgList(pMemberNoticeInputVo);
    }

    /**
     * 프로필메세지 통계
     * @param pMemberProfileInputVo
     * @return
     */
    @PostMapping("/profileMsg/summary")
    public String profileMsgListSummary(P_MemberProfileInputVo pMemberProfileInputVo) {
        return conBoardAdmService.profileMsgListSummary(pMemberProfileInputVo);
    }

    /**
     * 프로필메시지 삭제
     */
    @PostMapping("/profileMsg/del")
    public String profileMsgDel(P_MemberProfileInputVo pMemberProfileInputVo) {
        return conBoardAdmService.profileDelete(pMemberProfileInputVo);
    }

    /**
     * 프로필메시지 여러개 삭제
     */
    @PostMapping("/profileMsg/multi/del")
    public String profileMsgMultiDel(P_MemberProfileInputVo pMemberProfileInputVo) {
        return conBoardAdmService.profileMultiDelete(pMemberProfileInputVo);
    }

    /**
     * 클립 목록 조회
     */
    @PostMapping("/clipReplyList")
    public String clipReplyList(ClipReplyListVo clipReplyListVo) {
        return conBoardAdmService.selectClipReplyList(clipReplyListVo);
    }

    /**
     * 프로필메세지 통계
     */
    @PostMapping("/clipReplyList/summary")
    public String clipReplyListSummary(ClipReplyListVo clipReplyListVo) {
        return conBoardAdmService.clipReplyListSummary(clipReplyListVo);
    }

    /**
     * 클립댓글 삭제
     */
    @PostMapping("/clipReplyList/del")
    public String clipReplyListDel(ClipReplyListVo clipReplyListVo) {
        return conBoardAdmService.clipReplyListDel(clipReplyListVo);
    }

    /**
     * 클립댓글 여러개 삭제
     */
    @PostMapping("/clipReplyList/multi/del")
    public String clipReplyListMultiDel(ClipReplyListVo clipReplyListVo) {
        return conBoardAdmService.clipReplyListMultiDel(clipReplyListVo);
    }


    /**
     * 수정이력
     */
    @PostMapping("/edit/list")
    public String editList(P_MemberEditHistInputVo pMemberEditHistInputVo) {
        return conBoardAdmService.editList(pMemberEditHistInputVo);
    }



    /**
     * Tab Count Select
     */
    @PostMapping("/tab/count")
    public String tabCount(BoardAdmTabCountVo boardAdmTabCountVo) {
        return conBoardAdmService.tabCount(boardAdmTabCountVo);
    }


    /**
     * 우체통 대화 목록
     */
    @PostMapping("mailbox")
    public String mailbox(MailboxVo mailboxVo){
        String result = conBoardAdmService.callMailbox(mailboxVo);
        return result;
    }

    /**
     * 우체통 선물 목록
     */
    @PostMapping("mailbox/gift")
    public String mailboxGift(MailboxVo mailboxVo){
        String result = conBoardAdmService.callMailboxGift(mailboxVo);
        return result;
    }

    /**
     * Mailbox Tab Count Select
     */
    @PostMapping("/mailbox/tab/count")
    public String mailboxTabCount(BoardAdmTabCountVo boardAdmTabCountVo) {
        return conBoardAdmService.mailboxTabCount(boardAdmTabCountVo);
    }
}
