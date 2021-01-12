package com.dalbit.status.service;


import com.dalbit.common.code.Status;
import com.dalbit.common.vo.JsonOutputVo;
import com.dalbit.common.vo.PagingVo;
import com.dalbit.common.vo.ProcedureVo;
import com.dalbit.content.vo.procedure.P_pushDetailOutputVo;
import com.dalbit.member.vo.procedure.P_MemberListOutputVo;
import com.dalbit.status.dao.Sta_PushDao;
import com.dalbit.status.vo.procedure.*;
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
public class Sta_PushService {

    @Autowired
    MessageUtil messageUtil;
    @Autowired
    GsonUtil gsonUtil;
    @Autowired
    Sta_PushDao sta_PushDao;

    /**
     * Push발송 현황
     */
    public String callPushTotal(P_StatVo pStatVo){
        ProcedureVo procedureVo = new ProcedureVo(pStatVo);
        ArrayList<P_PushTotalOutDetailVo> detailList = sta_PushDao.callPushTotal(procedureVo);
        P_PushTotalOutVo totalInfo = new Gson().fromJson(procedureVo.getExt(), P_PushTotalOutVo.class);
        if(Integer.parseInt(procedureVo.getRet()) <= 0){
            return gsonUtil.toJson(new JsonOutputVo(Status.데이터없음));
        }
        var result = new HashMap<String, Object>();
        result.put("totalInfo", totalInfo);
        result.put("detailList", detailList);

        return gsonUtil.toJson(new JsonOutputVo(Status.조회, result));
    }

    /**
     * 알림설정 현황
     */
    public String callNotice(P_StatVo pStatVo){
        ProcedureVo procedureVo = new ProcedureVo(pStatVo);
        ArrayList<P_NoticeOutDetailVo> detailList = sta_PushDao.callNotice(procedureVo);
        if(Integer.parseInt(procedureVo.getRet()) <= 0){
            return gsonUtil.toJson(new JsonOutputVo(Status.데이터없음));
        }
        var result = new HashMap<String, Object>();
        result.put("detailList", detailList);

        return gsonUtil.toJson(new JsonOutputVo(Status.조회, result));
    }


    /**
     * PUSH 발송 내역 조회
     */
    public String callPushHistoryList(P_PushHistoryInputVo pPushHistoryInputVo) {
        String result;

        int totalCnt = sta_PushDao.callPushHistoryListCnt(pPushHistoryInputVo);
        pPushHistoryInputVo.setTotalCnt(totalCnt);
        ArrayList<P_PushHistoryOutputVo> historyList = sta_PushDao.callPushHistoryList(pPushHistoryInputVo);

        if(historyList != null && historyList.size() > 0) {
            P_PushHistoryOutputVo summary = sta_PushDao.callPushHistorySummary(pPushHistoryInputVo);

            result = gsonUtil.toJson(new JsonOutputVo(Status.조회, historyList, new PagingVo(pPushHistoryInputVo.getTotalCnt(), pPushHistoryInputVo.getPageStart(), pPushHistoryInputVo.getPageCnt()), summary));
        }else {
            result = gsonUtil.toJson(new JsonOutputVo(Status.데이터없음, new ArrayList<P_PushHistoryOutputVo>(), new PagingVo(pPushHistoryInputVo.getTotalCnt(), pPushHistoryInputVo.getPageStart(), pPushHistoryInputVo.getPageCnt())));
        }

        return result;
    }

    /** PUSH 발송 내역 상세 조회 */
    public String callPushHistoryDetail(P_PushHistoryInputVo pPushHistoryInputVo) {
        String result;

        P_pushDetailOutputVo pPushDetailOutputVo = sta_PushDao.callPushHistoryDetail(pPushHistoryInputVo);

        List<P_MemberListOutputVo> memInfo = sta_PushDao.selectTargetMemInfo(pPushHistoryInputVo);

        pPushDetailOutputVo.setMem_info(memInfo);

        if (pPushDetailOutputVo != null) {
            result = gsonUtil.toJson(new JsonOutputVo(Status.조회, pPushDetailOutputVo));
        } else{
            result = gsonUtil.toJson(new JsonOutputVo(Status.데이터없음));
        }

        return result;
    }



    /**
     * push현황 시간대별
     * @param pPushStatusInPutVo
     * @return
     */
    public String callPushTime(P_PushStatusInPutVo pPushStatusInPutVo){

        ArrayList resultList = new ArrayList();
        String[] dateList = pPushStatusInPutVo.getDateList().split("@");

        int slctType_date = 24;

        for(int i=0;i<dateList.length;i++){
            if(dateList[i].indexOf("-") > -1){
                pPushStatusInPutVo.setStartDate(dateList[i].split("-")[0]);
                pPushStatusInPutVo.setEndDate(dateList[i].split("-")[1]);
            }else{
                pPushStatusInPutVo.setStartDate(dateList[i]);
                pPushStatusInPutVo.setEndDate(dateList[i]);
            }

            ProcedureVo procedureVo = new ProcedureVo(pPushStatusInPutVo);
            List<P_PushStatusOutPutVo> detailList =  sta_PushDao.callPushStatus(procedureVo);
            P_PushStatusOutVo totalInfo = new Gson().fromJson(procedureVo.getExt(), P_PushStatusOutVo.class);

            boolean zeroSw = false;
            if(detailList.size() < slctType_date){
                int detailList_size = detailList.size();
                for (int j = 0; j < slctType_date; j++) {
                    P_PushStatusOutPutVo outVo = new P_PushStatusOutPutVo();
                    for (int k = 0; k < detailList_size; k++){
                        if (detailList.get(k).getThe_hr() == j) {
                            zeroSw = true;
                            break;
                        }
                    }
                    if(!zeroSw){
                        outVo.setThe_hr(j);
                        outVo.setMale_succ_cnt(0);
                        outVo.setMale_fail_cnt(0);
                        outVo.setFemale_send_cnt(0);
                        outVo.setFemale_succ_cnt(0);
                        outVo.setFemale_fail_cnt(0);
                        outVo.setNone_succ_cnt(0);
                        outVo.setNone_fail_cnt(0);
                        outVo.setTotal_succ_cnt(0);
                        outVo.setTotal_fail_cnt(0);

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

    public String callPushDay(P_PushStatusInPutVo pPushStatusInPutVo){
        ProcedureVo procedureVo = new ProcedureVo(pPushStatusInPutVo);
        ArrayList<P_PushStatusOutPutVo> detailList = sta_PushDao.callPushStatus(procedureVo);
        P_PushStatusOutVo totalInfo = new Gson().fromJson(procedureVo.getExt(), P_PushStatusOutVo.class);
        if(Integer.parseInt(procedureVo.getRet()) <= 0){
            return gsonUtil.toJson(new JsonOutputVo(Status.데이터없음));
        }
        var result = new HashMap<String, Object>();
        result.put("totalInfo", totalInfo);
        result.put("detailList", detailList);

        return gsonUtil.toJson(new JsonOutputVo(Status.조회, result));
    }

    public String callPushMonth(P_PushStatusInPutVo pPushStatusInPutVo){
        String startDate = pPushStatusInPutVo.getStartDate();
        String endDate = pPushStatusInPutVo.getEndDate();
        pPushStatusInPutVo.setStartDate(pPushStatusInPutVo.getBeforStartDate());
        pPushStatusInPutVo.setEndDate(pPushStatusInPutVo.getBeforEndDate());
        ProcedureVo procedureVo = new ProcedureVo(pPushStatusInPutVo);
        List<P_PushStatusOutPutVo> bDetailList =  sta_PushDao.callPushStatus(procedureVo);
        P_PushStatusOutVo bTotalInfo = new Gson().fromJson(procedureVo.getExt(), P_PushStatusOutVo.class);
        pPushStatusInPutVo.setStartDate(startDate);
        pPushStatusInPutVo.setEndDate(endDate);
        procedureVo = new ProcedureVo(pPushStatusInPutVo);
        List<P_PushStatusOutPutVo> detailList =  sta_PushDao.callPushStatus(procedureVo);
        P_PushStatusOutVo totalInfo = new Gson().fromJson(procedureVo.getExt(), P_PushStatusOutVo.class);
        P_PushStatusOutVo sumOutVo = new P_PushStatusOutVo();
        if(!DalbitUtil.isEmpty(bTotalInfo)) {
            sumOutVo.setMaleAlim_s(totalInfo.getMaleAlim_s());
            sumOutVo.setFemaleAlim_s(totalInfo.getFemaleAlim_s());
            sumOutVo.setNoneAlim_s(totalInfo.getNoneAlim_s());
            sumOutVo.setMaleAlim_v(totalInfo.getMaleAlim_v());
            sumOutVo.setFemaleAlim_v(totalInfo.getFemaleAlim_v());
            sumOutVo.setNoneAlim_v(totalInfo.getNoneAlim_v());
            sumOutVo.setMaleAlim_n(totalInfo.getMaleAlim_n());
            sumOutVo.setFemaleAlim_n(totalInfo.getFemaleAlim_n());
            sumOutVo.setNoneAlim_n(totalInfo.getNoneAlim_n());
            sumOutVo.setBmaleAlim_s(bTotalInfo.getMaleAlim_s());
            sumOutVo.setBfemaleAlim_s(bTotalInfo.getFemaleAlim_s());
            sumOutVo.setBnoneAlim_s(bTotalInfo.getNoneAlim_s());
            sumOutVo.setBmaleAlim_v(bTotalInfo.getMaleAlim_v());
            sumOutVo.setBfemaleAlim_v(bTotalInfo.getFemaleAlim_v());
            sumOutVo.setBnoneAlim_v(bTotalInfo.getNoneAlim_v());
            sumOutVo.setBmaleAlim_n(bTotalInfo.getMaleAlim_n());
            sumOutVo.setBfemaleAlim_n(bTotalInfo.getFemaleAlim_n());
            sumOutVo.setBnoneAlim_n(bTotalInfo.getNoneAlim_n());
            sumOutVo.setTotalAlim_s(totalInfo.getMaleAlim_s() + totalInfo.getFemaleAlim_s() + totalInfo.getNoneAlim_s());
            sumOutVo.setTotalAlim_v(totalInfo.getMaleAlim_v() + totalInfo.getFemaleAlim_v() + totalInfo.getNoneAlim_v());
            sumOutVo.setTotalAlim_n(totalInfo.getMaleAlim_n() + totalInfo.getFemaleAlim_n() + totalInfo.getNoneAlim_n());
            sumOutVo.setBtotalAlim_s(totalInfo.getMaleAlim_s() + totalInfo.getFemaleAlim_s() + totalInfo.getNoneAlim_s());
            sumOutVo.setBtotalAlim_v(totalInfo.getMaleAlim_v() + totalInfo.getFemaleAlim_v() + totalInfo.getNoneAlim_v());
            sumOutVo.setBtotalAlim_n(totalInfo.getMaleAlim_n() + totalInfo.getFemaleAlim_n() + totalInfo.getNoneAlim_n());
        }else{
            sumOutVo.setMaleAlim_s(0);
            sumOutVo.setFemaleAlim_s(0);
            sumOutVo.setNoneAlim_s(0);
            sumOutVo.setMaleAlim_v(0);
            sumOutVo.setFemaleAlim_v(0);
            sumOutVo.setNoneAlim_v(0);
            sumOutVo.setMaleAlim_n(0);
            sumOutVo.setFemaleAlim_n(0);
            sumOutVo.setNoneAlim_n(0);
            sumOutVo.setBmaleAlim_s(0);
            sumOutVo.setBfemaleAlim_s(0);
            sumOutVo.setBnoneAlim_s(0);
            sumOutVo.setBmaleAlim_v(0);
            sumOutVo.setBfemaleAlim_v(0);
            sumOutVo.setBnoneAlim_v(0);
            sumOutVo.setBmaleAlim_n(0);
            sumOutVo.setBfemaleAlim_n(0);
            sumOutVo.setBnoneAlim_n(0);
            sumOutVo.setTotalAlim_s(0);
            sumOutVo.setTotalAlim_v(0);
            sumOutVo.setTotalAlim_n(0);
            sumOutVo.setBtotalAlim_s(0);
            sumOutVo.setBtotalAlim_v(0);
            sumOutVo.setBtotalAlim_n(0);
        }

        List list = new ArrayList();
        for (int i=30; -1 < i; i --){
            P_PushStatusOutPutVo outVo = new P_PushStatusOutPutVo();
            outVo.setThe_date(pPushStatusInPutVo.getStartDate().substring(0,4) + "-" + pPushStatusInPutVo.getStartDate().substring(5,7) + "-" + DalbitUtil.lpad(Integer.toString(i+1),2,"0"));
            outVo.setBthe_date(pPushStatusInPutVo.getBeforStartDate().substring(0,4) + "-" + pPushStatusInPutVo.getBeforStartDate().substring(5,7) + "-" + DalbitUtil.lpad(Integer.toString(i+1),2,"0"));
            outVo.setYear(pPushStatusInPutVo.getStartDate().substring(0,4));
            outVo.setMonth(pPushStatusInPutVo.getStartDate().substring(5,7));
            outVo.setDay(Integer.toString(i+1));
            outVo.setByear(pPushStatusInPutVo.getBeforStartDate().substring(0,4));
            outVo.setBmonth(pPushStatusInPutVo.getBeforStartDate().substring(5,7));
            outVo.setBday(Integer.toString(i+1));
            boolean outVoSw = false;
            if(detailList.size() >= i+1) {
                if(DalbitUtil.isEmpty(detailList.get(i).getThe_date())) {
                    outVoSw = false;
                }else{
                    if (Integer.parseInt(detailList.get(i).getThe_date().substring(8,10)) == i+1) {
                        outVoSw = true;
                    }else{
                        outVoSw = false;
                    }
                }
            }else{
                outVoSw = false;
            }
            if(outVoSw){
                outVo.setMale_alim_s(detailList.get(i).getMale_alim_s());
                outVo.setFemale_alim_s(detailList.get(i).getFemale_alim_s());
                outVo.setNone_alim_s(detailList.get(i).getNone_alim_s());
                outVo.setMale_alim_v(detailList.get(i).getMale_alim_v());
                outVo.setFemale_alim_v(detailList.get(i).getFemale_alim_v());
                outVo.setNone_alim_v(detailList.get(i).getNone_alim_v());
                outVo.setMale_alim_n(detailList.get(i).getMale_alim_n());
                outVo.setFemale_alim_n(detailList.get(i).getFemale_alim_n());
                outVo.setNone_alim_n(detailList.get(i).getNone_alim_n());
                outVo.setTotal_alim_s(detailList.get(i).getMale_alim_s() + detailList.get(i).getFemale_alim_s() + detailList.get(i).getNone_alim_s());
                outVo.setTotal_alim_v(detailList.get(i).getMale_alim_v() + detailList.get(i).getFemale_alim_v() + detailList.get(i).getNone_alim_v());
                outVo.setTotal_alim_n(detailList.get(i).getMale_alim_n() + detailList.get(i).getFemale_alim_n() + detailList.get(i).getNone_alim_n());
            }else{
                outVo.setMale_alim_s(0);
                outVo.setFemale_alim_s(0);
                outVo.setNone_alim_s(0);
                outVo.setMale_alim_v(0);
                outVo.setFemale_alim_v(0);
                outVo.setNone_alim_v(0);
                outVo.setMale_alim_n(0);
                outVo.setFemale_alim_n(0);
                outVo.setNone_alim_n(0);
                outVo.setTotal_alim_s(0);
                outVo.setTotal_alim_v(0);
                outVo.setTotal_alim_n(0);
            }
            outVoSw = false;
            if(bDetailList.size() >= i+1) {
                if(DalbitUtil.isEmpty(bDetailList.get(i).getThe_date())){
                    outVoSw = false;
                }else {
                    if (Integer.parseInt(bDetailList.get(i).getThe_date().substring(8,10)) == i+1) {
                        outVoSw = true;
                    } else {
                        outVoSw = false;
                    }
                }
            }else{
                outVoSw = false;
            }

            if(outVoSw){
                outVo.setBmale_alim_s(bDetailList.get(i).getMale_alim_s());
                outVo.setBfemale_alim_s(bDetailList.get(i).getFemale_alim_s());
                outVo.setBnone_alim_s(bDetailList.get(i).getNone_alim_s());
                outVo.setBmale_alim_v(bDetailList.get(i).getMale_alim_v());
                outVo.setBfemale_alim_v(bDetailList.get(i).getFemale_alim_v());
                outVo.setBnone_alim_v(bDetailList.get(i).getNone_alim_v());
                outVo.setBmale_alim_n(bDetailList.get(i).getMale_alim_n());
                outVo.setBfemale_alim_n(bDetailList.get(i).getFemale_alim_n());
                outVo.setBnone_alim_n(bDetailList.get(i).getNone_alim_n());
                outVo.setBtotal_alim_s(bDetailList.get(i).getMale_alim_s() + bDetailList.get(i).getFemale_alim_s() + bDetailList.get(i).getNone_alim_s());
                outVo.setBtotal_alim_v(bDetailList.get(i).getMale_alim_v() + bDetailList.get(i).getFemale_alim_v() + bDetailList.get(i).getNone_alim_v());
                outVo.setBtotal_alim_n(bDetailList.get(i).getMale_alim_n() + bDetailList.get(i).getFemale_alim_n() + bDetailList.get(i).getNone_alim_n());
            }else{
                outVo.setBmale_alim_s(0);
                outVo.setBfemale_alim_s(0);
                outVo.setBnone_alim_s(0);
                outVo.setBmale_alim_v(0);
                outVo.setBfemale_alim_v(0);
                outVo.setBnone_alim_v(0);
                outVo.setBmale_alim_n(0);
                outVo.setBfemale_alim_n(0);
                outVo.setBnone_alim_n(0);
                outVo.setBtotal_alim_s(0);
                outVo.setBtotal_alim_v(0);
                outVo.setBtotal_alim_n(0);
            }
            list.add(outVo);
        }

        var result = new HashMap<String, Object>();
        result.put("totalInfo", sumOutVo);
        result.put("detailList", list);
        return gsonUtil.toJson(new JsonOutputVo(Status.조회, result));
    }

    public String callPushYear(P_PushStatusInPutVo pPushStatusInPutVo){
        ProcedureVo procedureVo = new ProcedureVo(pPushStatusInPutVo);
        ArrayList<P_PushStatusOutPutVo> detailList = sta_PushDao.callPushStatus(procedureVo);
        P_PushStatusOutVo totalInfo = new Gson().fromJson(procedureVo.getExt(), P_PushStatusOutVo.class);

        for(int i=0;i<detailList.size();i++){
            detailList.get(i).setTotal_alim_s(detailList.get(i).getMale_alim_s() + detailList.get(i).getFemale_alim_s() + detailList.get(i).getNone_alim_s());
            detailList.get(i).setTotal_alim_v(detailList.get(i).getMale_alim_v() + detailList.get(i).getFemale_alim_v() + detailList.get(i).getNone_alim_v());
            detailList.get(i).setTotal_alim_n(detailList.get(i).getMale_alim_n() + detailList.get(i).getFemale_alim_n() + detailList.get(i).getNone_alim_n());
        }
        totalInfo.setTotalAlim_s(totalInfo.getMaleAlim_s() + totalInfo.getFemaleAlim_s() + totalInfo.getNoneAlim_s());
        totalInfo.setTotalAlim_v(totalInfo.getMaleAlim_v() + totalInfo.getFemaleAlim_v() + totalInfo.getNoneAlim_v());
        totalInfo.setTotalAlim_n(totalInfo.getMaleAlim_n() + totalInfo.getFemaleAlim_n() + totalInfo.getNoneAlim_n());

        if(Integer.parseInt(procedureVo.getRet()) <= 0){
            return gsonUtil.toJson(new JsonOutputVo(Status.데이터없음));
        }
        var result = new HashMap<String, Object>();
        result.put("totalInfo", totalInfo);
        result.put("detailList", detailList);

        return gsonUtil.toJson(new JsonOutputVo(Status.조회, result));
    }

    public String callNewNotice(P_PushStatusInPutVo pPushStatusInPutVo){
        ProcedureVo procedureVo = new ProcedureVo(pPushStatusInPutVo);
        ArrayList<P_PushStatusOutPutVo> detailList = sta_PushDao.callPushStatus(procedureVo);

        if(detailList.size() <= 0){
            return gsonUtil.toJson(new JsonOutputVo(Status.데이터없음));
        }
        var result = new HashMap<String, Object>();
        result.put("detailList", detailList);

        return gsonUtil.toJson(new JsonOutputVo(Status.조회, result));
    }

    public String callDayDetailPopup(P_PushStatusInPutVo pPushStatusInPutVo){
        ProcedureVo procedureVo = new ProcedureVo(pPushStatusInPutVo);
        sta_PushDao.callDayDetailPopup(procedureVo);

        P_PushStatusOutVo totalInfo = new Gson().fromJson(procedureVo.getExt(), P_PushStatusOutVo.class);
//        if(Integer.parseInt(procedureVo.getRet()) <= 0){
//            return gsonUtil.toJson(new JsonOutputVo(Status.데이터없음));
//        }
        var result = new HashMap<String, Object>();
        result.put("totalInfo", totalInfo);

        return gsonUtil.toJson(new JsonOutputVo(Status.조회, result));
    }

    /**
     * PUSH 발송 회원 알림받기 회원 상세내역
     */
    public String callMemeberNoticeDetail(P_PushHistoryInputVo pPushHistoryInputVo) {

        ProcedureVo procedureVo = new ProcedureVo(pPushHistoryInputVo);
        ArrayList<P_PushHistoryOutputVo> list = sta_PushDao.callMemeberNoticeDetail(procedureVo);
        P_PushHistoryOutputVo totalInfo = new Gson().fromJson(procedureVo.getExt(), P_PushHistoryOutputVo.class);

        String result;
        if(list != null && list.size() > 0) {
            result = gsonUtil.toJson(new JsonOutputVo(Status.조회, list, new PagingVo(totalInfo.getTotalCnt(), totalInfo.getPageStart(), totalInfo.getPageCnt()), totalInfo));
        }else {
            result = gsonUtil.toJson(new JsonOutputVo(Status.데이터없음, new ArrayList<P_PushHistoryOutputVo>(), new PagingVo(pPushHistoryInputVo.getTotalCnt(), pPushHistoryInputVo.getPageStart(), pPushHistoryInputVo.getPageCnt()),totalInfo));
        }

        return result;
    }
}
