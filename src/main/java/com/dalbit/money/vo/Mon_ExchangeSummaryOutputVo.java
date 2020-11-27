package com.dalbit.money.vo;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class Mon_ExchangeSummaryOutputVo {

    private int cnt;
    private int sumCashReal;
    private int sumByeol;

    private int ready_cnt;
    private int ready_byeol;
    private int ready_amt;
    private int confirm_cnt;
    private int confirm_byeol;
    private int confirm_amt;
    private int cancel_cnt;
    private int cancel_byeol;
    private int cancel_amt;
    private int now_byeol;
    private int now_amt;
}
