package com.dalbit.content.vo.procedure;

import com.dalbit.common.vo.BaseVo;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class P_FullmoonConditionVo extends BaseVo {

    private int slctType;
    private String editDate;

    /* dj */
    private int targetValue;

    /* 혜택 */
    private int itemType;
    private int itemCnt;

    /* 청취자 */
    private int minValue;

    //수정
    private String broadTime;
    private String listenerCnt;
    private String byeolCnt;
    private String goodPoint;

    private String listenYn;
    private String minGoodPoint;
    private String minGiftDal;

    private String djItemCnt;
    private String djItemType;
    private String listenerItemCnt;
    private String listenerItemType;

    private String fullmoonYn;

}
