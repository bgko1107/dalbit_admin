package com.dalbit.clip.vo.procedure;

import com.dalbit.common.vo.PagingVo;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class P_ClipRecommend extends PagingVo {

    private String yearMonth;
    private String searchText;
    private int groupNo;

    private int weekNo;
    private String titleMsg;
    private String descMsg;
    private String videoUrl;
    private String thumbUrl;
    private int viewYn;
    private String castNoList;
    private String orderNoList;
    private String leaderYnList;


    private String castNo;
    private String yearMonthList;
    private String weekNoList;
    private String groupNoList;

}
