package com.dalbit.content.vo;

import com.dalbit.common.vo.PagingVo;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class AttendanceVo extends PagingVo {

    /* input */
    private String txt_startSel;
    private String txt_endSel;
    private String txt_search;
    private String searchType;
    private int newSearchType;

    /* output */
    private int mem_state;
    private String image_profile;
    private String mem_no;
    private String mem_userid;
    private String mem_nick;
    private String mem_sex;
    private String mem_birth_year;
    private String mem_birth_month;
    private String mem_birth_day;
    private int the_day;
    private String last_upd_date;
    private int reward_exp;
    private int reward_dal;
    private String device_uuid;

}
