package com.dalbit.content.vo;

import com.dalbit.common.vo.PagingVo;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class RouletteCalendarVo extends PagingVo {

    /* input */
    private String search_startDate;
    private String search_endDate;

    /* output */
    private String start_date;
    private String end_date;
    private String the_date;
    private int loginCnt;
    private int joinCnt;
    private int itemCnt;
    private int applyCnt;
    private int sex_man;
    private int sex_female;
    private int sex_unknown;
    private int itemNo1;
    private int itemNo2;
    private int itemNo3;
    private int itemNo4;
    private int itemNo5;
    private int itemNo6;
    private int itemNo7;
    private int itemNo8;
    private int itemNo9;
}
