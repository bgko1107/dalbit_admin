package com.dalbit.member.vo.procedure;

import com.dalbit.common.vo.SearchVo;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class P_DormancyInputVo extends SearchVo {
    private String startDate;
    private String endDate;
    private String mem_no;
}
