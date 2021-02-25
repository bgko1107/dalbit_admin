package com.dalbit.status.vo.procedure;

import com.dalbit.common.vo.BaseVo;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class P_ItemLiveOutputVo extends BaseVo {

    private int now_item_cnt;                   
    private int yes_item_cnt;       
    private int now_inc_cnt;        
    private int week_item_cnt;      
    private int bweek_item_cnt;     
    private int week_inc_cnt;       
    private int month_item_cnt;     
    private int bmonth_item_cnt;        
    private int month_inc_cnt;      
    private int now_item_amt;       
    private int yes_item_amt;       
    private int now_inc_amt;        
    private int week_item_amt;      
    private int bweek_item_amt;     
    private int week_inc_amt;       
    private int month_item_amt;     
    private int bmonth_item_amt;        
    private int month_inc_amt;

    private String week_startDate;
    private String week_endDate;
    private String bweek_startDate;
    private String bweek_endDate;

}
