package com.dalbit.content.vo.procedure;

import com.dalbit.common.vo.BaseVo;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class P_bannerInsertVo extends BaseVo {
    private int idx;
    private String title;       		//배너제목
    private int view_type;           //배너구분(0:전체, 1:로그인, 2:비로그인)
    private int sex;         		//성별(0:전체, 1:남자, 2:여자, 3:알수없음)
    private int frequency_rate;      //노출기간구분(0:상시, 1:직접선택)
    private int term_type;           //노출기간구분(0:상시, 1:직접선택)
    private String start_datetime;      //노출시작일시
    private String end_datetime;        //노출종료일시
    private int is_pop;              //새창여부(0:링크이동, 1:새창)
    private int is_view;             //게시여부(0:OFF, 1:ON)
    private int position;    		//배너위치(0:GNB, 1:펼침, 2:팝업, 3:고객센터, 4:스토어)
    private String pc_img_url;          //pc 이미지 URL
    private String pc_link_url;         //pc 링크 URL
    private String mobile_img_url;      //mobile 이미지 URL
    private String mobile_link_url;     //mobile 링크 URL
    private String thumb_img_url;       //썸네일 URL
    private int popup_type;             //팝업구분(0:이미지, 1:텍스트)
    private int is_cookie;              //쿠키사용여부(0:안함, 1:사용함)
    private String contents;            //배너내용
    private int is_title_view;          //제목노출여부(0:노출안함, 1:노출)
    private int is_button_view;         //버튼노출여부(0:노출안함, 1:노출)
    private String desc;                //비고
    private String reg_date;            //등록일
    private String op_name;             //등록자
    private String last_upd_date;       //수정일
    private String lastOpName;        //수정자
    private String platform;			// 플랫폼(111: PC/AOS/IOS)
    private int iosJudgeViewOn;			// IOS 심사중 노출여부

    private String dayOfTheWeek;        // 스케쥴 요일 선택
    private String content_scheduleWeekTime;        // 스케쥴 시간 구분 선택
    private String weekStartDatetime;   // 스케쥴 시작 시간
    private String weekEndDatetime;     // 스케쥴 종료 시간

    private Integer memJoinInnerDate;   // 회원가입 몇일 이내
    private Integer memLevelStart;      // 시작 노출레벨
    private Integer memLevelEnd;        // 종료 노출레벨

    private String buttonName;          // 버튼명

}

