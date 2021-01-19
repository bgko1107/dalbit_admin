package com.dalbit.administrate.dao;

import com.dalbit.administrate.vo.procedure.P_TermsDetailInputVo;
import com.dalbit.administrate.vo.procedure.P_TermsListInputVo;
import com.dalbit.administrate.vo.procedure.P_TermsListOutputVo;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;

@Repository
public interface Adm_TermsDao {

    @Transactional(readOnly = true)
    ArrayList<P_TermsListOutputVo> callTermsList(P_TermsListInputVo pTermsListInputVo);

    @Transactional(readOnly = true)
    int callTermsList_totalCnt(P_TermsListInputVo pTermsListInputVo);

    int callTermsUpdate(P_TermsDetailInputVo pTermsDetailInputVo);
    int callTermsInsert(P_TermsDetailInputVo pTermsDetailInputVo);
    int callTermsDelete(P_TermsDetailInputVo pTermsDetailInputVo);
}
