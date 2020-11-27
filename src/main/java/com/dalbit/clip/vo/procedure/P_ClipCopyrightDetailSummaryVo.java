package com.dalbit.clip.vo.procedure;

import com.dalbit.common.vo.BaseVo;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class P_ClipCopyrightDetailSummaryVo extends BaseVo {

    private String mem_no;
    private String nickName;
    private String cast_no;
    private String title;

    private int totalCnt;
    private int pageNo;
    private int pageCnt;

}
