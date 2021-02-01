package com.dalbit.status.vo.procedure;

import com.dalbit.common.vo.SearchVo;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class P_ItemBroadInputVo extends SearchVo {

    private int pageNo;
    private String startDate;
    private int itemType;
}
