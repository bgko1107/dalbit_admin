package com.dalbit.common.vo;

import lombok.Getter;
import lombok.Setter;

/**
 * 검색 조건들을 모아놓은 VO
 */
@Getter
@Setter
public class SearchVo extends PagingVo {

    private Integer searchType;
    private String searchText;
    private Integer slctType;
    private Integer platform;
    private Integer gender;
    private Integer viewOn;
    private Integer sortSlct;
    private Integer sortPlat;
    private Integer sortGender;
    private Integer sortView;
    private Integer slctReason;
    private Integer search_adminId;

    private String posType;
    private String deptType;
    private Integer empNo;
    private Integer menuIdx;
}
