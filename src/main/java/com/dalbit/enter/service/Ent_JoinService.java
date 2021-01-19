package com.dalbit.enter.service;

import com.dalbit.common.code.Status;
import com.dalbit.common.vo.JsonOutputVo;
import com.dalbit.common.vo.ProcedureVo;
import com.dalbit.enter.dao.Ent_JoinDao;
import com.dalbit.enter.vo.procedure.*;
import com.dalbit.util.GsonUtil;
import com.dalbit.util.MessageUtil;
import com.google.gson.Gson;
import lombok.extern.slf4j.Slf4j;
import lombok.var;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;

@Slf4j
@Service
public class Ent_JoinService {

    @Autowired
    MessageUtil messageUtil;
    @Autowired
    GsonUtil gsonUtil;
    @Autowired
    Ent_JoinDao entJoinDao;

    /**
     * 회원가입 총계
     * @param pStatVo
     * @return
     */
    public String callJoinTotal(P_StatVo pStatVo){
        ProcedureVo procedureVo = new ProcedureVo(pStatVo);
        List<P_JoinTotalOutDetailVo> detailList =  entJoinDao.callJoinTotal(procedureVo);

        P_JoinTotalOutVo totalInfo = new Gson().fromJson(procedureVo.getExt(), P_JoinTotalOutVo.class);


        if(Integer.parseInt(procedureVo.getRet()) <= 0){
            return gsonUtil.toJson(new JsonOutputVo(Status.데이터없음));
        }

        var result = new HashMap<String, Object>();
        result.put("totalInfo", totalInfo);
        result.put("detailList", detailList);

        return gsonUtil.toJson(new JsonOutputVo(Status.조회, result));
    }

    /**
     * 회원가입 성별
     * @param pStatVo
     * @return
     */
    public String callJoinGender(P_StatVo pStatVo){
        ProcedureVo procedureVo = new ProcedureVo(pStatVo);
        List<P_JoinGenderOutDetailVo> detailList =  entJoinDao.callJoinGender(procedureVo);

        P_JoinGenderOutVo totalInfo = new Gson().fromJson(procedureVo.getExt(), P_JoinGenderOutVo.class);


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
        List<P_JoinPlatformGenderOutDetailVo> detailList =  entJoinDao.callJoinPlatformGender(procedureVo);

        P_JoinPlatformGenderOutVo totalInfo = new Gson().fromJson(procedureVo.getExt(), P_JoinPlatformGenderOutVo.class);


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
        List<P_JoinPlatformAgeOutDetailVo> detailList =  entJoinDao.callJoinPlatformAge(procedureVo);

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
     * 회원탈퇴
     * @param pStatVo
     * @return
     */
    public String callJoinWithdraw(P_StatVo pStatVo){
        ProcedureVo procedureVo = new ProcedureVo(pStatVo);
        List<P_JoinWithdrawOutDetailVo> detailList =  entJoinDao.callJoinWithdraw(procedureVo);

        P_JoinWithdrawOutVo totalInfo = new Gson().fromJson(procedureVo.getExt(), P_JoinWithdrawOutVo.class);


        if(Integer.parseInt(procedureVo.getRet()) <= 0){
            return gsonUtil.toJson(new JsonOutputVo(Status.데이터없음));
        }

        var result = new HashMap<String, Object>();
        result.put("totalInfo", totalInfo);
        result.put("detailList", detailList);

        return gsonUtil.toJson(new JsonOutputVo(Status.조회, result));
    }

    /**
     * 어드민 가입현황 고정
     * @return
     */
    public String callStatJoin(){
        ProcedureVo procedureVo = new ProcedureVo();
        entJoinDao.callStatJoin(procedureVo);

        P_StatJoinOutVo joinInfo = new Gson().fromJson(procedureVo.getExt(), P_StatJoinOutVo.class);
        var result = new HashMap<String, Object>();
        result.put("joinInfo", joinInfo);

        return gsonUtil.toJson(new JsonOutputVo(Status.조회, result));
    }

    /**
     * 어드민 탈퇴현황 고정
     * @return
     */
    public String callStatWithdraw(){
        ProcedureVo procedureVo = new ProcedureVo();
        entJoinDao.callStatWithdraw(procedureVo);

        P_StatJoinOutVo withdrawInfo = new Gson().fromJson(procedureVo.getExt(), P_StatJoinOutVo.class);
        var result = new HashMap<String, Object>();
        result.put("withdrawInfo", withdrawInfo);

        return gsonUtil.toJson(new JsonOutputVo(Status.조회, result));
    }
}
