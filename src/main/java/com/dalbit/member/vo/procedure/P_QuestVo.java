package com.dalbit.member.vo.procedure;

import com.dalbit.common.vo.SearchVo;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class P_QuestVo extends SearchVo {

    private String questDate;
    private String questNo;


    /* output */

    private String questName;
    private String questDesc;
    private String reward;
    private int goalCnt;
    private int successCnt;
    private int rewardYn;

    private int idx;
    private String linkIdx;
    private String lastUpdDate;
    private String memNo;
    private String memNick;

    private String type;
    private String title;
    private int subjectType;
    private String itemName;
    private int itemCnt;
    private int dal;
    private int listentime;

}

