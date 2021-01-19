package com.dalbit.member.vo.procedure;

import com.dalbit.common.vo.SearchVo;
import lombok.Getter;
import lombok.Setter;

@Getter @Setter
public class P_NewWalletByeolListOutVo extends SearchVo {

    //output
    private String type;
    private String item_type;
    private String gold_old;
    private String gold_new;
    private String gold;
    private String room_no;
    private String mem_no;
    private String level;
    private String gread;
    private String userId;
    private String nickName;
    private String mem_sex;
    private String mem_birth_year;
    private String last_upd_date;
    private String item_code;
    private String item_cnt;
    private String secret;
    private String itemName;
    private String item_thumbnail;
}

