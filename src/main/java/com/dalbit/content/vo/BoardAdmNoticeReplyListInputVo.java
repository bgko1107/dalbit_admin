package com.dalbit.content.vo;

import com.dalbit.common.vo.PagingVo;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class BoardAdmNoticeReplyListInputVo extends PagingVo {

    /* 게시글 관리 > 회원공지댓글 리스트 조회 Vo*/

    /* input */
    private String txt_search;
    private String start_sel;
    private String end_sel;
    private int pageNo;
    private int replyStatus;
    private int newSearchType;

}
