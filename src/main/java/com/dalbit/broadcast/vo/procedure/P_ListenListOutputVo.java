package com.dalbit.broadcast.vo.procedure;

import com.dalbit.common.vo.PagingVo;
import com.dalbit.util.DalbitUtil;
import lombok.Getter;
import lombok.Setter;

import java.util.Date;

@Getter
@Setter
public class P_ListenListOutputVo extends PagingVo {

    /* return result */
    private int auth;
    private int state;
    private String mem_no;
    private String userID;
    private String nickName;
    private String mem_sex;
    private String mem_birth_year;
    private String mem_birth_month;
    private String mem_birth_day;
    private String level;
    private String grade;
    private Date start_date;
    private String startDateFormat;
    private Date end_date;
    private String endDateFormat;
    private String listenTime;
    private Date auth_start_date;
    private String authStartDateFormat;
    private Date auth_end_date;
    private String authEndDateFormat;
    private int goodCnt;
    private int boosterCnt;
    private int giftCnt;
    private int pageNo;
    private int listenerCnt;
    private int managerCnt;
    private int forcedCnt;
    private int totalGoodCnt;
    private int totalBoosterCnt;
    private int totalGiftCnt;
    private int totalGuestCnt;
    private int inner;
    private int joinCnt;
    private int complete_moon;
    private int step;
    private String complete_date; //보름달 완료일시
    private int totalCompleteMoonCnt;
    private int shadow;

    private String osType;
    private String appVersion;
    private String buildVersion;
    private String deviceManufacturer;
    private String deviceModel;

    // 회원 배찌
    private String recomm_badge;
    private String newdj_badge;
    private String specialdj_badge;
    private String new_badge;

    public void setStart_date(Date start_date){
        this.start_date = start_date;
        this.startDateFormat = DalbitUtil.convertDateFormat(start_date, "yyyy.MM.dd HH:mm:ss");
    }
    public void setEnd_date(Date start_date){
        this.end_date = start_date;
        this.endDateFormat = DalbitUtil.convertDateFormat(end_date, "yyyy.MM.dd HH:mm:ss");
    }
    public void setAuth_start_date(Date auth_start_date){
        this.auth_start_date = auth_start_date;
        this.authStartDateFormat = DalbitUtil.convertDateFormat(auth_start_date, "yyyy.MM.dd HH:mm:ss");
    }
    public void setAuth_end_date(Date auth_end_date){
        this.auth_end_date = auth_end_date;
        this.authEndDateFormat = DalbitUtil.convertDateFormat(auth_end_date, "yyyy.MM.dd HH:mm:ss");
    }
}


