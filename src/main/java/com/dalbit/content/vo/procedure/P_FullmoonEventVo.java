package com.dalbit.content.vo.procedure;

import com.dalbit.common.vo.BaseVo;
import lombok.Getter;
import lombok.Setter;

import java.util.Date;

@Getter
@Setter
public class P_FullmoonEventVo extends BaseVo {

    private int idx;
    private String start_date;
    private int start_date_hour;
    private int start_date_minute;
    private String end_date;
    private int end_date_hour;
    private int end_date_minute;
    private String view_yn;
    private String fullmoon_text;
    private String fullmoon_duration;
    private int banner_idx;
    private int moon_total_cnt;
    private int fullmoon_cnt;
    private int supermoon_cnt;
    private int mem_cnt;
    private String op_name;
    private Date upd_date;
    private String last_op_name;
    private Date last_upd_date;
    private int value_cnt;

    private String platform;
    private String banner_start_date;
    private int banner_start_date_hour;
    private int banner_start_date_minute;
    private String banner_end_date;
    private int banner_end_date_hour;
    private int banner_end_date_minute;
    private int ios_judge_view_on;
    private String pc_link_url;
    private String pc_img_url;
    private String mobile_link_url;
    private String mobile_img_url;
    private String position;
    private int is_view;
}
