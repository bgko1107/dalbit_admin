package com.dalbit.status.vo.procedure;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class P_ItemTotalOutDetailVo {

    private String monthly;
    private String daily;
    private String date;
    private String hour;
    private int the_hr;
    private String the_date;
    private int the_day;
    private int changeCnt;
    private int changeAmt;
    private int dalgiftCnt;
    private int dalgiftAmt;
    private int subsCnt;
    private int subsAmt;
    private int broadgiftCnt;
    private int broadgiftAmt;
    private int castgiftCnt;
    private int castgiftAmt;

    private int mailboxCnt;
    private int mailboxAmt;
    private int totalCnt;
    private int totalCntAccum;
    private int totalAmt;
    private int totalAmtAccum;

}



