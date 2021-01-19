package com.dalbit.payment.vo;

import com.dalbit.common.vo.SearchVo;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class Pay_PayInputVo extends SearchVo {

    private int pageNo;
//    private int period;
    private String sDate;
    private String eDate;
    private int searchPayStatus;
    private int ostype;
    private String innerType;
    private String payWay;
    private int memberDataType;

    private String genderStr;
    private String timeStr;
    private String ageStr;
    private String success;

}
