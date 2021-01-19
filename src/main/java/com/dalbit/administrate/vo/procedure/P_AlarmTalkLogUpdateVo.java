package com.dalbit.administrate.vo.procedure;

import com.dalbit.common.vo.BaseVo;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class P_AlarmTalkLogUpdateVo extends BaseVo {
    private String group_idx;
    private String phn;  			            // Y 사용자 전화번호 (국가코드(82)를 포함한 전화번호)
    private String result_code;
    private String result_cont;
}

