package com.dalbit.money.vo;

import com.dalbit.common.vo.PagingVo;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class Mon_ExchangeInputVo extends PagingVo {

    private int pageNo;
    private Integer idx;
    private Integer isSpecial;
    private String search_year;
    private String search_month;
    private String search_day;
    private String search_type;
    private String exchange_sort;
    private int slctType;
    private String search_value;
    private String search_state;
    private int search_testId;
    private String search_exchangeYn;
    private String limitDay;
    private String excelYn;
    private int last_reject;
    private String gender;
    private String baseDay;

    //환전통계 summary : 범위 때문에 end 날짜 추가
    private String end_year;
    private String end_month;
    private String end_day;

    private String viewName;
    private String idxs;
    private String[] idxArr;
    private int state;

    private String startDate;
    private String endDate;


    //procedure
    private String searchType;
    private String searchText;
    private String orderType;
    private String innerType;
    private String djType;

}
