package com.dalbit.status.vo.procedure;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class P_BroadcastPlatformOutVo {
    private int sum_pcCnt;
    private int sum_pcTime;
    private int sum_androidCnt;
    private int sum_androidTime;
    private int sum_iosCnt;
    private int sum_iosTime;
    private int sum_v_pcCnt;
    private int sum_v_pcTime;
    private int sum_v_androidCnt;
    private int sum_v_androidTime;
    private int sum_v_iosCnt;
    private int sum_v_iosTime;
    private int sum_totalCreateCnt;
    private int sum_totalBroadcastingTime;
    private int sum_v_totalCreateCnt;
    private int sum_v_totalBroadcastingTime;
}