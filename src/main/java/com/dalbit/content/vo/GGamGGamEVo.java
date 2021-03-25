package com.dalbit.content.vo;

import com.dalbit.common.vo.SearchVo;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class GGamGGamEVo extends SearchVo {

    /* input */
    private String editData;

    /* output */
    private int idx;
    private String idxList;
    private int event_no;
    private String event_name;
    private int view_yn;
    private String upd_date;
    private String upd_op_name;
    private int eventType;
    private int type;

    private int eventNo;
    private String eventName;
    private int viewYn;
    private String regDate;
    private String regOpName;
    private String updDate;
    private String updOpName;
    private String image_url;
    private int image_time;

    private String typeList;
    private String achieveTypeList;
    private String achieveCntList;
    private String rewardTypeList;
    private String rewardCntList;
    private String completeTextList;
    private String imageUrlList;
    private String imageTimeList;

    private String type_desc;
    private String achieve_type;
    private String achieve_desc;
    private String achieve_cnt;
    private String reward_type;
    private String reward_desc;
    private String reward_cnt;
    private String complete_text;

}
