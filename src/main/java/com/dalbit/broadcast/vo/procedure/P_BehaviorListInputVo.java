package com.dalbit.broadcast.vo.procedure;

import com.dalbit.common.vo.PagingVo;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class P_BehaviorListInputVo extends PagingVo{

    private int target;
    private int viewYn;
    private int slctType;
    private String searchText;
    private int pageNo;
    private String searchPlatform;

}
