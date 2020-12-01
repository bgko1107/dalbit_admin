package com.dalbit.content.vo;

import com.dalbit.common.vo.PagingVo;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class TimeEventVo extends PagingVo {

    private int idx;
    private String start_date;
    private String end_date;
    private int event_time;
    private int rate;
    private int pay_cnt;
    private int pay_cmt;
    private int pay_amt;
    private int pay_dal;
    private int event_dal;
    private int view_yn;
    private String last_upd_date;
    private String reg_date;
    private String op_name;

    private String platform;
    private int ios_judge_view_on;

    //메인탑 배너
    private int main_top_banner_idx;
    private String main_top_pc_image_url;
    private String main_top_mobile_image_url;
    private int main_top_banner_link_yn;
    private String main_top_pc_link_url;
    private String main_top_mobile_link_url;
    private int is_cookie;              //쿠키사용여부(0:안함, 1:사용함)

    //메인센터 배너
    private int main_center_banner_idx;
    private String main_center_pc_image_url;
    private String main_center_mobile_image_url;
    private int main_center_banner_link_yn;
    private String main_center_pc_link_url;
    private String main_center_mobile_link_url;

    //스토어 배너
    private int store_banner_idx;
    private String store_pc_image_url;
    private String store_mobile_image_url;
    private int store_banner_link_yn;
    private String store_pc_link_url;
    private String store_mobile_link_url;

    //링크
    private String pc_link_url;
    private String mobile_link_url;

    private int state;

}
