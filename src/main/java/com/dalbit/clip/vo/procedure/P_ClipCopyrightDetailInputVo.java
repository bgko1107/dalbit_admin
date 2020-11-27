package com.dalbit.clip.vo.procedure;

import com.dalbit.common.vo.PagingVo;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class P_ClipCopyrightDetailInputVo extends PagingVo {

    private String cast_no; // 클립 번호
    private String year;       // 검색 년
    private String month;      // 검색 월
    private int searchType; // 검색 대상 구분 (0: 전체, 1: 회원번호, 2: 닉네임, 3: userId, 4: 전화번호, 5: IP)
    private String searchText; // 검색어
    private int inner;      // 테스트 아이디 포함 여부(0:미포함, 1: 포함)
    private int pageNo;

}
