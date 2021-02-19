package com.dalbit.content.vo;

import com.dalbit.common.vo.PagingVo;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class CrewListVo extends PagingVo {
    private int crewIdx;
    private String crewName;
    private String crewMemo;
    private String crewLeader;
    private int state;
    private int crewCnt;
    private int levelAvg;
    private int payCnt;
    private int payAmtSum;
    private String regDate;
    private int slct_type;
    private int newSearchType;
}
