package com.dalbit.event.vo;

import com.dalbit.common.vo.SearchVo;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class QuestVo extends SearchVo {

    private String questDate;
    private int questNo;
    private int orderNo;
    private int questType;
    private String questDesc;
    private int goalCnt;
    private int dayCnt;
    private int rewardDal;
    private int rewardByeol;
    private int rewardExp;
    private int rewardBooster;
    private int rewardCoupon;
    private int rewardCnt;
    private int viewYn;
    private String imageReward;
    private String regDate;
    private String lastUpdDate;
    private int rewardType;
    private int rewardTypeCnt;
    private String rewardTypeList;

    private String questNameList;
    private String questNoList;
    private String questOrderList;
    private String questDescList;
    private String dayCntList;
    private String goalCntList;
    private String rewardTypeCntList;
    private String imageRewardList;
    private String viewYnList;
    private String quest_type;

    private String rewardDalList;
    private String rewardByeolList;
    private String rewardExpList;
    private String rewardBoosterList;
    private String rewardCouponList;


}
