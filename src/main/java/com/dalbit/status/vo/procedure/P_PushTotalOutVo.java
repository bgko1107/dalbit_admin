package com.dalbit.status.vo.procedure;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class P_PushTotalOutVo{

    private String sum_male_send_cnt;
    private String sum_male_succ_cnt;
    private String sum_male_fail_cnt;
    private String sum_male_succ_rate;
    private String sum_female_send_cnt;
    private String sum_female_succ_cnt;
    private String sum_female_fail_cnt;
    private String sum_female_succ_rate;
    private String sum_none_send_cnt;
    private String sum_none_succ_cnt;
    private String sum_none_fail_cnt;
    private String sum_none_succ_rate;
    private String sum_total_send_cnt;
    private String sum_total_succ_cnt;
    private String sum_total_fail_cnt;
    private String sum_total_succ_rate;

}