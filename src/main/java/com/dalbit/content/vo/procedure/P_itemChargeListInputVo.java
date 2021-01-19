package com.dalbit.content.vo.procedure;

import com.dalbit.common.vo.SearchVo;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class P_itemChargeListInputVo extends SearchVo {
    private int pageNo;
    private int viewYn = -1;
}
