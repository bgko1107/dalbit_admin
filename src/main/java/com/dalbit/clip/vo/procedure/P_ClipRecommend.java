package com.dalbit.clip.vo.procedure;

import com.dalbit.common.vo.PagingVo;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class P_ClipRecommend extends PagingVo {

    private String searchText;
    private String recDate;
    private int groupNo;

    private String titleMsg;
    private String descMsg;
    private String videoUrl;
    private String thumbUrl;
    private int viewYn;
    private String castNoList;
    private String orderNoList;
    private String leaderYnList;


    private String castNo;
    private String redDateList;
    private String groupNoList;

}
