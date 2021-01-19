package com.dalbit.administrate.service;

import com.dalbit.administrate.dao.Adm_TermsDao;
import com.dalbit.administrate.vo.procedure.P_TermsDetailInputVo;
import com.dalbit.administrate.vo.procedure.P_TermsListInputVo;
import com.dalbit.administrate.vo.procedure.P_TermsListOutputVo;
import com.dalbit.common.code.Status;
import com.dalbit.common.vo.JsonOutputVo;
import com.dalbit.common.vo.PagingVo;
import com.dalbit.excel.service.ExcelService;
import com.dalbit.member.vo.MemberVo;
import com.dalbit.util.GsonUtil;
import com.dalbit.util.MessageUtil;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;

@Slf4j
@Service
public class Adm_TermsService {

    @Autowired
    Adm_TermsDao adm_TermsDao;

    @Autowired
    MessageUtil messageUtil;
    @Autowired
    GsonUtil gsonUtil;
    @Autowired
    ExcelService excelService;

    /**
     * 약관 조회
     */
    public String callTermsList(P_TermsListInputVo pTermsListInputVo) {

        pTermsListInputVo.setPageNo(pTermsListInputVo.getPageNo() -1);
        pTermsListInputVo.setPageNo(pTermsListInputVo.getPageNo() * pTermsListInputVo.getPageCnt());

        ArrayList<P_TermsListOutputVo> termsList = adm_TermsDao.callTermsList(pTermsListInputVo);
        int totalCnt = adm_TermsDao.callTermsList_totalCnt(pTermsListInputVo);
        String result;
        if(termsList.size() > 0) {
            result = gsonUtil.toJson(new JsonOutputVo(Status.조회, termsList, new PagingVo(totalCnt)));
        }else{
            result = gsonUtil.toJson(new JsonOutputVo(Status.비즈니스로직오류));
        }

        return result;
    }

    /**
     * 약관 수정
     */
    public String callTermsUpdate(P_TermsDetailInputVo pTermsDetailInputVo) {
        pTermsDetailInputVo.setLast_op_name(MemberVo.getMyMemNo());
        int returnSw = adm_TermsDao.callTermsUpdate(pTermsDetailInputVo);
        String result;
        if(returnSw == 1){
            result = gsonUtil.toJson(new JsonOutputVo(Status.수정));
        }else{
            result = gsonUtil.toJson(new JsonOutputVo(Status.비즈니스로직오류));
        }
        return result;
    }

    /**
     * 약관 등록
     */
    public String callTermsInsert(P_TermsDetailInputVo pTermsDetailInputVo) {
        pTermsDetailInputVo.setOp_name(MemberVo.getMyMemNo());
        int returnSw = adm_TermsDao.callTermsInsert(pTermsDetailInputVo);
        String result;
        if(returnSw == 1){
            result = gsonUtil.toJson(new JsonOutputVo(Status.생성));
        }else{
            result = gsonUtil.toJson(new JsonOutputVo(Status.비즈니스로직오류));
        }
        return result;
    }

    /**
     * 약관 삭제
     */
    public String callTermsDelete(P_TermsDetailInputVo pTermsDetailInputVo) {
        int returnSw = adm_TermsDao.callTermsDelete(pTermsDetailInputVo);
        String result;
        if(returnSw == 1){
            result = gsonUtil.toJson(new JsonOutputVo(Status.삭제));
        }else{
            result = gsonUtil.toJson(new JsonOutputVo(Status.비즈니스로직오류));
        }
        return result;
    }

}
