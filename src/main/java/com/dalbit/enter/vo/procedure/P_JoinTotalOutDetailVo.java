package com.dalbit.enter.vo.procedure;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class P_JoinTotalOutDetailVo {
    private String date;
    private String daily;
    private String monthly;
    private int hour;
    private int totalCnt;
    private int maleCnt;
    private int femaleCnt;
    private int noneCnt;
    private int age10Cnt;
    private int age20Cnt;
    private int age30Cnt;
    private int age40Cnt;
    private int age50Cnt;
    private int age60Cnt;
}