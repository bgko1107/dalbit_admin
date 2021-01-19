package com.dalbit.content.vo;

import com.dalbit.common.vo.PagingVo;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class BannerStatVo extends PagingVo {

    private int on_cnt;
    private int off_cnt;
    private int pc_cnt;
    private int aos_cnt;
    private int ios_cnt;
    private int mainTop_cnt;
    private int mainCenter_cnt;
    private int clipCenter_cnt;
    private int gnb_cnt;
    private int start_cnt;
    private int end_cnt;
    private int image_cnt;
    private int text_cnt;

}
