package com.dalbit.administrate.vo;

import com.dalbit.common.vo.PagingVo;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class TestIdVo extends PagingVo {
    private String mem_no;
    private String emp_no;
    private String emp_name;
    private int relation;
    private int inner;

    private int userInfo;
    private String userInfoValue;

    private int cnt;

    private String sDate;
    private String eDate;
    private int listSort;

}
