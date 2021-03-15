package com.dalbit.broadcast.vo.procedure;

import com.dalbit.common.vo.BaseVo;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class P_BehaviorListOutputVo extends BaseVo {

    private int idx;
    private int target;
    private int slctType;
    private String platform;
    private String desc1;
    private String desc2;
    private String desc3;
    private int desc_cnt;
    private String title;
    private int type;
    private int conTime;
    private int runTime;
    private int viewYn;
    private String itemCode;
    private String last_upd_date;

}
