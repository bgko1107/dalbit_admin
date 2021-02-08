package com.dalbit.clip.vo.procedure;

import com.dalbit.common.vo.PagingVo;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class P_ClipCopyrightInputVo extends PagingVo {

    private String searchDate;  // 검색 요청 일자
    private int stateType;      // 상태 구분 (0:전체, 1:정상, 2:삭제(유저+운영), 3:삭제(유저), 4:삭제(운영), 5:숨기기
    private int subjectType;    // 클립 주제 구분(0:전체, 1~)
    private int orderType;      // 정렬구분 (1:청취순, 2:등록일자순, 3:등록개수순)
    private int inner;          // 테스트 아이디 포함 여부(0:미포함, 1: 포함)
    private int pageNo;
    private int newSearchType;

}
