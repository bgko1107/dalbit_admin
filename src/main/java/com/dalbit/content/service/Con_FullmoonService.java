package com.dalbit.content.service;


import com.dalbit.common.vo.JsonOutputVo;
import com.dalbit.common.vo.ProcedureVo;
import com.dalbit.content.dao.Con_FullmoonDao;
import com.dalbit.content.vo.procedure.P_FullmoonConditionInputVo;
import com.dalbit.content.vo.procedure.P_FullmoonConditionOutputVo;
import com.dalbit.util.GsonUtil;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.dalbit.common.code.Status;

import java.util.ArrayList;
import java.util.HashMap;


@Slf4j
@Service
public class Con_FullmoonService {

    @Autowired
    GsonUtil gsonUtil;

    @Autowired
    Con_FullmoonDao con_fullmoonDao;

    public String callFullmoonManagementSelect(P_FullmoonConditionInputVo pFullmoonConditionInputVo) {
        ProcedureVo procedureVo = new ProcedureVo(pFullmoonConditionInputVo);
        ArrayList<P_FullmoonConditionOutputVo> list = con_fullmoonDao.callFullmoonManagementSelect(procedureVo);
        P_FullmoonConditionOutputVo outputVo = new P_FullmoonConditionOutputVo();
        HashMap resultMap = new HashMap();
        for(int i=0; i<list.size(); i++) {
            if(pFullmoonConditionInputVo.getType() == 1) {
                outputVo.setSlctType(list.get(i).getSlctType());
                outputVo.setTargetValue(list.get(i).getTargetValue());
                outputVo.setOpName(list.get(i).getOpName());
                outputVo.setEditDate(list.get(i).getEditDate());
                resultMap.put("dj", outputVo);
            } else if(pFullmoonConditionInputVo.getType() == 2) {
                outputVo.setSlctType(list.get(i).getSlctType());
                outputVo.setItemType(list.get(i).getItemType());
                outputVo.setItemCnt(list.get(i).getItemCnt());
                outputVo.setOpName(list.get(i).getOpName());
                outputVo.setEditDate(list.get(i).getEditDate());
                resultMap.put("prize", outputVo);
            } else {
                outputVo.setSlctType(list.get(i).getSlctType());
                outputVo.setMinValue(list.get(i).getMinValue());
                outputVo.setOpName(list.get(i).getOpName());
                outputVo.setEditDate(list.get(i).getEditDate());
                resultMap.put("listener", outputVo);
            }
        }

        return gsonUtil.toJson(new JsonOutputVo(Status.조회, resultMap));
    }
}
