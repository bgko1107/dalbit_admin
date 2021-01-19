package com.dalbit.member.vo.procedure;

import com.dalbit.common.vo.SearchVo;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class P_MemberConnectInputVo extends SearchVo {
    private int pageNo;
    private int sortDate;
    private String mem_no;

}
