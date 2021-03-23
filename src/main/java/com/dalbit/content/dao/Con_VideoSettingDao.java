package com.dalbit.content.dao;

import com.dalbit.common.vo.ProcedureVo;
import com.dalbit.content.vo.procedure.P_VideoSettingDetailVo;
import com.dalbit.content.vo.procedure.P_VideoSettingListVo;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;

@Repository
public interface Con_VideoSettingDao {

    @Transactional(readOnly = true)
    ArrayList<P_VideoSettingListVo> callVideoSettingList(ProcedureVo procedureVo);

    ArrayList<P_VideoSettingDetailVo> callVideoSettingDetail(ProcedureVo procedureVo);

    ProcedureVo callVideoSettingEdit(ProcedureVo procedureVo);
}
