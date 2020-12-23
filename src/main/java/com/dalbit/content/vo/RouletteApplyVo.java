package com.dalbit.content.vo;

import com.dalbit.common.vo.PagingVo;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class RouletteApplyVo extends PagingVo {

    private int couponType;
    private String mem_no;
    private String apply_date;
    private String item_no;
    private String item_name;
    private String image_url;
    private String win_date;
    private String last_upd_date;
    private String phone;
    private String image_profile;
    private String mem_userid;
    private String mem_nick;
    private String mem_sex;

    private String startDate;
    private String endDate;
    private String txt_search;
    private String searchType;
    private String winType;
}
