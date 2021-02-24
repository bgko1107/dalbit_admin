package com.dalbit.content.vo.procedure;

import com.dalbit.common.vo.BaseVo;
import lombok.Getter;
import lombok.Setter;

import java.util.Date;

@Getter
@Setter
public class P_FullmoonRankingVo extends BaseVo {

    private int idx;
    private int slct_type;
    private int fullmoon_idx;
    //private int pageNo;
    //private int pageCnt;

    private String mem_no;
    private int rank;
    private String nickName;
    private String memSex;
    private String profileImage;
    private int completeCnt;
    private String lastDate;
    private int listenTime;
}
