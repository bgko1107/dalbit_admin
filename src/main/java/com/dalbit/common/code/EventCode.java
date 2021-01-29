package com.dalbit.common.code;

import lombok.Getter;

@Getter
public enum EventCode {
    인증샷(2, "2020.08 PC인증샷 이벤트"),
    노하우(3, "2020.08 방송 노하우 이벤트"),
    방송장비(4, "2020.09 방송장비 이벤트"),
    웹캠(10, "2021.01 웹캠 지원 이벤트"),

    ;
    final private int eventIdx;
    final private String desc;

    EventCode(int eventIdx, String desc){
        this.eventIdx = eventIdx;
        this.desc = desc;
    }
}
