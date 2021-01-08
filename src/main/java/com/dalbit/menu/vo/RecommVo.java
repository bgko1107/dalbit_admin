package com.dalbit.menu.vo;

import com.dalbit.common.vo.PagingVo;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class RecommVo extends PagingVo {

    /* input */
    private int slctType;
    private String title;
    private String memNoList;

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
}
