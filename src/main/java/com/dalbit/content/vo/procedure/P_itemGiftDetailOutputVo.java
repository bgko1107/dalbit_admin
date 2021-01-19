package com.dalbit.content.vo.procedure;

import com.dalbit.common.vo.BaseVo;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class P_itemGiftDetailOutputVo extends BaseVo {
    private String item_code;			//아이템코드
    private String item_name;			//아이템이름
    private String item_image;			//아이템이미지 경로
    private String item_thumbnail;		//아이템 썸네일이미지 경로
    private String item_price;				//가격(달)
    private String item_price_ios;			//ios가격(달)
    private String byeol;					//얻는 별
    private String item_type;			//아이템 타입( 신규,인기,한정)
    private String discount_rate;			//할인율
    private String sale_price;				//실제판매가격(달)
    private String item_slct;				//아이템구분(1: 방송방선물, 2: 방송방사용, 3: 달 선물)
    private String use_area;				//사용영역
    private String file_slct;			//파일 구분( webp/jason, sticker)
    private String webp_image;			//webp 이미지경로
    private String jason_image;			//jason 이미지경로
    private int sound_yn;			    //사운드 아이템 여부
    private String sound_url;			//사운드 파일 경로
    private String play_time;				//애니플레이시간
    private String platform;			//플랫폼(PC(Web포함),Mobile-Android,Mobile-IOS)
    private String desc;				//아이템설명
    private String view_yn;				//게시여부(0: OFF, 1: ON)
    private String purchase_count;			//구매건수
    private String op_name;				//등록자
    private String regDate;				//등록일자
    private String regDateFormat;
    private String lastupdDate;			//최종변경일자
    private String lastupdDateFormat;
    private String ruby;					//소모 루비
    private String gold;					//획득 골드
    private String exp;					//획득 경험치
    private String order;					//아이템 순서
    private String state;					//상태( 1: 판매중, 2: 판매 중지)
    private int in_app_yn;				//인앱 여부( 0: 아님, 1: 인앱 다운로드 아이템)
}
