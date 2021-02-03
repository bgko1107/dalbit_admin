package com.dalbit.content.vo.procedure;

import com.dalbit.common.vo.BaseVo;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class P_itemGiftInsertVo extends BaseVo {
    private String category;			//아이템카테고리
    private String platform;			// 플랫폼(PC(Web포함)/Mobile-Android/Mobile-IOS)
    private String item_slct;				// 아이템구분(1: 방송방선물, 2: 방송방사용, 3: 달 선물)
    private String item_name;			// 상품명
    private String byeol;					// 지급 별 수량(사용후획득점수)
    private String item_price;				// 아이템 가격(달)
    private String item_price_ios;			// ios아이템 가격(달)
    private String discount_rate;			// 할인율(0~100)
    private String item_type;			// 아이템 타입( 신규,인기,한정)
    private String view_yn;				// 게시상태(0: OFF, 1: ON)
    private String item_image;			// 아이템이미지경로
    private String item_thumbnail;		// 썸네일이미지경로
    private String use_area;				// 사용영역구분
    private String file_slct;			// 파일구분
    private String play_time;				// 애니플레이타임
    private String webp_image;			// webp이미지경로
    private String webp_file_name;		// webp 파일명
    private String jason_image;			// jason이미지경로
    private String jason_file_name;		// jason 파일명
    private int sound_yn;			    // 사운드 아이템 여부(0: 사운드 아님, 1: 사운드 아이템)
    private String sound_url;			// 사운드 URL
    private String sound_file_name;		// 사운드 파일명
    private String desc;				// 상품설명
    private int in_app_yn;				//인앱 여부( 0: 아님, 1: 인앱 다운로드 아이템)
}

