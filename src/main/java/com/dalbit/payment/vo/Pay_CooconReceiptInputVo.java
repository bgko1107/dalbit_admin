package com.dalbit.payment.vo;

import com.dalbit.common.vo.PagingVo;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class Pay_CooconReceiptInputVo extends PagingVo {

    private String txt_startSel;
    private String txt_endSel;
    private String searchType;
    private String searchText;
    private int newSearchType;

}
