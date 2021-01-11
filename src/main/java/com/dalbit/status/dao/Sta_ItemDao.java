package com.dalbit.status.dao;

import com.dalbit.common.vo.ProcedureVo;
import com.dalbit.status.vo.procedure.*;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;

@Repository
public interface Sta_ItemDao {

    @Transactional(readOnly = true)
    ArrayList<P_ItemLiveOutputVo> callItemLive(ProcedureVo procedureVo);

    @Transactional(readOnly = true)
    ArrayList<P_ItemTotalOutDetailVo> callItemTotal(ProcedureVo procedureVo);

    @Transactional(readOnly = true)
    ArrayList<P_ItemGenderOutDetailVo> callItemGender(ProcedureVo procedureVo);

    @Transactional(readOnly = true)
    ArrayList<P_ItemAgeOutDetailVo> callItemAge(ProcedureVo procedureVo);

    @Transactional(readOnly = true)
    ArrayList<P_ItemBroadOutDetailVo> callItemBroad(ProcedureVo procedureVo);

    @Transactional(readOnly = true)
    ArrayList<P_ItemClipOutDetailVo> callItemClip(ProcedureVo procedureVo);

    @Transactional(readOnly = true)
    ArrayList<P_MailboxVo> callMailboxList(ProcedureVo procedureVo);
}
