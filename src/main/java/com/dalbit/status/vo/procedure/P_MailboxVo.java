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
}



