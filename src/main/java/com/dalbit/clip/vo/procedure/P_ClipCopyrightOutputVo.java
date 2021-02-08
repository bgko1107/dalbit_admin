package com.dalbit.clip.vo.procedure;

import com.dalbit.common.vo.BaseVo;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class P_ClipCopyrightOutputVo extends BaseVo {

    private int clipIdx;
    private String mem_no;
    private String nickName;
    private int subjectType;    // 방송 주제
    private String filePath;    // 클립 파일 경로
    private String playTime;    // 재생시간
    private String cast_no;     // 클립번호
    private String title;       // 클립제목
    private String regDate;     // 등록일자
    private String userCoverTitle;  // 유저 커버 제목
    private String userCoverSinger; // 유저 커버 가수
    private String adminCoverTitle; // 어드민 커버 제목
    private String adminCoverSinger;// 어드민 커버 가수
    private String uciAlbumCode;// UCI 앨범코드
    private int playCnt;        // 청취 회수
    private int regCnt;         // 등록된 클립 총 수
    private int state;          // 상태
    private int hide;           // 숨기기 상태
    private int newSearchType;

}
