package com.dalbit.content.vo.procedure;

import com.dalbit.common.vo.BaseVo;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class P_BroadCastTipDetailOutputVo extends BaseVo {
    private String idx;
    private String viewTarget;
    private String tipDesc;
    private String viewOn;
    private String updateDate;
}
