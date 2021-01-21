package com.dalbit.content.vo;

import com.dalbit.common.vo.PagingVo;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class MailboxVo extends PagingVo {

    /* 우체통 */

    /* input */
    private String startDate;
    private String endDate;
    private String searchText;
    private int pageNo;

    /* output */
    private String lastChatDate;
    private String chatNo;
    private String memNo;
    private String memNick;
    private String memInner;
    private String targetMemNo;
    private String target_mem_nick;
    private String target_mem_inner;
    private String msgType;
    private String msg;
    private String data1;
    private String data2;
    private String data3;
    private String data4;
    private String data5;
    private String data6;
    private String deleteYn;
    private String diffDate;
    private String readYn;
    private String state;
    private String item_thumbnail;
    private String webp_image;
    private String chat_no;
    private String mem_no;
    private String memSex;
    private String memAge;
    private String giftDate;
    private String target_mem_no;
    private String target_memNick;
    private String target_memSex;
    private String target_memAge;
    private String item_code;
    private String item_image;
    private String item_name;
    private int giftCnt;
    private int giftDal;

    /* summary */
    private int msg_mCnt;
    private int msg_fCnt;
    private int msg_nCnt;
    private int img_mCnt;
    private int img_fCnt;
    private int img_nCnt;
    private int gift_mCnt;
    private int gift_fCnt;
    private int gift_nCnt;
    private int male_msgCnt;
    private int female_msgCnt;
    private int none_msgCnt;
    private int male_imgCnt;
    private int female_imgCnt;
    private int none_imgCnt;
    private int male_giftCnt;
    private int female_giftCnt;
    private int none_giftCnt;
    private int male_byeolCnt;
    private int female_byeolCnt;
    private int none_byeolCnt;
    private int male_giftDal;
    private int female_giftDal;
    private int none_giftDal;

}
