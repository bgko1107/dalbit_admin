package com.dalbit.content.vo.procedure;

import com.dalbit.common.vo.SearchVo;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class P_NewviLevelInputVo extends SearchVo {

    private int pageNo;
    private String startDate;
    private String endDate;

}
