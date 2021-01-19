package com.dalbit.status.vo.procedure;

import com.dalbit.common.vo.BaseVo;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class P_BroadcastGiftHistoryOutputVo extends BaseVo {

    private int totalCnt;
    private int sumItemCnt;
    private int sumItemAmt;
    private int sumTotalItemCnt;
    private int sumTotalItemAmt;
}
