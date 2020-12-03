package com.dalbit.content.service;


import com.dalbit.common.vo.ProcedureVo;
import com.dalbit.content.dao.Con_FullmoonDao;
import com.dalbit.content.vo.procedure.P_FullmoonConditionInputVo;
import com.dalbit.content.vo.procedure.P_FullmoonConditionOutputVo;
import com.dalbit.util.GsonUtil;
import com.google.gson.Gson;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;


@Slf4j
@Service
public class Con_FullmoonService {

    @Autowired
    GsonUtil gsonUtil;

    @Autowired
    Con_FullmoonDao con_fullmoonDao;

    public String callFullmoonManagementSelect(P_FullmoonConditionInputVo pFullmoonConditionInputVo) {
        ProcedureVo procedureVo = new ProcedureVo(pFullmoonConditionInputVo);
        con_fullmoonDao.callFullmoonManagementSelect(procedureVo);
        P_FullmoonConditionOutputVo outputVo = new Gson().fromJson(procedureVo.getExt(), P_FullmoonConditionOutputVo.class);
        log.debug(outputVo.toString());
        /* dj */
        if(pFullmoonConditionInputVo.getSlctType() == 1) {
        }
        /* 혜택 */
        else if(pFullmoonConditionInputVo.getSlctType() == 2) {
        }

        /* 청취자 */
        else if(pFullmoonConditionInputVo.getSlctType() == 3) {
        }

        log.debug("ddd");

        return "";
    }
}
