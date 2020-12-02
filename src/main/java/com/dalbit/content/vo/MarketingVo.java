package com.dalbit.content.vo;

import com.dalbit.common.vo.PagingVo;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class MarketingVo extends PagingVo {

    /* input */
    private String searText;
    private String opName;

}
