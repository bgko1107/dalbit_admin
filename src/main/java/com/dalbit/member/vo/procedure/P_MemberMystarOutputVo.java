package com.dalbit.member.vo.procedure;

import com.dalbit.common.vo.SearchVo;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class P_MemberMystarOutputVo extends SearchVo {

    //output
    private String mem_no_star;
    private String mem_no_start_id;
    private String mem_no_start_nick;
    private String mem_no_fan;
    private String mem_no_fan_id;
    private String mem_no_fan_nick;
    private String star_sex;
    private String fan_sex;
    private int accumCnt;
    private int totalItemCnt;
    private String mem_birth_year;
    private String mem_birth_month;
    private String mem_birth_day;
    private int inner;

    private int state;
    private String delMemNo;
    private String delMemNick;
    private String regDateFormat;
    private String delDateFormat;
    private String last_upd_date;

}
