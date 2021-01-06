package com.dalbit.enter.service;


import com.dalbit.common.code.Status;
import com.dalbit.common.vo.JsonOutputVo;
import com.dalbit.common.vo.ProcedureVo;
import com.dalbit.enter.dao.Ent_PayDao;
import com.dalbit.enter.vo.procedure.*;
import com.dalbit.util.DalbitUtil;
import com.dalbit.util.GsonUtil;
import com.dalbit.util.MessageUtil;
import com.google.gson.Gson;
import lombok.extern.slf4j.Slf4j;
import lombok.var;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

@Slf4j
@Service
public class Ent_PayService {

    @Autowired
    MessageUtil messageUtil;
    @Autowired
    GsonUtil gsonUtil;
    @Autowired
    Ent_PayDao ent_PayDao;

    /**
     * 결제/환불 고정
     * @return
     */
    public String callPayInfo(P_StatVo pStatVo){
        ProcedureVo procedureVo = new ProcedureVo(pStatVo);
        ent_PayDao.callPayInfo(procedureVo);

        P_PayInfoOutVo info = new Gson().fromJson(procedureVo.getExt(), P_PayInfoOutVo.class);
        var result = new HashMap<String, Object>();

        pStatVo.setStartDate(pStatVo.getStartDate().replaceAll("\\.",""));
        if(DalbitUtil.isEmpty(pStatVo.getEndDate())){
            pStatVo.setEndDate(pStatVo.getStartDate());
        }else {
            pStatVo.setEndDate(pStatVo.getEndDate().replaceAll("\\.", ""));
        }

        P_PayInfoOutVo outVo = ent_PayDao.callPayCancelInfo(pStatVo);
        if(!DalbitUtil.isEmpty(outVo)) {
            info.setCancelCnt(outVo.getCancelCnt());
            info.setCancelAmt(outVo.getCancelAmt());
        }
        result.put("info", info);

        return gsonUtil.toJson(new JsonOutputVo(Status.조회, result));
    }

    /**
     * 결제/취소현황 총계
     * @param pPayTotalInPutVo
     * @return
     */
    public String callPayTotal(P_PayTotalInPutVo pPayTotalInPutVo){

        ArrayList resultList = new ArrayList();
        String[] dateList = pPayTotalInPutVo.getDateList().split("@");

        int slctType_date = 0;
        P_PayTotalOutDetailVo[] sum = null;
        if(pPayTotalInPutVo.getSlctType() == 0) {
            sum = new P_PayTotalOutDetailVo[24];
            slctType_date = 24;
        }else if(pPayTotalInPutVo.getSlctType() == 1) {
            sum = new P_PayTotalOutDetailVo[32];
            slctType_date = 32;
        }else if(pPayTotalInPutVo.getSlctType() == 2) {
            sum = new P_PayTotalOutDetailVo[13];
            slctType_date = 13;
        }
        P_PayTotalOutVo sum_Total = new P_PayTotalOutVo();

        for(int i=0;i<dateList.length;i++){
            if(dateList[i].indexOf("-") > -1){
                pPayTotalInPutVo.setStartDate(dateList[i].split("-")[0]);
                pPayTotalInPutVo.setEndDate(dateList[i].split("-")[1]);
            }else{
                pPayTotalInPutVo.setStartDate(dateList[i]);
                pPayTotalInPutVo.setEndDate(null);
            }

            ProcedureVo procedureVo = new ProcedureVo(pPayTotalInPutVo);
            List<P_PayTotalOutDetailVo> detailList =  ent_PayDao.callPayTotal(procedureVo);
            P_PayTotalOutVo totalInfo = new Gson().fromJson(procedureVo.getExt(), P_PayTotalOutVo.class);

            boolean zeroSw = false;
            if(detailList.size() < slctType_date){
                int detailList_size = detailList.size();
                for (int j = 0; j < slctType_date; j++) {
                    P_PayTotalOutDetailVo outVo = new P_PayTotalOutDetailVo();
                    for (int k = 0; k < detailList_size; k++){
                        if(pPayTotalInPutVo.getSlctType() == 0) {
                            if (detailList.get(k).getHour() == j) {
                                zeroSw = true;
                                break;
                            }
                        }else if(pPayTotalInPutVo.getSlctType() == 1) {
                            if (Integer.parseInt(detailList.get(k).getDaily().split("-")[2]) == j) {
                                detailList.get(k).setDay(j);
                                zeroSw = true;
                                break;
                            }
                        }else if(pPayTotalInPutVo.getSlctType() == 2) {
                            if (detailList.get(k).getMonthly() == j) {
                                detailList.get(k).setDay(j);
                                zeroSw = true;
                                break;
                            }
                        }
                    }
                    if(!zeroSw){
                        outVo.setDay(j);
                        outVo.setHour(j);
                        outVo.setMonthly(j);
                        outVo.setSuccCnt(0);
                        outVo.setSuccAmt(0);
                        outVo.setSuccCmt(0);
                        outVo.setAccumAmt(0);
                        outVo.setCancCnt(0);
                        outVo.setCancCmt(0);
                        outVo.setCancAmt(0);
                        outVo.setFailCnt(0);

                        detailList.add(outVo);
                    }
                }
            }

            var result = new HashMap<String, Object>();
            result.put("totalInfo", totalInfo);
            result.put("detailList", detailList);

            resultList.add(result);

            for(int j=0; j < detailList.size();j++){
                if(DalbitUtil.isEmpty(sum[j])){
                    sum[j] = new P_PayTotalOutDetailVo();
                }
                if(pPayTotalInPutVo.getSlctType() == 0) {
                    sum[j].setHour(j);
                    sum[j].setDay(j);
                    sum[j].setSuccCnt(sum[j].getSuccCnt() + detailList.get(j).getSuccCnt());
                    sum[j].setSuccCmt(sum[j].getSuccCmt() + detailList.get(j).getSuccCmt());
                    sum[j].setSuccAmt(sum[j].getSuccAmt() + detailList.get(j).getSuccAmt());
                    sum[j].setAccumAmt(sum[j].getAccumAmt() + detailList.get(j).getAccumAmt());
                    sum[j].setCancCnt(sum[j].getCancCnt() + detailList.get(j).getCancCnt());
                    sum[j].setCancCmt(sum[j].getCancCmt() + detailList.get(j).getCancCmt());
                    sum[j].setCancAmt(sum[j].getCancAmt() + detailList.get(j).getCancAmt());
                    sum[j].setFailCnt(sum[j].getFailCnt() + detailList.get(j).getFailCnt());
                }else if(pPayTotalInPutVo.getSlctType() == 1) {
                    zeroSw = false;
                    int tmp_k = 0;
                    for (int k = 0; k < 32; k++) {
                        if(DalbitUtil.isEmpty(sum[k])){
                            sum[k] = new P_PayTotalOutDetailVo();
                            sum[k].setHour(k);
                            sum[k].setDay(k);
                        }
                        if(!DalbitUtil.isEmpty(detailList.get(j).getDaily())) {
                            if (Integer.parseInt(detailList.get(j).getDaily().split("-")[2]) == k) {
                                tmp_k = k;
                                zeroSw = true;
                                break;
                            }
                        }else{
                            break;
                        }
                    }
                    if(zeroSw) {
                        sum[tmp_k].setSuccCnt(sum[tmp_k].getSuccCnt() + detailList.get(j).getSuccCnt());
                        sum[tmp_k].setSuccCmt(sum[tmp_k].getSuccCmt() + detailList.get(j).getSuccCmt());
                        sum[tmp_k].setSuccAmt(sum[tmp_k].getSuccAmt() + detailList.get(j).getSuccAmt());
                        sum[tmp_k].setAccumAmt(sum[tmp_k].getAccumAmt() + detailList.get(j).getAccumAmt());
                        sum[tmp_k].setCancCnt(sum[tmp_k].getCancCnt() + detailList.get(j).getCancCnt());
                        sum[tmp_k].setCancCmt(sum[tmp_k].getCancCmt() + detailList.get(j).getCancCmt());
                        sum[tmp_k].setCancAmt(sum[tmp_k].getCancAmt() + detailList.get(j).getCancAmt());
                        sum[tmp_k].setFailCnt(sum[tmp_k].getFailCnt() + detailList.get(j).getFailCnt());
                    }
                }else if(pPayTotalInPutVo.getSlctType() == 2) {
                    zeroSw = false;
                    for (int k = 1; k < 13; k++) {
                        if(!DalbitUtil.isEmpty(detailList.get(j).getMonthly())) {
                            if (detailList.get(j).getMonthly() == k) {
                                zeroSw = true;
                                break;
                            }
                        }else{
                            break;
                        }
                    }
                    if(zeroSw) {
                        sum[j].setHour(j);
                        sum[j].setDay(j);
                        sum[j].setMonthly(j);
                        sum[j].setSuccCnt(sum[j].getSuccCnt() + detailList.get(j).getSuccCnt());
                        sum[j].setSuccCmt(sum[j].getSuccCmt() + detailList.get(j).getSuccCmt());
                        sum[j].setSuccAmt(sum[j].getSuccAmt() + detailList.get(j).getSuccAmt());
                        sum[j].setAccumAmt(sum[j].getAccumAmt() + detailList.get(j).getAccumAmt());
                        sum[j].setCancCnt(sum[j].getCancCnt() + detailList.get(j).getCancCnt());
                        sum[j].setCancCmt(sum[j].getCancCmt() + detailList.get(j).getCancCmt());
                        sum[j].setCancAmt(sum[j].getCancAmt() + detailList.get(j).getCancAmt());
                        sum[j].setFailCnt(sum[j].getFailCnt() + detailList.get(j).getFailCnt());
                    }else{
                        sum[j].setHour(j);
                        sum[j].setDay(j);
                        sum[j].setMonthly(j);
                        sum[j].setSuccCnt(0);
                        sum[j].setSuccCmt(0);
                        sum[j].setSuccAmt(0);
                        sum[j].setAccumAmt(0);
                        sum[j].setCancCnt(0);
                        sum[j].setCancCmt(0);
                        sum[j].setCancAmt(0);
                        sum[j].setFailCnt(0);
                    }
                }
            }

            sum_Total.setSum_succCnt(sum_Total.getSum_succCnt() + totalInfo.getSum_succCnt());
            sum_Total.setSum_succCmt(sum_Total.getSum_succCmt() + totalInfo.getSum_succCmt());
            sum_Total.setSum_succAmt(sum_Total.getSum_succAmt() + totalInfo.getSum_succAmt());
            sum_Total.setSum_firstCnt(sum_Total.getSum_firstCnt() + totalInfo.getSum_firstCnt());
            sum_Total.setSum_firstCmt(sum_Total.getSum_firstCmt() + totalInfo.getSum_firstCmt());
            sum_Total.setSum_firstAmt(sum_Total.getSum_firstAmt() + totalInfo.getSum_firstAmt());
            sum_Total.setSum_reCnt(sum_Total.getSum_reCnt() + totalInfo.getSum_reCnt());
            sum_Total.setSum_reCmt(sum_Total.getSum_reCmt() + totalInfo.getSum_reCmt());
            sum_Total.setSum_reAmt(sum_Total.getSum_reAmt() + totalInfo.getSum_reAmt());
            sum_Total.setSum_cancCnt(sum_Total.getSum_cancCnt() + totalInfo.getSum_cancCnt());
            sum_Total.setSum_cancCmt(sum_Total.getSum_cancCmt() + totalInfo.getSum_cancCmt());
            sum_Total.setSum_cancAmt(sum_Total.getSum_cancAmt() + totalInfo.getSum_cancAmt());
            sum_Total.setSum_failCnt(sum_Total.getSum_failCnt() + totalInfo.getSum_failCnt());
        }
        var result = new HashMap<String, Object>();
        result.put("totalInfo", sum_Total);
        result.put("detailList", sum);
        resultList.add(result);

        return gsonUtil.toJson(new JsonOutputVo(Status.조회, resultList));
    }

    /**
     * 결제/취소현황 연령별
     * @param pStatVo
     * @return
     */
    public String callPayAge(P_StatVo pStatVo){
        ProcedureVo procedureVo = new ProcedureVo(pStatVo);
        List<P_PayAgeOutDetailVo> detailList =  ent_PayDao.callPayAge(procedureVo);
        P_PayAgeOutVo totalInfo = new Gson().fromJson(procedureVo.getExt(), P_PayAgeOutVo.class);
        if(Integer.parseInt(procedureVo.getRet()) <= 0){
            return gsonUtil.toJson(new JsonOutputVo(Status.데이터없음));
        }
        var result = new HashMap<String, Object>();
        result.put("totalInfo", totalInfo);
        result.put("detailList", detailList);

        return gsonUtil.toJson(new JsonOutputVo(Status.조회, result));
    }

    /**
     * 결제/취소현황 수단별
     * @param pStatVo
     * @return
     */
    public String callPayWay(P_StatVo pStatVo){
        ProcedureVo procedureVo = new ProcedureVo(pStatVo);
        List<P_PayWayOutDetailVo> detailList =  ent_PayDao.callPayWay(procedureVo);
        P_PayWayOutVo totalInfo = new Gson().fromJson(procedureVo.getExt(), P_PayWayOutVo.class);
        if(Integer.parseInt(procedureVo.getRet()) <= 0){
            return gsonUtil.toJson(new JsonOutputVo(Status.데이터없음));
        }
        var result = new HashMap<String, Object>();
        result.put("totalInfo", totalInfo);
        result.put("detailList", detailList);

        return gsonUtil.toJson(new JsonOutputVo(Status.조회, result));
    }

    /**
     * 결제/취소현황 결제상품별
     * @param pStatVo
     * @return
     */
    public String callPayCode(P_StatVo pStatVo){
        ProcedureVo procedureVo = new ProcedureVo(pStatVo);
        List<P_PayCodeOutDetailVo> detailList =  ent_PayDao.callPayCode(procedureVo);
        P_PayCodeOutVo totalInfo = new Gson().fromJson(procedureVo.getExt(), P_PayCodeOutVo.class);
        if(Integer.parseInt(procedureVo.getRet()) <= 0){
            return gsonUtil.toJson(new JsonOutputVo(Status.데이터없음));
        }
        var result = new HashMap<String, Object>();
        result.put("totalInfo", totalInfo);
        result.put("detailList", detailList);

        return gsonUtil.toJson(new JsonOutputVo(Status.조회, result));
    }

    /**
     * 결제/취소현황 취소
     * @param pStatVo
     * @return
     */
    public String callPayCancel(P_StatVo pStatVo){
        ProcedureVo procedureVo = new ProcedureVo(pStatVo);
        List<P_PayCancelOutDetailVo> detailList =  ent_PayDao.callPayCancel(procedureVo);
        P_PayCancelOutVo totalInfo = new Gson().fromJson(procedureVo.getExt(), P_PayCancelOutVo.class);
        if(Integer.parseInt(procedureVo.getRet()) <= 0){
            return gsonUtil.toJson(new JsonOutputVo(Status.데이터없음));
        }
        var result = new HashMap<String, Object>();
        result.put("totalInfo", totalInfo);
        result.put("detailList", detailList);

        return gsonUtil.toJson(new JsonOutputVo(Status.조회, result));
    }

    /**
     * 결제/취소현황 총계
     * @param pPayTryInPutVo
     * @return
     */
    public String callPayTry(P_PayTryInPutVo pPayTryInPutVo){

        ArrayList resultList = new ArrayList();
        String[] dateList = pPayTryInPutVo.getDateList().split("@");

        int slctType_date = 0;
        P_PayTryOutDetailVo[] sum = null;
        if(pPayTryInPutVo.getSlctType() == 0) {
            sum = new P_PayTryOutDetailVo[24];
            slctType_date = 24;
        }else if(pPayTryInPutVo.getSlctType() == 1) {
            sum = new P_PayTryOutDetailVo[32];
            slctType_date = 32;
        }else if(pPayTryInPutVo.getSlctType() == 2) {
            sum = new P_PayTryOutDetailVo[13];
            slctType_date = 13;
        }
        P_PayTryOutVo sum_Total = new P_PayTryOutVo();

        for(int i=0;i<dateList.length;i++){
            if(dateList[i].indexOf("-") > -1){
                pPayTryInPutVo.setStartDate(dateList[i].split("-")[0]);
                pPayTryInPutVo.setEndDate(dateList[i].split("-")[1]);
            }else{
                pPayTryInPutVo.setStartDate(dateList[i]);
                pPayTryInPutVo.setEndDate(null);
            }

            ProcedureVo procedureVo = new ProcedureVo(pPayTryInPutVo);
            List<P_PayTryOutDetailVo> detailList =  ent_PayDao.callPayTry(procedureVo);
            P_PayTryOutVo totalInfo = new Gson().fromJson(procedureVo.getExt(), P_PayTryOutVo.class);

            boolean zeroSw = false;
            if(detailList.size() < slctType_date){
                int detailList_size = detailList.size();
                for (int j = 0; j < slctType_date; j++) {
                    P_PayTryOutDetailVo outVo = new P_PayTryOutDetailVo();
                    for (int k = 0; k < detailList_size; k++){
                        if(pPayTryInPutVo.getSlctType() == 0) {
                            if (detailList.get(k).getHour() == j) {
                                zeroSw = true;
                                break;
                            }
                        }else if(pPayTryInPutVo.getSlctType() == 1) {
                            if (Integer.parseInt(detailList.get(k).getDaily().split("-")[2]) == j) {
                                detailList.get(k).setDay(j);
                                zeroSw = true;
                                break;
                            }
                        }else if(pPayTryInPutVo.getSlctType() == 2) {
                            if (detailList.get(k).getMonthly() == j) {
                                detailList.get(k).setDay(j);
                                zeroSw = true;
                                break;
                            }
                        }
                    }
                    if(!zeroSw){
                        outVo.setDay(j);
                        outVo.setHour(j);
                        outVo.setMonthly(j);
                        outVo.setSuccCnt(0);
                        outVo.setTryCnt(0);
                        outVo.setSuccRate(0);

                        detailList.add(outVo);
                    }
                }
            }

            for(int j=0; j < detailList.size();j++){
                if(DalbitUtil.isEmpty(sum[j])){
                    sum[j] = new P_PayTryOutDetailVo();
                }
                if(pPayTryInPutVo.getSlctType() == 0) {
                    sum[j].setHour(j);
                    sum[j].setDay(j);
                    sum[j].setSuccCnt(sum[j].getSuccCnt() + detailList.get(j).getSuccCnt());
                    sum[j].setTryCnt(sum[j].getTryCnt() + detailList.get(j).getTryCnt());
                    sum[j].setSuccRate((sum[j].getSuccRate() + detailList.get(j).getSuccRate()));
                }else if(pPayTryInPutVo.getSlctType() == 1) {
                    zeroSw = false;
                    int tmp_k = 0;
                    for (int k = 0; k < 32; k++) {
                        if(!DalbitUtil.isEmpty(detailList.get(j).getDaily())) {
                            if (Integer.parseInt(detailList.get(j).getDaily().split("-")[2]) == k) {
                                tmp_k = k;
                                zeroSw = true;
                                break;
                            }
                        }else{
                            break;
                        }
                    }
                    if(zeroSw) {
                        sum[tmp_k].setHour(tmp_k);
                        sum[tmp_k].setDay(tmp_k);
                        sum[tmp_k].setSuccCnt(sum[tmp_k].getSuccCnt() + detailList.get(j).getSuccCnt());
                        sum[tmp_k].setTryCnt(sum[tmp_k].getTryCnt() + detailList.get(j).getTryCnt());
                        sum[tmp_k].setSuccRate((sum[tmp_k].getSuccRate() + detailList.get(j).getSuccRate()));
                    }else{
                        sum[j].setHour(j);
                        sum[j].setDay(j);
                        sum[j].setSuccCnt(0);
                        sum[j].setTryCnt(0);
                        sum[j].setSuccRate(0);
                    }
                }else if(pPayTryInPutVo.getSlctType() == 2) {
                    zeroSw = false;
                    int tmp_k = 0;
                    for (int k = 0; k < 32; k++) {
                        if(!DalbitUtil.isEmpty(detailList.get(j).getMonthly())) {
                            if (detailList.get(j).getMonthly() == k) {
                                tmp_k = k;
                                zeroSw = true;
                                break;
                            }
                        }else{
                            break;
                        }
                    }
                    if(zeroSw) {
                        sum[tmp_k].setHour(tmp_k);
                        sum[tmp_k].setDay(tmp_k);
                        sum[tmp_k].setMonthly(tmp_k);
                        sum[tmp_k].setSuccCnt(sum[tmp_k].getSuccCnt() + detailList.get(j).getSuccCnt());
                        sum[tmp_k].setTryCnt(sum[tmp_k].getTryCnt() + detailList.get(j).getTryCnt());
                        sum[tmp_k].setSuccRate((sum[tmp_k].getSuccRate() + detailList.get(j).getSuccRate()));
                    }else{
                        sum[j].setHour(j);
                        sum[j].setDay(j);
                        sum[j].setMonthly(j);
                        sum[j].setSuccCnt(0);
                        sum[j].setTryCnt(0);
                        sum[j].setSuccRate(0);
                    }
                }
            }

            sum_Total.setSum_succCnt(sum_Total.getSum_succCnt() + totalInfo.getSum_succCnt());
            sum_Total.setSum_tryCnt(sum_Total.getSum_tryCnt() + totalInfo.getSum_tryCnt());
            sum_Total.setSum_succRate(sum_Total.getSum_succRate() + totalInfo.getSum_succRate());

            var result = new HashMap<String, Object>();
            result.put("totalInfo", totalInfo);
            result.put("detailList", detailList);

            resultList.add(result);
        }
        var result = new HashMap<String, Object>();
        result.put("totalInfo", sum_Total);
        result.put("detailList", sum);
        resultList.add(result);

        return gsonUtil.toJson(new JsonOutputVo(Status.조회, resultList));
    }

    /**
     * 월간/결제 수단 별 총계
     * @param pPayTotalWayInPutVo
     * @return
     */
    public String callPayMonthWay(P_PayTotalWayInPutVo pPayTotalWayInPutVo){

        ArrayList resultList = new ArrayList();
        String[] dateList = pPayTotalWayInPutVo.getDateList().split("@");

        int slctType_date = 0;
        P_PayTotalOutDetailVo[] sum = null;

        if(pPayTotalWayInPutVo.getSlctType() == 1) {
            sum = new P_PayTotalOutDetailVo[32];
            slctType_date = 32;
        }
        P_PayTotalOutVo sum_Total = new P_PayTotalOutVo();
        for(int i=0;i<dateList.length;i++){
            if(dateList[i].indexOf("-") > -1){
                pPayTotalWayInPutVo.setStartDate(dateList[i].split("-")[0]);
                pPayTotalWayInPutVo.setEndDate(dateList[i].split("-")[1]);
            }else{
                pPayTotalWayInPutVo.setStartDate(dateList[i]);
                pPayTotalWayInPutVo.setEndDate(null);
            }

            ProcedureVo procedureVo = new ProcedureVo(pPayTotalWayInPutVo);
            List<P_PayTotalOutDetailVo> detailList =  ent_PayDao.callPayMonthWay(procedureVo);
            P_PayTotalOutVo totalInfo = new P_PayTotalOutVo();
            if(pPayTotalWayInPutVo.getPaywayType().equals("all")) {
                totalInfo = new Gson().fromJson(procedureVo.getExt(), P_PayTotalOutVo.class);
            }

            boolean zeroSw = false;
            if(detailList.size() < slctType_date){
                int detailList_size = detailList.size();
                for (int j = 0; j < slctType_date; j++) {
                    P_PayTotalOutDetailVo outVo = new P_PayTotalOutDetailVo();
                    for (int k = 0; k < detailList_size; k++){
                        if(pPayTotalWayInPutVo.getSlctType() == 1) {
                            if (Integer.parseInt(detailList.get(k).getDaily().split("-")[2]) == j) {
                                detailList.get(k).setDay(j);
                                if(!pPayTotalWayInPutVo.getPaywayType().equals("all")) {
                                    totalInfo.setSum_succCnt(totalInfo.getSum_succCnt() + detailList.get(k).getSuccCnt());
                                    totalInfo.setSum_succCmt(totalInfo.getSum_succCmt() + detailList.get(k).getSuccCmt());
                                    totalInfo.setSum_succAmt(totalInfo.getSum_succAmt() + detailList.get(k).getSuccAmt());
                                }
                                zeroSw = true;
                                break;
                            }
                        }
                    }
                    if(!zeroSw){
                        outVo.setDay(j);
                        outVo.setHour(j);
                        outVo.setMonthly(j);
                        outVo.setSuccCnt(0);
                        outVo.setSuccAmt(0);
                        outVo.setSuccCmt(0);
                        outVo.setAccumAmt(0);
                        outVo.setCancCnt(0);
                        outVo.setCancCmt(0);
                        outVo.setCancAmt(0);
                        outVo.setFailCnt(0);

                        detailList.add(outVo);
                    }
                }
            }

            var result = new HashMap<String, Object>();
            result.put("totalInfo", totalInfo);
            result.put("detailList", detailList);

            resultList.add(result);

            for(int j=0; j < detailList.size();j++){
                if(DalbitUtil.isEmpty(sum[j])){
                    sum[j] = new P_PayTotalOutDetailVo();
                }
                if(pPayTotalWayInPutVo.getSlctType() == 1) {
                    zeroSw = false;
                    int tmp_k = 0;
                    for (int k = 0; k < 32; k++) {
                        if(DalbitUtil.isEmpty(sum[k])){
                            sum[k] = new P_PayTotalOutDetailVo();
                            sum[k].setHour(k);
                            sum[k].setDay(k);
                        }
                        if(!DalbitUtil.isEmpty(detailList.get(j).getDaily())) {
                            if (Integer.parseInt(detailList.get(j).getDaily().split("-")[2]) == k) {
                                tmp_k = k;
                                zeroSw = true;
                                break;
                            }
                        }else{
                            break;
                        }
                    }
                    if(zeroSw) {
                        sum[tmp_k].setSuccCnt(sum[tmp_k].getSuccCnt() + detailList.get(j).getSuccCnt());
                        sum[tmp_k].setSuccCmt(sum[tmp_k].getSuccCmt() + detailList.get(j).getSuccCmt());
                        sum[tmp_k].setSuccAmt(sum[tmp_k].getSuccAmt() + detailList.get(j).getSuccAmt());
                        sum[tmp_k].setAccumAmt(sum[tmp_k].getAccumAmt() + detailList.get(j).getAccumAmt());
                        sum[tmp_k].setCancCnt(sum[tmp_k].getCancCnt() + detailList.get(j).getCancCnt());
                        sum[tmp_k].setCancCmt(sum[tmp_k].getCancCmt() + detailList.get(j).getCancCmt());
                        sum[tmp_k].setCancAmt(sum[tmp_k].getCancAmt() + detailList.get(j).getCancAmt());
                        sum[tmp_k].setFailCnt(sum[tmp_k].getFailCnt() + detailList.get(j).getFailCnt());
                    }
                }
            }

            sum_Total.setSum_succCnt(sum_Total.getSum_succCnt() + totalInfo.getSum_succCnt());
            sum_Total.setSum_succCmt(sum_Total.getSum_succCmt() + totalInfo.getSum_succCmt());
            sum_Total.setSum_succAmt(sum_Total.getSum_succAmt() + totalInfo.getSum_succAmt());
            sum_Total.setSum_firstCnt(sum_Total.getSum_firstCnt() + totalInfo.getSum_firstCnt());
            sum_Total.setSum_firstCmt(sum_Total.getSum_firstCmt() + totalInfo.getSum_firstCmt());
            sum_Total.setSum_firstAmt(sum_Total.getSum_firstAmt() + totalInfo.getSum_firstAmt());
            sum_Total.setSum_reCnt(sum_Total.getSum_reCnt() + totalInfo.getSum_reCnt());
            sum_Total.setSum_reCmt(sum_Total.getSum_reCmt() + totalInfo.getSum_reCmt());
            sum_Total.setSum_reAmt(sum_Total.getSum_reAmt() + totalInfo.getSum_reAmt());
            sum_Total.setSum_cancCnt(sum_Total.getSum_cancCnt() + totalInfo.getSum_cancCnt());
            sum_Total.setSum_cancCmt(sum_Total.getSum_cancCmt() + totalInfo.getSum_cancCmt());
            sum_Total.setSum_cancAmt(sum_Total.getSum_cancAmt() + totalInfo.getSum_cancAmt());
            sum_Total.setSum_failCnt(sum_Total.getSum_failCnt() + totalInfo.getSum_failCnt());
        }
        var result = new HashMap<String, Object>();
        result.put("totalInfo", sum_Total);
        result.put("detailList", sum);
        resultList.add(result);

        return gsonUtil.toJson(new JsonOutputVo(Status.조회, resultList));
    }
}
