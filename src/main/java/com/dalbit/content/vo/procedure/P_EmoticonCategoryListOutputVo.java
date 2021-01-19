package com.dalbit.content.vo.procedure;

import com.dalbit.common.vo.BaseVo;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class P_EmoticonCategoryListOutputVo extends BaseVo {
    private int idx;
    private int category_orderNo;
    private String categoryNm;
    private int pageNo;
}
