package com.dalbit.content.vo;

import com.dalbit.common.vo.PagingVo;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class BoardAdmFanBoardVo extends PagingVo {

    /* 게시글 관리 > 팬보드 Vo*/

    /* input */
    private String searchType;
    private String searchRadio;
    private String txt_search;
    private String start_sel;
    private String end_sel;
    private String boardType;
    private int isSecret;               // 비밀글 체크 여부
    private int isWithdarwal;           // 탈퇴회원모아보기 체크 여부
    private int fanBoardOwner;          // 팬보드주인(전체)
    private int isMemblock;          // 팬보드주인(전체)
    private int newSearchType;

    /* output */
    private int idx;                    // 게시글 번호
    private int board_no;               // 게시판 번호

    private String star_image_profile;  // 대상 회원 프로필 이미지
    private String star_mem_no;         // 대상 회원 멤버 번호
    private String star_mem_nick;       // 대상 회원 닉네임
    private int star_mem_state;         // 대상 회원 상태
    private String star_mem_sex;        // 대상 회원 성별
    private int star_birth_year;        // 대상 회원 생년

    private String fan_image_profile;     // 보낸 회원 프로필 이미지
    private String fan_mem_no;            // 보낸 회원 멤버 번호
    private String fan_mem_nick;          // 보낸 회원 닉네임
    private int fan_mem_state;            // 보낸 회원 상태
    private String fan_mem_sex;           // 보낸 회원 성별
    private int fan_birth_year;           // 보낸 회원 생년
    private int fan_inner;           // 보낸 회원 생년

    private String fan_reply_image_profile;     // 팬보드 리플 회원 프로필 이미지
    private String fan_reply_mem_no;            // 팬보드 리플 회원 번호
    private String fan_reply_userid;            // 팬보드 리플 회원 아이디
    private String fan_reply_mem_nick;          // 팬보드 리플 회원 닉네임
    private int fan_reply_mem_state;            // 팬보드 리플 회원 상태
    private String fan_reply_mem_sex;           // 팬보드 리플 회원 성별
    private int fan_reply_birth_year;           // 팬보드 리플 회원 생년

    private int status;                     // 게시글 상태
    private int reply_status;               // 리플 상태
    private String last_upd_date;           // 작성 일자
    private String contents;                // 내용
    private String replyContents;           // 리플 내용
    private String replyCnt;                // 댓글 개수
    private String view_yn;                 // 공개여부
    private String depth;                   // 리플인지~
    private String star_withdrawalType;     // 스타 탈퇴회원 구분
    private String fan_withdrawalType;      // 팬보드 작성자 탈퇴회원 구분
    private String fan_reply_withdrawalType;// 팬보드 댓글 작성자 탈퇴회원 구분

    /* summary */

    private String type;
    private int avgTotalCnt;
    private int totalDelCnt;
    private int avgTotalDelCnt;
    private int maleCnt;
    private int femaleCnt;
    private int noneCnt;

    private int secretTotalCnt;
    private int secretAvgTotalCnt;
    private int secretTotalDelCnt;
    private int secretAvgTotalDelCnt;
    private int secretMaleCnt;
    private int secretFemaleCnt;
    private int secretNoneCnt;
    private String datediff;

}
