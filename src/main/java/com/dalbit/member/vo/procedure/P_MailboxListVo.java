package com.dalbit.member.vo.procedure;

import com.dalbit.common.vo.SearchVo;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class P_MailboxListVo extends SearchVo {

    // input
    private int pageNo;
    private String mem_no;
    private int inner;

    // output
    private String lastChatDate;
    private String chatNo;
    private String memNo;
    private String memNick;
    private String targetMemNo;
    private String target_mem_nick;
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

    // summary
    private int memMsgCnt;
    private int memImgCnt;
    private int memGiftCnt;
    private int msgCnt;
    private int imageCnt;
    private int giftCnt;
    private int dalCnt;
    private int byeolCnt;
    private int mailbox_onoff;
}
