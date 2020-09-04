package com.dalbit.content.dao;

import com.dalbit.common.vo.ProcedureVo;
import com.dalbit.content.vo.BoardAdmFanBoardDeleteVo;
import com.dalbit.content.vo.BoardAdmFanBoardReplyVo;
import com.dalbit.content.vo.BoardAdmFanBoardVo;
import com.dalbit.content.vo.BoardAdmStoryVo;
import com.dalbit.member.vo.procedure.P_MemberNoticeInputVo;
import com.dalbit.member.vo.procedure.P_MemberNoticeOutputVo;
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
}
