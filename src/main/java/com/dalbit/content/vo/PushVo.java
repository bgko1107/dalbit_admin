package com.dalbit.content.vo;

import com.dalbit.common.vo.SearchVo;
import lombok.Getter;
import lombok.Setter;

import java.util.Date;

@Getter
@Setter
public class PushVo extends SearchVo {

//    /* input */
//    private String search;
//    private String searchType;

    /* output */
    private String push_col1;
    private String push_col2;
    private String push_col3;
    private Date push_col4;
    private String push_col5;
    private Date push_col6;
    private String push_col7;

}
