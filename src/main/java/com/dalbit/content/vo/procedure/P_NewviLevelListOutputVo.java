package com.dalbit.content.vo.procedure;

import com.dalbit.common.vo.PagingVo;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class P_NewviLevelListOutputVo extends PagingVo {

    private String achieveDate;
    private String level;
    private String dal;
    private String mem_no;
    private String mem_nick;
    private String achieve_date;
    private String inner;
    private String certificationYn;
    private String phone;

    //summary
    private int totalDal;
    private int level5Cnt;
    private int level10Cnt;
    private int dal5Cnt;
    private int dal10Cnt;

}
