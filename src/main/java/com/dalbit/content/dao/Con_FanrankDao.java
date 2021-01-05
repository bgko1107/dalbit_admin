package com.dalbit.content.dao;

import com.dalbit.common.vo.ProcedureVo;
import com.dalbit.content.vo.EventWinnerAddInfoDetailVo;
import com.dalbit.content.vo.procedure.*;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.HashMap;

@Repository
public interface Con_FanrankDao {

    @Transactional(readOnly = true)
    ArrayList<HashMap<String, Object>> callFanrankOnOffList(ProcedureVo procedureVo);

}
