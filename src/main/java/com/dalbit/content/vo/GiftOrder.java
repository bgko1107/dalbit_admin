package com.dalbit.content.vo;

import com.dalbit.common.vo.SearchVo;
import lombok.Getter;
import lombok.Setter;

import java.util.HashMap;
import java.util.List;

@Getter
@Setter
public class GiftOrder extends SearchVo {

    /* input */
    private String itemType;
    private String itemOrder;
    private String itemCode;
    private List<HashMap<String,String>> editData;

    /* output */
    private String item_code;
    private String item_name;
    private String item_image;
    private String item_thumbnail;
    private String item_price;
    private String byeol;
    private String item_type;
    private String sale_price;
    private String item_slct;
    private String use_area;
    private String webp_image;
    private int order;
    private String isNew;

}
