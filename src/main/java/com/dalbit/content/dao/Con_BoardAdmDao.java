package com.dalbit.content.dao;

import com.dalbit.common.vo.ProcedureVo;
import com.dalbit.content.vo.*;
import com.dalbit.member.vo.procedure.P_MemberEditHistInputVo;
import com.dalbit.member.vo.procedure.P_MemberEditHistOutputVo;
import com.dalbit.member.vo.procedure.P_MemberProfileInputVo;
import com.dalbit.member.vo.procedure.P_MemberProfileOutputVo;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.List;

@Repository
public interface Con_BoardAdmDao {

    @Transactional(readOnly = true)
    ArrayList<BoardAdmFanBoardVo> selectFanBoardList(BoardAdmFanBoardVo boardAdmFanBoardVo);

//    @Transactional(readOnly = true)
//    ArrayList<BoardAdmFanBoardVo> selectFanBoardSummary(BoardAdmFanBoardVo boardAdmFanBoardVo);

    @Transactional(readOnly = true)
    BoardAdmFanBoardVo selectFanBoardSummary(BoardAdmFanBoardVo boardAdmFanBoardVo);

    int deleteFanBoard(BoardAdmFanBoardDeleteVo boardAdmFanBoardDeleteVo);

    @Transactional(readOnly = true)
    ArrayList<BoardAdmFanBoardReplyVo> selectReply(BoardAdmFanBoardReplyVo boardAdmFanBoardReplyVo);

    @Transactional(readOnly = true)
    int selectFanBoardListCnt(BoardAdmFanBoardVo boardAdmFanBoardVo);

    @Transactional(readOnly = true)
    ArrayList<BoardAdmStoryVo> selectStoryList(BoardAdmStoryVo boardAdmStoryVo);

    @Transactional(readOnly = true)
    BoardAdmStoryVo selectStoryListSummary(BoardAdmStoryVo boardAdmStoryVo);

    @Transactional(readOnly = true)
    int selectStoryListCnt(BoardAdmStoryVo boardAdmStoryVo);

//    ProcedureVo callStoryDelete(ProcedureVo procedureVo);
    int callStoryDelete(String storyIdx);

    @Transactional(readOnly = true)
    int selectprofileMsgListCnt(P_MemberProfileInputVo pMemberProfileInputVo);

    @Transactional(readOnly = true)
    List<P_MemberProfileOutputVo> selectProfileMsgList(P_MemberProfileInputVo pMemberProfileInputVo);

    @Transactional(readOnly = true)
    P_MemberProfileOutputVo profileMsgListSummary(P_MemberProfileInputVo pMemberProfileInputVo);

    int callProfileMsgDelete(P_MemberProfileInputVo pMemberProfileInputVo);

    @Transactional(readOnly = true)
    int selectClipReplyListCnt(ClipReplyListVo clipReplyListVo);

    @Transactional(readOnly = true)
    ArrayList<ClipReplyListVo> selectClipReplyList(ClipReplyListVo clipReplyListVo);

    @Transactional(readOnly = true)
    ClipReplyListVo clipReplyListSummary(ClipReplyListVo clipReplyListVo);

    int clipReplyDelete(ClipReplyListVo clipReplyListVo);

    @Transactional(readOnly = true)
    P_MemberProfileOutputVo callMemberProfileMsg(P_MemberProfileInputVo pMemberProfileInputVo);

    @Transactional(readOnly = true)
    int editListCnt(P_MemberEditHistInputVo pMemberEditHistInputVo);

    @Transactional(readOnly = true)
    ArrayList<P_MemberEditHistOutputVo> editList(P_MemberEditHistInputVo pMemberEditHistInputVo);

    @Transactional(readOnly = true)
    BoardAdmTabCountVo tabCount(BoardAdmTabCountVo boardAdmTabCountVo);

    @Transactional(readOnly = true)
    ArrayList<MailboxVo> callMailbox(ProcedureVo procedureVo);

    @Transactional(readOnly = true)
    ArrayList<MailboxVo> callMailboxGift(ProcedureVo procedureVo);

    @Transactional(readOnly = true)
    ArrayList<BoardAdmTabCountVo> mailboxTabCount(BoardAdmTabCountVo boardAdmTabCountVo);

    @Transactional(readOnly = true)
    ArrayList<MiniGameListVo> callMiniGameList(ProcedureVo procedureVo);

    @Transactional(readOnly = true)
    ProcedureVo callMiniGameDetail(ProcedureVo procedureVo);

    ProcedureVo callMiniGameUpdate(ProcedureVo procedureVo);

    ProcedureVo callMiniGameAdd(ProcedureVo procedureVo);

    @Transactional(readOnly = true)
    ArrayList<MiniGameListVo> miniGameHistoryList(ProcedureVo procedureVo);

    @Transactional(readOnly = true)
    ArrayList<MiniGameListVo> miniGameMemberList(ProcedureVo procedureVo);

    @Transactional(readOnly = true)
    ArrayList<MiniGameListVo> miniGameEditHistory(ProcedureVo procedureVo);
}
