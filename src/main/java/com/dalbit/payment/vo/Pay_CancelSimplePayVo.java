package com.dalbit.payment.vo;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter @Setter @ToString
public class Pay_CancelSimplePayVo {
    private String tradeid;         // 주문번호
    private String prdtprice;       // 결제금액
    private String mobilid;         // 거래번호 tid
    private String memno;
    private int dalcnt;
    private String okdt;
    private String oktime;
}
