package com.dalbit.status.controller.rest;

import com.dalbit.status.service.Sta_LevelService;
import com.dalbit.status.vo.procedure.P_LevelInputVo;
import com.dalbit.util.GsonUtil;
import com.dalbit.util.MessageUtil;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@Slf4j
@RestController
@RequestMapping("rest/status/level")
public class Sta_LevelRestController {

    @Autowired
    GsonUtil gsonUtil;

    @Autowired
    MessageUtil messageUtil;

    @Autowired
    Sta_LevelService sta_LevelService;

    /**
     * 회원 레벨별 목록
     */
    @PostMapping("list")
    public String list(P_LevelInputVo pLevelInputVo){
        return sta_LevelService.getMemberLevel(pLevelInputVo);

    }

    /**
     * 회원 레벨별 통계
     */
    @PostMapping("summary")
    public String summary(P_LevelInputVo pLevelInputVo){
        return sta_LevelService.getLevelSummary(pLevelInputVo);

    }

    /**
     * 회원 레벨 분포현황
     */
    @PostMapping("level")
    public String level(P_LevelInputVo pLevelInputVo){
        return sta_LevelService.getLevelList(pLevelInputVo);

    }
}
