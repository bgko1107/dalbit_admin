package com.dalbit.clip.vo;

import com.dalbit.common.vo.PagingVo;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class ClipHistoryRemoveVo extends PagingVo {

    /* input */
    private int searchType;
    private String searchText;
    private int search_testId;
    private String searchHistText;
    private int orderByType;
    private int slctType;
    private int isChoiceDate;
    private int pageNo;
    private int newSearchType;
    private int newSlctType;

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
    private String inner;
    private String dal;
    private int clipConfirm;
    private String delName;


}
