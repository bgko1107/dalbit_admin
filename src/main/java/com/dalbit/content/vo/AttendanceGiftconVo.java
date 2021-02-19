package com.dalbit.content.vo;

import com.dalbit.common.vo.PagingVo;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class AttendanceGiftconVo extends PagingVo {

    /* input */
    private String searchType;
    private String txt_search;
    private String search_startDate;
    private String search_endDate;
    private String gifticon_type;
    private int newSearchType;

    /* output */
    private String the_date;
    private String mem_no;
    private String phone;
    private String win_date;
    private String phone_date;
    private String image_profile;
    private String mem_sex;
    private String mem_userid;
    private String mem_nick;
    private int mem_state;
    private int idx;
}
