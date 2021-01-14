package com.dalbit.member.vo.procedure;

import com.dalbit.common.vo.SearchVo;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class P_MailboxMsgVo extends SearchVo {

    // input
    private int pageNo;
    private String chat_no;
    private String startDate;
    private String endDate;
    private int inner;
    private int msgType;

    // output
    private String idx;
    private String msg_idx;
    private String mem_no;
    private String mem_nick;
    private String mem_id;
    private String mem_sex;
    private String mem_birth_year;
    private String type;
    private String msg;
    private String read_yn;
    private String delete_yn;
    private String os;
    private String last_upd_date;
    private String itemThumbnail;
    private String webpImage;
    private String time;
    private String data1;
    private String data2;
    private String data3;
    private String data4;
    private String data5;
    private String data6;

    // mailboxMember
    private String readCnt;

    // summary

}
