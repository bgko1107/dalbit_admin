package com.dalbit.status.vo.procedure;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class P_StatVo {
    private int slctType;
    private int orderType;
    private String startDate;
    private String endDate;
    private int pageNo;
    private int pageCnt;
    private int recvType;

    private String beforStartDate;
    private String beforEndDate;

    private String dateList;
    private int timeType;

}
