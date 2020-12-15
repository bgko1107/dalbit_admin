package com.dalbit.menu.vo;

import com.dalbit.common.vo.PagingVo;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class DjRankingVo extends PagingVo {

    /* input */
    private int rankType;    // 일간/주간/월간
    private String selectGubun;        // 검색구분(userID, user닉네임, 연락처, 이름)
    private String txt_search;
    private String sDate;
    private String eDate;
    private String onedayDate;
    private int liveCnt;
    private String liveDate;

    /* output */
    private int djRank;
    private String memNo;
    private String upDown;
    private String image_profile;
    private String mem_id;
    private int level;
    private String grade;
    private String mem_nick;
    private String mem_sex;
    private int money;
    private int byeol;
    private String gifted_mem_no;
    private int airCount;
    private String start_date;
    private int airTime;
    private int inner;

    private String reward_rank;              // 랭킹
    private String rewardStartDate;          // 배찌 유지기간 start
    private String rewardEndDate;            // 배찌 유지기간 end
    private String reward_date;              // 랭킹 선정일
    private String reward_dal;               // 랭킹 보상 달
    private String reward_byeol;             // 랭킹 보상 별
    private String reward_exp;               // 랭킹 보상 경험치
    private String reward_yn;                // 보상여부
    private String ranking_type;             // 랭킹 타입(1: 일간 , 2: 주간)
    private String rewardLastUpdDate;        // 랭킹보상 지급일
    private String badgeImage;               // 배찌 이미지

    private String boostCnt;
    private String boostByeol;

    private String mem_birth_year;
    private String mem_birth_month;
    private String mem_birth_day;

    private int broadCnt;
    private int listenCnt;
    private int goodCnt;
    private int rankPoint;
    private int itemCnt;
    private int awards;
}