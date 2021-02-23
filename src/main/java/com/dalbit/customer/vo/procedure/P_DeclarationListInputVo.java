package com.dalbit.customer.vo.procedure;

import com.dalbit.common.vo.SearchVo;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class P_DeclarationListInputVo extends SearchVo {
    private int pageNo;
    private String strPlatform;
    private int slctDateType;
    private String startDate;
    private String endDate;
}
