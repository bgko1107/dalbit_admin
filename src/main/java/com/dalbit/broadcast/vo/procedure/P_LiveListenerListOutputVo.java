package com.dalbit.broadcast.vo.procedure;

import com.dalbit.common.vo.PagingVo;
import lombok.Getter;
import lombok.Setter;

import java.util.List;

@Getter
@Setter
public class P_LiveListenerListOutputVo extends PagingVo {

    /* return result */
    private String roomNo;
    private String title;
    private String djMemNo;
    private String djNickNm;
    private int auth;
    private int os_type;
    private String gender;
    private String profImg;
    private String memNo;
    private String nickNm;
    private int age;
    private String joinDt;
    private String listenTime;
    private int listenCnt;
    private int goodCnt;
    private int giftCnt;
    private int boosterCnt;
    private int inner;

    private int day_badge;
    private int week_badge;
    private int month_badge;
    private int recomm_badge;
    private int newdj_badge;
    private int new_badge;
    private int specialdj_badge;
    private int admin_badge;
    List fanBadgeList;
    List liveBadgeList;

    /* summary */
    private int aosCnt;
    private int iosCnt;
    private int pcCnt;
    private int maleCnt;
    private int femaleCnt;
    private int noneCnt;
    private int noneMemberCnt;
    private int newCnt;
}


