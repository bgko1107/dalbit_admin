package com.dalbit.content.vo.procedure;

import com.dalbit.common.vo.BaseVo;
import com.dalbit.common.vo.PagingVo;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class P_EventManagementAddVo extends BaseVo {
    private String title;
    private int state;
    private int alwaysYn;
    private int announceYn;
    private String startDate;
    private String endDate;
    private int viewYn;
    private int prizeSlct;
    private int addInfoSlct;
    private String etcUrl;
    private String pcLinkUrl;
    private String mobileLinkUrl;
    private String listImgUrl;
    private String announcementDate;
}
