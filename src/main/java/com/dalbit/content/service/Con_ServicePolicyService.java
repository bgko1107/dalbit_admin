package com.dalbit.content.service;

import com.dalbit.common.code.Status;
import com.dalbit.common.vo.JsonOutputVo;
import com.dalbit.common.vo.PagingVo;
import com.dalbit.common.vo.ProcedureVo;
import com.dalbit.content.dao.Con_ServicePolicyDao;
import com.dalbit.content.vo.procedure.P_ServicePolicyVo;
import com.dalbit.excel.service.ExcelService;
import com.dalbit.member.vo.MemberVo;
import com.dalbit.util.GsonUtil;
import com.dalbit.util.MessageUtil;
import com.google.gson.Gson;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;

@Slf4j
@Service
public class Con_ServicePolicyService {

    @Autowired
    ExcelService excelService;

    @Autowired
    Con_ServicePolicyDao conServicePolicyDao;

    @Autowired
    MessageUtil messageUtil;
    @Autowired
    GsonUtil gsonUtil;


    /**
     * 서비스 정책관리 목록
     */
    public String callServicePolicyList(P_ServicePolicyVo pServicePolicyVo) {
        ProcedureVo procedureVo = new ProcedureVo(pServicePolicyVo);

        ArrayList<P_ServicePolicyVo> list = conServicePolicyDao.callServicePolicyList(procedureVo);
        P_ServicePolicyVo outVo = new Gson().fromJson(procedureVo.getExt(), P_ServicePolicyVo.class);

        String result;

        if(Integer.parseInt(procedureVo.getRet()) > 0) {
            result = gsonUtil.toJson(new JsonOutputVo(Status.조회, list, new PagingVo(procedureVo.getRet()), outVo));
        }else if(Status.데이터없음.getMessageCode().equals(procedureVo.getRet())){
            result = gsonUtil.toJson(new JsonOutputVo(Status.데이터없음));
        }else{
            result = gsonUtil.toJson(new JsonOutputVo(Status.비즈니스로직오류));
        }

        return result;
    }

    /**
     * 서비스 정책관리 등록/수정
     */
    public String callServicePolicyEdit(P_ServicePolicyVo pServicePolicyVo) {
        pServicePolicyVo.setOpName(MemberVo.getMyMemNo());
        ProcedureVo procedureVo = new ProcedureVo(pServicePolicyVo, true);
        conServicePolicyDao.callServicePolicyEdit(procedureVo);

        String result;

        if(procedureVo.getRet().equals("0")) {
            result = gsonUtil.toJson(new JsonOutputVo(Status.생성));
        }else{
            result = gsonUtil.toJson(new JsonOutputVo(Status.비즈니스로직오류));
        }

        return result;
    }

    /**
     * 서비스 정책관리 상세보기
     */
    public String callServicePolicyDetail(P_ServicePolicyVo pServicePolicyVo) {
        ProcedureVo procedureVo = new ProcedureVo(pServicePolicyVo);
        ArrayList<P_ServicePolicyVo> list = conServicePolicyDao.callServicePolicyDetail(procedureVo);
        P_ServicePolicyVo outVo = new Gson().fromJson(procedureVo.getExt(), P_ServicePolicyVo.class);

        String result;

        if(list.size() > 0) {
            result = gsonUtil.toJson(new JsonOutputVo(Status.조회, list, new PagingVo(procedureVo.getRet()), outVo));
        }else{
            result = gsonUtil.toJson(new JsonOutputVo(Status.데이터없음));
        }

        return result;
    }

    /**
     * 서비스 정책관리 삭제하기
     */
    public String callServicePolicyDelete(P_ServicePolicyVo pServicePolicyVo) {
        String[] idxArr = pServicePolicyVo.getIdxList().split("@@");
        pServicePolicyVo.setOpName(MemberVo.getMyMemNo());
        ProcedureVo procedureVo = new ProcedureVo();
        for (String idx : idxArr) {
            pServicePolicyVo.setIdx(Integer.parseInt(idx));
            procedureVo = new ProcedureVo(pServicePolicyVo);
            conServicePolicyDao.callServicePolicyDelete(procedureVo);
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
