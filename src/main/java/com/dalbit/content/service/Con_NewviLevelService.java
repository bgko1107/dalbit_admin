package com.dalbit.content.service;

import com.dalbit.common.code.Status;
import com.dalbit.common.vo.JsonOutputVo;
import com.dalbit.common.vo.PagingVo;
import com.dalbit.common.vo.ProcedureVo;
import com.dalbit.content.dao.Con_NewviLevelDao;
import com.dalbit.content.vo.procedure.P_NewviLevelInputVo;
import com.dalbit.content.vo.procedure.P_NewviLevelListOutputVo;
import com.dalbit.util.GsonUtil;
import com.google.gson.Gson;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;

@Slf4j
@Service
public class Con_NewviLevelService {

    @Autowired
    Con_NewviLevelDao con_NewviLevelDao;

    @Autowired
    GsonUtil gsonUtil;


    /** 배너 아이템 리스트 */
    public String callDetailList(P_NewviLevelInputVo pNewviLevelInputVo) {
        ProcedureVo procedureVo = new ProcedureVo(pNewviLevelInputVo);
        ArrayList<P_NewviLevelListOutputVo> outList = con_NewviLevelDao.callDetailList(procedureVo);
        P_NewviLevelListOutputVo summary = new Gson().fromJson(procedureVo.getExt(), P_NewviLevelListOutputVo.class);

        String result;
        if(outList.size() > 0) {
            result = gsonUtil.toJson(new JsonOutputVo(Status.레벨보상대상조회_성공, outList, new PagingVo(procedureVo.getRet()), summary));
        }else {
            result = gsonUtil.toJson(new JsonOutputVo(Status.데이터없음));
        }

        return result;
    }

}
