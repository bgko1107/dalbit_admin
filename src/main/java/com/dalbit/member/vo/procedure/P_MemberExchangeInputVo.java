package com.dalbit.member.vo.procedure;

import com.dalbit.common.vo.SearchVo;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class P_MemberExchangeInputVo extends SearchVo {
    private int pageNo;
    private String mem_no;
    private int slctDate;
    private int idx;
    private int djType;
    private String startDate;
    private String endDate;

}
