package com.dalbit.money.vo.procedure;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class P_ResourcePopupInputVo{

    private String sDate;
    private String eDate;
    private String type;
    private String gender;
    private String searchText;
    private String slctType;

    private int totalCnt;
    private int pageStart;
    private int pageCnt;

}