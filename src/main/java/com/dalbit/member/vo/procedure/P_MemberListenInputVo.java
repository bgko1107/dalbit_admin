package com.dalbit.member.vo.procedure;

import com.dalbit.common.vo.SearchVo;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class P_MemberListenInputVo extends SearchVo {
    private int pageNo;
    private String mem_no;
    private String room_no;
}
