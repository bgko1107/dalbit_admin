package com.dalbit.clip.vo;

import com.dalbit.common.vo.PagingVo;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class ClipHistoryVo extends PagingVo {

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
    private int newSearchType;
    private int newSlctType;

    private int searchTypeOpen = -1;
    private int searchConfirm = -1;
    private int searchState = -1;
    private int searchOsType = -1;
    private int searchAgeType = -1;
    private int searchGroupBy = -1;
    private String searchSex;

    /* output */
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
    private int memInsertCnt;
    private int memDeleteCnt;
    private String inner;
    private String replyCnt;
    private int clipConfirm;
    private int opMemoCnt;
    private String delName;
    private String hideName;
    private int countMaxPlay;
    private int countPlayMemberCnt;

}
