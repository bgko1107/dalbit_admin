package com.dalbit.content.vo;

import com.dalbit.common.vo.PagingVo;
import lombok.Getter;
import lombok.Setter;

import java.util.Date;

@Getter
@Setter
public class PhotoShotVo extends PagingVo {

    /* input */
    private String txt_search;
    private String searchType;
    private String slct_type;
    private int slct_order;
    private int only_check;
    private int event_idx;
    private String[] idxArr;
    private String idxs;
    private int del_yn;

    /* output */
    private int idx;
    private String mem_no;
    private String mem_name;
    private String mem_phone;
    private String mem_nick;
    private String image_url;
    private String image_url2;
    private String image_url3;
    private String title;
    private String contents;
    private int slct_device;
    private String device1;
    private String device2;
    private String reg_date;
    private int view_cnt;
    private int good_cnt;
    private int is_check;
    private String mem_sex;
    private String mem_userid;
    private String mem_birth_year;

}
