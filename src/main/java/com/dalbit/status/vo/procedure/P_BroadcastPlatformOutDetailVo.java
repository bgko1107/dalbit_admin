package com.dalbit.status.vo.procedure;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class P_BroadcastPlatformOutDetailVo {
    private String date;
    private String daily;
    private String monthly;
    private int hour;
    private int pcCnt;
    private int pcTime;
    private int androidCnt;
    private int androidTime;
    private int iosCnt;
    private int iosTime;
    private int v_pcCnt;
    private int v_pcTime;
    private int v_androidCnt;
    private int v_androidTime;
    private int v_iosCnt;
    private int v_iosTime;
    private int totalCreateCnt;
    private int totalBroadcastingTime;
    private int v_totalCreateCnt;
    private int v_totalBroadcastingTime;

}