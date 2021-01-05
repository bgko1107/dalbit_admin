package com.dalbit.member.vo.procedure;

import com.dalbit.common.vo.SearchVo;
import com.dalbit.util.DalbitUtil;
import lombok.Getter;
import lombok.Setter;

@Getter @Setter
public class P_WalletByeolListOutVo extends SearchVo {

    //output
    private String gubun;
    private int gold;
    private String gold_new;
    private String gold_old;
    private String room_no;
    private String mem_no;
    private String item_type;
    private String userId;
    private String nickName;
    private String mem_sex;
    private String mem_birth_year;
    private String mem_birth_month;
    private String mem_birth_day;
    private int level;
    private String grade;
    private java.sql.Date giftDate;
    private String giftDateFormat;
    private String itemImage;
    private String itemName;
    private int itemCnt;
    private String item_thumbnail;
    private int secret;
    private int inner;

    public void setGiftDate(java.sql.Date giftDate){
        this.giftDate = giftDate;
        this.giftDateFormat = DalbitUtil.convertDateFormat(giftDate, "yyyy.MM.dd HH:mm:ss");
    }


}

