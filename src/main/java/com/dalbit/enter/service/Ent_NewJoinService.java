package com.dalbit.enter.service;

import com.dalbit.common.code.Status;
import com.dalbit.common.vo.JsonOutputVo;
import com.dalbit.common.vo.ProcedureVo;
import com.dalbit.enter.dao.Ent_NewJoinDao;
import com.dalbit.enter.vo.procedure.*;
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
public class Ent_NewJoinService {

    @Autowired
    MessageUtil messageUtil;
    @Autowired
    GsonUtil gsonUtil;
    @Autowired
    Ent_NewJoinDao ent_NewJoinDao;

    /**
     * 회원가입 총계
     * @param pStatVo
     * @return
     */
    public String callInfoLive(P_StatVo pStatVo){

        ArrayList resultList = new ArrayList();
        String[] dateList = pStatVo.getDateList().split("@");

        int slctType_date = 0;
        if(pStatVo.getSlctType() == 0) {
            slctType_date = 25;
        }else if(pStatVo.getSlctType() == 1) {
            slctType_date = 32;
        }
        for(int i=0;i<dateList.length;i++){
            if(dateList[i].indexOf("-") > -1){
                pStatVo.setStartDate(dateList[i].split("-")[0]);
                pStatVo.setEndDate(dateList[i].split("-")[1]);
            }else{
                pStatVo.setStartDate(dateList[i]);
                pStatVo.setEndDate(dateList[i]);
            }

            ProcedureVo procedureVo = new ProcedureVo(pStatVo);
            List<P_JoinLiveOutDetailVo> detailList =  ent_NewJoinDao.callJoinLive(procedureVo);
            P_JoinLiveOutVo totalInfo = new Gson().fromJson(procedureVo.getExt(), P_JoinLiveOutVo.class);

            boolean zeroSw = false;
            if(detailList.size() < slctType_date){
                int detailList_size = detailList.size();
                for (int j = 0; j < slctType_date; j++) {
                    P_JoinLiveOutDetailVo outVo = new P_JoinLiveOutDetailVo();
                    for (int k = 0; k < detailList_size; k++){
                        if(pStatVo.getSlctType() == 0) {
                            if (detailList.get(k).getThe_hr() == j) {
                                zeroSw = true;
                                break;
                            }
                        }else if(pStatVo.getSlctType() == 1) {
                            if (Integer.parseInt(detailList.get(k).getThe_date().substring(5,2)) == j) {
                                detailList.get(k).setThe_day(j);
                                zeroSw = true;
                                break;
                            }

                        }
                    }
                    if(!zeroSw){
                        outVo.setThe_date(dateList[i]);
                        outVo.setThe_day(j);
                        outVo.setThe_hr(j);
                        outVo.setPhone_join_mCnt(0);
                        outVo.setPhone_out_mCnt(0);
                        outVo.setKakao_join_mCnt(0);
                        outVo.setKakao_out_mCnt(0);
                        outVo.setNaver_join_mCnt(0);
                        outVo.setNaver_out_mCnt(0);
                        outVo.setFbook_join_mCnt(0);
                        outVo.setFbook_out_mCnt(0);
                        outVo.setApple_join_mCnt(0);
                        outVo.setApple_out_mCnt(0);
                        outVo.setGoogle_join_mCnt(0);
                        outVo.setGoogle_out_mCnt(0);
                        outVo.setTotal_join_mCnt(0);
                        outVo.setTotal_out_mCnt(0);
                        outVo.setPhone_join_fCnt(0);
                        outVo.setPhone_out_fCnt(0);
                        outVo.setKakao_join_fCnt(0);
                        outVo.setKakao_out_fCnt(0);
                        outVo.setNaver_join_fCnt(0);
                        outVo.setNaver_out_fCnt(0);
                        outVo.setFbook_join_fCnt(0);
                        outVo.setFbook_out_fCnt(0);
                        outVo.setApple_join_fCnt(0);
                        outVo.setApple_out_fCnt(0);
                        outVo.setGoogle_join_fCnt(0);
                        outVo.setGoogle_out_fCnt(0);
                        outVo.setTotal_join_fCnt(0);
                        outVo.setTotal_out_fCnt(0);
                        outVo.setPhone_join_nCnt(0);
                        outVo.setPhone_out_nCnt(0);
                        outVo.setKakao_join_nCnt(0);
                        outVo.setKakao_out_nCnt(0);
                        outVo.setNaver_join_nCnt(0);
                        outVo.setNaver_out_nCnt(0);
                        outVo.setFbook_join_nCnt(0);
                        outVo.setFbook_out_nCnt(0);
                        outVo.setApple_join_nCnt(0);
                        outVo.setApple_out_nCnt(0);
                        outVo.setGoogle_join_nCnt(0);
                        outVo.setGoogle_out_nCnt(0);
                        outVo.setTotal_join_nCnt(0);
                        outVo.setTotal_out_nCnt(0);
                        outVo.setTotal_join_Cnt(0);
                        outVo.setTotal_out_Cnt(0);

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
    /**
     * 회원가입 일자별
     * @param pStatVo
     * @return
     */
    public String callCalender(P_StatVo pStatVo){
        String[] dateList = pStatVo.getDateList().split("@");

        pStatVo.setStartDate(dateList[0].split("-")[0]);
        pStatVo.setEndDate(dateList[0].split("-")[1]);

        ProcedureVo procedureVo = new ProcedureVo(pStatVo);
        ArrayList<P_JoinCalenderOutDetailVo> detailList =  ent_NewJoinDao.callCalender(procedureVo);
        P_JoinCalenderOutVo totalInfo = new Gson().fromJson(procedureVo.getExt(), P_JoinCalenderOutVo.class);
        if(Integer.parseInt(procedureVo.getRet()) <= 0){
            return gsonUtil.toJson(new JsonOutputVo(Status.데이터없음));
        }

        var result = new HashMap<String, Object>();
        result.put("totalInfo", totalInfo);
        result.put("detailList", detailList);

        return gsonUtil.toJson(new JsonOutputVo(Status.조회, result));
    }

    /**
     * 회원가입 플랫폼 성별
     * @param pStatVo
     * @return
             */
    public String callMonth(P_StatVo pStatVo){
        ProcedureVo procedureVo = new ProcedureVo(pStatVo);
        ArrayList<P_JoinMonthOutDetailVo> detailList =  ent_NewJoinDao.callMonth(procedureVo);
        P_JoinMonthOutVo totalInfo = new Gson().fromJson(procedureVo.getExt(), P_JoinMonthOutVo.class);
        if(Integer.parseInt(procedureVo.getRet()) <= 0){
            return gsonUtil.toJson(new JsonOutputVo(Status.데이터없음));
        }
        var result = new HashMap<String, Object>();
        result.put("totalInfo", totalInfo);
        result.put("detailList", detailList);

        return gsonUtil.toJson(new JsonOutputVo(Status.조회, result));
    }

    /**
     * 회원가입 플랫폼 연령
     * @param pStatVo
     * @return
     */
    public String callJoinPlatformAge(P_StatVo pStatVo){
        ProcedureVo procedureVo = new ProcedureVo(pStatVo);
        List<P_JoinPlatformAgeOutDetailVo> detailList =  ent_NewJoinDao.callJoinPlatformAge(procedureVo);
        P_JoinPlatformAgeOutVo totalInfo = new Gson().fromJson(procedureVo.getExt(), P_JoinPlatformAgeOutVo.class);
        if(Integer.parseInt(procedureVo.getRet()) <= 0){
            return gsonUtil.toJson(new JsonOutputVo(Status.데이터없음));
        }
        var result = new HashMap<String, Object>();
        result.put("totalInfo", totalInfo);
        result.put("detailList", detailList);

        return gsonUtil.toJson(new JsonOutputVo(Status.조회, result));
    }

    /**
     * 회원가입 플랫폼 성별
     * @param pStatVo
     * @return
             */
    public String callJoinPlatformGender(P_StatVo pStatVo){
        ProcedureVo procedureVo = new ProcedureVo(pStatVo);
        List<P_JoinPlatformGenderOutDetailVo> detailList =  ent_NewJoinDao.callJoinPlatformGender(procedureVo);
        P_JoinPlatformGenderOutVo totalInfo = new Gson().fromJson(procedureVo.getExt(), P_JoinPlatformGenderOutVo.class);
        if(Integer.parseInt(procedureVo.getRet()) <= 0){
            return gsonUtil.toJson(new JsonOutputVo(Status.데이터없음));
        }
        var result = new HashMap<String, Object>();
        result.put("totalInfo", totalInfo);
        result.put("detailList", detailList);

        return gsonUtil.toJson(new JsonOutputVo(Status.조회, result));
    }


}
