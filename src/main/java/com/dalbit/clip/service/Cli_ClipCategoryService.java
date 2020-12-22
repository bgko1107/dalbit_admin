package com.dalbit.clip.service;

import com.dalbit.clip.dao.Cli_ClipCategoryDao;
import com.dalbit.clip.vo.procedure.*;
import com.dalbit.common.code.Status;
import com.dalbit.common.vo.JsonOutputVo;
import com.dalbit.common.vo.PagingVo;
import com.dalbit.common.vo.ProcedureVo;
import com.dalbit.customer.dao.Cus_BlockAdmDao;
import com.dalbit.member.vo.MemberVo;
import com.dalbit.util.GsonUtil;
import com.google.gson.Gson;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.Calendar;

@Slf4j
@Service
public class Cli_ClipCategoryService {

    @Autowired
    GsonUtil gsonUtil;

    @Autowired
    Cli_ClipCategoryDao cli_ClipCategoryDao;

    /**
     * 클립 랭킹 조회
     */
    public String callClipRankList(P_ClipRank pClipRank){
        ProcedureVo procedureVo = new ProcedureVo(pClipRank);
        ArrayList<P_ClipRankListOutPut> list = cli_ClipCategoryDao.callClipRankList(procedureVo);

        String result;
        if(list.size() > 0) {
            result = gsonUtil.toJson(new JsonOutputVo(Status.조회, list));
        }else{
            result = gsonUtil.toJson(new JsonOutputVo(Status.데이터없음));
        }
        return result;
    }

    /**
     * 주간 클립 테이블 테이블 목록 조회
     */
    public String callClipRecommendList(P_ClipRecommend pClipRecommend){
        ProcedureVo procedureVo = new ProcedureVo(pClipRecommend);
        ArrayList<P_ClipRecommendListOutPut> list = cli_ClipCategoryDao.callClipRecommendList(procedureVo);

        for(int i=0;i<list.size();i++){

            Calendar calendar = Calendar.getInstance();
            String date = list.get(i).getRec_date();
            String[] dates = date.split("-");
            int year = Integer.parseInt(dates[0]);
            int month = Integer.parseInt(dates[1]);
            int day = Integer.parseInt(dates[2]);
            calendar.setFirstDayOfWeek(Calendar.MONDAY);
            calendar.setMinimalDaysInFirstWeek(7);
            calendar.set(year, month - 1, day);

            list.get(i).setWeek_no(Integer.toString(calendar.get(Calendar.WEEK_OF_MONTH)));

        }

        String result;
        if(list.size() > 0) {
            result = gsonUtil.toJson(new JsonOutputVo(Status.조회, list));
        }else{
            result = gsonUtil.toJson(new JsonOutputVo(Status.데이터없음));
        }
        return result;
    }

    /**
     * 주간 클립 테이블 등록
     */
    public String callClipRecommendEdit(P_ClipRecommend pClipRecommend){
        pClipRecommend.setOpName(MemberVo.getMyMemNo());
        ProcedureVo procedureVo = new ProcedureVo(pClipRecommend);
        cli_ClipCategoryDao.callClipRecommendEdit(procedureVo);

        if(procedureVo.getRet().equals("0")){
            return gsonUtil.toJson(new JsonOutputVo(Status.처리완료));
        } else {
            return gsonUtil.toJson(new JsonOutputVo(Status.비즈니스로직오류));
        }
    }

    /**
     * 주간 클립 테이블 상세 정보 조회
     */
    public String callClipRecommendDetail(P_ClipRecommend pClipRecommend){
        ProcedureVo procedureVo = new ProcedureVo(pClipRecommend);
        ArrayList<P_ClipRecommendDetailOutPut> list = cli_ClipCategoryDao.callClipRecommendDetail(procedureVo);
        P_ClipRecommendDetailOutPut detail = new Gson().fromJson(procedureVo.getExt(), P_ClipRecommendDetailOutPut.class);

        String result;
        if(Integer.parseInt(procedureVo.getRet()) == 0) {
            result = gsonUtil.toJson(new JsonOutputVo(Status.조회, list, new PagingVo(procedureVo.getRet()),detail));
        }else{
            result = gsonUtil.toJson(new JsonOutputVo(Status.데이터없음));
        }
        return result;
    }

    /**
     * 주간 클립 테이블 등록
     */
    public String callClipRecommendDelete(P_ClipRecommend pClipRecommend){
        String[] redDateList = pClipRecommend.getRedDateList().split("@@");
        String[] groupNoList = pClipRecommend.getGroupNoList().split("@@");

        boolean resultSw = false;
        for(int i=0;i<groupNoList.length;i++){
            pClipRecommend.setRecDate(redDateList[i]);
            pClipRecommend.setGroupNo(Integer.parseInt(groupNoList[i]));

            ProcedureVo procedureVo = new ProcedureVo(pClipRecommend);
            cli_ClipCategoryDao.callClipRecommendDelete(procedureVo);

            if(!procedureVo.getRet().equals("0")) {
                resultSw = false;
                break;
            }else{
                resultSw = true;
            }
        }

        return resultSw ? gsonUtil.toJson(new JsonOutputVo(Status.처리완료)) : gsonUtil.toJson(new JsonOutputVo(Status.비즈니스로직오류));
    }

    /**
     * 주간 클립 테이블 등록 여부 체크
     */
    public String getLeaderCheck(P_ClipRecommend pClipRecommend){
        P_ClipRecommendDetailOutPut outVo = cli_ClipCategoryDao.getLeaderCheck(pClipRecommend);
        return gsonUtil.toJson(new JsonOutputVo(Status.조회, outVo));
    }
}
