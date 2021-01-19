package com.dalbit.enter.controller.rest;

import com.dalbit.enter.service.Ent_NewJoin2Service;
import com.dalbit.enter.vo.procedure.P_StatVo;
import com.dalbit.util.DalbitUtil;
import com.dalbit.util.GsonUtil;
import com.dalbit.util.MessageUtil;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@Slf4j
@RestController
@RequestMapping("rest/enter/newjoin2")
public class Ent_NewJoin2RestController {

    @Autowired
    GsonUtil gsonUtil;

    @Autowired
    MessageUtil messageUtil;

    @Autowired
    Ent_NewJoin2Service ent_NewJoin2Service;

    @PostMapping("/info/state")
    public String state(P_StatVo pStatVo){
        if(DalbitUtil.isEmpty(pStatVo.getStartDate())){
            pStatVo.setStartDate(null);
        }

        if(DalbitUtil.isEmpty(pStatVo.getEndDate())){
            pStatVo.setEndDate(null);
        }

        String result = ent_NewJoin2Service.callInfoDay(pStatVo);
        return result;
    }
}
