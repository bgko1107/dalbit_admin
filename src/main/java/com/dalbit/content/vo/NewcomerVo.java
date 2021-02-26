package com.dalbit.content.vo;

import com.dalbit.common.vo.PagingVo;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class NewcomerVo extends PagingVo {

    private int idx;
    private int slctType;
    private String memNoList;

    private String mem_no;
    private String mem_nick;
    private String mem_sex;
    private String mem_birth_year;
    private String reg_date;
    private String last_upd_date;
    private String reg_opName;
    private String last_opName;
    private int viewYn;
    private String last_date;
    private int broadcastTime;
    private int broadcastCnt;
    private String send_title;
    private String send_cont;
    private String profileImage;
    private int send_cnt;
    private String last_send_date;
    private String last_broadcast;
    private int specialdj_badge;
    private int shiningdj_badge;




}
