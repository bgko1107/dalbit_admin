package com.dalbit.member.vo.procedure;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class P_MemberReportVo {

    private int idx;
    private int deleteYn;
    private int reportIdx;
    private String opName;
    private String mem_no;
    private String cast_no;
    private String mem_userid;
    private String mem_nick;
    private String mem_sex;
    private String ip;
    private String browser;
    private String flatform;
    private String reported_mem_no;
    private String reported_userid;
    private String reported_nick;
    private String reported_phone;
    private int reported_level;
    private String reported_grade;
    private int slctReason;
    private int slctType;
    private String notiContents;
    private String memo;
    private String notimemo;
    private int blockDay;

    private String blockScope;
    private String blockScopeText;

    private String slctOs; // OS Type 구분.. (a: AOS, b: IOS)

    // 알림..
    private String targetRoomNo;
    private String targetBoardIdx;
    private String targetMemNo;
    private String targetRedirectUrl;
    private String push_slct;
    private int type_noti;
}

