package com.dalbit.member.vo.procedure;

import com.dalbit.common.vo.SearchVo;
import com.dalbit.util.DalbitUtil;
import lombok.Getter;
import lombok.Setter;

@Getter @Setter
public class P_WalletDalListOutVo extends SearchVo {

    //output
    private String gubun;
    private int ruby;
    private String ruby_new;
    private String ruby_old;
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

//    private String updateDt;
//    private Long updateTs;
//    private int slct_type;
//    private String contents;
//    private int dalCnt;
//    private int dalResultCount;
//
//    public void setUpdateDt(Date data){
////        this.updateDt = DalbitUtil.getUTCFormat(data);
//        this.updateDt = DalbitUtil.convertDateFormat(data, "yyyy.MM.dd HH:mm:ss");
//        this.updateTs = DalbitUtil.getUTCTimeStamp(data);
//    }

}

