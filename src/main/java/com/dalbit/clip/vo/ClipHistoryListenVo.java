package com.dalbit.clip.vo;

import com.dalbit.common.vo.PagingVo;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class ClipHistoryListenVo extends PagingVo {

    /* input */
    private int searchType;
    private String searchText;
    private int search_testId;
    private String searchHistText;
    private String searchSex;
    private int orderByType;
    private int slctType;
    private int isChoiceDate;
    private int pageNo;
    private String targetMemNo;
    private String targetClipNo;
    private int searchOsType = -1;
    private int newSearchType;
    private int newSlctType;

    /* output */
    private String listenDate;
    private String listenMemNo;
    private String listenMemNick;
    private String listenMemSex;
    private String listenMemBirthYear;
    private String listenMemIp;
    private String clipIdx;
    private String castNo;
    private int subjectType;
    private String subjectName;
    private String title;
    private String typeEntry;
    private String imageBackground;
    private String fileName;
    private String filePath;
    private String filePlay;
    private String memNo;
    private String memSex;
    private String memBirthYear;
    private String memNick;
    private String typeOpen;
    private String state;
    private String hide;
    private String codeLink;
    private String countPlay;
    private String countGood;
    private String countGift;
    private String countByeol;
    private String startDate;
    private String endDate;
    private String badgeNewdj;
    private String osType;
    private String lastUpdDate;
    private String inner;
    private String dal;
    private String listenPlayCnt;
    private String listenGiftCnt;
    private String listenGiftDalCnt;
    private String listenGoodCnt;
    private String listenGoodDate;
    private int clipConfirm;

    private int listenerCnt;
    private int giftCnt;

}
