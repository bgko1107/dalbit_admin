package com.dalbit.connect.service;


import com.dalbit.common.code.Status;
import com.dalbit.common.dao.CommonDao;
import com.dalbit.common.vo.*;
import com.dalbit.connect.dao.Con_UserDao;
import com.dalbit.connect.vo.procedure.P_ConnectNonBroadOutDetailVo;
import com.dalbit.connect.vo.procedure.P_UserCurrentInputVo;
import com.dalbit.connect.vo.procedure.P_UserCurrentOutputVo;
import com.dalbit.connect.vo.procedure.P_UserTotalOutDetailVo;
import com.dalbit.util.GsonUtil;
import com.dalbit.util.MessageUtil;
import com.google.gson.Gson;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;

@Slf4j
@Service
public class Con_UserService {

    @Autowired
    MessageUtil messageUtil;
    @Autowired
    GsonUtil gsonUtil;
    @Autowired
    Con_UserDao con_UserDao;
    @Autowired
    CommonDao commonDao;

    /**
     * 현재 접속자 통계 총계
     * @return
     */
    public String callUserTotal(P_UserCurrentInputVo pUserCurrentInputVo){
        ProcedureVo procedureVo = new ProcedureVo(pUserCurrentInputVo);
        con_UserDao.callUserTotal(procedureVo);
        P_UserTotalOutDetailVo detailList = new Gson().fromJson(procedureVo.getExt(), P_UserTotalOutDetailVo.class);

        /** 기타(4044/4549/5054/5559/6064/65) 처리를 위한 항목 합 추가 - 2020.06.29 Jeon.YooSin */
        int etc_male_cnt = detailList.getAge4044_male_cnt() + detailList.getAge4549_male_cnt() + detailList.getAge5054_male_cnt() + detailList.getAge5559_male_cnt() + detailList.getAge6064_male_cnt() + detailList.getAge65_male_cnt();
        int etc_female_cnt = detailList.getAge4044_female_cnt() + detailList.getAge4549_female_cnt() + detailList.getAge5054_female_cnt() + detailList.getAge5559_female_cnt() + detailList.getAge6064_female_cnt() + detailList.getAge65_female_cnt();
        int etc_none_cnt = detailList.getAge4044_none_cnt() + detailList.getAge4549_none_cnt() + detailList.getAge5054_none_cnt() + detailList.getAge5559_none_cnt() + detailList.getAge6064_none_cnt() + detailList.getAge65_none_cnt();
        int etc_total_cnt = detailList.getAge4044_total_cnt() + detailList.getAge4549_total_cnt() + detailList.getAge5054_total_cnt() + detailList.getAge5559_total_cnt() + detailList.getAge6064_total_cnt() + detailList.getAge65_total_cnt();

        detailList.setAgeEtc_male_cnt(etc_male_cnt);
        detailList.setAgeEtc_female_cnt(etc_female_cnt);
        detailList.setAgeEtc_none_cnt(etc_none_cnt);
        detailList.setAgeEtc_total_cnt(etc_total_cnt);

        return gsonUtil.toJson(new JsonOutputVo(Status.조회, detailList));
    }


    /**
     * 현재 접속자 통계 총계
     * @return
     */
    public String callUserCurrentUser(P_UserCurrentInputVo pUserCurrentInputVo){

        ProcedureVo procedureVo = new ProcedureVo(pUserCurrentInputVo);
        ArrayList<P_UserCurrentOutputVo> currentList = con_UserDao.callUserCurrent(procedureVo);

        //방송 접속 외 현재 접속자 통계
        ProcedureVo procedureVo2 = new ProcedureVo(pUserCurrentInputVo);
        con_UserDao.callCurrentLiveSummary(procedureVo2);
        P_ConnectNonBroadOutDetailVo detailList = new Gson().fromJson(procedureVo2.getExt(), P_ConnectNonBroadOutDetailVo.class);

        //DB 부하로 인해 뱃지리스트 주석처리
        /*for(int i=0;i<currentList.size();i++) {
//            fanBadgeList   주간/일간 탑DJ/팽 1,2,3
            HashMap fanBadgeMap = new HashMap();
            fanBadgeMap.put("mem_no", currentList.get(i).getMem_no());
            fanBadgeMap.put("type", -1);
            List fanBadgeList = commonDao.callMemberBadgeSelect(fanBadgeMap);
            currentList.get(i).setFanBadgeList(fanBadgeList);

//            liveBadgeList    실시간1,2,3 / 회장,부회장,사장,부장,팀장
            HashMap liveBadgeMap = new HashMap();
            liveBadgeMap.put("mem_no", currentList.get(i).getMem_no());
            liveBadgeMap.put("type", -1);
            List liveBadgeList = commonDao.callLiveBadgeSelect(liveBadgeMap);
            for (int j = (liveBadgeList.size() - 1); j > -1; j--) {
                if (DalbitUtil.isEmpty(((FanBadgeVo) liveBadgeList.get(j)).getIcon())) {
                    liveBadgeList.remove(j);
                }
            }
            currentList.get(i).setLiveBadgeList(liveBadgeList);
        }*/

        String result;
        if(Integer.parseInt(procedureVo.getRet()) > 0) {
            result = gsonUtil.toJson(new JsonOutputVo(Status.조회, currentList, new PagingVo(procedureVo.getRet()), detailList));
        }else if(Integer.parseInt(procedureVo.getRet()) == 0){
            result = gsonUtil.toJson(new JsonOutputVo(Status.데이터없음));
        }else{
            result = gsonUtil.toJson(new JsonOutputVo(Status.비즈니스로직오류));
        }
        return result;
    }

}
