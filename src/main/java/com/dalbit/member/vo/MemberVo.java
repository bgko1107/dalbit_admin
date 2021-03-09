package com.dalbit.member.vo;

import com.dalbit.common.vo.ImageVo;
import com.dalbit.security.vo.InforexLoginLayoutVo;
import com.dalbit.security.vo.InforexLoginUserInfoVo;
import lombok.Getter;
import lombok.Setter;
import lombok.var;
import org.springframework.security.core.context.SecurityContextHolder;

import java.sql.Date;

@Getter
@Setter
public class MemberVo{

    private static final long serialVersionUID = 1L;

    public static String getMyMemNo() {
        var inforexLoginLayoutVo = (InforexLoginLayoutVo) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        return inforexLoginLayoutVo.getUserInfo().getName();
    }

    public static InforexLoginUserInfoVo getUserInfo(){
        try{
            var inforexLoginLayoutVo = (InforexLoginLayoutVo) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
            return inforexLoginLayoutVo.getUserInfo();
        }catch (Exception e){
            return null;
        }

    }

    private String memNo;
    private String memNick;
    private String memSex;
    private int age;
    private String memId;
    private ImageVo backgroundImage;
    private ImageVo profileImage;
    private String profileMsg;
    private int level;
    private String grade;
    private int exp;
    private int expNext;

    private int fanCount;
    private int starCount;
    private boolean enableFan;

    private int idx;
    private String memPhone;
    private String memPasswd;
    private int memBirthYear;
    private int memBirthMonth;
    private int memBirthDay;
    private String memSlct;
    private String memState;
    private Date memJoinDate;
    private Date lastUpdDate;


    private String mem_no;
    private String mem_id;
    private String mem_passwd;
    private String mem_phone;
    private String mem_nick;
    private String mem_userid;
    private String mem_name;
    private String mem_email;
    private String foreign_yn;
    private String mem_sex;
    private String mem_birth_year;
    private String mem_birth_month;
    private String mem_birth_day;
    private String mem_slct;
    private String mem_adid;
    private String mem_state;
    private String block_day;
    private String block_end_date;
    private String mem_join_date;
    private String os_type;
    private String location;
    private String ip;
    private int inner;
    private String last_upd_date;

    private String room_no;

    private String join_path;
    private int day_badge;
    private int week_badge;
    private int month_badge;
    private int recomm_badge;
    private int newdj_badge;
    private int new_badge;
    private int specialdj_badge;
    private int admin_badge;
    private int shiningdj_badge;
    private int specialdj_cnt;
    private String image_profile;
}
