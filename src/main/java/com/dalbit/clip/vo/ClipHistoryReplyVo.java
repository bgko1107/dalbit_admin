package com.dalbit.clip.vo;

import com.dalbit.common.vo.PagingVo;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class ClipHistoryReplyVo extends PagingVo {

    /* input */
    private int searchType;
    private String searchText;
    private int search_testId;
    private String searchHistText;
    private int orderByType;
    private int slctType;
    private int isChoiceDate;
    private int pageNo;
    private String targetMemNo;
    private String targetClipNo;
    private String startDate;
    private String endDate;


    /* output */
    private String replyIdx;
    private String castNo;
    private String castMemNo;
    private String writerMemNo;
    private String contents;
    private String status;
    private String writeDate;
    private String lastUpdDate;
    private String memSex;
    private String memBirthYear;
    private String memNick;
    private String profileImage;
    private String inner;

    private int replyWriteCnt;

}
