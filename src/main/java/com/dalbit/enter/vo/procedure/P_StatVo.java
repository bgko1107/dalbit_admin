package com.dalbit.enter.vo.procedure;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

@Getter
@Setter
@ToString
public class P_StatVo {
    private int slctType;
    private String startDate;
    private String endDate;
    private String dateList;
    private int slctTab;
    private int memoIdx;
    private String gubun;
    private String memo;
    private String op_name;


    private String beforeStartDate;
    private String beforeEndDate;


    private String twoAgoStartDate;
    private String twoAgoEndDate;

    private String adbrixExcelList;


    private ArrayList<HashMap> delList;
}
