package com.dalbit.content.service;


import com.dalbit.common.code.Status;
import com.dalbit.common.vo.JsonOutputVo;
import com.dalbit.common.vo.ProcedureVo;
import com.dalbit.content.dao.Con_FullmoonDao;
import com.dalbit.content.vo.procedure.P_FullmoonConditionVo;
import com.dalbit.content.vo.procedure.P_FullmoonTextVo;
import com.dalbit.util.GsonUtil;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;


@Slf4j
@Service
public class Con_FullmoonService {

    @Autowired
    GsonUtil gsonUtil;

    @Autowired
    Con_FullmoonDao con_fullmoonDao;

    public String callFullmoonManagementSelect(P_FullmoonConditionVo pFullmoonConditionVo) {
        ProcedureVo procedureVo = new ProcedureVo(pFullmoonConditionVo);
        ArrayList<P_FullmoonConditionVo> list = con_fullmoonDao.callFullmoonManagementSelect(procedureVo);
        return gsonUtil.toJson(new JsonOutputVo(Status.조회, list));
    }

    public String callFullmoonManagementEdit(P_FullmoonConditionVo pFullmoonConditionVo) {
        ProcedureVo procedureVo = new ProcedureVo(pFullmoonConditionVo);
        con_fullmoonDao.callFullmoonManagementEdit(procedureVo);
        return gsonUtil.toJson(new JsonOutputVo(Status.수정));
    }

    public String callFullmoonTextSelect(P_FullmoonTextVo pFullmoonTextVo) {
        ProcedureVo procedureVo = new ProcedureVo(pFullmoonTextVo);
        ArrayList<P_FullmoonTextVo> list = con_fullmoonDao.callFullmoonTextSelect(procedureVo);
        return gsonUtil.toJson(new JsonOutputVo(Status.조회, list));
    }

    public String callFullmoonTextEdit(P_FullmoonTextVo pFullmoonTextVo) {
        ProcedureVo procedureVo = new ProcedureVo(pFullmoonTextVo, true);
        con_fullmoonDao.callFullmoonTextEdit(procedureVo);
        return gsonUtil.toJson(new JsonOutputVo(Status.수정));
    }

}
