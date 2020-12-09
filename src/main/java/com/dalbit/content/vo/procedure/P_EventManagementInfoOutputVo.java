package com.dalbit.content.vo.procedure;

import com.dalbit.common.vo.BaseVo;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class P_EventManagementInfoOutputVo extends BaseVo {
    private String title;
    private int alwaysYn;
    private int announceYn;
    private String startDate;
    private String endDate;
    private int state;
    private int viewYn;
    private String regDate;
    private String regOpName;
    private String lastUpdDate;
    private String lastOpName;
    private int addInfoSlct;
    private String etcUrl;
    private int prizeSlct;
    private String announcementDate;
    private String pcLinkUrl;
    private String mobileLinkUrl;
    private String listImgUrl;

    private int foldYn;
    private String notice;

    private int prizeWinner;
}
