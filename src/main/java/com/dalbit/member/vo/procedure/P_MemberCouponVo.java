package com.dalbit.member.vo.procedure;

import com.dalbit.common.vo.SearchVo;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class P_MemberCouponVo extends SearchVo {

    private String mem_no;
    private int pageNo;
    private String couponCnt;
    private String eventCnt;

    private String type;
    private String status;
    private String mem_nick;
    private String title;
    private String dj_mem_no;
    private String issue_date;
}