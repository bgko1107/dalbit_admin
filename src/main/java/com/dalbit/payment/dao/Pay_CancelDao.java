package com.dalbit.payment.dao;

import com.dalbit.common.vo.ProcedureVo;
import com.dalbit.payment.vo.Pay_CancelVo;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

@Repository
public interface Pay_CancelDao {

    int sendPayCancel(Pay_CancelVo payCancelVo);

    ProcedureVo dalCancel(ProcedureVo procedureVo);
}
