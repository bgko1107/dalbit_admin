package com.dalbit.common.vo;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class MenuAuthVo {

    MenuAuthVo(){}

    private String emp_no;
    private int menu_idx;
    private int is_read;
    private int is_insert;
    private int is_delete;
}
