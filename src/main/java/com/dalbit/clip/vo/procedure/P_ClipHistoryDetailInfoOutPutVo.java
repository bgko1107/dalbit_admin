package com.dalbit.clip.vo.procedure;

import com.dalbit.common.vo.BaseVo;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class P_ClipHistoryDetailInfoOutPutVo extends BaseVo {

    private String castNo;
    private String backgroundImage;		// 배경이미지
    private String cast_mem_no;			// 등록회원번호
    private String cast_userId;			// 등록회원아이디
    private String cast_nickName;		// 등록회원닉네임
    private String cast_memSex;			// 등록회원성별
    private String cast_korean_age;		// 나이,
    private String cast_birth_year;		// 나이,
    private String openType;			// 공개여부(0: 비공개, 1:공개)
    private String entryType;			// 입장제한(0: 전체, 1: 팬만, 2: 20세이상)
    private String state;				// 상태(1: 정상, 4: 회원삭제, 5: 운영삭제)
    private String hide;				// 숨김여부(0: 정상, 1:숨김)
    private String hideOpName;			// 순김처리운영자,
    private String confirm;				// 확인여부(0: 미확인, 1: 확인)
    private String confirmOpName;		// 확인처리운영자
    private String title;				// 클립제목
    private String subjectType;			// 클립주제
    private String startDate;			// 클립등록일자
    private String fileName;			// 클립파일명
    private String filePath;			// 클립경로
    private String playTime;			// 클립재생시간
    private String fileSize;			// 클립용량
    private String goodCnt;				// 좋아요수
    private String giftCnt;				// 선물건수
    private String giftedByeol;			// 받은별수
    private String playCnt;				// 재생수
    private String boardCnt;			// 댓글수
    private String osType;				// 등록플랫폼(1: AOS,2: IOS,3: PC)
    private String opMemoCnt;			// 운영자메모개수
    private String lastOpDate;			// 최근수정일자
    private String lastOpName;			// 최근수정이름
    private int isWithdrawal;           // 탈퇴여부 (0: 정상 1: 탈퇴)
    private String cast_deviceUuid;
    private String cast_ip;

    private String cover_title;         //커버제목
    private String cover_singer;        //커버가수
    private String admin_cover_title;   //어드민 커버제목
    private String admin_cover_singer;  //어드민 커버가수
    private String uci_album_code;      //uci 앨범 코드
}
