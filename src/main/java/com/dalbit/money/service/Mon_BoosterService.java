package com.dalbit.money.service;

import com.dalbit.common.code.Status;
import com.dalbit.common.vo.JsonOutputVo;
import com.dalbit.common.vo.ProcedureVo;
import com.dalbit.money.dao.Mon_BoosterDao;
import com.dalbit.money.vo.procedure.*;
import com.dalbit.util.GsonUtil;
import com.google.gson.Gson;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.HashMap;

@Slf4j
@Service
public class Mon_BoosterService {

    @Autowired
    Mon_BoosterDao monBoosterDao;

    @Autowired
    GsonUtil gsonUtil;

    public String callBoosterStat(P_memberBoostStatInputVo pMemberBoostItemInputVo){
        ProcedureVo procedureVo = new ProcedureVo(pMemberBoostItemInputVo);

        ArrayList<P_memberBoostStatOutputVo> statList = monBoosterDao.callBoosterStat(procedureVo);

        P_memberBoostStatOutputVo summary = new Gson().fromJson(procedureVo.getExt(), P_memberBoostStatOutputVo.class);

        HashMap resultMap = new HashMap();
        resultMap.put("summary", summary);
        resultMap.put("list", statList);

        return gsonUtil.toJson(new JsonOutputVo(Status.조회, resultMap));
    }

    public String callBoosterHistList(P_memberBoostHistListInputVo pMemberBoostHistListInputVo){
        ProcedureVo procedureVo = new ProcedureVo(pMemberBoostHistListInputVo);

        ArrayList<P_memberBoostHistListOutputVo> histList = monBoosterDao.callBoosterHistList(procedureVo);

        HashMap paging = new Gson().fromJson(procedureVo.getExt(), HashMap.class);

        HashMap resultMap = new HashMap();
        resultMap.put("list", histList);
        resultMap.put("paging", paging);

        return gsonUtil.toJson(new JsonOutputVo(Status.조회, resultMap));
    }

}
