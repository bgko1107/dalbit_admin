package com.dalbit.menu.vo;

import com.dalbit.common.vo.PagingVo;
import com.dalbit.common.vo.SearchVo;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class RecommVo extends SearchVo {

    /* input */
    private String title;
    private String memNoList;
    private int pageNo;
    private String startDate;
    private String endDate;

    /* ourput */
    /* list */
    private String mem_no;
    private String profileImage;
    private String memNick;
    private String memSex;
    private String ageDesc;
    private String specialdjYn;
    private String shiningdjYn;
    private String viewYn;
    private String recommendFanCnt;
    private String last_broadcast;
    private String broadcastTime;
    private String reg_date;
    private String upd_date;
    private String reg_op_name;
    private String upd_op_name;
    private String mem_no_fan;
    private String mem_birth_year;

    /* detail */
    private String idx;
    private String ageType;
    private String regDate;
    private String updDate;
    private String reg_opName;
    private String upd_opName;
    private String fanCnt;
    private String broadcastCnt;
    private String broadcastTitle;
    private String desc;
    private String imageUrl;


    // 리뉴얼 추천DJ -----------
    private String imageProfile;
    private String memNo;
    private String broadcastType;
    private String mainRecomm;
    private String recommendStart;
    private String recommendEnd;
    private String lastBroadcast;
    private String regOpName;
    private String updOpName;
    private String mainStart;
    private String mainEnd;
    private String mainRecommendCnt;
    private String mainRecommendTime;

    //summary
    private int maleCnt;
    private int femaleCnt;
    private int audioCnt;
    private int videoCnt;
    private int fanMaleCnt;
    private int fanFemaleCnt;
    private int fanAudioCnt;
    private int fanVideoCnt;


}
