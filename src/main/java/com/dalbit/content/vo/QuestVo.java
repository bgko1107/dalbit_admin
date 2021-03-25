package com.dalbit.content.vo;

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
    private String imageReward1;        // 보너스 보상 이미지 1
    private String imageReward2;        // 보너스 보상 이미지 2
    private String imagePopup;
    private String regDate;
    private String lastUpdDate;
    private int rewardType;
    private int rewardTypeCnt;
    private String rewardTypeList;

    private String questDateList;
    private String questNameList;
    private String questNoList;
    private String questOrderList;
    private String questDescList;
    private String dayCntList;
    private String goalCntList;
    private String rewardTypeCntList;
    private String imageRewardList;
    private String imagePopupList;
    private String viewYnList;
    private String quest_type;

    private String rewardDalList;
    private String rewardByeolList;
    private String rewardExpList;
    private String rewardBoosterList;
    private String rewardCouponList;


    //memberList output
    private int idx;
    private String memNo;
    private String memNick;
    private String memId;
    private String memUserid;
    private String memPhone;
    private String memSex;
    private String memBirthYear;
    private String questName;
    private String imageProfile;


    // summary
    private int totalDal;
    private int totalExp;
    private int totalByeol;
    private int totalBooster;
    private int totalCoupon;

}
