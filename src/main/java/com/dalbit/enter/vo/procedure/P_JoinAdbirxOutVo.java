package com.dalbit.enter.vo.procedure;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class P_JoinAdbirxOutVo {

    private String the_date;
    private int total_joinCnt;
    private int natural_joinCnt;
    private int uac;
    private int ios;
    private int aos;
    private int ios_aos;

    private String idx;
    private String memo;
    private String op_name;
    private String last_upd_date;
    private int memoYn;

}