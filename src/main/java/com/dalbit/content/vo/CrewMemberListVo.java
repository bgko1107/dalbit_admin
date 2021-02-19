package com.dalbit.content.vo;

import com.dalbit.common.vo.PagingVo;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class CrewMemberListVo extends PagingVo {

    /* input */
    private int searchType;
    private String searchText;
    private int newSearchType;

    /* output */
    private int idx;
    private String mem_no;
    private int crewIdx;
    private String crewName;
    private String memNick;
    private int memState;
    private String broadDate;
    private int ranking;
    private int level;
    private int leader_yn;
    private String lastLoginDate;
    private String mem_join_date;
    private int weekLoginCnt;
    private int present;
    private int receive;
}
