package com.dalbit.money.vo;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class Mon_ExchangeOutputVo{

    private int rowNum;
    private String mem_no;
    private String mem_id;
    private String mem_userid;
    private String mem_name;
    private String mem_nick;
    private String mem_sex;
    private String mem_birth_year;
    private String mem_birth_month;
    private String mem_birth_day;
    private String image_profile;
    private int mem_state;
    private String mem_phone;
    private int idx;
    private int byeol;
    private int cash_basic;
    private int income_tax;
    private int resident_tax;
    private int transfer_fee;
    private int benefit;
    private int cash_real;
    private String account_name;
    private String bank_code;
    private String bank_name;
    private String account_no;
    private String social_no;
    private String phone_no;
    private String address_1;
    private String address_2;
    private String add_file1;
    private String add_file2;
    private String add_file3;
    private int terms_agree;
    private int os_type;
    private String ip;
    private int confirm;
    private String state;
    private String op_msg;
    private String op_name;
    private String op_date;
    private String reg_date;
    private String last_upd_date;
    private int gold;
    private int exchangeCnt;
    private int totalCashBasic;
    private int totalCashReal;
    private int last_reject;
    private String recant_yn;

    private int gold_old;
    private int mod_gold;            // 나머지 별
    private String last_reg_date;
    private String reapply_exchage;

    private String prevAccountName; //최근 환전승인 이름
    private String prevSocialNo;    //최근 환전승인 주민번호

    private String send_title;		// 발송 메시지 제목
    private String send_cont;		// 발송 메시지 내용
    private int send_type;		    //(0: 미선택, 1 증빙서류 화질문제, 2: 미비한 증빙서류 , 3: 입력정보 불일치, 4: 기타 직접작성)

    private String testid_history;

    private String birth;
    private String inner;

    private String totalCnt;


    private String before_add_file1;
    private String before_add_file2;
    private String before_add_file3;

}
