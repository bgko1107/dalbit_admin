package com.dalbit.clip.vo.procedure;

import com.dalbit.common.vo.SearchVo;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class P_ClipHistoryDetailInfoEditVo extends SearchVo {

    private String cast_no;				// 클립번호
    private String editSlct;			    // 수정구분(1: 배경이미지2:닉네임,3:공개설정,4:삭제,5:숨기기,6:제목,7:주제,8:확인,9:입장제한
    private String backgroundImage;		// 배경이미지경로
    private String nickName;			// 닉네임
    private String openType;			// 공개변경(1: 공개,0:비공개)
    private String state;				    // 삭제(5)
    private String hide;				    // 숨기기(1: 숨기기, 0:정상)
    private String title;				    // 제목초기화
    private String subjectType;		// 주제변경
    private String admin_cover_title;		// 제목
    private String admin_cover_singer;		// 가수
    private String uci_album_code;		// uci 앨범 코드
    private String confirm;				// 확인(1)
    private String sendNoti;			    // 알림보내기여부(1:보냄, 0: 안보냄)
    private String notiContents;		// 이미지초기화 조치 안내,
    private String notiMemo;			// 안내 내용
    private String memNo;

}
