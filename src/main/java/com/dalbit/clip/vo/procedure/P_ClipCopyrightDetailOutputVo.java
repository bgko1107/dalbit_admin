package com.dalbit.clip.vo.procedure;

import com.dalbit.common.vo.BaseVo;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class P_ClipCopyrightDetailOutputVo extends BaseVo {

    private String mem_no;
    private String nickName;
    private String userId;
    private String memPhone;
    private int innerMem;
    private String playDate;       // 청취 일자
    private String ip;
    private int repeatCnt;   // 누적 청취 횟수

}
