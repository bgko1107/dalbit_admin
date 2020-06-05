package com.dalbit.customer.vo.procedure;

import com.dalbit.common.vo.BaseVo;
import com.dalbit.util.DalbitUtil;
import lombok.Getter;
import lombok.Setter;

import java.sql.Date;

@Getter
@Setter
public class P_DeclarationListOutputVo extends BaseVo {
    private int reportIdx;
    private String mem_no;
    private String mem_userid;
    private String mem_nick;
    private String reported_mem_no;
    private String reported_userid;
    private String reported_nick;
    private String room_no;
    private int reason;
    private String etc;
    private int status;
    private int op_code;
    private String platform;
    private String browser;
    private String ip;
    private Date opDate;
    private Date regDate;
    private String opDateFormat;
    private String regDateFormat;

    private int totalReportedCnt;
    private int totalOpCnt;

    public void setRegDate(Date regDate) {
        this.regDate = regDate;
        this.regDateFormat = DalbitUtil.convertDateFormat(regDate, "yyyy.MM.dd HH:mm:ss");
    }
    public void setOpDate(Date opDate) {
        this.opDate = opDate;
        this.opDateFormat = DalbitUtil.convertDateFormat(opDate, "yyyy.MM.dd HH:mm:ss");
    }
}
