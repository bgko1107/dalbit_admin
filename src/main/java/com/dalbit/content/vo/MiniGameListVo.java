package com.dalbit.content.vo;

import com.dalbit.common.vo.PagingVo;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class MiniGameListVo extends PagingVo {
    /* Output */
    private int game_no;
    private String game_name;
    private String image_url;
    private String game_desc;
    private int view_yn;
    private String op_name;
    private String reg_date;
    private String last_upd_date;
}
