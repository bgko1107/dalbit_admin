package com.dalbit.menu.vo;

import com.dalbit.common.vo.PagingVo;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class SpecialVo extends PagingVo {

    /* input */
    private String txt_search;
    private String searchType;
    private String select_year;
    private String select_month;
    
    /* output */
    private int req_idx;
    private String mem_no;
    private String reg_date;
    private int is_force;
    private int order;
    private String op_name;
    private String mem_phone;
    private String mem_id;
    private String mem_userid;
    private String mem_nick;
    private String mem_sex;
    private String mem_birth_year;
    private String mem_birth_month;
    private String mem_birth_day;
    private int level;
    private String grade;
    private String image_profile;
    private int onAir;
    private String fanCnt;
    private int airTime;
    private int giftedRuby;
    private int likeCnt;
    private int boostCnt;
    private int broadcastCnt;
    private int reportCnt;
    private int inner;

    private String title;
    private String contents;
    private String request_date;
}
