package com.dalbit.broadcast.vo.procedure;

import com.dalbit.common.vo.PagingVo;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class P_ChatTargetListInputVo extends PagingVo {

    /*  intput  */
    private String room_no;
    private String mem_no;
    private int slct_type;
    private String slct_value;
    private int pageNo;
}






