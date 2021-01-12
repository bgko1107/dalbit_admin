package com.dalbit.member.vo.procedure;

import com.dalbit.common.vo.SearchVo;
import com.dalbit.util.DalbitUtil;
import lombok.Getter;
import lombok.Setter;

import java.sql.Date;

@Getter
@Setter
public class P_MemberAccumOutputVo{

    private int payCnt;
    private int payAmt;
    private int payCanCnt;
    private int payCanAmt;
    private int brodCnt;
    private int broadTime;
    private int byeolCnt;
    private int listenerCnt;
    private int goodCnt;
    private int boostCnt;
    private int listenCnt;
    private int listenTime;
    private int dalCnt;
    private int sendDal;
    private int giftedDal;
    private int exchangeCnt;
    private int exchangeAmt;
    private int exchangeCancelCnt;
    private int exchangeCancelAmt;
    private int changeCnt;
    private int changeByeol;
    private int clipCnt;
    private int clipByeol;
    private int clipPlay;
    private int clipGood;

}
