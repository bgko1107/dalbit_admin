package com.dalbit.content.vo.procedure;

import com.dalbit.common.vo.BaseVo;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class P_noticeDetailOutputVo extends BaseVo {
    private int noticeIdx;
    private int slctType;
    private String platform;
    private int gender;
    private String title;
    private String contents;
    private int topFix;
    private int viewOn;
    private int viewCnt;
    private String offDate;
    private String writeDate;
    private int iosJudgeViewOn;

}
