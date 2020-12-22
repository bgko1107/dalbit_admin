package com.dalbit.member.vo.procedure;

import com.dalbit.common.vo.PagingVo;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class P_DormancyOutputVo extends PagingVo {

    private String mem_no;
    private String memJoinDate;
    private String lastLoginDate;
    private String notLoginDate;
    private String sleepStartDate;
    private String osType;
    private String lastOsType;
    private String memNick;
    private String memSex;
    private String memBirthYear;
    private String memAge;
    private String ip;
    private String endDate;

    private int sum_sleep_mcnt;
    private int sum_sleep_fcnt;
    private int sum_sleep_ncnt;
    private int sum_aos_total_sleep_cnt;
    private int sum_ios_total_sleep_cnt;
    private int sum_pc_total_sleep_cnt;
    private int sum_total_join_cnt;
    private int sum_total_out_cnt;
    private int sum_auto_out_cnt;
    private int sum_sleep_cnt;
    private int sum_return_cnt;

}
