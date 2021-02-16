package com.dalbit.clip.vo.procedure;

import com.dalbit.common.vo.PagingVo;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class P_ClipRecommend extends PagingVo {

    private String searchText;
    private String recDate;
    private String beforRecDate;
    private int groupNo;
    private int editYn;     // 0 등록 , 1 수정
    private String fbookUrl;
    private String instaUrl;
    private String ytubeUrl;
    private String bannerUrl;
    private int newSearchType;
    private int newSlctType;

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
