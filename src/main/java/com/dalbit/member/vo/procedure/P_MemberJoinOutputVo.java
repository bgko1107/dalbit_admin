package com.dalbit.member.vo.procedure;

import com.dalbit.common.vo.SearchVo;
import com.dalbit.util.DalbitUtil;
import lombok.Getter;
import lombok.Setter;

import java.sql.Date;

@Getter
@Setter
public class P_MemberJoinOutputVo extends SearchVo {

    //output
    private String mem_no;
    private String mem_id;
    private String mem_phone;
    private String mem_nick;
    private String mem_userid;
    private String mem_name;
    private String mem_sex;
    private String mem_slct;
    private String mem_birth_year;
    private String mem_birth_month;
    private String mem_birth_day;
    private Date mem_join_date;
    private String memJoinDateFormat;
    private Date last_upd_date;
    private String lastUpdDateFormat;
    private int os_type;
    private String ip;
    private String join_path;
    private String testId;
    private int broadcastCnt;
    private int listenCnt;
    private int listenCnt2;
    private int payCnt;
    private int inner;
    private int serviceDate;
    private int koreaAge;

    //summary
    private int allCnt;
    private int slctPhonCnt;
    private int slctFaceCnt;
    private int slctGoogleCnt;
    private int slctKakaoCnt;
    private int slctNaverCnt;
    private int slctAppleCnt;

    private int aosCnt;
    private int iosCnt;
    private int pcCnt;

    private int maleCnt;
    private int femaleCnt;
    private int noneCnt;


    public void setMem_join_date(Date mem_join_date){
        this.mem_join_date = mem_join_date;
        this.memJoinDateFormat = DalbitUtil.convertDateFormat(mem_join_date, "yyyy-MM-dd HH:mm:ss");
    }

    public void setLast_upd_date(Date last_upd_date){
        this.last_upd_date = last_upd_date;
        this.lastUpdDateFormat = DalbitUtil.convertDateFormat(last_upd_date, "yyyy-MM-dd HH:mm:ss");
    }
}
