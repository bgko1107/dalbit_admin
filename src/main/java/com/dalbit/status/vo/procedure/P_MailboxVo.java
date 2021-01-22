package com.dalbit.status.vo.procedure;

import com.dalbit.common.vo.SearchVo;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class P_MailboxVo extends SearchVo {

    // input
    private int pageNo;
    private String startDate;

    // output
    private String item_code;
    private String webp_image;
    private String item_thumbnail;
    private String item_name;
    private String sale_price;
    private int itemCnt;
    private int itemAmt;
    private int totalItemCnt;
    private int totalItemAmt;

    // summary
    private int sum_itemCnt;
    private int sum_itemAmt;
    private int sum_totalItemCnt;
    private int sum_totalItemAmt;

    // ----------------------------- stat ------------------------------
    // list
    private String the_date;
    private int the_day;
    private int the_hr;
    private int Cnt00;
    private int Cnt10;
    private int Cnt20;
    private int Cnt30;
    private int Cnt40;
    private int Cnt50;
    private int Cnt60;
    private int male_uniqueCnt;
    private int female_uniqueCnt;
    private int none_uniqueCnt;
    private int total_uniqueCnt;
    private int total_createCnt;
    private int msgCnt;
    private int imgCnt;
    private int giftCnt;
    private int giftDal;

    //summary
    private int sum_00Cnt;
    private int sum_10Cnt;
    private int sum_20Cnt;
    private int sum_30Cnt;
    private int sum_40Cnt;
    private int sum_50Cnt;
    private int sum_60Cnt;
    private int sum_male_uniqueCnt;
    private int sum_female_uniqueCnt;
    private int sum_none_uniqueCnt;
    private int sum_total_uniqueCnt;
    private int sum_total_createCnt;
    private int sum_msgCnt;
    private int sum_imgCnt;
    private int sum_giftCnt;
    private int sum_giftDal;
}



