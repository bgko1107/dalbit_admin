package com.dalbit.broadcast.vo.procedure;

import com.dalbit.common.vo.PagingVo;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class P_BroadcastListInputVo extends PagingVo {

    /*  intput  */
    private int slctType;
    private int dj_slctType;
    private String dj_searchText;
    private int room_slctType;
    private String room_searchText;
    private int pageNo;
    private int room_liveType;
    private String room_no;
    private int sortState;
    private int orderType;
    private int newSearchType;

    private String startDate;
    private String endDate;

    private String sortTitle;
    private String sortStartDate;
    private String sortAirTime;
    private String sortListener;
    private String sortGift;
    private String sortByeol;
    private String sortMoon;

}