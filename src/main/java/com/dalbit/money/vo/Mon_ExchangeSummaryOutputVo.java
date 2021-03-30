package com.dalbit.money.vo;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class Mon_ExchangeSummaryOutputVo {

    private int cnt;
    private int sumCashReal;
    private int sumByeol;

    private long ready_cnt;
    private long ready_byeol;
    private long ready_amt;
    private long confirm_cnt;
    private long confirm_byeol;
    private long confirm_amt;
    private long cancel_cnt;
    private long cancel_byeol;
    private long cancel_amt;
    private long now_byeol;
    private long now_amt;
    private long byeol;
    private long silver;

}
