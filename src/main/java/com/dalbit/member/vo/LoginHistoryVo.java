package com.dalbit.member.vo;

import com.dalbit.common.vo.PagingVo;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class LoginHistoryVo extends PagingVo {

    /* in */
    private String txt_startSel;
    private String txt_endSel;
    private String searchType;
    private String searchText;

    /* out */
    private int idx;
    private String mem_no;
    private String mem_nick;
    private String mem_sex;
    private String mem_birth_year;
    private String mem_birth_month;
    private String mem_birth_day;
    private int os_type;
    private String device_uuid;
    private String device_token;
    private String app_version;
    private String browser;
    private String device_manufacturer;
    private String device_model;
    private String sdk_version;
    private String adid;
    private String location;
    private String ip;
    private String last_upd_date;
}
