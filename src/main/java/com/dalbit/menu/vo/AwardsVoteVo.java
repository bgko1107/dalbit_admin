package com.dalbit.menu.vo;

import com.dalbit.common.vo.PagingVo;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class AwardsVoteVo extends PagingVo {

    /* input */
    private String searchText;
    private String selectYear;
    private String mem_no;
    private int slctTarget;
    private int slctType;

    /* output */
    private int rank;
    private String memNo;
    private String memNick;
    private String profileImage;
    private String level;
    private String grade;
    private String memSex;
    private String memBirthYear;
    private String memAge;
    private int voteCnt;
    private int giftPoint;
    private int listenerPoint;
    private int goodPoint;
    private int boosterPoint;
    private int broadcastPoint;
    private String fan1_memNo;
    private String fan1_memNick;
    private String fan2_memNo;
    private String fan2_memNick;
    private String fan3_memNo;
    private String fan3_memNick;
    private int fanRank;
    private int listenPoint;


    private String lastUpdDate;
    private String ip;
}