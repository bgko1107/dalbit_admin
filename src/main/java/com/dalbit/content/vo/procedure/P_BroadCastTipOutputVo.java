package com.dalbit.content.vo.procedure;

import com.dalbit.common.vo.BaseVo;
import lombok.Getter;
import lombok.Setter;

import java.util.Date;

@Getter
@Setter
public class P_BroadCastTipOutputVo extends BaseVo {
    private int idx;
    private String viewTarget;
    private String tipDesc;
    private int viewOn;
    private Date updateDate;
}
