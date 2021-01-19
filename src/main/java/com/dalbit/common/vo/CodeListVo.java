package com.dalbit.common.vo;

import lombok.Getter;
import lombok.Setter;

import java.util.List;

@Getter
@Setter
public class CodeListVo {

    private List<String> typeList;

    private String sel;
    private String type;
    private String value;
    private String code;
    private String order;
    private String is_use;

}
