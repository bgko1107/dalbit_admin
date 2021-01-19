package com.dalbit.main.service;

import com.dalbit.common.code.Status;
import com.dalbit.common.vo.JsonOutputVo;
import com.dalbit.common.vo.ProcedureVo;
import com.dalbit.connect.dao.Con_LoginDao;
import com.dalbit.connect.vo.procedure.P_LoginAgeOutDetailVo;
import com.dalbit.connect.vo.procedure.P_LoginAgeOutVo;
import com.dalbit.connect.vo.procedure.P_LoginTotalOutDetailVo;
import com.dalbit.connect.vo.procedure.P_LoginTotalOutVo;
import com.dalbit.enter.dao.Ent_JoinDao;
import com.dalbit.enter.dao.Ent_NewJoinDao;
import com.dalbit.enter.dao.Ent_PayDao;
import com.dalbit.enter.vo.procedure.*;
import com.dalbit.main.dao.Mai_MainStatusDao;
import com.dalbit.main.vo.PayStatusInputVo;
import com.dalbit.main.vo.PayStatusOutputVo;
import com.dalbit.main.vo.procedure.*;
import com.dalbit.status.dao.Sta_BroadcastDao;
import com.dalbit.status.dao.Sta_ExchangeDao;
import com.dalbit.status.vo.procedure.P_BroadcastTotalOutDetailVo;
import com.dalbit.status.vo.procedure.P_BroadcastTotalOutVo;
import com.dalbit.status.vo.procedure.P_ExchangeTotalOutDetailVo;
import com.dalbit.status.vo.procedure.P_ExchangeTotalOutVo;
import com.dalbit.util.DalbitUtil;
import com.dalbit.util.GsonUtil;
import com.dalbit.util.MessageUtil;
import com.google.gson.Gson;
import lombok.extern.slf4j.Slf4j;
import lombok.var;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.dalbit.main.vo.procedure.P_StatVo;

import java.util.*;


@Slf4j
@Service
public class Mai_MainStatusService {

    @Autowired
    MessageUtil messageUtil;
    @Autowired
    GsonUtil gsonUtil;
    @Autowired
    Mai_MainStatusDao main_JoinDao;


    @Autowired
    Ent_JoinDao ent_JoinDao;
    @Autowired
    Con_LoginDao con_LoginDao;
    @Autowired
    Sta_BroadcastDao sta_BroadcastDao;
    @Autowired
    Ent_PayDao ent_PayDao;
    @Autowired
    Sta_ExchangeDao sta_ExchangeDao;
    @Autowired
    Ent_NewJoinDao ent_NewJoinDao;

    /**
     * Total 메인
     * @param
     * @return
     */
    public String callTotalStatusList(){
        ProcedureVo procedureVo = new ProcedureVo();
        main_JoinDao.callTotalStatusList(procedureVo);
        P_TotalStatusOutVo totalStatus = new Gson().fromJson(procedureVo.getExt(), P_TotalStatusOutVo.class);
        return gsonUtil.toJson(new JsonOutputVo(Status.조회, totalStatus));
    }

    /**
     * 회원가입 메인
     * @param
     * @return
     */
    public String callJoinStatusList(){
        ProcedureVo procedureVo = new ProcedureVo();
        main_JoinDao.callJoinStatusList(procedureVo);
        P_JoinStatusOutVo joinStatus = new Gson().fromJson(procedureVo.getExt(), P_JoinStatusOutVo.class);
        var result = new HashMap<String, Object>();
        result.put("joinStatus", joinStatus);
        return gsonUtil.toJson(new JsonOutputVo(Status.조회, result));
    }

    /**
     * 회원탈퇴 메인
     * @param
     * @return
     */
    public String callWithdrawStatusList(){
        ProcedureVo procedureVo = new ProcedureVo();
        main_JoinDao.callWithdrawStatusList(procedureVo);
        P_JoinStatusOutVo withdrawStatus = new Gson().fromJson(procedureVo.getExt(), P_JoinStatusOutVo.class);
        var result = new HashMap<String, Object>();
        result.put("withdrawStatus", withdrawStatus);
        return gsonUtil.toJson(new JsonOutputVo(Status.조회, result));
    }

    /**
     * 방송정보 메인
     * @param
     * @return
     */
    public String callBroadStatusInfoList(){
        ProcedureVo procedureVo = new ProcedureVo();
        main_JoinDao.callBroadStatusInfoList(procedureVo);
        P_BroadStatusOutVo broadStatus = new Gson().fromJson(procedureVo.getExt(), P_BroadStatusOutVo.class);
        return gsonUtil.toJson(new JsonOutputVo(Status.조회, broadStatus));
    }

    /**
     * 차트 메인
     * @param
     * @return
     */
    public String callChartStatusInfoList(P_ChartStatusInputVo pChartStatusInputVo){
        ProcedureVo procedureVo = new ProcedureVo(pChartStatusInputVo);
        List<P_ChartStatusOutVo> chartList = main_JoinDao.callChartStatusInfoList(procedureVo);

        return gsonUtil.toJson(new JsonOutputVo(Status.조회, chartList));
    }

    /**
     * 아이템 Top5 메인
     * @param
     * @return
     */
    public String callItemStatusInfoList() {
        ProcedureVo procedureVo = new ProcedureVo();
        List<P_ItemTopFiveOutputVo> itemList = main_JoinDao.callItemStatusInfoList(procedureVo);
        return gsonUtil.toJson(new JsonOutputVo(Status.조회, itemList));
    }

    public String getPayDayStatusInfoList(PayStatusInputVo payStatusInputVo){

        List<PayStatusOutputVo> todayList = main_JoinDao.getPayDayStatusInfoList(new PayStatusInputVo(payStatusInputVo.getToday()));
        List<PayStatusOutputVo> yesterdayList = main_JoinDao.getPayDayStatusInfoList(new PayStatusInputVo(payStatusInputVo.getYesterday()));

        List<PayStatusOutputVo> thisWeekList = main_JoinDao.getPayDayStatusWeekInfoList(new PayStatusInputVo(payStatusInputVo.getThisWeekStartDay(), payStatusInputVo.getThisWeekEndDay()));
        List<PayStatusOutputVo> prevWeekList = main_JoinDao.getPayDayStatusWeekInfoList(new PayStatusInputVo(payStatusInputVo.getPrevWeekStartDay(), payStatusInputVo.getPrevWeekEndDay()));

        var map = new HashMap<String, Object>();
        map.put("todayList", todayList);
        map.put("yesterdayList", yesterdayList);
        map.put("thisWeekList", thisWeekList);
        map.put("prevWeekList", prevWeekList);

        return gsonUtil.toJson(new JsonOutputVo(Status.조회, map));
    }

    public String getPayCancelDayStatusInfoList(PayStatusInputVo payStatusInputVo){

        List<PayStatusOutputVo> todayList = main_JoinDao.getPayCalcelDayStatusInfoList(new PayStatusInputVo(payStatusInputVo.getToday()));
        List<PayStatusOutputVo> yesterdayList = main_JoinDao.getPayCalcelDayStatusInfoList(new PayStatusInputVo(payStatusInputVo.getYesterday()));

        List<PayStatusOutputVo> thisWeekList = main_JoinDao.getPayCalcelWeekStatusInfoList(new PayStatusInputVo(payStatusInputVo.getThisWeekStartDay(), payStatusInputVo.getThisWeekEndDay()));
        List<PayStatusOutputVo> prevWeekList = main_JoinDao.getPayCalcelWeekStatusInfoList(new PayStatusInputVo(payStatusInputVo.getPrevWeekStartDay(), payStatusInputVo.getPrevWeekEndDay()));

        var map = new HashMap<String, Object>();
        map.put("todayList", todayList);
        map.put("yesterdayList", yesterdayList);
        map.put("thisWeekList", thisWeekList);
        map.put("prevWeekList", prevWeekList);

        return gsonUtil.toJson(new JsonOutputVo(Status.조회, map));
    }


    /**
     * 메인 가입현황 고정
     * @return
     */
    public String callStatJoin(P_StatVo pStatVo) {
        ProcedureVo procedureVo = new ProcedureVo(pStatVo);
        List<P_JoinTotalOutDetailVo> detailList =  ent_JoinDao.callJoinTotal(procedureVo);
        P_JoinTotalOutVo totalInfo = new Gson().fromJson(procedureVo.getExt(), P_JoinTotalOutVo.class);
        if(Integer.parseInt(procedureVo.getRet()) <= 0){
            return gsonUtil.toJson(new JsonOutputVo(Status.데이터없음));
        }

        List<P_JoinWithdrawOutDetailVo> detailList2 =  ent_JoinDao.callJoinWithdraw(procedureVo);
        P_JoinWithdrawOutVo totalInfo2 = new Gson().fromJson(procedureVo.getExt(), P_JoinWithdrawOutVo.class);
        if(Integer.parseInt(procedureVo.getRet()) <= 0){
            return gsonUtil.toJson(new JsonOutputVo(Status.데이터없음));
        }


        // 이전 날짜 구하기
        HashMap<String, String> preDate = DalbitUtil.getPreviousDate(pStatVo);
        pStatVo.setStartDate(preDate.get("sDate"));
        pStatVo.setEndDate(preDate.get("eDate"));

        procedureVo = new ProcedureVo(pStatVo);
        List<P_JoinTotalOutDetailVo> pre_detailList =  ent_JoinDao.callJoinTotal(procedureVo);
        P_JoinTotalOutVo pre_totalInfo = new Gson().fromJson(procedureVo.getExt(), P_JoinTotalOutVo.class);

        List<P_JoinWithdrawOutDetailVo> pre_detailList2 =  ent_JoinDao.callJoinWithdraw(procedureVo);
        P_JoinWithdrawOutVo pre_totalInfo2 = new Gson().fromJson(procedureVo.getExt(), P_JoinWithdrawOutVo.class);

        if(!DalbitUtil.isEmpty(pre_detailList)){
            totalInfo.setInc_sum_totalCnt(totalInfo.getSum_totalCnt() - pre_totalInfo.getSum_totalCnt());
        }
        if(!DalbitUtil.isEmpty(pre_totalInfo2)){
            totalInfo2.setInc_sum_totalCnt(totalInfo2.getSum_totalCnt() - pre_totalInfo2.getSum_totalCnt());
        }

        var result = new HashMap<String, Object>();
        result.put("totalInfo", totalInfo);
        result.put("detailList", detailList);
        result.put("withdrawTotalInfo", totalInfo2);
        result.put("withdrawDetailList", detailList2);

        return gsonUtil.toJson(new JsonOutputVo(Status.조회, result));
    }

    /**
     * 메인 로그인현황 고정
     * @return
     */
    public String callStatLogin(P_StatVo pStatVo){

        // PV
        ProcedureVo procedureVo = new ProcedureVo(pStatVo);
        List<P_LoginTotalOutDetailVo> detailList =  con_LoginDao.callLoginTotalAll(procedureVo);
        P_LoginTotalOutVo totalInfo = new Gson().fromJson(procedureVo.getExt(), P_LoginTotalOutVo.class);

        if(Integer.parseInt(procedureVo.getRet()) <= 0){
            return gsonUtil.toJson(new JsonOutputVo(Status.데이터없음));
        }

        //UV
        procedureVo = new ProcedureVo(pStatVo);
        List<P_LoginTotalOutDetailVo> detailList2 =  con_LoginDao.callLoginTotal(procedureVo);
        P_LoginTotalOutVo totalInfo2 = new Gson().fromJson(procedureVo.getExt(), P_LoginTotalOutVo.class);

        if(Integer.parseInt(procedureVo.getRet()) <= 0){
            return gsonUtil.toJson(new JsonOutputVo(Status.데이터없음));
        }


        HashMap<String, String> preDate = DalbitUtil.getPreviousDate(pStatVo);
        pStatVo.setStartDate(preDate.get("sDate"));
        pStatVo.setEndDate(preDate.get("eDate"));

        procedureVo = new ProcedureVo(pStatVo);
        List<P_LoginTotalOutDetailVo> pre_detailList =  con_LoginDao.callLoginTotalAll(procedureVo);
        P_LoginTotalOutVo pre_totalInfo = new Gson().fromJson(procedureVo.getExt(), P_LoginTotalOutVo.class);

        procedureVo = new ProcedureVo(pStatVo);
        List<P_LoginTotalOutDetailVo> pre_detailList2 =  con_LoginDao.callLoginTotal(procedureVo);
        P_LoginTotalOutVo pre_totalInfo2 = new Gson().fromJson(procedureVo.getExt(), P_LoginTotalOutVo.class);

        if(!DalbitUtil.isEmpty(pre_totalInfo)){
            totalInfo.setInc_sum_totalCnt(totalInfo.getSum_totalCnt() - pre_totalInfo.getSum_totalCnt());
        }
        if(!DalbitUtil.isEmpty(pre_totalInfo2)){
            totalInfo2.setInc_sum_totalCnt(totalInfo2.getSum_totalCnt() - pre_totalInfo2.getSum_totalCnt());
        }

        var result = new HashMap<String, Object>();
        result.put("overTotalInfo", totalInfo);
        result.put("overDetailList", detailList);
        result.put("totalInfo", totalInfo2);
        result.put("detailList", detailList2);

        return gsonUtil.toJson(new JsonOutputVo(Status.조회, result));
    }

    /**
     * 메인 방송개설/청취현황
     * @return
     */
    public String callStatBroadCast(P_StatVo pStatVo){
        ProcedureVo procedureVo = new ProcedureVo(pStatVo);
        ArrayList<P_BroadcastTotalOutDetailVo> detailList = sta_BroadcastDao.callBroadcastTotal(procedureVo);

        P_BroadcastTotalOutVo totalInfo = new Gson().fromJson(procedureVo.getExt(), P_BroadcastTotalOutVo.class);

        if(Integer.parseInt(procedureVo.getRet()) <= 0){
            return gsonUtil.toJson(new JsonOutputVo(Status.데이터없음));
        }

        HashMap<String, String> preDate = DalbitUtil.getPreviousDate(pStatVo);
        pStatVo.setStartDate(preDate.get("sDate"));
        pStatVo.setEndDate(preDate.get("eDate"));

        procedureVo = new ProcedureVo(pStatVo);
        ArrayList<P_BroadcastTotalOutDetailVo> pre_detailList = sta_BroadcastDao.callBroadcastTotal(procedureVo);
        P_BroadcastTotalOutVo pre_totalInfo = new Gson().fromJson(procedureVo.getExt(), P_BroadcastTotalOutVo.class);

        if(!DalbitUtil.isEmpty(pre_totalInfo)){
            totalInfo.setInc_sum_createCnt(totalInfo.getSum_createCnt() - pre_totalInfo.getSum_createCnt());
            totalInfo.setInc_sum_broadcastingTime(totalInfo.getSum_broadcastingTime() - pre_totalInfo.getSum_broadcastingTime());
            totalInfo.setInc_sum_djCnt(totalInfo.getSum_djCnt() - pre_totalInfo.getSum_djCnt());
            totalInfo.setInc_sum_listenerCnt(totalInfo.getSum_listenerCnt() - pre_totalInfo.getSum_listenerCnt());
            totalInfo.setInc_sum_guestCnt(totalInfo.getSum_guestCnt() - pre_totalInfo.getSum_guestCnt());
            totalInfo.setInc_sum_giftCnt(totalInfo.getSum_giftCnt() - pre_totalInfo.getSum_giftCnt());
            totalInfo.setInc_sum_giftAmount(totalInfo.getSum_giftAmount() - pre_totalInfo.getSum_giftAmount());
        }

        var result = new HashMap<String, Object>();
        result.put("totalInfo", totalInfo);
        result.put("detailList", detailList);

        return gsonUtil.toJson(new JsonOutputVo(Status.조회, result));
    }


    /**
     * 결제/환불 고정
     * @return
     */
    public String callPayInfo(P_StatVo pStatVo){
        // 결제/취소/환불
        ProcedureVo procedureVo = new ProcedureVo(pStatVo);
        List<P_PayTotalOutDetailVo> detailList =  ent_PayDao.callPayTotal(procedureVo);
        P_PayTotalOutVo totalInfo = new Gson().fromJson(procedureVo.getExt(), P_PayTotalOutVo.class);
        if(Integer.parseInt(procedureVo.getRet()) <= 0){
            return gsonUtil.toJson(new JsonOutputVo(Status.데이터없음));
        }

        // 환전
        procedureVo = new ProcedureVo(pStatVo);
        ArrayList<P_ExchangeTotalOutDetailVo> detailList2 = sta_ExchangeDao.callExchangeTotal(procedureVo);
        P_ExchangeTotalOutVo totalInfo2 = new Gson().fromJson(procedureVo.getExt(), P_ExchangeTotalOutVo.class);
        if(Integer.parseInt(procedureVo.getRet()) <= 0){
            return gsonUtil.toJson(new JsonOutputVo(Status.데이터없음));
        }

        HashMap<String, String> preDate = DalbitUtil.getPreviousDate(pStatVo);
        pStatVo.setStartDate(preDate.get("sDate"));
        pStatVo.setEndDate(preDate.get("eDate"));

        procedureVo = new ProcedureVo(pStatVo);
        List<P_PayTotalOutDetailVo> pre_detailList =  ent_PayDao.callPayTotal(procedureVo);
        P_PayTotalOutVo pre_totalInfo = new Gson().fromJson(procedureVo.getExt(), P_PayTotalOutVo.class);

        boolean minusSw;
        for(int i=0;i<detailList.size();i++){
            for(int j=0;j<pre_detailList.size();j++){
                minusSw = false;
                if(pStatVo.getSlctType() == 0){
                    if(detailList.get(i).getHour() == pre_detailList.get(j).getHour()){
                        minusSw = true;
                    }
                }else if(pStatVo.getSlctType() == 1){
                    if(detailList.get(i).getDaily().split("-")[2].equals(pre_detailList.get(j).getDaily().split("-")[2])){
                        minusSw = true;
                    }
                }else if(pStatVo.getSlctType() == 1){
                    if(detailList.get(i).getMonthly() == pre_detailList.get(j).getMonthly()){
                        minusSw = true;
                    }
                }
                if(minusSw){
                    detailList.get(i).setInc_succCnt(detailList.get(i).getSuccCnt() - pre_detailList.get(j).getSuccCnt());
                    detailList.get(i).setInc_succAmt(detailList.get(i).getSuccAmt() - pre_detailList.get(j).getSuccAmt());
                    break;
                }
            }
        }
        totalInfo.setInc_sum_succCnt(totalInfo.getSum_succCnt() - pre_totalInfo.getSum_succCnt());
        totalInfo.setInc_sum_succAmt(totalInfo.getSum_succAmt() - pre_totalInfo.getSum_succAmt());

        // 환전
        procedureVo = new ProcedureVo(pStatVo);
        ArrayList<P_ExchangeTotalOutDetailVo> pre_detailList2 = sta_ExchangeDao.callExchangeTotal(procedureVo);
        P_ExchangeTotalOutVo pre_totalInfo2 = new Gson().fromJson(procedureVo.getExt(), P_ExchangeTotalOutVo.class);

        for(int i=0;i<detailList2.size();i++){
            for(int j=0;j<pre_detailList2.size();j++){
                minusSw = false;
                if(pStatVo.getSlctType() == 0){
                    if(detailList2.get(i).getHour() == pre_detailList2.get(j).getHour()){
                        minusSw = true;
                    }
                }else if(pStatVo.getSlctType() == 1){
                    if(detailList2.get(i).getDaily().split("-")[2].equals(pre_detailList2.get(j).getDaily().split("-")[2])){
                        minusSw = true;
                    }
                }else if(pStatVo.getSlctType() == 1){
                    if(detailList2.get(i).getMonthly() == pre_detailList2.get(j).getMonthly()){
                        minusSw = true;
                    }
                }
                if(minusSw){
                    detailList2.get(i).setInc_succCnt(detailList2.get(i).getSuccCnt() - pre_detailList2.get(j).getSuccCnt());
                    detailList2.get(i).setInc_succAmt(detailList2.get(i).getSuccAmt() - pre_detailList2.get(j).getSuccAmt());
                    break;
                }
            }
        }
        totalInfo2.setInc_sum_succCnt(totalInfo2.getSum_succCnt() - pre_totalInfo2.getSum_succCnt());
        totalInfo2.setInc_sum_succAmt(totalInfo2.getSum_succAmt() - pre_totalInfo2.getSum_succAmt());

        var result = new HashMap<String, Object>();
        result.put("totalInfo", totalInfo);
        result.put("detailList", detailList);
        result.put("totalInfo2", totalInfo2);
        result.put("detailList2", detailList2);

        return gsonUtil.toJson(new JsonOutputVo(Status.조회, result));
    }

    /**
     * 로그인 성별 현황
     * @return
     */
    public String callLoginTotal(P_StatVo pStatVo){
        ProcedureVo procedureVo = new ProcedureVo(pStatVo);
        List<P_LoginTotalOutDetailVo> detailList =  con_LoginDao.callLoginTotal(procedureVo);
        P_LoginTotalOutVo totalInfo = new Gson().fromJson(procedureVo.getExt(), P_LoginTotalOutVo.class);

        if(Integer.parseInt(procedureVo.getRet()) <= 0){
            return gsonUtil.toJson(new JsonOutputVo(Status.데이터없음));
        }

        var result = new HashMap<String, Object>();
        result.put("totalInfo", totalInfo);
        result.put("detailList", detailList);

        return gsonUtil.toJson(new JsonOutputVo(Status.조회, result));
    }

    /**
     * 로그인 연령별 현황
     * @return
     */
    public String callLoginAge(P_StatVo pStatVo){
        ProcedureVo procedureVo = new ProcedureVo(pStatVo);
        List<P_LoginAgeOutDetailVo> detailList =  con_LoginDao.callLoginAge(procedureVo);
        P_LoginAgeOutVo totalInfo = new Gson().fromJson(procedureVo.getExt(), P_LoginAgeOutVo.class);

        if(Integer.parseInt(procedureVo.getRet()) <= 0){
            return gsonUtil.toJson(new JsonOutputVo(Status.데이터없음));
        }

        var result = new HashMap<String, Object>();
        result.put("totalInfo", totalInfo);
        result.put("detailList", detailList);

        return gsonUtil.toJson(new JsonOutputVo(Status.조회, result));
    }


    /**
     * 가입/탈퇴현황 플랫폼별
     * @return
     */
    public String callStatJoinPlatform(P_StatVo pStatVo){
        ProcedureVo procedureVo = new ProcedureVo(pStatVo);
        List<P_JoinLiveOutDetailVo> detailList =  ent_NewJoinDao.callJoinLive(procedureVo);
        P_JoinLiveOutVo totalInfo = new Gson().fromJson(procedureVo.getExt(), P_JoinLiveOutVo.class);

        if(Integer.parseInt(procedureVo.getRet()) <= 0){
            return gsonUtil.toJson(new JsonOutputVo(Status.데이터없음));
        }

        var result = new HashMap<String, Object>();
        result.put("totalInfo", totalInfo);
        result.put("detailList", detailList);

        return gsonUtil.toJson(new JsonOutputVo(Status.조회, result));
    }



}
