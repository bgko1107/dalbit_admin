package com.dalbit.status.vo.procedure;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class P_MailboxMonthSetVo{

    // output
    private String the_date;
    private int male_mailbox_y;
    private int male_mailbox_n;
    private int female_mailbox_y;
    private int female_mailbox_n;
    private int none_mailbox_y;
    private int none_mailbox_n;
    private int total_mailbox_y;
    private int total_mailbox_n;

    private int sum_male_mailbox_y;
    private int sum_male_mailbox_n;
    private int sum_female_mailbox_y;
    private int sum_female_mailbox_n;
    private int sum_none_mailbox_y;
    private int sum_none_mailbox_n;
    private int sum_total_mailbox_y;
    private int sum_total_mailbox_n;


}



