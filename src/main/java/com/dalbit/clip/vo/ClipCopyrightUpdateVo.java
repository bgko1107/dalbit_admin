package com.dalbit.clip.vo;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class ClipCopyrightUpdateVo {

    private int idx;
    private String admin_cover_title;   // 커버 곡명(관리자)
    private String admin_cover_singer;  // 커버 가수(관리자)

}
