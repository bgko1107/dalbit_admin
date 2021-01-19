package com.dalbit.content.vo.procedure;

import com.dalbit.common.vo.BaseVo;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class P_RouletteRateVo extends BaseVo {

    private int couponType;
    private int itemNo;
    private int dalCnt;
    private int winRate;
    private int limitCnt;

    private String editList;
}
