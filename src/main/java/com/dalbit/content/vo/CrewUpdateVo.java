package com.dalbit.content.vo;

import com.dalbit.common.vo.BaseVo;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class CrewUpdateVo extends BaseVo {
    private int crewIdx;
    private String crewMemo;
}
