package com.dalbit.customer.vo.procedure;

import com.dalbit.common.vo.BaseVo;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class P_MacroVo extends BaseVo {

    /* input */
    private int pageNo;
    private String searchText;
    private int idx;
    private String idxs;

    /* ourput */
    private String title;
    private String msg;
    private String timeValue;
    private int viewYn;
    private String regDate;
    private String updDate;
}
