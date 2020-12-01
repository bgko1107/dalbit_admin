package com.dalbit.common.vo;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class PagingVo extends BaseVo {

    public PagingVo(){}

    public PagingVo(String totalCnt){
        this.totalCnt = Integer.parseInt(totalCnt);
    }

    public PagingVo(int totalCnt){
        setTotalCnt(totalCnt);
    }

    public PagingVo(int totalCnt, int pageStart, int pageCnt){
        this.totalCnt = totalCnt;
        this.pageStart = pageStart;
        this.pageCnt = pageCnt;
    }

    /*output*/
    private int totalCnt;
    private String tableColumnName;
    private int orderColumnIdx;
    private String orderDir;
    private int pageStart;
    private int pageCnt;

    private int searchStartNo;
    private int searchStartLimitNo;
    private int searchEndNo;

    public void setTotalCnt(int totalCnt){
        this.totalCnt = totalCnt;
        this.searchStartNo = (int)(Math.floor(this.pageStart-1) * this.pageCnt) + 1;
        this.searchEndNo = this.pageStart * this.pageCnt;

        this.searchStartLimitNo = (int)(Math.floor(this.pageStart-1) * this.pageCnt);
/*
        int pageSt = (int)(Math.floor(this.pageStart-1) * this.pageCnt);
        this.pageStart = 0 < pageSt ? pageSt : 0;*/
    }

}
