package com.dalbit.content.vo.procedure;

import com.dalbit.common.vo.SearchVo;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class P_MarketingVo extends SearchVo {
    private String idx;
    private String idxs;
    private String title;
    private String contents;
    private int round;
    private int viewCnt;
    private String notice_idx;
    private String mem_no1;
    private String mem_nick1;
    private String mem_no2;
    private String mem_nick2;
    private String writeDate;
    private String updateDate;
    private String lastOpName;
}
