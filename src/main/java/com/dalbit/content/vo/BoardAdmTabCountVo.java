package com.dalbit.content.vo;

import com.dalbit.common.vo.PagingVo;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class BoardAdmTabCountVo extends PagingVo {

    /* 게시글 관리 > 사연 Vo*/

    /* input */
    private String txt_search;
    private String start_sel;
    private String end_sel;
    private int broState;
    private int searchType;
    private int boardType;
    private int status;

    /* output */
    private int storyListCnt;
    private int fanBoardListCnt;
    private int fanBoardReplyCnt;
    private int noticeListCnt;
    private int broadNoticeListCnt;
    private int profileMsgListCnt;
    private int clipReplyCnt;
    private int broadNoticeReplyCnt;
    private int mailboxCnt;

}
