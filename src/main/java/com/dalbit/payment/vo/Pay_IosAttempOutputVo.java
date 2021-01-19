package com.dalbit.payment.vo;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class Pay_IosAttempOutputVo {

    private int rowNum;
    private int idx;
    private String mem_no;
    private String product_nm;
    private String product_price;
    private String attempt_date;

    private String mem_nick;
    private String mem_name;
    private String mem_state;
    private String image_profile;
}
