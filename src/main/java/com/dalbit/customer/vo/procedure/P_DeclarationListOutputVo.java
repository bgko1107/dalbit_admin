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
    private String mem_sex;
    private String mem_birth_year;
    private String mem_birth_month;
    private String mem_birth_day;
    private String reported_mem_no;
    private String reported_userid;
    private String reported_nick;
    private String reported_mem_sex;
    private String reported_mem_birth_year;
    private String reported_mem_birth_month;
    private String reported_mem_birth_day;
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
    private String roomType;
    private String device_uuid;

    private int inner;
    private int image_idx;
    private int reported_inner;

    private int totalReportedCnt;
    private int totalOpCnt;

    // 이미지 신고
    private String imageType;
    private String imageUrl;
    private String viewState;
    private String uploadDate;
    private String upload_mem_no;
    private String upload_nick;
    private String upload_userid;
    private String upload_phone;
    private String upload_sex;
    private String upload_age;
    private String upload_level;
    private String upload_grade;
    private String report_mem_no;
    private String report_nick;
    private String report_userid;
    private String report_phone;
    private String report_sex;
    private String report_age;
    private String report_level;
    private String report_grade;
    private String data2;

    // 첨부 이미지
    private String image_url1;
    private String image_url2;
    private String image_url3;
    private int image_cnt;

    public void setRegDate(Date regDate) {
        this.regDate = regDate;
        this.regDateFormat = DalbitUtil.convertDateFormat(regDate, "yyyy.MM.dd HH:mm:ss");
    }
    public void setOpDate(Date opDate) {
        this.opDate = opDate;
        this.opDateFormat = DalbitUtil.convertDateFormat(opDate, "yyyy.MM.dd HH:mm:ss");
    }
}
