package com.dalbit.content.service;

import com.dalbit.common.code.Status;
import com.dalbit.common.dao.CommonStatDao;
import com.dalbit.common.vo.JsonOutputVo;
import com.dalbit.common.vo.PagingVo;
import com.dalbit.common.vo.ProcedureVo;
import com.dalbit.content.dao.Con_RouletteEventDao;
import com.dalbit.content.vo.*;
import com.dalbit.content.vo.procedure.P_RouletteRateVo;
import com.dalbit.member.vo.MemberVo;
import com.dalbit.util.DalbitUtil;
import com.dalbit.util.GsonUtil;
import com.dalbit.util.MessageUtil;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

@Slf4j
@Service
public class Con_RouletteEventService {

    @Autowired
    Con_RouletteEventDao con_rouletteEventDao;
    @Autowired
    CommonStatDao commonStatDao;
    @Autowired
    MessageUtil messageUtil;
    @Autowired
    GsonUtil gsonUtil;


    public String selectRouletteRate(P_RouletteRateVo pRouletteRateVo){
        ProcedureVo procedureVo = new ProcedureVo(pRouletteRateVo);
        ArrayList<P_RouletteRateVo> list = con_rouletteEventDao.callRouletteRate(procedureVo);

        return gsonUtil.toJson(new JsonOutputVo(Status.조회, list));
    }

    public String updateRouletteRate(P_RouletteRateVo pRouletteRateVo){
        pRouletteRateVo.setOpName(MemberVo.getMyMemNo());
        ProcedureVo procedureVo = new ProcedureVo(pRouletteRateVo);
        P_RouletteRateVo p_rouletteRateVo = con_rouletteEventDao.callEditRouletteRate(procedureVo);

        String result = "";
        if (Integer.parseInt(procedureVo.getRet()) == 0) {
            result = gsonUtil.toJson(new JsonOutputVo(Status.수정, p_rouletteRateVo));

        } else if (Status.룰렛이벤트_파라메터없음.getMessageCode().equals(procedureVo.getRet())) {
            result = gsonUtil.toJson(new JsonOutputVo(Status.룰렛이벤트_파라메터없음));

        } else if (Status.룰렛이벤트_당청활률총합안맞음.getMessageCode().equals(procedureVo.getRet())) {
            result = gsonUtil.toJson(new JsonOutputVo(Status.룰렛이벤트_당청활률총합안맞음));

        }else {
            result = gsonUtil.toJson(new JsonOutputVo(Status.비즈니스로직오류));
        }

        return result;
    }

    public String selectRouletteApplyList(RouletteApplyVo rouletteApplyVo){

        int totalCnt = con_rouletteEventDao.selectRouletteApplyCnt(rouletteApplyVo);
        rouletteApplyVo.setTotalCnt(totalCnt);
        ArrayList<RouletteApplyVo> list = con_rouletteEventDao.selectRouletteApplyList(rouletteApplyVo);

        String result = gsonUtil.toJson(new JsonOutputVo(Status.조회, list, new PagingVo(totalCnt, rouletteApplyVo.getPageStart(), rouletteApplyVo.getPageCnt())));
        return result;
    }

    public String selectRouletteWeekCalendarList(RouletteCalendarVo rouletteCalendarVo){

        rouletteCalendarVo.setIs_list(0);
        List<RouletteCalendarVo> itemList = con_rouletteEventDao.selectRouletteWeekCalendarList_item(rouletteCalendarVo);
        List<RouletteCalendarVo> memberList = con_rouletteEventDao.selectRouletteWeekCalendarList_member(rouletteCalendarVo);

        RouletteCalendarVo itemInfo = DalbitUtil.isEmpty(itemList) ? new RouletteCalendarVo() : itemList.get(0);

        RouletteCalendarVo manInfo = memberList.parallelStream().filter(vo->vo.getMem_sex().equals("m")).findAny().orElse(new RouletteCalendarVo());
        RouletteCalendarVo femaleInfo = memberList.parallelStream().filter(vo->vo.getMem_sex().equals("f")).findAny().orElse(new RouletteCalendarVo());
        RouletteCalendarVo unknownInfo = memberList.parallelStream().filter(vo->vo.getMem_sex().equals("n")).findAny().orElse(new RouletteCalendarVo());

        itemInfo.setSex_man(manInfo.getMem_unique_cnt());
        itemInfo.setSex_female(femaleInfo.getMem_unique_cnt());
        itemInfo.setSex_unknown(unknownInfo.getMem_unique_cnt());

        int applyCnt = manInfo.getMem_unique_cnt() + femaleInfo.getMem_unique_cnt() + unknownInfo.getMem_unique_cnt();

        ProcedureVo procedureVo = new ProcedureVo(rouletteCalendarVo);
        List<HashMap> loginCntList = commonStatDao.callStatLoginCnt(procedureVo);
        HashMap loginInfo = DalbitUtil.isEmpty(loginCntList) ? new HashMap() : loginCntList.get(0);
        itemInfo.setLoginCnt(DalbitUtil.getIntMap(loginInfo, "login_cnt"));

        itemInfo.setApplyCnt(applyCnt);
        return gsonUtil.toJson(new JsonOutputVo(Status.조회, itemInfo));
    }

    public String selectRouletteCalendarList(RouletteCalendarVo rouletteCalendarVo){

        rouletteCalendarVo.setIs_list(1);
        List<RouletteCalendarVo> itemList = con_rouletteEventDao.selectRouletteWeekCalendarList_item(rouletteCalendarVo);
        List<RouletteCalendarVo> memberList = con_rouletteEventDao.selectRouletteWeekCalendarList_member(rouletteCalendarVo);

        ProcedureVo procedureVo = new ProcedureVo(rouletteCalendarVo);
        List<HashMap> loginCntList = commonStatDao.callStatLoginCnt(procedureVo);

        itemList.parallelStream().forEach(vo -> {

            RouletteCalendarVo manInfo = memberList.parallelStream().filter(manVo->vo.getThe_date().equals(manVo.getThe_date()) && manVo.getMem_sex().equals("m") ).findAny().orElse(new RouletteCalendarVo());
            RouletteCalendarVo femaleInfo = memberList.parallelStream().filter(femailVo->vo.getThe_date().equals(femailVo.getThe_date()) && femailVo.getMem_sex().equals("f")).findAny().orElse(new RouletteCalendarVo());
            RouletteCalendarVo unknownInfo = memberList.parallelStream().filter(unknownVo->vo.getThe_date().equals(unknownVo.getThe_date()) && unknownVo.getMem_sex().equals("n")).findAny().orElse(new RouletteCalendarVo());

            vo.setSex_man(manInfo.getMem_unique_cnt());
            vo.setSex_female(femaleInfo.getMem_unique_cnt());
            vo.setSex_unknown(unknownInfo.getMem_unique_cnt());
            vo.setApplyCnt(manInfo.getMem_unique_cnt() + femaleInfo.getMem_unique_cnt() + unknownInfo.getMem_unique_cnt());

            HashMap loginInfo = loginCntList.parallelStream().filter(loginVo->vo.getThe_date().equals(loginVo.get("the_date"))).findAny().orElse(new HashMap());
            vo.setLoginCnt(DalbitUtil.getIntMap(loginInfo, "login_cnt"));
        });


        return gsonUtil.toJson(new JsonOutputVo(Status.조회, itemList));
    }

}
