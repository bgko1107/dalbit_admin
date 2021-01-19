package com.dalbit.broadcast.vo.procedure;

import com.dalbit.common.vo.PagingVo;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class P_GuestListOutputVo extends PagingVo {

    /* return result */
    private int auth;
    private String room_no;
    private int state;
    private int proState;
    private int guestState;
    private String mem_no;
    private String mem_nick;
    private String mem_sex;
    private String mem_birth_year;
    private String level;
    private String grade;
    private int giftCnt;
    private int giftGold;
    private String proDate;
    private String start_date;
    private String end_date;
    private int air_time;

    private int guestCnt;
    private int proCnt;
    private int proCancelCnt;
    private int inviteCnt;
    private int inviteCancelCnt;
    private int inviteOkCnt;
    private int inviteNoCnt;


    /* summary */
    private String totalAirTime;
    private int totalGiftCnt;
    private int totalGiftGold;
    private int totalSexM;
    private int totalSexF;
    private int totalSexN;

}


