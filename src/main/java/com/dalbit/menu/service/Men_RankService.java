package com.dalbit.menu.service;

import com.dalbit.common.code.Status;
import com.dalbit.common.vo.JsonOutputVo;
import com.dalbit.common.vo.PagingVo;
import com.dalbit.common.vo.ProcedureVo;
import com.dalbit.excel.service.ExcelService;
import com.dalbit.excel.vo.ExcelVo;
import com.dalbit.member.vo.MemberVo;
import com.dalbit.menu.dao.Men_RankDao;
import com.dalbit.menu.vo.*;
import com.dalbit.util.DalbitUtil;
import com.dalbit.util.GsonUtil;
import com.google.gson.Gson;
import lombok.extern.slf4j.Slf4j;
import org.apache.poi.xssf.streaming.SXSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import java.util.*;

@Slf4j
@Service
public class Men_RankService {

    @Autowired
    Men_RankDao menRankDao;
    @Autowired
    GsonUtil gsonUtil;

    @Autowired
    ExcelService excelService;

    /**
     * DJ 랭킹 (프로시저)
     */
//    public String callMainDjRanking(P_MainDjRankingVo pMainDjRankingVo) {
//        ProcedureVo procedureVo = new ProcedureVo(pMainDjRankingVo);
//        List<P_MainDjRankingVo> mainDjRankingVoList = menRankDao.callMainDjRanking(procedureVo);
//
//        HashMap mainDjRankingList = new HashMap();
//
//        List<MainDjRankingOutVo> outVoList = new ArrayList<>();
//        for (int i=0; i<mainDjRankingVoList.size(); i++){
//            outVoList.add(new MainDjRankingOutVo(mainDjRankingVoList.get(i)));
//        }
//        ProcedureOutputVo procedureOutputVo = new ProcedureOutputVo(procedureVo, outVoList);
//        HashMap resultMap = new Gson().fromJson(procedureOutputVo.getExt(), HashMap.class);
//        mainDjRankingList.put("list", procedureOutputVo.getOutputBox());
//        mainDjRankingList.put("paging", new PagingVo(DalbitUtil.getIntMap(resultMap, "totalCnt"), DalbitUtil.getIntMap(resultMap, "pageNo"), DalbitUtil.getIntMap(resultMap, "pageCnt")));
//
//        String result;
//        if(0 <= Integer.parseInt(procedureOutputVo.getRet())) {
//            result = gsonUtil.toJson(new JsonOutputVo(Status.메인_DJ랭킹조회_성공, mainDjRankingList));
//        } else if (procedureVo.getRet().equals(Status.메인_DJ랭킹조회_요청회원_회원아님.getMessageCode())) {
//            result = gsonUtil.toJson(new JsonOutputVo(Status.메인_DJ랭킹조회_요청회원_회원아님));
//        }else{
//            result = gsonUtil.toJson(new JsonOutputVo(Status.메인_DJ랭킹조회_실패));
//        }
//        return result;
//    }

    /**
     * DJ 랭킹
     */
    public String getMainDjRankingList(DjRankingVo djRankingVo) {

        djRankingVo.setPageStart(djRankingVo.getPageStart() -1);
        djRankingVo.setPageStart(djRankingVo.getPageStart() * djRankingVo.getPageCnt());

        djRankingVo.setRankType(DalbitUtil.isEmpty(djRankingVo.getRankType()) ? 1 : djRankingVo.getRankType());

        DjRankingVo outVo = menRankDao.getDjLiveCheck(djRankingVo);
        djRankingVo.setLiveCnt(outVo.getLiveCnt());
        djRankingVo.setLiveDate(outVo.getLiveDate());

        int getMainDjRankingListCnt = menRankDao.getMainDjRankingListCnt(djRankingVo);
        djRankingVo.setTotalCnt(getMainDjRankingListCnt);
        List<DjRankingVo> djRankingList = menRankDao.getMainDjRankingList(djRankingVo);

        String result = gsonUtil.toJson(new JsonOutputVo(Status.메인_DJ랭킹조회_성공, djRankingList, new PagingVo(djRankingVo.getTotalCnt(), djRankingVo.getPageStart(), djRankingVo.getPageCnt())));
        return result;
    }

    /**
     * 팬 랭킹 (프로시저)
     */
//    public String callMainFanRanking(P_MainFanRankingVo pMainFanRankingVo) {
//        ProcedureVo procedureVo = new ProcedureVo(pMainFanRankingVo);
//        List<P_MainFanRankingVo> mainFanRankingVoList = menRankDao.callMainFanRanking(procedureVo);
//
//        HashMap mainFanRankingList = new HashMap();
//        List<MainFanRankingOutVo> outVoList = new ArrayList<>();
//        for (int i=0; i<mainFanRankingVoList.size(); i++){
//            outVoList.add(new MainFanRankingOutVo(mainFanRankingVoList.get(i)));
//        }
//        ProcedureOutputVo procedureOutputVo = new ProcedureOutputVo(procedureVo, outVoList);
//        HashMap resultMap = new Gson().fromJson(procedureOutputVo.getExt(), HashMap.class);
//        mainFanRankingList.put("list", procedureOutputVo.getOutputBox());
//        mainFanRankingList.put("paging", new PagingVo(DalbitUtil.getIntMap(resultMap, "totalCnt"), DalbitUtil.getIntMap(resultMap, "pageNo"), DalbitUtil.getIntMap(resultMap, "pageCnt")));
//
//        String result;
//        if(0 <= Integer.parseInt(procedureOutputVo.getRet())) {
//            result = gsonUtil.toJson(new JsonOutputVo(Status.메인_팬랭킹조회_성공, mainFanRankingList));
//        } else if (procedureVo.getRet().equals(Status.메인_팬랭킹조회_요청회원_회원아님.getMessageCode())) {
//            result = gsonUtil.toJson(new JsonOutputVo(Status.메인_팬랭킹조회_요청회원_회원아님));
//        }else{
//            result = gsonUtil.toJson(new JsonOutputVo(Status.메인_팬랭킹조회_실패));
//        }
//        return result;
//    }

    /**
     * 팬 랭킹
     */
    public String getMainFanRankingList(FanRankingVo fanRankingVo) {

        fanRankingVo.setPageStart(fanRankingVo.getPageStart() -1);
        fanRankingVo.setPageStart(fanRankingVo.getPageStart() * fanRankingVo.getPageCnt());


        fanRankingVo.setRankType(DalbitUtil.isEmpty(fanRankingVo.getRankType()) ? 1 : fanRankingVo.getRankType());

        FanRankingVo outVo = menRankDao.getFanLiveCheck(fanRankingVo);
        fanRankingVo.setLiveCnt(outVo.getLiveCnt());
        fanRankingVo.setLiveDate(outVo.getLiveDate());

        int getMainFanRankingListCnt = menRankDao.getMainFanRankingListCnt(fanRankingVo);
        fanRankingVo.setTotalCnt(getMainFanRankingListCnt);
        List<FanRankingVo> fanRankingList = menRankDao.getMainFanRankingList(fanRankingVo);

        String result = gsonUtil.toJson(new JsonOutputVo(Status.메인_팬랭킹조회_성공, fanRankingList, new PagingVo(fanRankingVo.getTotalCnt(), fanRankingVo.getPageStart(), fanRankingVo.getPageCnt())));

        return result;
    }

    /**
     * 랭킹 어드민 가산점 추가 목록
     */
    public String getAddDjPointList(AddDjPointVo addDjPointVo) {

        addDjPointVo.setPageStart(addDjPointVo.getPageStart() -1);
        addDjPointVo.setPageStart(addDjPointVo.getPageStart() * addDjPointVo.getPageCnt());

        AddDjPointVo outVo = menRankDao.getAddDjLiveCheck(addDjPointVo);
        addDjPointVo.setLiveCnt(outVo.getLiveCnt());
        addDjPointVo.setLiveDate(outVo.getLiveDate());

        int getAddDjPointListCnt = menRankDao.getAddDjPointListCnt(addDjPointVo);
        addDjPointVo.setTotalCnt(getAddDjPointListCnt);
        List<AddDjPointVo> addDjPointList = menRankDao.getAddDjPointList(addDjPointVo);

        String result;
        if(addDjPointList.size() > 0){
            result = gsonUtil.toJson(new JsonOutputVo(Status.DJ가산점조회_성공, addDjPointList, new PagingVo(addDjPointVo.getTotalCnt(), addDjPointVo.getPageStart(), addDjPointVo.getPageCnt())));
        }else{
            result = gsonUtil.toJson(new JsonOutputVo(Status.DJ가산점조회_실패));
        }

        return result;
    }

    /**
     * 좋아요랭킹 목록
     */
    public String getGoodRank(GoodRankVo goodRankVo) {
        ProcedureVo procedureVo = new ProcedureVo(goodRankVo);
        List<GoodRankVo> outVoList = menRankDao.callGetGoodRank(procedureVo);

        String result;
        if(outVoList.size() > 0){
            result = gsonUtil.toJson(new JsonOutputVo(Status.좋아요랭킹_성공, outVoList, new PagingVo(procedureVo.getRet())));
        }else{
            result = gsonUtil.toJson(new JsonOutputVo(Status.좋아요랭킹_실패));
        }

        return result;
    }

    /**
     * 어워즈 투표 현황
     */
    public String callAwardsVote(AwardsVoteVo awardsVoteVo) {
        ProcedureVo procedureVo = new ProcedureVo(awardsVoteVo);
        ArrayList<AwardsVoteVo> outVoList = menRankDao.callAwardsVote(procedureVo);

        String result;
        if(outVoList.size() > 0){
            result = gsonUtil.toJson(new JsonOutputVo(Status.어워즈투표현황조회_성공, outVoList, new PagingVo(procedureVo.getRet())));
        }else{
            result = gsonUtil.toJson(new JsonOutputVo(Status.데이터없음));
        }

        return result;
    }

    /**
     * 어워즈 투표 참여자 목록
     */
    public String callAwardsVoteMember(AwardsVoteVo awardsVoteVo) {
        ProcedureVo procedureVo = new ProcedureVo(awardsVoteVo);
        ArrayList<AwardsVoteVo> outVoList = menRankDao.callAwardsVoteMember(procedureVo);

        String result;
        if(outVoList.size() > 0){
            result = gsonUtil.toJson(new JsonOutputVo(Status.투표참여자목록조회_성공, outVoList, new PagingVo(procedureVo.getRet())));
        }else{
            result = gsonUtil.toJson(new JsonOutputVo(Status.데이터없음));
        }

        return result;
    }

    /**
     * 어워즈 투표현황 엑셀 출력
     */
    public Model callAwardsVoteExcel(AwardsVoteVo awardsVoteVo, Model model) {
        ProcedureVo procedureVo = new ProcedureVo(awardsVoteVo);
        ArrayList<AwardsVoteVo> list = menRankDao.callAwardsVote(procedureVo);

        String[] headers = {"rank", "회원번호", "닉네임", "성별", "나이", "실시간 득표 수", "받은 별", "누적 청취자", "받은 좋아요", "부스터 횟수", "누적 방송시간"};
        int[] headerWidths = {2000, 4000, 4000, 4000, 4000, 4000, 4000, 4000, 4000, 4000, 4000};

        List<Object[]> bodies = new ArrayList<>();
        for(int i=0; i<list.size(); i++) {
            HashMap hm = new LinkedHashMap();

            hm.put("rank", list.get(i).getRank());
            hm.put("memNo", list.get(i).getMemNo());
            hm.put("memNick", list.get(i).getMemNick());
            hm.put("memSex", list.get(i).getMemSex());
            hm.put("memAge", list.get(i).getMemAge());
            hm.put("voteCnt", list.get(i).getVoteCnt());
            hm.put("giftPoint", list.get(i).getGiftPoint());
            hm.put("listenerPoint", list.get(i).getListenerPoint());
            hm.put("goodPoint", list.get(i).getGoodPoint());
            hm.put("boosterPoint", list.get(i).getBoosterPoint());
            hm.put("broadcastPoint", DalbitUtil.timeStampDay(list.get(i).getBroadcastPoint()));

            bodies.add(hm.values().toArray());
        }

        ExcelVo vo = new ExcelVo(headers, headerWidths, bodies);
        SXSSFWorkbook workbook = excelService.excelDownload("어워즈 투표현황",vo);
        model.addAttribute("locale", Locale.KOREA);
        model.addAttribute("workbook", workbook);
        model.addAttribute("workbookName", "어워즈 투표현황");

        return model;
    }


    /**
     * 어워즈 투표 상세내역
     */
    public String callAwardsVoteDetail(AwardsVoteVo awardsVoteVo) {
        ProcedureVo procedureVo = new ProcedureVo(awardsVoteVo);
        ArrayList<AwardsVoteVo> outVoList = menRankDao.callAwardsVoteDetail(procedureVo);

        String result;
        if(outVoList.size() > 0){
            result = gsonUtil.toJson(new JsonOutputVo(Status.어워즈투표현황조회_성공, outVoList, new PagingVo(procedureVo.getRet())));
        }else{
            result = gsonUtil.toJson(new JsonOutputVo(Status.데이터없음));
        }

        return result;
    }

    /**
     * 어워즈 후보 등록
     */
    public String callAwardsRegist(AwardsVoteVo awardsVoteVo) {
        awardsVoteVo.setOpName(MemberVo.getMyMemNo());
        ProcedureVo procedureVo = new ProcedureVo(awardsVoteVo);
        menRankDao.callAwardsRegist(procedureVo);

        return gsonUtil.toJson(new JsonOutputVo(Status.수정));
    }

    /**
     * 어워즈 수상 Dj 목록
     */
    public String callAwardsDj(AwardsVoteVo awardsVoteVo) {
        ProcedureVo procedureVo = new ProcedureVo(awardsVoteVo);
        ArrayList<AwardsVoteVo> outVoList = menRankDao.callAwardsDj(procedureVo);

        String result;
        if(outVoList.size() > 0){
            result = gsonUtil.toJson(new JsonOutputVo(Status.어워즈투표수상조회_성공, outVoList, new PagingVo(procedureVo.getRet())));
        }else{
            result = gsonUtil.toJson(new JsonOutputVo(Status.데이터없음));
        }

        return result;
    }

    /**
     * 어워즈 수상 팬 목록
     */
    public String callAwardsFan(AwardsVoteVo awardsVoteVo) {
        ProcedureVo procedureVo = new ProcedureVo(awardsVoteVo);
        ArrayList<AwardsVoteVo> outVoList = menRankDao.callAwardsFan(procedureVo);

        String result;
        if(outVoList.size() > 0){
            result = gsonUtil.toJson(new JsonOutputVo(Status.어워즈투표수상조회_성공, outVoList, new PagingVo(procedureVo.getRet())));
        }else{
            result = gsonUtil.toJson(new JsonOutputVo(Status.데이터없음));
        }

        return result;
    }

    /**
     * 어워즈 수상 DJ 등록
     */
    public String callAwardsDjRegist(AwardsVoteVo awardsVoteVo) {
        awardsVoteVo.setOpName(MemberVo.getMyMemNo());
        ProcedureVo procedureVo = new ProcedureVo(awardsVoteVo);
        menRankDao.callAwardsDjRegist(procedureVo);

        return gsonUtil.toJson(new JsonOutputVo(Status.수정));
    }

    /**
     * DJ 어워즈 소감/팬 소개 조회
     */
    public String callAwardsDjSelImpression(AwardsVoteVo awardsVoteVo) {
        awardsVoteVo.setOpName(MemberVo.getMyMemNo());
        ProcedureVo procedureVo = new ProcedureVo(awardsVoteVo);
        menRankDao.callAwardsDjSelImpression(procedureVo);
        AwardsVoteVo outVo = new Gson().fromJson(procedureVo.getExt(), AwardsVoteVo.class);

        return gsonUtil.toJson(new JsonOutputVo(Status.조회, outVo));
    }

    /**
     * DJ 어워즈 소감/팬 소개 등록
     */
    public String callAwardsDjImpression(AwardsVoteVo awardsVoteVo) {
        awardsVoteVo.setOpName(MemberVo.getMyMemNo());
        ProcedureVo procedureVo = new ProcedureVo(awardsVoteVo);
        menRankDao.callAwardsDjImpression(procedureVo);

        return gsonUtil.toJson(new JsonOutputVo(Status.수정));
    }

}
