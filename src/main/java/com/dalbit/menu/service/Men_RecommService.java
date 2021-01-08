package com.dalbit.menu.service;

import com.dalbit.common.code.Status;
import com.dalbit.common.vo.JsonOutputVo;
import com.dalbit.common.vo.PagingVo;
import com.dalbit.common.vo.ProcedureVo;
import com.dalbit.excel.service.ExcelService;
import com.dalbit.member.vo.MemberVo;
import com.dalbit.menu.dao.Men_RecommDao;
import com.dalbit.menu.vo.RecommVo;
import com.dalbit.util.GsonUtil;
import com.google.gson.Gson;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Slf4j
@Service
public class Men_RecommService {

    @Autowired
    Men_RecommDao men_RecommDao;

    @Autowired
    GsonUtil gsonUtil;

    @Autowired
    ExcelService excelService;

    /**
     * 추천 DJ 목록
     */
    public String callRecommList(RecommVo recommVo) {
        ProcedureVo procedureVo = new ProcedureVo(recommVo);
        List<RecommVo> list = men_RecommDao.callRecommList(procedureVo);
        String result = gsonUtil.toJson(new JsonOutputVo(Status.조회, list, new PagingVo(procedureVo.getRet())));
        return result;
    }

    /**
     * 추천 DJ 정보
     */
    public String callRecommDetail(RecommVo recommVo) {
        ProcedureVo procedureVo = new ProcedureVo(recommVo);
        men_RecommDao.callRecommDetail(procedureVo);
        RecommVo outVo = new Gson().fromJson(procedureVo.getExt(), RecommVo.class);
        return gsonUtil.toJson(new JsonOutputVo(Status.조회, outVo));
    }

    /**
     * 추천 DJ 등록/수정
     */
    public String callEditRecomm(RecommVo recommVo) {
        recommVo.setOpName(MemberVo.getMyMemNo());
        try {
            ProcedureVo procedureVo = new ProcedureVo(recommVo);
            men_RecommDao.callEditRecomm(procedureVo);
            return gsonUtil.toJson(new JsonOutputVo(Status.처리완료));
        }catch(Exception e){
            return gsonUtil.toJson(new JsonOutputVo(Status.비즈니스로직오류));
        }
    }

    /**
     * 추천 DJ 등록
     */
    public String callRecommDelete(RecommVo recommVo) {
        String[] memNo = recommVo.getMemNoList().split("@@");

        for(int i=0; i<memNo.length;i++){
            recommVo.setMem_no(memNo[i]);
            ProcedureVo procedureVo = new ProcedureVo(recommVo);

            try {
                men_RecommDao.callDeleteRecomm(procedureVo);
            }catch(Exception e){
                return gsonUtil.toJson(new JsonOutputVo(Status.비즈니스로직오류));
            }

        }
        return gsonUtil.toJson(new JsonOutputVo(Status.처리완료));

    }


}
