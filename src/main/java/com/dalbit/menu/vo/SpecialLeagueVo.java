package com.dalbit.menu.vo;

import com.dalbit.common.vo.PagingVo;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class SpecialLeagueVo extends PagingVo {

    /* output */
    private int rank;
    private String up_down;
    private String mem_no;
    private String mem_nick;
    private String mem_sex;
    private String profileImage;
    private int byeolCount;
    private int listenerCount;
    private int goodCount;
    private int boosterCount;
    private int giftPoint;
    private int listenerPoint;
    private int goodPoint;
    private int totalPoint;
    private int totalGoodCnt;

}
