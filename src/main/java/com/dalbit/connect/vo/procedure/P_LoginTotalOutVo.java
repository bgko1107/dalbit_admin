package com.dalbit.connect.vo.procedure;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class P_LoginTotalOutVo {
    private int sum_totalCnt;
    private int sum_maleCnt;
    private int sum_femaleCnt;
    private int sum_noneCnt;
}
