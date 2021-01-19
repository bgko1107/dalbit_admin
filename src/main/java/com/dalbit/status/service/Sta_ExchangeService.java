package com.dalbit.status.service;


import com.dalbit.common.code.Status;
import com.dalbit.common.vo.JsonOutputVo;
import com.dalbit.common.vo.ProcedureVo;
import com.dalbit.status.dao.Sta_ExchangeDao;
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
public class Sta_ExchangeService {

    @Autowired
    MessageUtil messageUtil;
    @Autowired
    GsonUtil gsonUtil;
    @Autowired
    Sta_ExchangeDao sta_ExchangeDao;

    /**
     * 환전 통합현황 월간
     */
    public String callExchangeMonth(P_StatVo pStatVo){
        ProcedureVo procedureVo = new ProcedureVo(pStatVo);
        ArrayList<P_ExchangeTotalOutDetailVo> detailList_n = sta_ExchangeDao.callExchangeMonth(procedureVo);
        P_ExchangeTotalOutVo totalInfo_n = new Gson().fromJson(procedureVo.getExt(), P_ExchangeTotalOutVo.class);
        if(Integer.parseInt(procedureVo.getRet()) <= 0){
            return gsonUtil.toJson(new JsonOutputVo(Status.데이터없음));
        }

        pStatVo.setStartDate(pStatVo.getBeforStartDate());
        pStatVo.setEndDate(pStatVo.getBeforEndDate());
        ProcedureVo procedureVo2 = new ProcedureVo(pStatVo);
        ArrayList<P_ExchangeTotalOutDetailVo> detailList_b = sta_ExchangeDao.callExchangeMonth(procedureVo2);
        P_ExchangeTotalOutVo totalInfo_b = new Gson().fromJson(procedureVo2.getExt(), P_ExchangeTotalOutVo.class);
        if(Integer.parseInt(procedureVo2.getRet()) <= 0){
            return gsonUtil.toJson(new JsonOutputVo(Status.데이터없음));
        }

        P_ExchangeTotalOutVo totalOutVo = new P_ExchangeTotalOutVo();
        totalOutVo.setTot_specialdj_succ_Cnt(totalInfo_b.getTot_specialdj_succ_Cnt());
        totalOutVo.setTot_specialdj_succ_Amt(totalInfo_b.getTot_specialdj_succ_Amt());
        totalOutVo.setTot_specialdj_succ_byeol_Cnt(totalInfo_b.getTot_specialdj_succ_byeol_Cnt());
        totalOutVo.setTot_succ_Cnt(totalInfo_b.getTot_succ_Cnt());
        totalOutVo.setTot_succ_Amt(totalInfo_b.getTot_succ_Amt());
        totalOutVo.setTot_succ_byeol_Cnt(totalInfo_b.getTot_succ_byeol_Cnt());
        totalOutVo.setNTot_specialdj_succ_Cnt(totalInfo_n.getTot_specialdj_succ_Cnt());
        totalOutVo.setNTot_specialdj_succ_Amt(totalInfo_n.getTot_specialdj_succ_Amt());
        totalOutVo.setNTot_specialdj_succ_byeol_Cnt(totalInfo_n.getTot_specialdj_succ_byeol_Cnt());
        totalOutVo.setNTot_succ_Cnt(totalInfo_n.getTot_succ_Cnt());
        totalOutVo.setNTot_succ_Amt(totalInfo_n.getTot_succ_Amt());
        totalOutVo.setNTot_succ_byeol_Cnt(totalInfo_n.getTot_succ_byeol_Cnt());

        List list = new ArrayList();
        for (int i=30; -1 < i; i --){
            P_ExchangeTotalOutDetailVo outVo = new P_ExchangeTotalOutDetailVo();
            outVo.setDay(Integer.toString(i+1));

            if(detailList_n.size() >= i+1) {
                if (detailList_n.get(i).getThe_date().substring(8).equals(DalbitUtil.lpad(Integer.toString(i+1),2,"0"))) {
                    outVo.setNSpecialdj_succ_Cnt(detailList_n.get(i).getSpecialdj_succ_Cnt());
                    outVo.setNSpecialdj_succ_Amt(detailList_n.get(i).getSpecialdj_succ_Amt());
                    outVo.setNSpecialdj_succ_byeol_Cnt(detailList_n.get(i).getSpecialdj_succ_byeol_Cnt());
                    outVo.setNSucc_Cnt(detailList_n.get(i).getSucc_Cnt());
                    outVo.setNSucc_Amt(detailList_n.get(i).getSucc_Amt());
                    outVo.setNSucc_byeol_Cnt(detailList_n.get(i).getSucc_byeol_Cnt());
                }else{
                    outVo.setNSpecialdj_succ_Cnt(0);
                    outVo.setNSpecialdj_succ_Amt(0);
                    outVo.setNSpecialdj_succ_byeol_Cnt(0);
                    outVo.setNSucc_Cnt(0);
                    outVo.setNSucc_Amt(0);
                    outVo.setNSucc_byeol_Cnt(0);
                }
            }else{
                outVo.setNSpecialdj_succ_Cnt(0);
                outVo.setNSpecialdj_succ_Amt(0);
                outVo.setNSpecialdj_succ_byeol_Cnt(0);
                outVo.setNSucc_Cnt(0);
                outVo.setNSucc_Amt(0);
                outVo.setNSucc_byeol_Cnt(0);
            }

            if(detailList_b.size() >= i+1) {
                if (detailList_b.get(i).getThe_date().substring(8).equals(DalbitUtil.lpad(Integer.toString(i+1),2,"0"))) {
                    outVo.setSpecialdj_succ_Cnt(detailList_b.get(i).getSpecialdj_succ_Cnt());
                    outVo.setSpecialdj_succ_Amt(detailList_b.get(i).getSpecialdj_succ_Amt());
                    outVo.setSpecialdj_succ_byeol_Cnt(detailList_b.get(i).getSpecialdj_succ_byeol_Cnt());
                    outVo.setSucc_Cnt(detailList_b.get(i).getSucc_Cnt());
                    outVo.setSucc_Amt(detailList_b.get(i).getSucc_Amt());
                    outVo.setSucc_byeol_Cnt(detailList_b.get(i).getSucc_byeol_Cnt());
                }else{
                    outVo.setSpecialdj_succ_Cnt(0);
                    outVo.setSpecialdj_succ_Amt(0);
                    outVo.setSpecialdj_succ_byeol_Cnt(0);
                    outVo.setSucc_Cnt(0);
                    outVo.setSucc_Amt(0);
                    outVo.setSucc_byeol_Cnt(0);
                }
            }else{
                outVo.setSpecialdj_succ_Cnt(0);
                outVo.setSpecialdj_succ_Amt(0);
                outVo.setSpecialdj_succ_byeol_Cnt(0);
                outVo.setSucc_Cnt(0);
                outVo.setSucc_Amt(0);
                outVo.setSucc_byeol_Cnt(0);
            }
            list.add(outVo);
        }

        var result = new HashMap<String, Object>();
        result.put("totalInfo", totalOutVo);
        result.put("detailList", list);

        return gsonUtil.toJson(new JsonOutputVo(Status.조회, result));
    }


    /**
     * 환전 통합현황 성별
     */
    public String callExchangeGender(P_StatVo pStatVo){
        ProcedureVo procedureVo = new ProcedureVo(pStatVo);
        ArrayList<P_ExchangeGenderOutDetailVo> detailList_n = sta_ExchangeDao.callExchangeGender(procedureVo);
        P_ExchangeGenderOutVo totalInfo = new Gson().fromJson(procedureVo.getExt(), P_ExchangeGenderOutVo.class);
        if(Integer.parseInt(procedureVo.getRet()) <= 0){
            return gsonUtil.toJson(new JsonOutputVo(Status.데이터없음));
        }

        pStatVo.setStartDate(pStatVo.getBeforStartDate());
        pStatVo.setEndDate(pStatVo.getBeforEndDate());
        ProcedureVo procedureVo2 = new ProcedureVo(pStatVo);
        ArrayList<P_ExchangeGenderOutDetailVo> detailList_b = sta_ExchangeDao.callExchangeGender(procedureVo2);
        P_ExchangeGenderOutVo totalInfo_b = new Gson().fromJson(procedureVo2.getExt(), P_ExchangeGenderOutVo.class);
        if(Integer.parseInt(procedureVo2.getRet()) <= 0){
            return gsonUtil.toJson(new JsonOutputVo(Status.데이터없음));
        }

        totalInfo.setB_tot_specialdj_succ_mCnt(totalInfo_b.getTot_specialdj_succ_mCnt());
        totalInfo.setB_tot_specialdj_succ_mAmt(totalInfo_b.getTot_specialdj_succ_mAmt());
        totalInfo.setB_tot_specialdj_succ_byeol_mCnt(totalInfo_b.getTot_specialdj_succ_byeol_mCnt());
        totalInfo.setB_tot_specialdj_succ_fcnt(totalInfo_b.getTot_specialdj_succ_fcnt());
        totalInfo.setB_tot_specialdj_succ_fAmt(totalInfo_b.getTot_specialdj_succ_fAmt());
        totalInfo.setB_tot_specialdj_succ_byeol_fCnt(totalInfo_b.getTot_specialdj_succ_byeol_fCnt());
        totalInfo.setB_tot_specialdj_succ_nCnt(totalInfo_b.getTot_specialdj_succ_nCnt());
        totalInfo.setB_tot_specialdj_succ_nAmt(totalInfo_b.getTot_specialdj_succ_nAmt());
        totalInfo.setB_tot_specialdj_succ_byeol_nCnt(totalInfo_b.getTot_specialdj_succ_byeol_nCnt());
        totalInfo.setB_tot_succ_mCnt(totalInfo_b.getTot_succ_mCnt());
        totalInfo.setB_tot_succ_mAmt(totalInfo_b.getTot_succ_mAmt());
        totalInfo.setB_tot_succ_byeol_mCnt(totalInfo_b.getTot_succ_byeol_mCnt());
        totalInfo.setB_tot_succ_fCnt(totalInfo_b.getTot_succ_fCnt());
        totalInfo.setB_tot_succ_fAmt(totalInfo_b.getTot_succ_fAmt());
        totalInfo.setB_tot_succ_byeol_fCnt(totalInfo_b.getTot_succ_byeol_fCnt());
        totalInfo.setB_tot_succ_nCnt(totalInfo_b.getTot_succ_nCnt());
        totalInfo.setB_tot_succ_nAmt(totalInfo_b.getTot_succ_nAmt());
        totalInfo.setB_tot_succ_byeol_nCnt(totalInfo_b.getTot_succ_byeol_nCnt());

        List list = new ArrayList();
        for (int i=30; -1 < i; i --){
            P_ExchangeGenderOutDetailVo outVo = new P_ExchangeGenderOutDetailVo();
            outVo.setDay(Integer.toString(i+1));
            if(detailList_n.size() >= i+1) {
                if (detailList_n.get(i).getThe_date().substring(8).equals(DalbitUtil.lpad(Integer.toString(i+1),2,"0"))) {
                    outVo.setSpecialdj_succ_mCnt(detailList_n.get(i).getSpecialdj_succ_mCnt());
                    outVo.setSpecialdj_succ_mAmt(detailList_n.get(i).getSpecialdj_succ_mAmt());
                    outVo.setSpecialdj_succ_byeol_mCnt(detailList_n.get(i).getSpecialdj_succ_byeol_mCnt());
                    outVo.setSpecialdj_succ_fcnt(detailList_n.get(i).getSpecialdj_succ_fcnt());
                    outVo.setSpecialdj_succ_fAmt(detailList_n.get(i).getSpecialdj_succ_fAmt());
                    outVo.setSpecialdj_succ_byeol_fCnt(detailList_n.get(i).getSpecialdj_succ_byeol_fCnt());
                    outVo.setSpecialdj_succ_nCnt(detailList_n.get(i).getSpecialdj_succ_nCnt());
                    outVo.setSpecialdj_succ_nAmt(detailList_n.get(i).getSpecialdj_succ_nAmt());
                    outVo.setSpecialdj_succ_byeol_nCnt(detailList_n.get(i).getSpecialdj_succ_byeol_nCnt());
                    outVo.setSucc_mCnt(detailList_n.get(i).getSucc_mCnt());
                    outVo.setSucc_mAmt(detailList_n.get(i).getSucc_mAmt());
                    outVo.setSucc_byeol_mCnt(detailList_n.get(i).getSucc_byeol_mCnt());
                    outVo.setSucc_fCnt(detailList_n.get(i).getSucc_fCnt());
                    outVo.setSucc_fAmt(detailList_n.get(i).getSucc_fAmt());
                    outVo.setSucc_byeol_fCnt(detailList_n.get(i).getSucc_byeol_fCnt());
                    outVo.setSucc_nCnt(detailList_n.get(i).getSucc_nCnt());
                    outVo.setSucc_nAmt(detailList_n.get(i).getSucc_nAmt());
                    outVo.setSucc_byeol_nCnt(detailList_n.get(i).getSucc_byeol_nCnt());
                }else{
                    outVo.setSpecialdj_succ_mCnt(0);
                    outVo.setSpecialdj_succ_mAmt(0);
                    outVo.setSpecialdj_succ_byeol_mCnt(0);
                    outVo.setSpecialdj_succ_fcnt(0);
                    outVo.setSpecialdj_succ_fAmt(0);
                    outVo.setSpecialdj_succ_byeol_fCnt(0);
                    outVo.setSpecialdj_succ_nCnt(0);
                    outVo.setSpecialdj_succ_nAmt(0);
                    outVo.setSpecialdj_succ_byeol_nCnt(0);
                    outVo.setSucc_mCnt(0);
                    outVo.setSucc_mAmt(0);
                    outVo.setSucc_byeol_mCnt(0);
                    outVo.setSucc_fCnt(0);
                    outVo.setSucc_fAmt(0);
                    outVo.setSucc_byeol_fCnt(0);
                    outVo.setSucc_nCnt(0);
                    outVo.setSucc_nAmt(0);
                    outVo.setSucc_byeol_nCnt(0);
                }
            }else{
                outVo.setSpecialdj_succ_mCnt(0);
                outVo.setSpecialdj_succ_mAmt(0);
                outVo.setSpecialdj_succ_byeol_mCnt(0);
                outVo.setSpecialdj_succ_fcnt(0);
                outVo.setSpecialdj_succ_fAmt(0);
                outVo.setSpecialdj_succ_byeol_fCnt(0);
                outVo.setSpecialdj_succ_nCnt(0);
                outVo.setSpecialdj_succ_nAmt(0);
                outVo.setSpecialdj_succ_byeol_nCnt(0);
                outVo.setSucc_mCnt(0);
                outVo.setSucc_mAmt(0);
                outVo.setSucc_byeol_mCnt(0);
                outVo.setSucc_fCnt(0);
                outVo.setSucc_fAmt(0);
                outVo.setSucc_byeol_fCnt(0);
                outVo.setSucc_nCnt(0);
                outVo.setSucc_nAmt(0);
                outVo.setSucc_byeol_nCnt(0);
            }

            if(detailList_b.size() >= i+1) {
                if (detailList_b.get(i).getThe_date().substring(8).equals(DalbitUtil.lpad(Integer.toString(i+1),2,"0"))) {
                    outVo.setB_specialdj_succ_mCnt(detailList_b.get(i).getSpecialdj_succ_mCnt());
                    outVo.setB_specialdj_succ_mAmt(detailList_b.get(i).getSpecialdj_succ_mAmt());
                    outVo.setB_specialdj_succ_byeol_mCnt(detailList_b.get(i).getSpecialdj_succ_byeol_mCnt());
                    outVo.setB_specialdj_succ_fcnt(detailList_b.get(i).getSpecialdj_succ_fcnt());
                    outVo.setB_specialdj_succ_fAmt(detailList_b.get(i).getSpecialdj_succ_fAmt());
                    outVo.setB_specialdj_succ_byeol_fCnt(detailList_b.get(i).getSpecialdj_succ_byeol_fCnt());
                    outVo.setB_specialdj_succ_nCnt(detailList_b.get(i).getSpecialdj_succ_nCnt());
                    outVo.setB_specialdj_succ_nAmt(detailList_b.get(i).getSpecialdj_succ_nAmt());
                    outVo.setB_specialdj_succ_byeol_nCnt(detailList_b.get(i).getSpecialdj_succ_byeol_nCnt());
                    outVo.setB_succ_mCnt(detailList_b.get(i).getSucc_mCnt());
                    outVo.setB_succ_mAmt(detailList_b.get(i).getSucc_mAmt());
                    outVo.setB_succ_byeol_mCnt(detailList_b.get(i).getSucc_byeol_mCnt());
                    outVo.setB_succ_fCnt(detailList_b.get(i).getSucc_fCnt());
                    outVo.setB_succ_fAmt(detailList_b.get(i).getSucc_fAmt());
                    outVo.setB_succ_byeol_fCnt(detailList_b.get(i).getSucc_byeol_fCnt());
                    outVo.setB_succ_nCnt(detailList_b.get(i).getSucc_nCnt());
                    outVo.setB_succ_nAmt(detailList_b.get(i).getSucc_nAmt());
                    outVo.setB_succ_byeol_nCnt(detailList_b.get(i).getSucc_byeol_nCnt());
                }else{
                    outVo.setB_specialdj_succ_mCnt(0);
                    outVo.setB_specialdj_succ_mAmt(0);
                    outVo.setB_specialdj_succ_byeol_mCnt(0);
                    outVo.setB_specialdj_succ_fcnt(0);
                    outVo.setB_specialdj_succ_fAmt(0);
                    outVo.setB_specialdj_succ_byeol_fCnt(0);
                    outVo.setB_specialdj_succ_nCnt(0);
                    outVo.setB_specialdj_succ_nAmt(0);
                    outVo.setB_specialdj_succ_byeol_nCnt(0);
                    outVo.setB_succ_mCnt(0);
                    outVo.setB_succ_mAmt(0);
                    outVo.setB_succ_byeol_mCnt(0);
                    outVo.setB_succ_fCnt(0);
                    outVo.setB_succ_fAmt(0);
                    outVo.setB_succ_byeol_fCnt(0);
                    outVo.setB_succ_nCnt(0);
                    outVo.setB_succ_nAmt(0);
                    outVo.setB_succ_byeol_nCnt(0);
                }
            }else{
                outVo.setB_specialdj_succ_mCnt(0);
                outVo.setB_specialdj_succ_mAmt(0);
                outVo.setB_specialdj_succ_byeol_mCnt(0);
                outVo.setB_specialdj_succ_fcnt(0);
                outVo.setB_specialdj_succ_fAmt(0);
                outVo.setB_specialdj_succ_byeol_fCnt(0);
                outVo.setB_specialdj_succ_nCnt(0);
                outVo.setB_specialdj_succ_nAmt(0);
                outVo.setB_specialdj_succ_byeol_nCnt(0);
                outVo.setB_succ_mCnt(0);
                outVo.setB_succ_mAmt(0);
                outVo.setB_succ_byeol_mCnt(0);
                outVo.setB_succ_fCnt(0);
                outVo.setB_succ_fAmt(0);
                outVo.setB_succ_byeol_fCnt(0);
                outVo.setB_succ_nCnt(0);
                outVo.setB_succ_nAmt(0);
                outVo.setB_succ_byeol_nCnt(0);
            }
            list.add(outVo);
        }


        var result = new HashMap<String, Object>();
        result.put("totalInfo", totalInfo);
        result.put("detailList", list);

        return gsonUtil.toJson(new JsonOutputVo(Status.조회, result));
    }

    /**
     * 환전 통합현황 주별
     */
    public String callExchangeWeek(P_StatVo pStatVo){
        ProcedureVo procedureVo = new ProcedureVo(pStatVo);
        ArrayList<P_ExchangeWeekOutDetailVo> detailList = sta_ExchangeDao.callExchangeWeek(procedureVo);
        P_ExchangeWeekOutVo totalInfo = new Gson().fromJson(procedureVo.getExt(), P_ExchangeWeekOutVo.class);
        if(Integer.parseInt(procedureVo.getRet()) <= 0){
            return gsonUtil.toJson(new JsonOutputVo(Status.데이터없음));
        }

        var result = new HashMap<String, Object>();
        result.put("totalInfo", totalInfo);
        result.put("detailList", detailList);

        return gsonUtil.toJson(new JsonOutputVo(Status.조회, result));
    }

}
