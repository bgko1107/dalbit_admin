package com.dalbit.common.service;

import com.dalbit.common.dao.CommonMemberDao;
import com.dalbit.common.vo.FanBadgeVo;
import com.dalbit.common.vo.MemberBadgeVo;
import com.dalbit.common.vo.ProcedureVo;
import com.dalbit.util.DalbitUtil;
import com.google.gson.Gson;
import com.google.gson.internal.LinkedTreeMap;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.HashMap;
import java.util.List;

@Slf4j
@Service
public class CommonMemberService {

    @Autowired
    CommonMemberDao commonMemberDao;

    public ProcedureVo memberBadgeAdd(MemberBadgeVo memberBadgeVo){
        ProcedureVo procedureVo = new ProcedureVo(memberBadgeVo);
        commonMemberDao.callMemberBadgeAdd(procedureVo);
        return procedureVo;
    }

    public ProcedureVo memberBadgeDelete(MemberBadgeVo memberBadgeVo){
        ProcedureVo procedureVo = new ProcedureVo(memberBadgeVo);
        commonMemberDao.callMemberBadgeDelete(procedureVo);
        return procedureVo;
    }

    public ProcedureVo memberSettingSelect(String memNo){
        HashMap map = new HashMap();
        map.put("mem_no", memNo);
        ProcedureVo procedureVo = new ProcedureVo(map);

        commonMemberDao.callMemberSettingSelect(procedureVo);

        return procedureVo;
    }

    public List selectMemberBadgeList(String memNo){

        HashMap param = new HashMap();
        param.put("mem_no", memNo);
        param.put("type", 6);
        param.put("timeDay", 0);
        param.put("djRank", 0);
        param.put("fanRank", 0);
        param.put("by", "admin");
        List badgeList = commonMemberDao.callMemberBadgeListServer(param);

        return badgeList;
    }

    /**
     * 주간,일간 탑DJ, 팬 1,2,3
     */
    public List selectMemberFanBadgeList(String memNo){
        HashMap fanBadgeMap = new HashMap();
        fanBadgeMap.put("mem_no", memNo);
        fanBadgeMap.put("type", -1);
        List fanBadgeList = commonMemberDao.callMemberBadgeSelect(fanBadgeMap);

        return fanBadgeList;
    }

    /**
     * 실시간1,2,3 / 회장,부회장,사장,부장,팀장
     */
    public List selectMemberLiveBadgeList(String memNo){
        HashMap liveBadgeMap = new HashMap();
        liveBadgeMap.put("mem_no", memNo);
        liveBadgeMap.put("type", -1);
        List liveBadgeList = commonMemberDao.callLiveBadgeSelect(liveBadgeMap);
        for (int j = (liveBadgeList.size() - 1); j > -1; j--) {
            if (DalbitUtil.isEmpty(((FanBadgeVo) liveBadgeList.get(j)).getIcon())) {
                liveBadgeList.remove(j);
            }
        }
        return liveBadgeList;
    }

}
