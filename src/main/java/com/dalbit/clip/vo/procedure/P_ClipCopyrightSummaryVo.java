package com.dalbit.clip.vo.procedure;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class P_ClipCopyrightSummaryVo {

    private int regCnt;         // 등록개수
    private int totalClip;      // 클립전체개수
    private int totalPlayCnt;   // 전체 청취 회수

    private int totalCnt;
    private int pageNo;
    private int pageCnt;
}
