package com.dalbit.status.service;

import com.dalbit.common.code.Status;
import com.dalbit.common.vo.JsonOutputVo;
import com.dalbit.common.vo.PagingVo;
import com.dalbit.common.vo.ProcedureVo;
import com.dalbit.excel.service.ExcelService;
import com.dalbit.status.dao.Sta_LevelDao;
import com.dalbit.status.vo.procedure.P_LevelInputVo;
import com.dalbit.status.vo.procedure.P_LevelListOutputVo;
import com.dalbit.status.vo.procedure.P_LevelOutputVo;
import com.dalbit.status.vo.procedure.P_LevelSummaryOutputVo;
import com.dalbit.util.GsonUtil;
import com.google.gson.Gson;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.*;

@Slf4j
@Service
public class Sta_LevelService {

    @Autowired
    Sta_LevelDao staLevelDao;

    @Autowired
    GsonUtil gsonUtil;

    @Autowired
    ExcelService excelService;

    /**
     *  회원 레벨별 목록 조회
     */
    public String getMemberLevel(P_LevelInputVo pLevelInputVo) {
        ProcedureVo procedureVo = new ProcedureVo(pLevelInputVo);
        List<P_LevelOutputVo> list = staLevelDao.callMemberLevelList(procedureVo);
        P_LevelOutputVo summary = new Gson().fromJson(procedureVo.getExt(), P_LevelOutputVo.class);

       /* pLevelInputVo.setPageNo(pLevelInputVo.getPageNo() -1);
        pLevelInputVo.setPageNo(pLevelInputVo.getPageNo() * pLevelInputVo.getPageCnt());
        List<P_LevelOutputVo> list = staLevelDao.getMemberLevelList(pLevelInputVo);
        int getLevelListCnt = staLevelDao.getLevelListCnt(pLevelInputVo);

        for(int i=0;i<list.size();i++){
            P_LevelOutputVo outputVo = staLevelDao.getTopFanInfo(list.get(i).getMem_no());
            if(!DalbitUtil.isEmpty(outputVo)) {
                list.get(i).setTotRcvRubyCnt(outputVo.getTotRcvRubyCnt());
                list.get(i).setFanNickName(outputVo.getFanNickName());
            }
        }
        //summary
        P_LevelOutputVo summary = staLevelDao.getLevelSummary(pLevelInputVo);*/

        String result = gsonUtil.toJson(new JsonOutputVo(Status.조회, list, new PagingVo(procedureVo.getRet()) ,summary));

        return result;
    }

    /**
     *  레벨별 통계 조회
     */
    public String getLevelSummary(P_LevelInputVo pLevelInputVo) {

        //summary
        P_LevelSummaryOutputVo summary = null;
        if(pLevelInputVo.getLevel().equals("10")){    //0~10
            summary = staLevelDao.getLevelSummary10(pLevelInputVo);
        }else if(pLevelInputVo.getLevel().equals("20")){    //11~20
            summary = staLevelDao.getLevelSummary20(pLevelInputVo);
        }else if(pLevelInputVo.getLevel().equals("30")){    //21~30
            summary = staLevelDao.getLevelSummary30(pLevelInputVo);
        }else if(pLevelInputVo.getLevel().equals("40")){    //31~40
            summary = staLevelDao.getLevelSummary40(pLevelInputVo);
        }else if(pLevelInputVo.getLevel().equals("50")){    //41~50
            summary = staLevelDao.getLevelSummary50(pLevelInputVo);
        }else if(pLevelInputVo.getLevel().equals("60")){    //51~60
            summary = staLevelDao.getLevelSummary60(pLevelInputVo);
        }else if(pLevelInputVo.getLevel().equals("70")){    //61~70
            summary = staLevelDao.getLevelSummary70(pLevelInputVo);
        }else if(pLevelInputVo.getLevel().equals("80")){    //71~80
            summary = staLevelDao.getLevelSummary80(pLevelInputVo);
        }else if(pLevelInputVo.getLevel().equals("90")){    //81~90
            summary = staLevelDao.getLevelSummary90(pLevelInputVo);
        }else if(pLevelInputVo.getLevel().equals("100")){    //91~100
            summary = staLevelDao.getLevelSummary100(pLevelInputVo);
        }

        String result = gsonUtil.toJson(new JsonOutputVo(Status.조회, null, new PagingVo(0),summary));

        return result;
    }

    /**
     *  회원 레벨별 목록 조회
     */
    public String getLevelList(P_LevelInputVo pLevelInputVo) {
        List<P_LevelListOutputVo> list = staLevelDao.getLevelList(pLevelInputVo);

        //summary
        P_LevelListOutputVo summary = new P_LevelListOutputVo();
        summary.setMemAllCount(list.get(0).getMemAllCount());

        String result = gsonUtil.toJson(new JsonOutputVo(Status.조회, list, new PagingVo(0),summary));

        return result;
    }

}
