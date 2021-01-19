package com.dalbit.menu.vo.procedure;

import com.dalbit.common.vo.PagingVo;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class P_ShiningDjListOutVo extends PagingVo {

    /* Output */
    private String profileImage;                  //방번호
    private String memNo;
    private String nickName;
    private String memSex;
    private String memBirthYear;
    private int fanCnt;
    private String broadCastTime;
    private int totalByeol;
    private int totalGood;
    private String broadCastDate;
    private int reportedCnt;

}
