package com.dalbit.common.vo;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

import java.sql.Date;
import java.util.List;

@Getter
@Setter
@ToString
public class MenuVo {

    public List<MenuVo> twoDepth;

    public MenuVo(){}

    public MenuVo(int depth){
        this.depth = depth;
    }

    private int idx;
    private String menu_name;
    private String menu_url;
    private int depth;
    private int order_no;
    private int parent_idx;
    private String icon;
    private int is_pop;
    private int is_comming_soon;
    private int is_use;
    private String mobile_yn;
    private Date reg_date;
    private Date last_upd_date;
    private String emp_no;

    private int is_read;
    private int is_insert;
    private int is_delete;

    private String id;
    private String parent;
    private String text;

}
