package com.dalbit.content.vo;

import com.dalbit.common.vo.PagingVo;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class MiniGameListVo extends PagingVo {
    /* input */
    private String startDate;
    private String endDate;
    private int sortState;
    private int pageNo;
    private int slctType;
    private String searchText;
    private int newSearchType;

    /* Output */
    private int game_no;
    private String game_name;
    private String image_url;
    private String game_desc;
    private int view_yn;
    private String op_name;
    private String reg_date;
    private String last_upd_date;

    private String os_type;
    private String mem_no;
    private String mem_nick;
    private String mem_sex;
    private String mem_birth_year;
    private String room_no;
    private String title;
    private String state;
    private String start_date;
    private String end_date;
    private String pay_yn;
    private int go_cnt;
    private int memCnt;
    private int memberCnt;
    private int rubyCnt;
    private int pay_amt;
    private String opt;

    private int totalPayAmt;
    private int totalGoCnt;
    private String subjectType;

    private String idx;
    private String edit_contents;
    private String edit_date;

}
