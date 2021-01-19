package com.dalbit.menu.vo;

import com.dalbit.common.vo.PagingVo;
import lombok.Getter;
import lombok.Setter;

import java.util.List;

@Getter
@Setter
public class SpecialDjManageVo extends PagingVo {

    private String idx;
    private String title;
    private String select_year;
    private String select_month;
    private String req_start_date;
    private String req_end_date;
    private String condition_start_date;
    private String condition_end_date;
    private String condition_code1;
    private String condition_codeName1;
    private int condition_data1;
    private String condition_code2;
    private String condition_codeName2;
    private int condition_data2;
    private String condition_code3;
    private String condition_codeName3;
    private int condition_data3;
    private int is_view;
    private int platform;
    private String pc_image_url;
    private String mobile_image_url;
    private String reg_date;
    private String op_name;
    private String last_upd_date;
    private String last_op_name;
    private int round_no;

    private List<SpecialDjContentVo> contentList;
}
