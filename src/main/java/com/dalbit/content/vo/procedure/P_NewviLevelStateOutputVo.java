package com.dalbit.content.vo.procedure;

import com.dalbit.common.vo.PagingVo;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class P_NewviLevelStateOutputVo extends PagingVo {

    private String theDate;
    private int eventType;
    private int maleCnt;
    private int maleDal;
    private int malePay;
    private int femaleCnt;
    private int femaleDal;
    private int femalePay;

    // 합계
    private int totalLevel5MaleCnt;
    private int totalLevel5MaleDal;
    private int totalLevel5MalePay;
    private int totalLevel5FemaleCnt;
    private int totalLevel5FemaleDal;
    private int totalLevel5FemalePay;
    private int totalLevel10MaleCnt;
    private int totalLevel10MaleDal;
    private int totalLevel10MalePay;
    private int totalLevel10FemaleCnt;
    private int totalLevel10FemaleDal;
    private int totalLevel10FemalePay;


}
