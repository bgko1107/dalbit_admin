package com.dalbit.clip.vo;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class ClipMemberSummaryVo{

    /* input */
    private String memNo;
    private String subjectType;

    /* output */
    private int listenerCnt;
    private int countPlay;
    private int countGood;
    private int countGift;
    private int countByeol;
    private int countDal;

}
