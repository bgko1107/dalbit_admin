package com.dalbit.enter.service;

import com.dalbit.common.code.Status;
import com.dalbit.common.vo.JsonOutputVo;
import com.dalbit.common.vo.ProcedureVo;
import com.dalbit.enter.dao.Ent_NewJoin2Dao;
import com.dalbit.enter.vo.procedure.*;
import com.dalbit.util.GsonUtil;
import com.dalbit.util.MessageUtil;
import com.google.gson.Gson;
import lombok.extern.slf4j.Slf4j;
import lombok.var;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;

@Slf4j
@Service
public class Ent_NewJoin2Service {

    @Autowired
    MessageUtil messageUtil;
    @Autowired
    GsonUtil gsonUtil;
    @Autowired
    Ent_NewJoin2Dao ent_NewJoin2Dao;

    /**
     * 회원가입 총계
     * @param pStatVo
     * @return
     */
    public String callInfoDay(P_StatVo pStatVo){
        ProcedureVo procedureVo = new ProcedureVo(pStatVo);
        List<P_NewJoin2OutDetailVo> detailList =  ent_NewJoin2Dao.callInfoDay(procedureVo);

        P_NewJoin2OutDetailVo totalInfo = new Gson().fromJson(procedureVo.getExt(), P_NewJoin2OutDetailVo.class);

        if(Integer.parseInt(procedureVo.getRet()) <= 0){
            return gsonUtil.toJson(new JsonOutputVo(Status.데이터없음));
        }

        pStatVo.setStartDate(pStatVo.getBeforeStartDate());
        pStatVo.setEndDate(pStatVo.getBeforeEndDate());
        procedureVo = new ProcedureVo(pStatVo);
        List<P_NewJoin2OutDetailVo> detailList2 =  ent_NewJoin2Dao.callInfoDay(procedureVo);
        P_NewJoin2OutDetailVo totalInfo2 = new Gson().fromJson(procedureVo.getExt(), P_NewJoin2OutDetailVo.class);

        pStatVo.setStartDate(pStatVo.getTwoAgoStartDate());
        pStatVo.setEndDate(pStatVo.getTwoAgoEndDate());
        procedureVo = new ProcedureVo(pStatVo);
        List<P_NewJoin2OutDetailVo> detailList3 =  ent_NewJoin2Dao.callInfoDay(procedureVo);
        P_NewJoin2OutDetailVo totalInfo3 = new Gson().fromJson(procedureVo.getExt(), P_NewJoin2OutDetailVo.class);

        var result = new HashMap<String, Object>();
        result.put("totalInfo", totalInfo);
        result.put("detailList", detailList);
        result.put("totalInfo2", totalInfo2);
        result.put("detailList2", detailList2);
        result.put("totalInfo3", totalInfo3);
        result.put("detailList3", detailList3);

        return gsonUtil.toJson(new JsonOutputVo(Status.조회, result));
    }

}
