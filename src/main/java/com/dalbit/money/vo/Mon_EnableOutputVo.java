package com.dalbit.money.vo;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class Mon_EnableOutputVo {

    private int rowNum;
    private String mem_no;
    private String mem_userid;
    private String mem_nick;
    private String image_profile;
    private String mem_birth_year;
    private String mem_birth_month;
    private String mem_birth_day;
    private int inner;
    private int mem_state;
    private String mem_sex;
    private int gold;
    private int exchangeCnt;
    private int specialCnt;
    private int type;
    private String memtype;

    private int byeol;
    private int cash_real;
    private String last_upd_date;
    private String op_date;
    private String opName;


    private int enableCnt;
    private long totalGold;
    private int totalSpecialCnt;
    private long totalExchangeAmt;

}
