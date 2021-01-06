package com.dalbit.menu.vo;

import com.dalbit.common.vo.PagingVo;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class GoodRankVo extends PagingVo {

    /* input */
    private int slctType;        // 검색구분(userID, user닉네임, 연락처, 이름)
    private String searchText;
    private String rankingDate;
    private int searchType;
    private int pageNo;

    /* output */
    private int rank;
    private String profileImage;
    private String mem_no;
    private String nickName;
    private String memId;
    private String memSex;
    private String rewardBadge;
    private String startBadge;
    private String endBadge;
    private int totalPoint;
    private int goodPoint;
    private int boosterPoint;
    private int boosterCnt;
    private int giftPoint;
    private int rewardDal;
    private String mem_birth_year;


}