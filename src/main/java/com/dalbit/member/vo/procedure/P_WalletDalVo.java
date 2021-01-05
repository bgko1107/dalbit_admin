package com.dalbit.member.vo.procedure;

import com.dalbit.common.vo.SearchVo;
import lombok.Getter;
import lombok.Setter;

@Getter @Setter
public class P_WalletDalVo extends SearchVo {

    /* Input */
    private String mem_no;
    private String walletType;            //(0: 전체, 1:구매, 2:선물, 3:교환)
    private int slct_type;          //사용 구분(1: 루비구매, 2: 아이템선물, 3: 아이템사용, 4: 루비선물보내기, 5:루비선물받기, 6: 루비 교환, 7: 이벤트 받기, 8: 환불차감, 12:운영자지급)
    private String slct_typeTxt;
    private int pageNo;

    private String sDate;
    private String eDate;
    private int walletDataType;

    private String startDate;
    private String endDate;
}
