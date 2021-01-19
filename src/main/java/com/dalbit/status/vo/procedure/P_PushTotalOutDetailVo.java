package com.dalbit.status.vo.procedure;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class P_PushTotalOutDetailVo{

    private String date;
    private String hour;
    private String daily;
    private String monthly;
    private String month;
    private String day;
    private String year;
    private int male_send_cnt;
    private int male_succ_cnt;
    private int male_fail_cnt;
    private int male_succ_rate;
    private int female_send_cnt;
    private int female_succ_cnt;
    private int female_succ_rate;
    private int none_send_cnt;
    private int none_succ_cnt;
    private int none_fail_cnt;
    private int none_succ_rate;
    private int total_send_cnt;
    private int total_succ_cnt;
    private int accum_total_succ_cnt;
    private int total_fail_cnt;
    private int total_succ_rate;
}



