package com.dalbit.status.vo.procedure;

import com.dalbit.common.vo.BaseVo;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class P_BroadcastGiftOutputVo extends BaseVo {

    private String date;
    private int hour;
    private String daily;
    private int monthly;
    private int totalGiftCnt;
    private int totalGiftCmt;
    private int totalGiftAmount;
    private int djGiftCnt;
    private int djGiftCmt;
    private int djGiftAmount;
    private int guestGiftCnt;
    private int guestGiftCmt;
    private int guestGiftAmount;
    private int audioGiftCnt;
    private int audioGiftCmt;
    private int audioGiftAmount;
    private int vedioGiftCnt;
    private int vedioGiftCmt;
    private int vedioGiftAmount;
    private int secretGiftCnt;
    private int secretGiftCmt;
    private int secretGiftAmount;
}
