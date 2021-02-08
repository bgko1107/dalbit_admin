package com.dalbit.menu.vo;

import com.dalbit.common.vo.PagingVo;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class ShiningVo extends PagingVo {

    /* input */
    private String checkDate;
    private int newSearchType;
    private int pageNo;

    private String mem_no;
    private String profileImage;
    private String memNick;
    private String memSex;
    private String memJoinDate;
    private int dateCnt;
    private int broadcastCnt;
    private int airTime;
    private int sumEntry;
    private int avgEntry;
    private int byeolCnt;
    private int reportedCnt;


    private int slctType;
    private int badgeValue;
    private int badgeType;
    private int badgeRank;
    private String memNo;
    private String startDate;
    private String endDate;
    private String searchText;


}
