package com.dalbit.content.vo;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class SitebanVo{
    private String idx;
    private String ban_word;
    private String is_use;
    private String count;
    private int slctType;

    private String[] ban_words;
}
