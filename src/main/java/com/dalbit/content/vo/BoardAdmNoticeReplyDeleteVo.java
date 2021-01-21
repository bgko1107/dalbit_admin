package com.dalbit.content.vo;

import com.dalbit.common.vo.PagingVo;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class BoardAdmNoticeReplyDeleteVo extends PagingVo {

    /* 게시글 관리 > 회원공지 댓글 삭제 input Vo*/
    private String replyIdxs;
    private int replyIdx;
    private int status;
}
