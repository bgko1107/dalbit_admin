package com.dalbit.menu.vo;

import com.dalbit.common.vo.PagingVo;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class SpecialDjBestVo extends PagingVo {
    private String select_year;
    private String select_month;

    private int specialdj_badge;
    private int specialdj_cnt;
    private int bestdj_cnt;
    private String mem_no;
    private String mem_nick;
    private String mem_sex;
    private String mem_birth_year;
    private String is_req;
    private int fan_air_time;
    private int air_time;
    private int broad_cnt;
    private int new_fan_cnt;

    private int best_code1;
    private int best_data1;
    private boolean best_condition1;

    private int best_code2;
    private int best_data2;
    private int best_condition2;

    private int best_code3;
    private int best_data3;
    private int best_condition3;
}