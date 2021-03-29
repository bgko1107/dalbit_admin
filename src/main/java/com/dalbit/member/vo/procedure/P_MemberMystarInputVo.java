package com.dalbit.member.vo.procedure;

import com.dalbit.common.vo.SearchVo;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class P_MemberMystarInputVo extends SearchVo {
    private int pageNo;
    private String mem_no;
    private int state;
    private String startDate;
    private String endDate;
    private int fanStarDateSlct;
}
