package com.dalbit.member.vo.procedure;

import com.dalbit.common.vo.SearchVo;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class P_MailboxImgListVo extends SearchVo {

    //input
    private int pageNo;
    private String startDate;
    private String endDate;

    //output
    private String imageUrl;
    private String delete_yn;
    private String mem_nick;
    private String mem_sex;
    private String mem_birth_year;
    private String last_upd_date;
    private String chat_no;
    private String mem_no;
    private String data2;
    private int inner;

    // summary
    private int mCnt;
    private int fCnt;
    private int nCnt;
    private int tCnt;
    private int mCntMsg;
    private int fCntMsg;
    private int nCntMsg;
    private int totalCntMsg;

}
