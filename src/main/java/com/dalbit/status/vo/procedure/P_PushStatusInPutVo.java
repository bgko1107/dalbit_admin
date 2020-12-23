package com.dalbit.status.vo.procedure;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class P_PushStatusInPutVo {

    private String dateList;

    private int slctType;
    private int viewType;
    private String startDate;
    private String endDate;

    private String beforStartDate;
    private String beforEndDate;

    private String type;

}
