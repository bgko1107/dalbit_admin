package com.dalbit.money.vo.procedure;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class P_BuyDalListOutVo {

    private int rowNum;
    private String mem_no;
    private String memNick;
    private String memSex;
    private String memAge;
    private String memSlct;
    private String osType;
    private int dalCnt;
    private int payAmt;
    private String payDate;
    private int total_payCnt;
    private int total_payAmt;
    private String prev_payDate;
    private String re_payDate;
    private int inner;
    private String mem_id;
    private String mem_phone;

    private int totalCnt;

}
