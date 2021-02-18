package com.dalbit.content.vo;

import com.dalbit.common.vo.PagingVo;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class BoardAdmStoryVo extends PagingVo {

    /* 게시글 관리 > 사연 Vo*/

    /* input */
    private String searchType;
    private String searchRadio;
    private String txt_search;
    private String start_sel;
    private String end_sel;
    private int newSearchType;

    /* output */
    private int storyIdx;           // 사연 idx
    private String room_no;         // 사연 방송방 번호
    private String status;          // 사연 상태
    private String dj_mem_no;       // 대상 회원 멤버 번호
    private String dj_mem_nick;     // 대상 회원 닉네임
    private String dj_mem_sex;      // 대상 회원 성별
    private int dj_birth_year;      // 대상 회원 생년
    private String title;           // 대상 회원 방송제목
    private String broState;        // 대상 회원 방송상태

    private String send_mem_no;     // 보낸 회원 멤버 번호
    private String send_mem_nick;   // 보낸 회원 닉네임
    private String send_mem_sex;    // 보낸 회원 성별
    private int send_birth_year;    // 보낸 회원 생년
    private String send_date;       // 보낸 일시
    private String story_content;   // 사연 내용
    private String send_inner;      // 사연 내용

    private int storyCnt;           // 받은 사연 수
    private int sendStoryCnt;       // 보낸 사연 수

    // summary --------------------------
    private String type;
    private int maleCnt;      // 총합 남자
    private int femaleCnt;    // 총합 여자
    private int noneCnt;      // 총합 알수없음



}
