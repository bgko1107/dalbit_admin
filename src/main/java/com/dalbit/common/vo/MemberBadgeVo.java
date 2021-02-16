package com.dalbit.common.vo;

import lombok.Getter;
import lombok.Setter;

import java.util.Date;

@Getter
@Setter
public class MemberBadgeVo {
    private int idx;
    private String memNo;
    private int badgeType;  //slct_type
    private int badgeRank;  //badge_value
    private String startDate;
    private String endDate;
    private Date last_upd_date;
    private String opName;
}
