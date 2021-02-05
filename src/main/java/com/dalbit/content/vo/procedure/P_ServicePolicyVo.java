package com.dalbit.content.vo.procedure;

import com.dalbit.common.vo.PagingVo;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class P_ServicePolicyVo extends PagingVo {


    /* input */
    private int dateType;
    private int slctType;
    private String searchText;
    private int searchType;
    private String idxList;
    private int eventNo;
    private String eventStartDate;
    private String eventEndDate;
    private int viewYn;


    /* output */
    private int idx;
    private int reg_idx;
    private String apply_date;
    private int type;
    private String type_desc;
    private String title;
    private String reg_date;
    private String reg_op_name;
    private String upd_date;
    private String upd_op_name;
    private String platform;
    private String osType;
    private String desc;
    private String applyDate;
    private String event_no;
    private String view_yn;
    private String event_start_date;
    private String event_end_date;

    /* summary */

}
