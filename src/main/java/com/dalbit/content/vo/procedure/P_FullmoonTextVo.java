package com.dalbit.content.vo.procedure;

import com.dalbit.common.vo.BaseVo;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class P_FullmoonTextVo extends BaseVo {

    private int slctType;

    private String title;
    private String textData;
    private String viewYn;
    private String regDate;
    private String lastUpdDate;

}
