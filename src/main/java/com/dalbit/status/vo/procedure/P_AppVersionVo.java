package com.dalbit.status.vo.procedure;

import com.dalbit.common.vo.PagingVo;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class P_AppVersionVo extends PagingVo {

    /* 파라메터 */
    private int os;                     // os
    private int selectVersionCount;     // limit에 들어갈 파라미터

//    /* 버전, 사용자 */
//    private int aosVersionUsers;        // aos 화면상에 있는 버전의 사용자
//    private int iosVersionUsers;        // ios 화면상에 있는 버전의 사용자

    private int aosTotUsers;     // aos 총 사용자
    private int iosTotUsers;     // ios 총 사용자

    /* 빌드, 사용자 */
    private int aosBuildUser;    // aos 화면상에 있는 빌드번호의 사용자
    private int iosBuildUser;    // ios 화면상에 있는 빌드번호의 사용자

    /* 총 테이블 수 */
    private int platform;       // 플랫폼
    private String appVersion;  // 버전
    private String buildVersion;// 빌드번호
    private int userCnt;        // 사용자 수
    private String reg_date;    // 등록날짜
}
