package com.dalbit.content.vo.procedure;

import com.dalbit.common.vo.BaseVo;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class P_WeeklyListOutputVo extends BaseVo {
    private int winnerIdx;
    private int prizeRank;
    private int prizeCnt;
    private String prizeName;
    private String mem_no;
    private String nickName;
    private int certificationYn;
    private int minorYn;
    private int receiveWay;
    private int addInfo;
    private int depositConfirm;
    private int addIdx;
    private int state;

    /* 추가한 것 */
    private int prizeIdx;
}