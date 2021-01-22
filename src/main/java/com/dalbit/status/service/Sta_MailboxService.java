package com.dalbit.status.service;


import com.dalbit.common.code.Status;
import com.dalbit.common.vo.JsonOutputVo;
import com.dalbit.common.vo.ProcedureVo;
import com.dalbit.status.dao.Sta_MailboxDao;
import com.dalbit.status.vo.procedure.P_MailboxVo;
import com.dalbit.status.vo.procedure.P_StatVo;
import com.dalbit.util.GsonUtil;
import com.dalbit.util.MessageUtil;
import com.google.gson.Gson;
import lombok.extern.slf4j.Slf4j;
import lombok.var;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.HashMap;

@Slf4j
@Service
public class Sta_MailboxService {

    @Autowired
    MessageUtil messageUtil;
    @Autowired
    GsonUtil gsonUtil;
    @Autowired
    Sta_MailboxDao sta_MailboxDao;

    /**
     * 1:1문의 총계
     */
    public String callMailboxTime(P_StatVo pStatVo){

        String[] dateList = pStatVo.getDateList().split("@");

        int slctType_date =0;
        if(pStatVo.getTimeType() == 0){
            slctType_date = 24;
        }else{
            slctType_date = 31;
        }

        ArrayList resultList = new ArrayList();
        for(int i=0;i<dateList.length;i++){
            if(dateList[i].indexOf("-") > -1){
                pStatVo.setStartDate(dateList[i].split("-")[0]);
                pStatVo.setEndDate(dateList[i].split("-")[1]);
            }else{
                pStatVo.setStartDate(dateList[i]);
                pStatVo.setEndDate(dateList[i]);
            }

            ProcedureVo procedureVo = new ProcedureVo(pStatVo);
            ArrayList<P_MailboxVo> detailList =  sta_MailboxDao.callMailboxTime(procedureVo);
            P_MailboxVo totalInfo = new Gson().fromJson(procedureVo.getExt(), P_MailboxVo.class);

            boolean zeroSw = false;
            if(detailList.size() < slctType_date){
                int detailList_size = detailList.size();
                for (int j = 0; j < slctType_date; j++) {
                    P_MailboxVo outVo = new P_MailboxVo();
                    for (int k = 0; k < detailList_size; k++){
                        if(pStatVo.getTimeType() == 0) {
                            if (detailList.get(k).getThe_hr() == j) {
                                zeroSw = true;
                                break;
                            }
                        }else if(pStatVo.getTimeType() == 1){
                            if (Integer.parseInt(detailList.get(k).getThe_date().substring(8)) == j) {
                                detailList.get(k).setThe_day(j);
                                zeroSw = true;
                                break;
                            }
                        }
                    }
                    if(!zeroSw){
                        if(pStatVo.getTimeType() == 0) {
                            outVo.setThe_hr(j);
                        }else if(pStatVo.getTimeType() == 1) {
                            outVo.setThe_day(j);
                        }
                        outVo.setMale_uniqueCnt(0);
                        outVo.setFemale_uniqueCnt(0);
                        outVo.setNone_uniqueCnt(0);
                        outVo.setTotal_uniqueCnt(0);
                        outVo.setTotal_createCnt(0);
                        outVo.setMsgCnt(0);
                        outVo.setImgCnt(0);
                        outVo.setGiftCnt(0);
                        outVo.setGiftDal(0);
                        outVo.setCnt00(0);
                        outVo.setCnt10(0);
                        outVo.setCnt20(0);
                        outVo.setCnt30(0);
                        outVo.setCnt40(0);
                        outVo.setCnt50(0);
                        outVo.setCnt60(0);
                        detailList.add(outVo);
                    }
                }
            }

            var result = new HashMap<String, Object>();
            result.put("totalInfo", totalInfo);
            result.put("detailList", detailList);

            resultList.add(result);

        }

        return gsonUtil.toJson(new JsonOutputVo(Status.조회, resultList));
    }


}
