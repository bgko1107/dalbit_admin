package com.dalbit.status.vo.procedure;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class P_ItemTotalOutVo {
    private int sum_changeCnt;
    private int sum_changeAmt;
    private int sum_dalgiftCnt;
    private int sum_dalgiftAmt;
    private int sum_subsCnt;
    private int sum_subsAmt;
    private int sum_broadgiftCnt;
    private int sum_broadgiftAmt;
    private int sum_castgiftCnt;
    private int sum_castgiftAmt;
    private int sum_mailboxCnt;
    private int sum_mailboxAmt;
}