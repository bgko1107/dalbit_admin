package com.dalbit.content.service;

import com.dalbit.common.code.Status;
import com.dalbit.common.vo.JsonOutputVo;
import com.dalbit.common.vo.PagingVo;
import com.dalbit.common.vo.ProcedureVo;
import com.dalbit.content.dao.Con_MarketingDao;
import com.dalbit.content.vo.procedure.P_MarketingVo;
import com.dalbit.excel.service.ExcelService;
import com.dalbit.member.vo.MemberVo;
import com.dalbit.util.DalbitUtil;
import com.dalbit.util.GsonUtil;
import com.dalbit.util.MessageUtil;
import com.google.gson.Gson;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.Arrays;

@Slf4j
@Service
public class Con_MarketingService {

    @Autowired
    ExcelService excelService;

    @Autowired
    Con_MarketingDao conMarketingDao;

    @Autowired
    MessageUtil messageUtil;
    @Autowired
    GsonUtil gsonUtil;


    /**
     * 마케팅 목록 보기
     */
    public String callMarketingList(P_MarketingVo pMarketingVo) {
        ProcedureVo procedureVo = new ProcedureVo(pMarketingVo);

        ArrayList<P_MarketingVo> marketingList = conMarketingDao.callMarketingList(procedureVo);

        String result;

        if(Integer.parseInt(procedureVo.getRet()) > 0) {
            result = gsonUtil.toJson(new JsonOutputVo(Status.공지사항조회_성공, marketingList, new PagingVo(procedureVo.getRet())));
        }else if(Status.공지사항조회_데이터없음.getMessageCode().equals(procedureVo.getRet())){
            result = gsonUtil.toJson(new JsonOutputVo(Status.공지사항조회_데이터없음));
        }else{
            result = gsonUtil.toJson(new JsonOutputVo(Status.공지사항조회_에러));
        }

        return result;
    }

    /**
     * 마케팅 상세보기
     */
    public String callMarketingDetail(P_MarketingVo pMarketingVo) {
        ProcedureVo procedureVo = new ProcedureVo(pMarketingVo);

        conMarketingDao.callMarketingDetail(procedureVo);

        P_MarketingVo detail = new Gson().fromJson(procedureVo.getExt(), P_MarketingVo.class);

        String result;

        if(DalbitUtil.isEmpty(detail)) {
            result = gsonUtil.toJson(new JsonOutputVo(Status.공지사항조회_데이터없음));
        }else if(Status.공지사항조회_데이터없음.getMessageCode().equals(procedureVo.getRet())){
            result = gsonUtil.toJson(new JsonOutputVo(Status.공지사항조회_성공, detail, new PagingVo(procedureVo.getRet())));
        }else{
            result = gsonUtil.toJson(new JsonOutputVo(Status.공지사항조회_에러));
        }

        return result;
    }

    /**
     * 마케팅 수정하기
     */
    public String callMarketingUpdate(P_MarketingVo pMarketingVo) {
        pMarketingVo.setOpName(MemberVo.getMyMemNo());
        ProcedureVo procedureVo = new ProcedureVo(pMarketingVo);

        conMarketingDao.callMarketingUpdate(procedureVo);

        P_MarketingVo detail = new Gson().fromJson(procedureVo.getExt(), P_MarketingVo.class);

        String result;

        if(DalbitUtil.isEmpty(detail)) {
            result = gsonUtil.toJson(new JsonOutputVo(Status.공지사항조회_데이터없음, null, new PagingVo(0)));
        }else if(Status.공지사항조회_데이터없음.getMessageCode().equals(procedureVo.getRet())){
            result = gsonUtil.toJson(new JsonOutputVo(Status.공지사항조회_성공, detail, new PagingVo(procedureVo.getRet())));
        }else{
            result = gsonUtil.toJson(new JsonOutputVo(Status.공지사항조회_에러));
        }

        return result;
    }

    /**
     * 마케팅 등록하기
     */
    public String callMarketingInsert(P_MarketingVo pMarketingVo) {
        pMarketingVo.setOpName(MemberVo.getMyMemNo());
        ProcedureVo procedureVo = new ProcedureVo(pMarketingVo);

        conMarketingDao.callMarketingInsert(procedureVo);

        String result;

        if(procedureVo.getRet().equals("0")) {
            result = gsonUtil.toJson(new JsonOutputVo(Status.생성));
        }else{
            result = gsonUtil.toJson(new JsonOutputVo(Status.비즈니스로직오류));
        }

        return result;
    }

    /**
     * 마케팅 삭제하기
     */
    public String callMarketingDelete(P_MarketingVo pMarketingVo) {


        String[] idxArr = pMarketingVo.getIdxs().split(",");

        pMarketingVo.setOpName(MemberVo.getMyMemNo());

        ProcedureVo procedureVo = new ProcedureVo();

        for (String idx : idxArr) {
            pMarketingVo.setIdx(idx);
            procedureVo = new ProcedureVo(pMarketingVo);
            conMarketingDao.callMarketingDelete(procedureVo);
        }

        String result;

        if(procedureVo.getRet().equals("0")) {
            result = gsonUtil.toJson(new JsonOutputVo(Status.삭제));
        }else{
            result = gsonUtil.toJson(new JsonOutputVo(Status.비즈니스로직오류));
        }

        return result;
    }

}
