package com.dalbit.menu.controller.rest;

import com.dalbit.excel.service.ExcelService;
import com.dalbit.menu.service.Men_RecommService;
import com.dalbit.menu.vo.RecommVo;
import com.dalbit.util.GsonUtil;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@Slf4j
@RestController
@RequestMapping("rest/menu/recomm")
public class Men_RecommRestController {

    @Autowired
    GsonUtil gsonUtil;

    @Autowired
    Men_RecommService men_RecommService;

    @Autowired
    ExcelService excelService;

    /**
     * 추천 DJ 목록
     */
    @PostMapping("list")
    public String list(RecommVo recommVo){
        String result = men_RecommService.callRecommList(recommVo);
        return result;
    }


    /**
     * 추천 DJ 정보
     */
    @PostMapping("detail")
    public String detail(RecommVo recommVo){
        String result = men_RecommService.callRecommDetail(recommVo);
        return result;
    }
    /**
     * 추천 DJ 등록/수정
     */
    @PostMapping("edit")
    public String editRecomm(RecommVo recommVo){
        String result = men_RecommService.callEditRecomm(recommVo);
        return result;
    }

    /**
     * 추천 DJ 삭제
     */
    @PostMapping("delete")
    public String delete(RecommVo recommVo){
        String result = men_RecommService.callRecommDelete(recommVo);
        return result;
    }



}
