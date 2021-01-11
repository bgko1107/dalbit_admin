package com.dalbit.broadcast.vo.procedure;

import com.dalbit.common.vo.PagingVo;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class P_GiftListInputVo extends PagingVo {

    /*  intput  */
    private String room_no;
    private int pageNo;
    private String itemType;
}






