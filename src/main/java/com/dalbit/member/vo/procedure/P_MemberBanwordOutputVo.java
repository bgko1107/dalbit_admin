package com.dalbit.member.vo.procedure;

import com.dalbit.common.vo.SearchVo;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class P_MemberBanwordOutputVo extends SearchVo {

    //output
    private String ban_word;
    private int count;

}
