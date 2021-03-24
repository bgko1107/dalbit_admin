package com.dalbit.member.vo.procedure;

import com.dalbit.common.vo.SearchVo;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class P_MemberGGamGGamEVo extends SearchVo {

    private int idx;
    private String mem_no;
    private String startDate;
    private int pageNo;

    private String room_no;
    private String title;
    private String mem_nick;
    private String mem_sex;
    private int event_no;
    private String achieve_type;
    private int achieve_cnt;
    private String reward_type;
    private String reward_cnt;
    private String start_date;

    /* top */
    private int topGoodCnt;
    private int topListenerCnt;
    private int topByeolCnt;


}

