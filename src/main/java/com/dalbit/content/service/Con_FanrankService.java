package com.dalbit.content.service;

import com.dalbit.common.code.Status;
import com.dalbit.common.vo.JsonOutputVo;
import com.dalbit.common.vo.PagingVo;
import com.dalbit.common.vo.ProcedureVo;
import com.dalbit.content.dao.Con_FanrankDao;
import com.dalbit.exception.GlobalException;
import com.dalbit.util.DalbitUtil;
import com.dalbit.util.GsonUtil;
import com.dalbit.util.MessageUtil;
import com.google.gson.Gson;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.HashMap;

@Slf4j
@Service
public class Con_FanrankService {

    @Autowired
    Con_FanrankDao conFanrankDao;
    @Autowired
    MessageUtil messageUtil;
    @Autowired
    GsonUtil gsonUtil;

    public String callFanrankOnOffList(HashMap<String, Object> hashMap) throws GlobalException{
        HashMap paramMap = new HashMap();
        paramMap.put("mem_no", DalbitUtil.isNullToString(DalbitUtil.getStringMap(hashMap, "mem_no")));
        paramMap.put("checkDate", DalbitUtil.getStringMap(hashMap, "checkDate"));
        paramMap.put("slctType", DalbitUtil.getIntMap(hashMap, "slctType"));
        paramMap.put("pageNo", DalbitUtil.getIntMap(hashMap, "pageNo"));
        paramMap.put("pageCnt", DalbitUtil.getIntMap(hashMap, "pageCnt"));
        paramMap.put("state", DalbitUtil.getIntMap(hashMap, "state"));

        ProcedureVo procedureVo = new ProcedureVo(paramMap);
        String result;

        try {
            ArrayList<HashMap<String, Object>> onOffList = conFanrankDao.callFanrankOnOffList(procedureVo);

            if (Integer.parseInt(procedureVo.getRet()) > 0) {

                HashMap summary = new Gson().fromJson(procedureVo.getExt(), HashMap.class);

                result = gsonUtil.toJson(new JsonOutputVo(Status.조회, onOffList, new PagingVo(procedureVo.getRet()), summary));
            } else if (Status.데이터없음.getMessageCode().equals(procedureVo.getRet())) {
                result = gsonUtil.toJson(new JsonOutputVo(Status.데이터없음));
            } else if(Status.DB_비즈니스로직오류.getMessageCode().equals(procedureVo.getRet())){
                result = gsonUtil.toJson(new JsonOutputVo(Status.DB_비즈니스로직오류));
            }else{
                result = gsonUtil.toJson(new JsonOutputVo(Status.비즈니스로직오류));
            }
        } catch (Exception e) {
            result = gsonUtil.toJson(new JsonOutputVo(Status.비즈니스로직오류));
        }

        return result;

    }
}
