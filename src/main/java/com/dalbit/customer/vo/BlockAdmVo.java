package com.dalbit.customer.vo;

import com.dalbit.common.vo.PagingVo;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class BlockAdmVo extends PagingVo {

    /* input */
    private String searchType;
    private String searchText;
    private String blockType;   // 차단유형 검색조건을 위한 input
    private int radioBlock;  // 모달창에서 라디오 타입을 위한 input blockType
    private String report_idx;
    private String idx;
    private String adminMemo;   // 모달창에서 입력하는 memo
    private String tabType;

    /* output */
    private int block_type;     // output을 위한 block_type
    private String block_text;
    private int block_day;
    private String block_end_date;
    private String last_upd_date;
    private String op_name;
    private String op_msg;
    private String blockIdxs;

    /* history를 위한 */
    private String edit_contents;
    private int edit_type;

}
