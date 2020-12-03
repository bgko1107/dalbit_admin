package com.dalbit.content.vo.procedure;

import com.dalbit.common.vo.BaseVo;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class P_FullmoonConditionOutputVo extends BaseVo {

    private int slctType;
    private String editDate;

    /* dj */
    private int targetValue;

    /* 혜택 */
    private int itemType;
    private int itemCnt;
    
    /* 청취자 */
    private int minValue;

}
