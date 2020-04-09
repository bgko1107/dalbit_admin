package com.dalbit.member.vo.procedure;

import com.dalbit.common.vo.SearchVo;
import com.dalbit.util.DalbitUtil;
import lombok.Getter;
import lombok.Setter;

import java.sql.Date;

@Getter
@Setter
public class P_MemberBroadcastOutputVo extends SearchVo {

    //output
    private String room_no;
    private String subject_type;
    private String title;
    private Date start_date;
    private String startDateFormat;
    private Date end_date;
    private String endDateFormat;
    private String airtime;
    private int listenerCnt;
    private int managerCnt;
    private int giftCnt;
    private int byeolCnt;
    private int goodCnt;
    private int boosterCnt;

    //summary
    private int totalListenerCnt;
    private int totalGiftCnt;
    private int totalByeol;
    private int totalGood;
    private int totalBooster;


    public void setStart_date(Date start_date){
        this.start_date = start_date;
        this.startDateFormat = DalbitUtil.convertDateFormat(start_date, "yyyy.MM.dd HH:mm:ss");
    }
    public void setEnd_date(Date end_date){
        this.end_date = end_date;
        this.endDateFormat = DalbitUtil.convertDateFormat(end_date, "yyyy.MM.dd HH:mm:ss");
    }
}
