package com.dalbit.member.service;

import com.dalbit.common.code.Status;
import com.dalbit.common.vo.JsonOutputVo;
import com.dalbit.common.vo.PagingVo;
import com.dalbit.common.vo.ProcedureVo;
import com.dalbit.excel.service.ExcelService;
import com.dalbit.excel.vo.ExcelVo;
import com.dalbit.member.dao.Mem_WalletDao;
import com.dalbit.member.vo.procedure.*;
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
public class Mem_WalletService {

    @Autowired
    GsonUtil gsonUtil;
    @Autowired
    Mem_WalletDao mem_walletDao;

    @Autowired
    ExcelService excelService;

    /**
     * 내지갑 달 내역 조회
     */
    public String callMemberWalletDal(P_WalletDalVo pDalVo) {
        int totalCnt = mem_walletDao.callMemberWalletDal_totalCnt(pDalVo);
        pDalVo.setTotalCnt(totalCnt);
        List<P_WalletDalListOutVo> outVoList = mem_walletDao.callMemberWalletDal(pDalVo);

        HashMap summary = mem_walletDao.getResultDalSummary(pDalVo);

//        for(int i=0;i<outVoList.size();i++) {
//            MemberVo memInfoOutVo = DalbitUtil.getMemInfo(outVoList.get(i).getMem_no());
//            if(!DalbitUtil.isEmpty(memInfoOutVo)) {
//                outVoList.get(i).setMem_birth_year(memInfoOutVo.getMem_birth_year());
//                outVoList.get(i).setMem_birth_month(memInfoOutVo.getMem_birth_month());
//                outVoList.get(i).setMem_birth_day(memInfoOutVo.getMem_birth_day());
//            }
//        }

        if(DalbitUtil.isEmpty(outVoList) || outVoList.size() <= 0){
            return gsonUtil.toJson(new JsonOutputVo(Status.내지갑_달사용내역조회_없음, new ArrayList<P_WalletDalListOutVo>(), new PagingVo(pDalVo.getTotalCnt(), pDalVo.getPageNo(), pDalVo.getPageCnt()), summary));
        }

        String result;
        if(outVoList.size() > 0) {
            result = gsonUtil.toJson(new JsonOutputVo(Status.내지갑_달사용내역조회_성공, outVoList, new PagingVo(pDalVo.getTotalCnt(), pDalVo.getPageNo(), pDalVo.getPageCnt()), summary));
        }else{
            result = gsonUtil.toJson(new JsonOutputVo(Status.내지갑_달사용내역조회_실패));
        }
        return result;
    }

    /**
     * 내지갑 달 내역 엑셀 출력
     */
    public Model getWalletDalListExcel (P_WalletDalVo pDalVo, Model model) {
        int totalCnt = mem_walletDao.callMemberWalletDal_totalCnt(pDalVo);
        pDalVo.setPageStart(0);
        pDalVo.setPageCnt(90000000);
        pDalVo.setTotalCnt(totalCnt);
        List<P_WalletDalListOutVo> list = mem_walletDao.callMemberWalletDal(pDalVo);

        String[] headers = {"No.","회원번호","UserID","User닉네임","성별","구분","비공개","아이템명","선물 수","선물 달","선물 일시"};
        int[] headerWidths = {1500, 5000, 4000, 6000, 1500, 5000, 1700, 10000, 3000, 3000, 5000};

        List<Object[]> bodies = new ArrayList<>();
        for(int i=0; i<list.size(); i++) {
            HashMap hm = new LinkedHashMap();

            String gubun =  "";
            //(1: 루비구매, 2: 아이템선물, 3: 아이템사용, 4: 루비선물보내기, 5:루비선물받기, 6: 루비 교환, 7: 이벤트 받기, 8: 환불차감, 12:운영자지급
            switch (DalbitUtil.isEmpty(list.get(i).getGubun())? "99" : list.get(i).getGubun()){
                case "1" :
                    gubun = "달 구매";
                    break;
                case "2" :
                    gubun = "아이템 선물";
                    break;
                case "3" :
                    gubun = "부스터사용";
                    break;
                case "4" :
                    gubun = "달 선물 보내기";
                    break;
                case "5" :
                    gubun = "달 선물 받기";
                    break;
                case "6" :
                    gubun = "달 교환";
                    break;
                case "7" :
                    gubun = "이벤트 받기";
                    break;
                case "8" :
                    gubun = "환불";
                    break;
                case "9" :
                    gubun = "퀵 메시지 구매/연장";
                    break;
                case "10" :
                    gubun = "레벨업 보상";
                    break;
                case "11" :
                    gubun = "출석체크 보상";
                    break;
                case "12" :
                    gubun = "소실금액복구";
                    break;
                case "121" :
                    gubun = "운영자지급";
                    break;
                case "13" :
                    gubun = "테스트지급및회수";
                    break;
                case "14" :
                    gubun = "클립선물";
                    break;
                case "15" :
                    gubun = "가입보상 달";
                    break;
                case "16" :
                    gubun = "랭킹보상";
                    break;
                case "17" :
                    gubun = "아이템비밀선물";
                    break;
                case "18" :
                    gubun = "룰렛이벤트보상";
                    break;
                case "22" :
                    gubun = "스페셜DJ혜택";
                    break;
                case "23" :
                    gubun = "이벤트 지급(어드민)";
                    break;
                default:
                    gubun = "?";
            }

            String sex;
            switch (DalbitUtil.isEmpty(list.get(i).getMem_sex())? "n" : list.get(i).getMem_sex()){
                case "m" :
                    sex = "남자";
                    break;
                case "f" :
                    sex = "여자";
                    break;
                default:
                    sex = "알수없음";
            }

            hm.put("No.", DalbitUtil.isEmpty(list.get(i).getRowNum()) ? "" : list.get(i).getRowNum());
            hm.put("회원번호", DalbitUtil.isEmpty(list.get(i).getMem_no()) ? "" : list.get(i).getMem_no());
            hm.put("UserID", DalbitUtil.isEmpty(list.get(i).getUserId()) ? "" : list.get(i).getUserId());
            hm.put("User닉네임", DalbitUtil.isEmpty(list.get(i).getNickName()) ? "" : list.get(i).getNickName());
            hm.put("성별", sex);
            hm.put("구분", gubun);
            hm.put("비공개", DalbitUtil.isEmpty(list.get(i).getSecret()) ? "" : list.get(i).getSecret());
            hm.put("아이템명", DalbitUtil.isEmpty(list.get(i).getItemName()) ? "" : list.get(i).getItemName());
            hm.put("선물 수", DalbitUtil.isEmpty(list.get(i).getItemCnt()) ? "" : list.get(i).getItemCnt());
            hm.put("선물 달", DalbitUtil.isEmpty(list.get(i).getRuby()) ? "" : list.get(i).getRuby());
            hm.put("선물 일시", DalbitUtil.isEmpty(list.get(i).getGiftDateFormat()) ? "" : list.get(i).getGiftDateFormat());

            bodies.add(hm.values().toArray());
        }

        ExcelVo vo = new ExcelVo(headers, headerWidths, bodies);
        SXSSFWorkbook workbook = excelService.excelDownload("내지갑 - 달",vo);
        model.addAttribute("locale", Locale.KOREA);
        model.addAttribute("workbook", workbook);
        model.addAttribute("workbookName", ("내지갑_달_"+pDalVo.getMem_no()));

        return model;
    }



    /**
     * 내지갑 별 내역 조회
     */
    public String callMemberWalletByeol(P_WalletByeolVo pByeolVo) {
        int totalCnt = mem_walletDao.callMemberWalletByeol_totalCnt(pByeolVo);
        pByeolVo.setTotalCnt(totalCnt);
        List<P_WalletByeolListOutVo> outVoList = mem_walletDao.callMemberWalletByeol(pByeolVo);

        HashMap summary = mem_walletDao.getResultByeolSummary(pByeolVo);

//        for(int i=0;i<outVoList.size();i++) {
//            MemberVo memInfoOutVo = DalbitUtil.getMemInfo(outVoList.get(i).getMem_no());
//            if(!DalbitUtil.isEmpty(memInfoOutVo)) {
//                outVoList.get(i).setMem_birth_year(memInfoOutVo.getMem_birth_year());
//                outVoList.get(i).setMem_birth_month(memInfoOutVo.getMem_birth_month());
//                outVoList.get(i).setMem_birth_day(memInfoOutVo.getMem_birth_day());
//            }
//        }

        if(DalbitUtil.isEmpty(outVoList) || outVoList.size() <= 0){
            return gsonUtil.toJson(new JsonOutputVo(Status.내지갑_별사용내역조회_없음, new ArrayList<P_WalletByeolListOutVo>(), new PagingVo(pByeolVo.getTotalCnt(), pByeolVo.getPageNo(), pByeolVo.getPageCnt()), summary));
        }

        String result;
        if(outVoList.size() > 0) {
            result = gsonUtil.toJson(new JsonOutputVo(Status.내지갑_별사용내역조회_성공, outVoList, new PagingVo(pByeolVo.getTotalCnt(), pByeolVo.getPageNo(), pByeolVo.getPageCnt()), summary));
        }else{
            result = gsonUtil.toJson(new JsonOutputVo(Status.내지갑_별사용내역조회_실패));
        }
        return result;
    }


    /**
     * 내지갑 달 내역 엑셀 출력
     */
    public Model getWalletByeolListExcel (P_WalletByeolVo pByeolVo, Model model) {
        int totalCnt = mem_walletDao.callMemberWalletByeol_totalCnt(pByeolVo);
        pByeolVo.setPageStart(0);
        pByeolVo.setPageCnt(90000000);
        pByeolVo.setTotalCnt(totalCnt);
        List<P_WalletByeolListOutVo> list = mem_walletDao.callMemberWalletByeol(pByeolVo);

        String[] headers = {"No.","회원번호","UserID","User닉네임","성별","구분","비공개","아이템명","선물 수","선물 별","선물 일시"};
        int[] headerWidths = {1500, 5000, 4000, 6000, 1500, 5000, 1700, 10000, 3000, 3000, 5000};

        List<Object[]> bodies = new ArrayList<>();
        for(int i=0; i<list.size(); i++) {
            HashMap hm = new LinkedHashMap();

            String gubun =  "";
            //(1: 루비교환, 2: 선물, 3: 환전, 4: 이벤트 받기, 6: 운영 지급 )
            switch (DalbitUtil.isEmpty(list.get(i).getGubun())? "99" : list.get(i).getGubun()){
                case "1" :
                    gubun = "달 교환";
                    break;
                case "2" :
                    gubun = "선물";
                    break;
                case "3" :
                    gubun = "환전";
                    break;
                case "4" :
                    gubun = "이벤트";
                    break;
                case "6" :
                    gubun = "운영자 지급";
                    break;
                default:
                    gubun = "?";
            }

            String sex;
            switch (DalbitUtil.isEmpty(list.get(i).getMem_sex())? "n" : list.get(i).getMem_sex()){
                case "f" :
                    sex = "여자";
                    break;
                case "m" :
                    sex = "남자";
                    break;
                default:
                    sex = "알수없음";
            }

            hm.put("No.", DalbitUtil.isEmpty(list.get(i).getRowNum()) ? "" : list.get(i).getRowNum());
            hm.put("회원번호", DalbitUtil.isEmpty(list.get(i).getMem_no()) ? "" : list.get(i).getMem_no());
            hm.put("UserID", DalbitUtil.isEmpty(list.get(i).getUserId()) ? "" : list.get(i).getUserId());
            hm.put("User닉네임", DalbitUtil.isEmpty(list.get(i).getNickName()) ? "" : list.get(i).getNickName());
            hm.put("성별", sex);
            hm.put("구분", gubun);
            hm.put("비공개", DalbitUtil.isEmpty(list.get(i).getSecret()) ? "" : list.get(i).getSecret());
            hm.put("아이템명", DalbitUtil.isEmpty(list.get(i).getItemName()) ? "" : list.get(i).getItemName());
            hm.put("선물 수", DalbitUtil.isEmpty(list.get(i).getItemCnt()) ? "" : list.get(i).getItemCnt());
            hm.put("선물 별", DalbitUtil.isEmpty(list.get(i).getGold()) ? "" : list.get(i).getGold());
            hm.put("선물 일시", DalbitUtil.isEmpty(list.get(i).getGiftDateFormat()) ? "" : list.get(i).getGiftDateFormat());

            bodies.add(hm.values().toArray());
        }

        ExcelVo vo = new ExcelVo(headers, headerWidths, bodies);
        SXSSFWorkbook workbook = excelService.excelDownload("내지갑 - 별",vo);
        model.addAttribute("locale", Locale.KOREA);
        model.addAttribute("workbook", workbook);
        model.addAttribute("workbookName", ("내지갑_별_"+pByeolVo.getMem_no()));

        return model;
    }



    /**
     * new 내지갑 달 내역 조회
     */
    public String getNewDalList(P_WalletDalVo pDalVo) {
//        int totalCnt = mem_walletDao.callNewWalletDal_totalCnt(pDalVo);
//        pDalVo.setTotalCnt(totalCnt);
//        List<P_NewWalletDalListOutVo> outVoList = mem_walletDao.callNewWalletDal(pDalVo);

        HashMap summary = mem_walletDao.getResultNewDalSummary(pDalVo);

        ProcedureVo procedureVo = new ProcedureVo(pDalVo);
        List<P_NewWalletDalListOutVo> outVoList = mem_walletDao.callNewWalletProDal(procedureVo);
        P_NewWalletDalListOutVo totalInfo = new Gson().fromJson(procedureVo.getExt(), P_NewWalletDalListOutVo.class);

        if(DalbitUtil.isEmpty(outVoList) || outVoList.size() <= 0){
            return gsonUtil.toJson(new JsonOutputVo(Status.내지갑_달사용내역조회_없음));
        }

        String result;
        if(outVoList.size() > 0) {
            result = gsonUtil.toJson(new JsonOutputVo(Status.내지갑_달사용내역조회_성공, outVoList, new PagingVo(totalInfo.getTotalCnt(), totalInfo.getPageNo(), totalInfo.getPageCnt()),summary));
        }else{
            result = gsonUtil.toJson(new JsonOutputVo(Status.내지갑_달사용내역조회_실패));
        }
        return result;
    }

    /**
     * new 내지갑 별 내역 조회
     */
    public String getNewByeolList(P_WalletByeolVo pByeolVo) {
//        int totalCnt = mem_walletDao.callNewWalletByeol_totalCnt(pByeolVo);
//        pByeolVo.setTotalCnt(totalCnt);
//        List<P_NewWalletByeolListOutVo> outVoList = mem_walletDao.callNewWalletByeol(pByeolVo);

        ProcedureVo procedureVo = new ProcedureVo(pByeolVo);
        List<P_NewWalletByeolListOutVo> outVoList = mem_walletDao.callNewWalletProByeol(procedureVo);
        P_NewWalletByeolListOutVo totalInfo = new Gson().fromJson(procedureVo.getExt(), P_NewWalletByeolListOutVo.class);

        HashMap summary = mem_walletDao.getResultNewByeolSummary(pByeolVo);

        if(DalbitUtil.isEmpty(outVoList) || outVoList.size() <= 0){
            return gsonUtil.toJson(new JsonOutputVo(Status.내지갑_별사용내역조회_없음));
        }

        String result;
        if(outVoList.size() > 0) {
            result = gsonUtil.toJson(new JsonOutputVo(Status.내지갑_별사용내역조회_성공, outVoList, new PagingVo(totalInfo.getTotalCnt(), totalInfo.getPageNo(), totalInfo.getPageCnt()), summary));
        }else{
            result = gsonUtil.toJson(new JsonOutputVo(Status.내지갑_별사용내역조회_실패));
        }
        return result;
    }



    /**
     * 내지갑 달 내역 엑셀 출력
     */
    public Model getWalletDalNewListExcel (P_WalletDalVo pDalVo, Model model) {
        pDalVo.setPageStart(0);
        pDalVo.setPageCnt(90000000);

        ProcedureVo procedureVo = new ProcedureVo(pDalVo);
        List<P_NewWalletDalListOutVo> list = mem_walletDao.callNewWalletProDal(procedureVo);

        String[] headers = {"No.","회원번호","UserID","User닉네임","성별","구분","비공개","아이템명","선물 건","선물 달","선물 전","선물 후","선물 일시"};
        int[] headerWidths = {3000,3000,3000,3000,3000,3000,3000,3000,3000,3000,3000,3000,3000,};

        List<Object[]> bodies = new ArrayList<>();
        for(int i=0; i<list.size(); i++) {
            HashMap hm = new LinkedHashMap();

            String gubun =  "";
            switch (DalbitUtil.isEmpty(list.get(i).getGubun())? "99" : list.get(i).getGubun()){
                case "1" :
                    gubun = "달 구매";
                    break;
                case "2" :
                    gubun = "아이템 선물";
                    break;
                case "3" :
                    gubun = "부스터사용";
                    break;
                case "4" :
                    gubun = "달 선물 보내기";
                    break;
                case "5" :
                    gubun = "달 선물 받기";
                    break;
                case "6" :
                    gubun = "달 교환";
                    break;
                case "7" :
                    gubun = "이벤트 받기";
                    break;
                case "8" :
                    gubun = "환불";
                    break;
                case "9" :
                    gubun = "퀵 메시지 구매/연장";
                    break;
                case "10" :
                    gubun = "레벨업 보상";
                    break;
                case "11" :
                    gubun = "출석체크 보상";
                    break;
                case "12" :
                    gubun = "소실금액복구";
                    break;
                case "121" :
                    gubun = "운영자지급";
                    break;
                case "13" :
                    gubun = "테스트지급및회수";
                    break;
                case "14" :
                    gubun = "클립선물";
                    break;
                case "15" :
                    gubun = "가입보상 달";
                    break;
                case "16" :
                    gubun = "랭킹보상";
                    break;
                case "17" :
                    gubun = "아이템비밀선물";
                    break;
                case "18" :
                    gubun = "룰렛이벤트보상";
                    break;
                case "22" :
                    gubun = "스페셜DJ혜택";
                    break;
                case "23" :
                    gubun = "이벤트 지급(어드민)";
                    break;
                case "25" :
                    gubun = "이벤트 경품 달로 받기";
                    break;
                case "31" :
                    gubun = "자동교환";
                    break;
                case "32" :
                    gubun = "우체동 선물";
                    break;
                case "33" :
                    gubun = "미니 게임(룰렛)";
                    break;
                default:
                    gubun = "?";
            }
            hm.put("No.", i+1);
            hm.put("회원번호", DalbitUtil.isEmpty(list.get(i).getMem_no()) ? "" : list.get(i).getMem_no());
            hm.put("UserID", DalbitUtil.isEmpty(list.get(i).getUserId()) ? "" : list.get(i).getUserId());
            hm.put("User닉네임", DalbitUtil.isEmpty(list.get(i).getNickName()) ? "" : list.get(i).getNickName());
            hm.put("성별", DalbitUtil.isEmpty(list.get(i).getMem_sex()) ? "" : list.get(i).getMem_sex());
            hm.put("구분", gubun);
            hm.put("비공개", DalbitUtil.isEmpty(list.get(i).getSecret()) ? "" : list.get(i).getSecret());
            hm.put("아이템명", DalbitUtil.isEmpty(list.get(i).getItemName()) ? "" : list.get(i).getItemName());
            hm.put("선물 건", DalbitUtil.isEmpty(list.get(i).getItem_cnt()) ? "" : list.get(i).getItem_cnt());
            hm.put("선물 달", DalbitUtil.isEmpty(list.get(i).getRuby()) ? "" : list.get(i).getRuby());
            hm.put("선물 전", DalbitUtil.isEmpty(list.get(i).getRuby_old()) ? "" : list.get(i).getRuby_old());
            hm.put("선물 후", DalbitUtil.isEmpty(list.get(i).getRuby_new()) ? "" : list.get(i).getRuby_new());
            hm.put("선물 일시", DalbitUtil.isEmpty(list.get(i).getLast_upd_date()) ? "" : list.get(i).getLast_upd_date());

            bodies.add(hm.values().toArray());
        }

        ExcelVo vo = new ExcelVo(headers, headerWidths, bodies);
        SXSSFWorkbook workbook = excelService.excelDownload("내지갑 - 달",vo);
        model.addAttribute("locale", Locale.KOREA);
        model.addAttribute("workbook", workbook);
        model.addAttribute("workbookName", ("내지갑_달_"+pDalVo.getMem_no()));

        return model;
    }


    /**
     * 내지갑 달 내역 엑셀 출력
     */
    public Model getWalletByeolNewListExcel (P_WalletByeolVo pByeolVo, Model model) {
        pByeolVo.setPageStart(0);
        pByeolVo.setPageCnt(90000000);
        ProcedureVo procedureVo = new ProcedureVo(pByeolVo);
        List<P_NewWalletByeolListOutVo> list = mem_walletDao.callNewWalletProByeol(procedureVo);

        String[] headers = {"No.","회원번호","UserID","User닉네임","성별","구분","비공개","아이템명","선물 건","선물 별","선물 전","선물 후","선물 일시"};
        int[] headerWidths = {3000,3000,3000,3000,3000,3000,3000,3000,3000,3000,3000,3000,3000,};

        List<Object[]> bodies = new ArrayList<>();
        for(int i=0; i<list.size(); i++) {
            HashMap hm = new LinkedHashMap();

            String gubun =  "";
            //(1: 루비교환, 2: 선물, 3: 환전, 4: 이벤트 받기, 6: 운영 지급 )
            switch (DalbitUtil.isEmpty(list.get(i).getGubun())? "99" : list.get(i).getGubun()){
                case "1" :
                    gubun = "달 교환";
                    break;
                case "2" :
                    gubun = "선물";
                    break;
                case "3" :
                    gubun = "환전";
                    break;
                case "4" :
                    gubun = "이벤트";
                    break;
                case "5" :
                    gubun = "레벨업 보상";
                    break;
                case "6" :
                    gubun = "소실금액복구";
                    break;
                case "7" :
                    gubun = "테스트지급및회수";
                    break;
                case "8" :
                    gubun = "환전취소";
                    break;
                case "14" :
                    gubun = "클립선물";
                    break;
                case "17" :
                    gubun = "아이템비밀선물";
                    break;
                case "19" :
                    gubun = "게스트선물";
                    break;
                case "20" :
                    gubun = "게스트몰래선물";
                    break;
                case "21" :
                    gubun = "출석체크 보상";
                    break;
                case "22" :
                    gubun = "스페셜DJ혜택";
                    break;
                case "23" :
                    gubun = "이벤트 지급(어드민)";
                    break;
                case "31" :
                    gubun = "자동교환";
                    break;
                case "32" :
                    gubun = "우체통 선물";
                    break;
                case "33" :
                    gubun = "미니 게임(룰렛)";
                    break;
                default:
                    gubun = "?";
            }
            hm.put("No.", i+1);
            hm.put("회원번호", DalbitUtil.isEmpty(list.get(i).getMem_no()) ? "" : list.get(i).getMem_no());
            hm.put("UserID", DalbitUtil.isEmpty(list.get(i).getUserId()) ? "" : list.get(i).getUserId());
            hm.put("User닉네임", DalbitUtil.isEmpty(list.get(i).getNickName()) ? "" : list.get(i).getNickName());
            hm.put("성별", DalbitUtil.isEmpty(list.get(i).getMem_sex()) ? "" : list.get(i).getMem_sex());
            hm.put("구분", gubun);
            hm.put("비공개", DalbitUtil.isEmpty(list.get(i).getSecret()) ? "" : list.get(i).getSecret());
            hm.put("아이템명", DalbitUtil.isEmpty(list.get(i).getItemName()) ? "" : list.get(i).getItemName());
            hm.put("선물 수", DalbitUtil.isEmpty(list.get(i).getItem_cnt()) ? "" : list.get(i).getItem_cnt());
            hm.put("선물 별", DalbitUtil.isEmpty(list.get(i).getGold()) ? "" : list.get(i).getGold());
            hm.put("선물 전", DalbitUtil.isEmpty(list.get(i).getGold_old()) ? "" : list.get(i).getGold_old());
            hm.put("선물 후", DalbitUtil.isEmpty(list.get(i).getGold_new()) ? "" : list.get(i).getGold_new());
            hm.put("선물 일시", DalbitUtil.isEmpty(list.get(i).getLast_upd_date()) ? "" : list.get(i).getLast_upd_date());

            bodies.add(hm.values().toArray());
        }

        ExcelVo vo = new ExcelVo(headers, headerWidths, bodies);
        SXSSFWorkbook workbook = excelService.excelDownload("내지갑 - 별",vo);
        model.addAttribute("locale", Locale.KOREA);
        model.addAttribute("workbook", workbook);
        model.addAttribute("workbookName", ("내지갑_별_"+pByeolVo.getMem_no()));

        return model;
    }
}
