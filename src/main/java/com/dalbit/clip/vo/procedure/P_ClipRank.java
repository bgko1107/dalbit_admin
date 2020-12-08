package com.dalbit.clip.vo.procedure;

import com.dalbit.common.vo.PagingVo;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class P_ClipRank extends PagingVo {

    private String searchText;
    private String startDate;
    private String endDate;
    private String slctType;
    private String rankingDate;
    private int searchType;

}
