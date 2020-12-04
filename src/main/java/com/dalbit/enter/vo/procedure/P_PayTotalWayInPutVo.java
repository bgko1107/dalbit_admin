package com.dalbit.enter.vo.procedure;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class P_PayTotalWayInPutVo {

    private String dateList;

    private int slctType;
    private String paywayType;
    private String startDate;
    private String endDate;

}
