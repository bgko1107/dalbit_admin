package com.dalbit.content.vo;

import com.dalbit.common.vo.SearchVo;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class ClipReplyListVo extends SearchVo {

    //multi delete
    private String castReplyIdxs;
    private String cast_nos;

    //input
    private String sDate;
    private String eDate;
    private String cast_no;
    private int idx;

    //output
    private String title;
    private String cast_mem_no;
    private String cast_mem_nick;
    private String cast_mem_sex;
    private String cast_birth_year;
    private String writer_mem_no;
    private String writer_mem_nick;
    private String writer_mem_sex;
    private String writer_birth_year;
    private String contents;
    private String write_date;
    private String last_upd_date;
    private String status;
    private int castReplyIdx;
    private int writer_inner;

    //summary
    private int maleCnt;
    private int femaleCnt;
    private int noneCnt;

}
