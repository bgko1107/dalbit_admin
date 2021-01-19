package com.dalbit.money.service;

import com.dalbit.common.code.Status;
import com.dalbit.common.service.SmsService;
import com.dalbit.common.vo.JsonOutputVo;
import com.dalbit.common.vo.ProcedureVo;
import com.dalbit.member.dao.Mem_MemberDao;
import com.dalbit.member.vo.procedure.P_MemberSetting;
import com.dalbit.money.dao.Mon_ItemDao;
import com.dalbit.money.vo.Mon_AutoChangeOutputVo;
import com.dalbit.money.vo.Mon_ItemInputVo;
import com.dalbit.money.vo.Mon_ItemOutputVo;
import com.dalbit.util.GsonUtil;
import com.google.gson.Gson;
import lombok.extern.slf4j.Slf4j;
import lombok.var;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.HashMap;

@Slf4j
@Service
public class Mon_ItemService {

    @Autowired
    Mon_ItemDao monItemDao;

    @Autowired
    GsonUtil gsonUtil;

    @Autowired
    SmsService smsService;
    @Autowired
    Mem_MemberDao mem_MemberDao;

    public String selectChangeItemList(Mon_ItemInputVo monItemInputVo){

        ProcedureVo procedureVo = new ProcedureVo(monItemInputVo);
        ArrayList<Mon_ItemOutputVo> listOutVo = monItemDao.callSelectChangeItemList(procedureVo);
        Mon_ItemOutputVo totalInfo = new Gson().fromJson(procedureVo.getExt(), Mon_ItemOutputVo.class);

        P_MemberSetting setting =  mem_MemberDao.getMemberSetting(monItemInputVo.getSearchText());

        var result = new HashMap<String, Object>();
        result.put("totalInfo", totalInfo);
        result.put("detailList", listOutVo);
        result.put("setting", setting);

        return gsonUtil.toJson(new JsonOutputVo(Status.조회, result));

    }

    public String selectAutoChangeItemList(Mon_ItemInputVo monItemInputVo){
        ProcedureVo procedureVo = new ProcedureVo(monItemInputVo);
        ArrayList<Mon_AutoChangeOutputVo> listOutVo = monItemDao.callSelectAutoChangeItemList(procedureVo);
        Mon_AutoChangeOutputVo totalInfo = new Gson().fromJson(procedureVo.getExt(), Mon_AutoChangeOutputVo.class);

        var result = new HashMap<String, Object>();
        result.put("totalInfo", totalInfo);
        result.put("detailList", listOutVo);

        return gsonUtil.toJson(new JsonOutputVo(Status.조회, result));
    }
}
