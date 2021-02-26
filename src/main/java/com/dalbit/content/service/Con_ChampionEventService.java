package com.dalbit.content.service;

import com.dalbit.common.code.Status;
import com.dalbit.common.vo.JsonOutputVo;
import com.dalbit.common.vo.ProcedureVo;
import com.dalbit.content.dao.Con_ChampionEventDao;
import com.dalbit.util.GsonUtil;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.HashMap;

@Slf4j
@Service
public class Con_ChampionEventService {

    @Autowired
    Con_ChampionEventDao con_championEventDao;
    @Autowired
    GsonUtil gsonUtil;


    public String callChampionList(HashMap<String, Object> hashMap) {
        ProcedureVo procedureVo = new ProcedureVo(hashMap);
        ArrayList<HashMap> list = con_championEventDao.callChampionList(procedureVo);

        String result = gsonUtil.toJson(new JsonOutputVo(Status.조회, list));
        return result;
    }
}
