package com.dalbit.enter.service;


import com.dalbit.common.code.Status;
import com.dalbit.common.vo.JsonOutputVo;
import com.dalbit.common.vo.ProcedureVo;
import com.dalbit.enter.dao.Ent_PayDao;
import com.dalbit.enter.vo.procedure.*;
import com.dalbit.excel.service.ExcelService;
import com.dalbit.excel.vo.ExcelVo;
import com.dalbit.util.DalbitUtil;
import com.dalbit.util.GsonUtil;
import com.dalbit.util.MessageUtil;
import com.google.gson.Gson;
import lombok.extern.slf4j.Slf4j;
import lombok.var;
import org.apache.poi.xssf.streaming.SXSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import java.util.*;

@Slf4j
@Service
public class Ent_PayService {

    @Autowired
    MessageUtil messageUtil;
    @Autowired
    GsonUtil gsonUtil;
    @Autowired
    Ent_PayDao ent_PayDao;

    @Autowired
    ExcelService excelService;

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

    // 수익인식 프로세스 ---------------------------------------------------------
    // 달 양식
    public String callDalForm(P_RevenueProcessVo pRevenueProcessVo){
        ProcedureVo procedureVo = new ProcedureVo(pRevenueProcessVo);
        List<P_RevenueProcessVo> detailList =  ent_PayDao.callDalForm(procedureVo);
        P_RevenueProcessVo totalInfo = new Gson().fromJson(procedureVo.getExt(), P_RevenueProcessVo.class);
        if(Integer.parseInt(procedureVo.getRet()) <= 0){
            return gsonUtil.toJson(new JsonOutputVo(Status.데이터없음));
        }
        var result = new HashMap<String, Object>();
        result.put("totalInfo", totalInfo);
        result.put("detailList", detailList);

        return gsonUtil.toJson(new JsonOutputVo(Status.조회, result));
    }

    // 달 수
    public String callDalCount(P_RevenueProcessVo pRevenueProcessVo){
        ProcedureVo procedureVo = new ProcedureVo(pRevenueProcessVo);
        List<P_RevenueProcessVo> detailList =  ent_PayDao.callDalCount(procedureVo);
        P_RevenueProcessVo totalInfo = new Gson().fromJson(procedureVo.getExt(), P_RevenueProcessVo.class);
        if(Integer.parseInt(procedureVo.getRet()) <= 0){
            return gsonUtil.toJson(new JsonOutputVo(Status.데이터없음));
        }
        var result = new HashMap<String, Object>();
        result.put("totalInfo", totalInfo);
        result.put("detailList", detailList);

        return gsonUtil.toJson(new JsonOutputVo(Status.조회, result));
    }

    // 달 금액
    public String callDalAmt(P_RevenueProcessVo pRevenueProcessVo){
        ProcedureVo procedureVo = new ProcedureVo(pRevenueProcessVo);
        List<P_RevenueProcessVo> detailList =  ent_PayDao.callDalAmt(procedureVo);
        P_RevenueProcessVo totalInfo = new Gson().fromJson(procedureVo.getExt(), P_RevenueProcessVo.class);
        if(Integer.parseInt(procedureVo.getRet()) <= 0){
            return gsonUtil.toJson(new JsonOutputVo(Status.데이터없음));
        }
        var result = new HashMap<String, Object>();
        result.put("totalInfo", totalInfo);
        result.put("detailList", detailList);

        return gsonUtil.toJson(new JsonOutputVo(Status.조회, result));
    }


    // 달 금액 엑셀 다운로드
    public Model callDalAmtListExcel(P_RevenueProcessVo pRevenueProcessVo, Model model) {
        pRevenueProcessVo.setPageCnt(100000);
        ProcedureVo procedureVo = new ProcedureVo(pRevenueProcessVo);

        List<P_RevenueProcessVo> list = ent_PayDao.callDalAmt(procedureVo);
        P_RevenueProcessVo totalInfo = new Gson().fromJson(procedureVo.getExt(), P_RevenueProcessVo.class);

        String[] headers = {"회원번호"
                            ,"닉네임"
                            ,"기초(유료)"
                            ,"기초(무료)"
                            ,"증가(전체합계)"
                            ,"증가-유료(합계)"
                            ,"증가-유료(PG사결제)"
                            ,"증가-유료(달전환)"
                            ,"증가-유료(선물하기)"
                            ,"증가-유료(관리자지급)"
                            ,"증가-무료(합계)"
                            ,"증가-무료(이벤트)"
                            ,"증가-무료(선물하기)"
                            ,"증가-무료(관리자지급)"
                            ,"감소(전체합계)"
                            ,"감소-유료(합계)"
                            ,"감소-유료(방송)"
                            ,"감소-유료(클립)"
                            ,"감소-유료(우체통)"
                            ,"감소-유료(선물하기)"
                            ,"감소-유료(환불)"
                            ,"감소-유료(회원탈퇴)"
                            ,"감소-유료(휴면탈퇴)"
                            ,"감소-유료(관리자회수)"
                            ,"감소-무료(합계)"
                            ,"감소-무료(방송)"
                            ,"감소-무료(클립)"
                            ,"감소-무료(우체통)"
                            ,"감소-무료(선물하기)"
                            ,"감소-무료(환불)"
                            ,"감소-무료(회원탈퇴)"
                            ,"감소-무료(휴면탈퇴)"
                            ,"감소-무료(관리자회수)"
                            ,"기말(유료)"
                            ,"기말(무료)"
        };
        int[] headerWidths = {3000, 3000, 3000, 3000, 3000, 3000, 3000, 3000, 3000, 3000
                                , 3000, 3000, 3000, 3000, 3000, 3000, 3000, 3000, 3000, 3000
                                , 3000, 3000, 3000, 3000, 3000, 3000, 3000, 3000, 3000, 3000
                                , 3000, 3000, 3000, 3000, 3000};

        List<Object[]> bodies = new ArrayList<>();
        if(!DalbitUtil.isEmpty(totalInfo)){
            HashMap hm = new LinkedHashMap();
            hm.put("mem1",  "합계");
            hm.put("mem2",  "");
            hm.put("mem3",  totalInfo.getOldPayDal());
            hm.put("mem4",  totalInfo.getOldFreeDal());
            hm.put("mem5",  totalInfo.getAddTotalDal());
            hm.put("mem6",  totalInfo.getAddPayTotal());
            hm.put("mem7",  totalInfo.getAddPayPg());
            hm.put("mem8",  totalInfo.getAddPayChange());
            hm.put("mem9",  totalInfo.getAddPayGift());
            hm.put("mem10",  totalInfo.getAddPayOp());
            hm.put("mem11",  totalInfo.getAddFreeTotal());
            hm.put("mem12",  totalInfo.getAddFreeEvent());
            hm.put("mem13",  totalInfo.getAddFreeGift());
            hm.put("mem14",  totalInfo.getAddFreeOp());
            hm.put("mem15",  totalInfo.getSubTotalDal());
            hm.put("mem16",  totalInfo.getSubPayTotal());
            hm.put("mem17",  totalInfo.getSubPayBroad());
            hm.put("mem18",  totalInfo.getSubPayClip());
            hm.put("mem19",  totalInfo.getSubPayMailbox());
            hm.put("mem20",  totalInfo.getSubPayGift());
            hm.put("mem21",  totalInfo.getSubPayCancel());
            hm.put("mem22",  totalInfo.getSubPayWithdrawal());
            hm.put("mem23",  totalInfo.getSubPayWithdrawalSleep());
            hm.put("mem24",  totalInfo.getSubPayOp());
            hm.put("mem25",  totalInfo.getSubFreeTotal());
            hm.put("mem26",  totalInfo.getSubFreeBroad());
            hm.put("mem27",  totalInfo.getSubFreeClip());
            hm.put("mem28",  totalInfo.getSubFreeMailbox());
            hm.put("mem29",  totalInfo.getSubFreeGift());
            hm.put("mem30",  totalInfo.getSubFreeCancel());
            hm.put("mem31",  totalInfo.getSubFreeWithdrawal());
            hm.put("mem32",  totalInfo.getSubFreeWithdrawlSleep());
            hm.put("mem33",  totalInfo.getSubFreeOp());
            hm.put("mem34",  totalInfo.getNewPayDal());
            hm.put("mem35",  totalInfo.getNewFreeDal());
            bodies.add(hm.values().toArray());
        }

        for(int i = 0; i < list.size(); i++){
            HashMap hm = new LinkedHashMap();
            hm.put("mem1",  list.get(i).getMem_no());
            hm.put("mem2",  list.get(i).getNickName());
            hm.put("mem3",  list.get(i).getOldPayDal());
            hm.put("mem4",  list.get(i).getOldFreeDal());
            hm.put("mem5",  list.get(i).getAddTotalDal());
            hm.put("mem6",  list.get(i).getAddPayTotal());
            hm.put("mem7",  list.get(i).getAddPayPg());
            hm.put("mem8",  list.get(i).getAddPayChange());
            hm.put("mem9",  list.get(i).getAddPayGift());
            hm.put("mem10",  list.get(i).getAddPayOp());
            hm.put("mem11",  list.get(i).getAddFreeTotal());
            hm.put("mem12",  list.get(i).getAddFreeEvent());
            hm.put("mem13",  list.get(i).getAddFreeGift());
            hm.put("mem14",  list.get(i).getAddFreeOp());
            hm.put("mem15",  list.get(i).getSubTotalDal());
            hm.put("mem16",  list.get(i).getSubPayTotal());
            hm.put("mem17",  list.get(i).getSubPayBroad());
            hm.put("mem18",  list.get(i).getSubPayClip());
            hm.put("mem19",  list.get(i).getSubPayMailbox());
            hm.put("mem20",  list.get(i).getSubPayGift());
            hm.put("mem21",  list.get(i).getSubPayCancel());
            hm.put("mem22",  list.get(i).getSubPayWithdrawal());
            hm.put("mem23",  list.get(i).getSubPayWithdrawalSleep());
            hm.put("mem24",  list.get(i).getSubPayOp());
            hm.put("mem25",  list.get(i).getSubFreeTotal());
            hm.put("mem26",  list.get(i).getSubFreeBroad());
            hm.put("mem27",  list.get(i).getSubFreeClip());
            hm.put("mem28",  list.get(i).getSubFreeMailbox());
            hm.put("mem29",  list.get(i).getSubFreeGift());
            hm.put("mem30",  list.get(i).getSubFreeCancel());
            hm.put("mem31",  list.get(i).getSubFreeWithdrawal());
            hm.put("mem32",  list.get(i).getSubFreeWithdrawlSleep());
            hm.put("mem33",  list.get(i).getSubFreeOp());
            hm.put("mem34",  list.get(i).getNewPayDal());
            hm.put("mem35",  list.get(i).getNewFreeDal());
            bodies.add(hm.values().toArray());
        }
        ExcelVo vo = new ExcelVo(headers, headerWidths, bodies);
        SXSSFWorkbook workbook = excelService.excelDownload("목록",vo);
        model.addAttribute("locale", Locale.KOREA);
        model.addAttribute("workbook", workbook);
        model.addAttribute("workbookName", "달빛Live_수익인식Process(달금액)_" + pRevenueProcessVo.getStartDate());

        return model;
    }

    // 별 수
    public String callByeolCount(P_RevenueProcessVo pRevenueProcessVo){
        ProcedureVo procedureVo = new ProcedureVo(pRevenueProcessVo);
        List<P_RevenueProcessVo> detailList =  ent_PayDao.callByeolCount(procedureVo);
        P_RevenueProcessVo totalInfo = new Gson().fromJson(procedureVo.getExt(), P_RevenueProcessVo.class);
        if(Integer.parseInt(procedureVo.getRet()) <= 0){
            return gsonUtil.toJson(new JsonOutputVo(Status.데이터없음));
        }
        var result = new HashMap<String, Object>();
        result.put("totalInfo", totalInfo);
        result.put("detailList", detailList);

        return gsonUtil.toJson(new JsonOutputVo(Status.조회, result));
    }

    // 별 금액
    public String callByeolAmt(P_RevenueProcessVo pRevenueProcessVo){
        ProcedureVo procedureVo = new ProcedureVo(pRevenueProcessVo);
        List<P_RevenueProcessVo> detailList =  ent_PayDao.callByeolAmt(procedureVo);
        P_RevenueProcessVo totalInfo = new Gson().fromJson(procedureVo.getExt(), P_RevenueProcessVo.class);
        if(Integer.parseInt(procedureVo.getRet()) <= 0){
            return gsonUtil.toJson(new JsonOutputVo(Status.데이터없음));
        }
        var result = new HashMap<String, Object>();
        result.put("totalInfo", totalInfo);
        result.put("detailList", detailList);

        return gsonUtil.toJson(new JsonOutputVo(Status.조회, result));
    }

    // 별 금액 엑셀 다운로드
    public Model callByeolAmtListExcel(P_RevenueProcessVo pRevenueProcessVo, Model model) {
        pRevenueProcessVo.setPageCnt(100000);
        ProcedureVo procedureVo = new ProcedureVo(pRevenueProcessVo);

        List<P_RevenueProcessVo> list = ent_PayDao.callByeolAmt(procedureVo);
        P_RevenueProcessVo totalInfo = new Gson().fromJson(procedureVo.getExt(), P_RevenueProcessVo.class);

        String[] headers = {"회원번호"
                ,"닉네임"
                ,"기초"
                ,"증가-합계"
                ,"증가-방송"
                ,"증가-이벤트"
                ,"증가-클립"
                ,"증가-우체통"
                ,"증가-관리자지급"
                ,"감소-합계"
                ,"감소-환전"
                ,"감소-달로 변환"
                ,"감소-회원탈퇴"
                ,"감소-휴면탈퇴"
                ,"감소-관리자회수"
                ,"기말"
        };
        int[] headerWidths = {3000, 3000, 3000, 3000, 3000, 3000, 3000, 3000, 3000, 3000
                , 3000, 3000, 3000, 3000, 3000, 3000};

        List<Object[]> bodies = new ArrayList<>();

        if(!DalbitUtil.isEmpty(totalInfo)){
            HashMap hm = new LinkedHashMap();
            hm.put("mem1",  "합계");
            hm.put("mem2",  "");
            hm.put("mem3",  totalInfo.getOldByeol());
            hm.put("mem4",  totalInfo.getAddTotal());
            hm.put("mem5",  totalInfo.getAddEvent());
            hm.put("mem6",  totalInfo.getAddBroad());
            hm.put("mem7",  totalInfo.getAddClip());
            hm.put("mem8",  totalInfo.getAddMailbox());
            hm.put("mem9",  totalInfo.getAddOp());
            hm.put("mem10",  totalInfo.getSubTotal());
            hm.put("mem11",  totalInfo.getSubExchange());
            hm.put("mem12",  totalInfo.getSubChange());
            hm.put("mem13",  totalInfo.getSubWithdrawal());
            hm.put("mem14",  totalInfo.getSubWithdrawalSleep());
            hm.put("mem15",  totalInfo.getSubOp());
            hm.put("mem16",  totalInfo.getNewByeol());
            bodies.add(hm.values().toArray());
        }
        for(int i = 0; i < list.size(); i++){
            HashMap hm = new LinkedHashMap();
            hm.put("mem1",  list.get(i).getMem_no());
            hm.put("mem2",  list.get(i).getNickName());
            hm.put("mem3",  list.get(i).getOldByeol());
            hm.put("mem4",  list.get(i).getAddTotal());
            hm.put("mem5",  list.get(i).getAddEvent());
            hm.put("mem6",  list.get(i).getAddBroad());
            hm.put("mem7",  list.get(i).getAddClip());
            hm.put("mem8",  list.get(i).getAddMailbox());
            hm.put("mem9",  list.get(i).getAddOp());
            hm.put("mem10",  list.get(i).getSubTotal());
            hm.put("mem11",  list.get(i).getSubExchange());
            hm.put("mem12",  list.get(i).getSubChange());
            hm.put("mem13",  list.get(i).getSubWithdrawal());
            hm.put("mem14",  list.get(i).getSubWithdrawalSleep());
            hm.put("mem15",  list.get(i).getSubOp());
            hm.put("mem16",  list.get(i).getNewByeol());
            bodies.add(hm.values().toArray());
        }
        ExcelVo vo = new ExcelVo(headers, headerWidths, bodies);
        SXSSFWorkbook workbook = excelService.excelDownload("목록",vo);
        model.addAttribute("locale", Locale.KOREA);
        model.addAttribute("workbook", workbook);
        model.addAttribute("workbookName", "달빛Live_수익인식Process(별금액)_" + pRevenueProcessVo.getStartDate());

        return model;
    }

    // 달 매출
    public String callDalSales(P_RevenueProcessVo pRevenueProcessVo){
        ProcedureVo procedureVo = new ProcedureVo(pRevenueProcessVo);
        List<P_RevenueProcessVo> detailList =  ent_PayDao.callDalSales(procedureVo);
        P_RevenueProcessVo totalInfo = new Gson().fromJson(procedureVo.getExt(), P_RevenueProcessVo.class);
        if(Integer.parseInt(procedureVo.getRet()) <= 0){
            return gsonUtil.toJson(new JsonOutputVo(Status.데이터없음));
        }
        var result = new HashMap<String, Object>();
        result.put("totalInfo", totalInfo);
        result.put("detailList", detailList);

        return gsonUtil.toJson(new JsonOutputVo(Status.조회, result));
    }

    // 달 매출 엑셀 다운로드
    public Model callDalSalesListExcel(P_RevenueProcessVo pRevenueProcessVo, Model model) {
        pRevenueProcessVo.setPageCnt(100000);
        ProcedureVo procedureVo = new ProcedureVo(pRevenueProcessVo);
        List<P_RevenueProcessVo> list = ent_PayDao.callDalSales(procedureVo);
        P_RevenueProcessVo totalInfo = new Gson().fromJson(procedureVo.getExt(), P_RevenueProcessVo.class);

        String[] headers = {"회원번호"
                ,"닉네임"
                ,"유형"
                ,"DJ"
                ,"달-유료"
                ,"달-무료"
                ,"달-합계"
                ,"별"
                ,"선수금"
                ,"미지급"
                ,"매출액"
        };
        int[] headerWidths = {3000, 3000, 3000, 3000, 3000, 3000, 3000, 3000, 3000, 3000
                , 3000};

        List<Object[]> bodies = new ArrayList<>();

        if(!DalbitUtil.isEmpty(totalInfo)){
            HashMap hm = new LinkedHashMap();
            hm.put("mem1",  "합계");
            hm.put("mem2",  "");
            hm.put("mem3",  "");
            hm.put("mem4",  "");
            hm.put("mem5",  totalInfo.getPayDal());
            hm.put("mem6",  totalInfo.getFreeDal());
            hm.put("mem7",  totalInfo.getTotalDal());
            hm.put("mem8",  totalInfo.getTotalByeol());
            hm.put("mem9",  totalInfo.getFirstAmt());
            hm.put("mem10",  totalInfo.getUnpaidAmt());
            hm.put("mem11",  totalInfo.getSalesAmt());
            bodies.add(hm.values().toArray());
        }
        for(int i = 0; i < list.size(); i++){
            HashMap hm = new LinkedHashMap();
            hm.put("mem1",  list.get(i).getMem_no());
            hm.put("mem2",  list.get(i).getNickName());
            hm.put("mem3",  (list.get(i).getSlctType() == 1 ? "방송" : (list.get(i).getSlctType() == 2 ) ? "클립" : "우체통"));
            hm.put("mem4",  (list.get(i).getMemType().equals("0")) ? "일반" : "스페셜");
            hm.put("mem5",  list.get(i).getPayDal());
            hm.put("mem6",  list.get(i).getFreeDal());
            hm.put("mem7",  list.get(i).getTotalDal());
            hm.put("mem8",  list.get(i).getTotalByeol());
            hm.put("mem9",  list.get(i).getFirstAmt());
            hm.put("mem10",  list.get(i).getUnpaidAmt());
            hm.put("mem11",  list.get(i).getSalesAmt());
            bodies.add(hm.values().toArray());
        }
        ExcelVo vo = new ExcelVo(headers, headerWidths, bodies);
        SXSSFWorkbook workbook = excelService.excelDownload("목록",vo);
        model.addAttribute("locale", Locale.KOREA);
        model.addAttribute("workbook", workbook);
        model.addAttribute("workbookName", "달빛Live_수익인식Process(별금액)_" + pRevenueProcessVo.getStartDate());

        return model;
    }

    // 탈퇴 달
    public String callWithdrawalDal(P_RevenueProcessVo pRevenueProcessVo){
        ProcedureVo procedureVo = new ProcedureVo(pRevenueProcessVo);
        List<P_RevenueProcessVo> detailList =  ent_PayDao.callWithdrawalDal(procedureVo);
        P_RevenueProcessVo totalInfo = new Gson().fromJson(procedureVo.getExt(), P_RevenueProcessVo.class);
        if(Integer.parseInt(procedureVo.getRet()) <= 0){
            return gsonUtil.toJson(new JsonOutputVo(Status.데이터없음));
        }
        var result = new HashMap<String, Object>();
        result.put("totalInfo", totalInfo);
        result.put("detailList", detailList);

        return gsonUtil.toJson(new JsonOutputVo(Status.조회, result));
    }

    // 탈퇴 달 엑셀 다운로드
    public Model callWithdrawalDalListExcel(P_RevenueProcessVo pRevenueProcessVo, Model model) {
        pRevenueProcessVo.setPageCnt(100000);
        ProcedureVo procedureVo = new ProcedureVo(pRevenueProcessVo);

        List<P_RevenueProcessVo> list = ent_PayDao.callWithdrawalDal(procedureVo);
        P_RevenueProcessVo totalInfo = new Gson().fromJson(procedureVo.getExt(), P_RevenueProcessVo.class);

        String[] headers = {"회원번호"
                ,"닉네임"
                ,"달-유료"
                ,"달-무료"
                ,"달-합계"
                ,"달 금액"
        };
        int[] headerWidths = {3000, 3000, 3000, 3000, 3000, 3000};

        List<Object[]> bodies = new ArrayList<>();

        if(!DalbitUtil.isEmpty(totalInfo)){
            HashMap hm = new LinkedHashMap();
            hm.put("mem1",  "합계");
            hm.put("mem2",  "");
            hm.put("mem3",  totalInfo.getPayDal());
            hm.put("mem4",  totalInfo.getFreeDal());
            hm.put("mem5",  totalInfo.getTotalDal());
            hm.put("mem6",  totalInfo.getDalAmt());
            bodies.add(hm.values().toArray());
        }
        for(int i = 0; i < list.size(); i++){
            HashMap hm = new LinkedHashMap();
            hm.put("mem1",  list.get(i).getMem_no());
            hm.put("mem2",  list.get(i).getNickName());
            hm.put("mem3",  list.get(i).getPayDal());
            hm.put("mem4",  list.get(i).getFreeDal());
            hm.put("mem5",  list.get(i).getTotalDal());
            hm.put("mem6",  list.get(i).getDalAmt());
            bodies.add(hm.values().toArray());
        }
        ExcelVo vo = new ExcelVo(headers, headerWidths, bodies);
        SXSSFWorkbook workbook = excelService.excelDownload("목록",vo);
        model.addAttribute("locale", Locale.KOREA);
        model.addAttribute("workbook", workbook);
        model.addAttribute("workbookName", "달빛Live_수익인식Process(탈퇴달)_" + pRevenueProcessVo.getStartDate());

        return model;
    }


    // 탈퇴 별
    public String callWithdrawalByeol(P_RevenueProcessVo pRevenueProcessVo){
        ProcedureVo procedureVo = new ProcedureVo(pRevenueProcessVo);
        List<P_RevenueProcessVo> detailList =  ent_PayDao.callWithdrawalByeol(procedureVo);
        P_RevenueProcessVo totalInfo = new Gson().fromJson(procedureVo.getExt(), P_RevenueProcessVo.class);
        if(Integer.parseInt(procedureVo.getRet()) <= 0){
            return gsonUtil.toJson(new JsonOutputVo(Status.데이터없음));
        }
        var result = new HashMap<String, Object>();
        result.put("totalInfo", totalInfo);
        result.put("detailList", detailList);

        return gsonUtil.toJson(new JsonOutputVo(Status.조회, result));
    }

    // 탈퇴 달 엑셀 다운로드
    public Model callWithdrawalByeolListExcel(P_RevenueProcessVo pRevenueProcessVo, Model model) {
        pRevenueProcessVo.setPageCnt(100000);
        ProcedureVo procedureVo = new ProcedureVo(pRevenueProcessVo);

        List<P_RevenueProcessVo> list = ent_PayDao.callWithdrawalByeol(procedureVo);
        P_RevenueProcessVo totalInfo = new Gson().fromJson(procedureVo.getExt(), P_RevenueProcessVo.class);

        String[] headers = {"회원번호"
                ,"닉네임"
                ,"별-수량"
                ,"별-금액"
        };
        int[] headerWidths = {3000, 3000, 3000, 3000, 3000, 3000};

        List<Object[]> bodies = new ArrayList<>();

        if(!DalbitUtil.isEmpty(totalInfo)){
            HashMap hm = new LinkedHashMap();
            hm.put("mem1",  "합계");
            hm.put("mem2",  "");
            hm.put("mem3",  totalInfo.getByeol());
            hm.put("mem4",  totalInfo.getByeolAmt());
            bodies.add(hm.values().toArray());
        }
        for(int i = 0; i < list.size(); i++){
            HashMap hm = new LinkedHashMap();
            hm.put("mem1",  list.get(i).getMem_no());
            hm.put("mem2",  list.get(i).getNickName());
            hm.put("mem3",  list.get(i).getByeol());
            hm.put("mem4",  list.get(i).getByeolAmt());
            bodies.add(hm.values().toArray());
        }
        ExcelVo vo = new ExcelVo(headers, headerWidths, bodies);
        SXSSFWorkbook workbook = excelService.excelDownload("목록",vo);
        model.addAttribute("locale", Locale.KOREA);
        model.addAttribute("workbook", workbook);
        model.addAttribute("workbookName", "달빛Live_수익인식Process(탈퇴별)_" + pRevenueProcessVo.getStartDate());

        return model;
    }
}
