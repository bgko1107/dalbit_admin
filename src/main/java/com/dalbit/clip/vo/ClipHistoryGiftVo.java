package com.dalbit.clip.vo;

import com.dalbit.common.vo.PagingVo;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class ClipHistoryGiftVo extends PagingVo {

    /* input */
    private int searchType;
    private String searchText;
    private int search_testId;
    private String searchHistText;
    private int orderByType;
    private int slctType;
    private int isChoiceDate;
    private int pageNo;
    private String targetClipNo;
    private int newSearchType;

    private String searchSex;
    private int searchState = -1;

    /* output */
    private String memNo;
    private String memNick;
    private String memSex;
    private String memBirthYear;
    private String giftDate;
    private String giftedMemNo;
    private String giftedMemNick;
    private String giftedMemSex;
    private String giftedMemBirthYear;
    private String itemThumbnail;
    private String itemWebpImage;
    private String itemName;
    private int itemCnt;
    private int gold;
    private int ruby;
    private int itemTotalCnt;
    private int goldTotalCnt;

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
    private String inner;
    private String dal;
    private String lastUpdDate;
    private int clipConfirm;

}
