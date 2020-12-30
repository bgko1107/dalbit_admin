package com.dalbit.member.vo.procedure;

import com.dalbit.common.vo.SearchVo;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class P_MailboxMsgVo extends SearchVo {

    // input
    private int pageNo;
    private String chat_no;
    private String startDate;
    private String endDate;
    private int inner;

    // output

    // summary

}
