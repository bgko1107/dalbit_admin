package com.dalbit.broadcast.vo.procedure;

import com.dalbit.common.vo.PagingVo;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class P_LiveGuestListOutputVo extends PagingVo {

    /* return result */
    private String now_state;
    private String room_no;
    private String room_title;
    private String image_profile;
    private String mem_no;
    private String now_joinstate;
    private String inner;
    private String mem_nick;
    private String mem_sex;
    private String mem_age;
    private String mem_userid;
    private String start_date;
    private String end_date;
    private String connect_time;
    private String join_form;
    private String gift_cnt;
    private String byeol_cnt;
    private String duplicate_cnt;
    private String total_cnt;
    private String device_uuid;
    private String ip;

    /* summary */
    private int guestMcnt;
    private int guestFcnt;
    private int guestNcnt;
    private int uniqueMcnt;
    private int uniqueFcnt;
    private int uniqueNcnt;
    private int normalCnt;
    private int secretCnt;
    private int secretByeol;
    private int normalByeol;
    private int totalConnect;

}


