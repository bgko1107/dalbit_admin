package com.dalbit.clip.service;

import com.dalbit.clip.dao.Cli_ClipCategoryDao;
import com.dalbit.clip.vo.procedure.P_ClipRecommend;
import com.dalbit.clip.vo.procedure.P_ClipRecommendDetailOutPut;
import com.dalbit.clip.vo.procedure.P_ClipRecommendListOutPut;
import com.dalbit.common.code.Status;
import com.dalbit.common.vo.JsonOutputVo;
import com.dalbit.common.vo.PagingVo;
import com.dalbit.common.vo.ProcedureVo;
import com.dalbit.customer.dao.Cus_BlockAdmDao;
import com.dalbit.util.GsonUtil;
import com.google.gson.Gson;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;

@Slf4j
@Service
public class Cli_ClipCategoryService {

    @Autowired
    GsonUtil gsonUtil;

    @Autowired
    Cli_ClipCategoryDao cli_ClipCategoryDao;

    /**
     * 달대리 추천클립 목록 조회
     */
    public String callClipRecommendList(P_ClipRecommend pClipRecommend){
        ProcedureVo procedureVo = new ProcedureVo(pClipRecommend);
        ArrayList<P_ClipRecommendListOutPut> list = cli_ClipCategoryDao.callClipRecommendList(procedureVo);

        String result;
        if(list.size() > 0) {
            result = gsonUtil.toJson(new JsonOutputVo(Status.조회, list));
        }else{
            result = gsonUtil.toJson(new JsonOutputVo(Status.데이터없음));
        }
        return result;
    }

    /**
     * 달대리 추천 클립 등록
     */
    public String callClipRecommendEdit(P_ClipRecommend pClipRecommend){
        ProcedureVo procedureVo = new ProcedureVo(pClipRecommend);
        cli_ClipCategoryDao.callClipRecommendEdit(procedureVo);

        if(procedureVo.getRet().equals("0")){
            return gsonUtil.toJson(new JsonOutputVo(Status.처리완료));
        } else {
            return gsonUtil.toJson(new JsonOutputVo(Status.비즈니스로직오류));
        }
    }

    /**
     * 달대리 추천클립 상세 정보 조회
     */
    public String callClipRecommendDetail(P_ClipRecommend pClipRecommend){
        ProcedureVo procedureVo = new ProcedureVo(pClipRecommend);
        ArrayList<P_ClipRecommendDetailOutPut> list = cli_ClipCategoryDao.callClipRecommendDetail(procedureVo);
        P_ClipRecommendDetailOutPut detail = new Gson().fromJson(procedureVo.getExt(), P_ClipRecommendDetailOutPut.class);

        String result;
        if(Integer.parseInt(procedureVo.getRet()) == 0) {
            result = gsonUtil.toJson(new JsonOutputVo(Status.조회, list, new PagingVo(procedureVo.getRet()),detail));
        }else{
            result = gsonUtil.toJson(new JsonOutputVo(Status.데이터없음));
        }
        return result;
    }
}
