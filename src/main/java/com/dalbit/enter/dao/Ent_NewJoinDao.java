package com.dalbit.enter.dao;

import com.dalbit.common.vo.ProcedureVo;
import com.dalbit.enter.vo.procedure.*;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;

@Repository
public interface Ent_NewJoinDao {

    @Transactional(readOnly = true)
    ArrayList<P_JoinLiveOutDetailVo> callJoinLive(ProcedureVo procedureVo);

    @Transactional(readOnly = true)
    ArrayList<P_JoinCalenderOutDetailVo> callCalender(ProcedureVo procedureVo);

    @Transactional(readOnly = true)
    ArrayList<P_JoinMonthOutDetailVo> callMonth(ProcedureVo procedureVo);

    @Transactional(readOnly = true)
    ArrayList<P_JoinPlatformAgeOutDetailVo> callJoinPlatformAge(ProcedureVo procedureVo);

    @Transactional(readOnly = true)
    ArrayList<P_JoinPlatformGenderOutDetailVo> callJoinPlatformGender(ProcedureVo procedureVo);

}
