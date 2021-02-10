package com.dalbit.member.vo.procedure;

import com.dalbit.common.vo.SearchVo;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class P_MemberInfoInputVo extends SearchVo {
    private String mem_no;
    private String memWithdrawal;
    private String auto_change;
    private String memSex;
    private String memNick;
    private String leaderList;
    private String profileList;
    private String idxList;

    private int leader;
    private String profile;
    private int idx;

}
