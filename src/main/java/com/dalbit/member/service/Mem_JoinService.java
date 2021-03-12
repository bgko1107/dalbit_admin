package com.dalbit.member.service;

import com.dalbit.common.code.Status;
import com.dalbit.common.vo.JsonOutputVo;
import com.dalbit.common.vo.PagingVo;
import com.dalbit.common.vo.ProcedureVo;
import com.dalbit.excel.service.ExcelService;
import com.dalbit.excel.vo.ExcelVo;
import com.dalbit.member.dao.Mem_JoinDao;
import com.dalbit.member.vo.MemberVo;
import com.dalbit.member.vo.procedure.P_DormancyInputVo;
import com.dalbit.member.vo.procedure.P_DormancyOutputVo;
import com.dalbit.member.vo.procedure.P_MemberJoinInputVo;
import com.dalbit.member.vo.procedure.P_MemberJoinOutputVo;
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
public class Mem_JoinService {

    @Autowired
    Mem_JoinDao mem_JoinDao;
    @Autowired
    GsonUtil gsonUtil;
    @Autowired
    ExcelService excelService;

    public String getJoinList(P_MemberJoinInputVo pMemberJoinInputVo){
        pMemberJoinInputVo.setPageNo(pMemberJoinInputVo.getPageNo() -1);
        pMemberJoinInputVo.setPageNo(pMemberJoinInputVo.getPageNo() * pMemberJoinInputVo.getPageCnt());
        ArrayList<P_MemberJoinOutputVo> joinList = mem_JoinDao.callJoinList(pMemberJoinInputVo);
        int totalCnt = mem_JoinDao.callJoinList_totalCnt(pMemberJoinInputVo);
        P_MemberJoinOutputVo slctCnt_List = mem_JoinDao.callJoinList_slctCnt(pMemberJoinInputVo);

        String result;
        result = gsonUtil.toJson(new JsonOutputVo(Status.회원가입조회_성공, joinList, new PagingVo(totalCnt),slctCnt_List));

        log.info(result);

        return result;
    }

    public String getWithdrawalList(P_MemberJoinInputVo pMemberJoinInputVo){
        pMemberJoinInputVo.setPageNo(pMemberJoinInputVo.getPageNo() -1);
        pMemberJoinInputVo.setPageNo(pMemberJoinInputVo.getPageNo() * pMemberJoinInputVo.getPageCnt());
        ArrayList<P_MemberJoinOutputVo> withdrawalList = mem_JoinDao.callWithdrawalList(pMemberJoinInputVo);
        int totalCnt = mem_JoinDao.callWithdrawalList_totalCnt(pMemberJoinInputVo);
        P_MemberJoinOutputVo slctCnt_List = mem_JoinDao.callWithdrawalList_slctCnt(pMemberJoinInputVo);

        String result;
        result = gsonUtil.toJson(new JsonOutputVo(Status.회원가입조회_성공, withdrawalList, new PagingVo(totalCnt),slctCnt_List));

        log.info(result);

        return result;
    }


    /**
     * 회원가입 엑셀
     */
    public Model getJoinListExcel(P_MemberJoinInputVo pMemberJoinInputVo, Model model) {
        pMemberJoinInputVo.setPageNo(0);
        pMemberJoinInputVo.setPageCnt(60000);
        ArrayList<P_MemberJoinOutputVo> list = mem_JoinDao.callJoinList(pMemberJoinInputVo);
        String[] headers = null;
        headers = new String[]{"No", "회원가입일시", "가입플랫폼", "OS", "회원번호", "UserID", "닉네임", "성별","나이", "이름", "연락처", "IP", "광고유입여부", "방생성수", "청취일수", "청취수", "결제수"};
        int[] headerWidths = {3000, 6000, 6000, 6000, 6000, 6000, 6000, 6000, 6000, 6000, 6000, 6000, 6000, 6000, 6000, 6000, 6000};

        List<Object[]> bodies = new ArrayList<>();
        for(int i = 0; i < list.size(); i++){
            HashMap hm = new LinkedHashMap();
            String osType = "";
            if(list.get(i).getOs_type() == 1){          //안드
                osType = "Android";
            }else if(list.get(i).getOs_type() == 2){    //ios
                osType = "IOS";
            }else{      //pc
                osType = "PC";
            }
            String memSlct = "";
            if(list.get(i).getMem_slct().equals("p")){              // 폰
                memSlct = "Phone";
            }else if(list.get(i).getMem_slct().equals("f")){        //페북
                memSlct = "FaceBook";
            }else if(list.get(i).getMem_slct().equals("g")){        //구글
                memSlct = "Google";
            }else if(list.get(i).getMem_slct().equals("k")){        //카톡
                memSlct = "KAKAO";
            }else if(list.get(i).getMem_slct().equals("n")){        //네이버
                memSlct = "NAVER";
            }else if(list.get(i).getMem_slct().equals("i")){        //아이폰
                memSlct = "IOS";
            }

            hm.put("no", list.size()-i);
            hm.put("mem1", DalbitUtil.isEmpty(list.get(i).getMemJoinDateFormat()) ? "" : list.get(i).getMemJoinDateFormat());
            hm.put("mem2",  memSlct);
            hm.put("mem3", osType);
            hm.put("mem4",  DalbitUtil.isEmpty(list.get(i).getMem_no())            ? "" : list.get(i).getMem_no());
            hm.put("mem5",  DalbitUtil.isEmpty(list.get(i).getMem_userid())        ? "" : list.get(i).getMem_userid());
            hm.put("mem6",  DalbitUtil.isEmpty(list.get(i).getMem_nick())          ? "" : list.get(i).getMem_nick());
            hm.put("mem7",  DalbitUtil.isEmpty(list.get(i).getMem_sex())           ? "" : list.get(i).getMem_sex());
            hm.put("mem8",  DalbitUtil.isEmpty(list.get(i).getKoreaAge())          ? "" : list.get(i).getKoreaAge());
            hm.put("mem9",  DalbitUtil.isEmpty(list.get(i).getMem_name())          ? "" : list.get(i).getMem_name());
            hm.put("mem10", DalbitUtil.isEmpty(list.get(i).getMem_phone())         ? "" : list.get(i).getMem_phone());
            hm.put("mem11", DalbitUtil.isEmpty(list.get(i).getIp())                ? "" : list.get(i).getIp());
            hm.put("mem12", DalbitUtil.isEmpty(list.get(i).getJoin_path())         ? "N" : "Y");
            hm.put("mem13", DalbitUtil.isEmpty(list.get(i).getBroadcastCnt())      ? "" : list.get(i).getBroadcastCnt());
            hm.put("mem14", DalbitUtil.isEmpty(list.get(i).getListenCnt2())        ? "" : list.get(i).getListenCnt2());
            hm.put("mem15", DalbitUtil.isEmpty(list.get(i).getListenCnt())         ? "" : list.get(i).getListenCnt());
            hm.put("mem16", DalbitUtil.isEmpty(list.get(i).getPayCnt())            ? "" : list.get(i).getPayCnt());
            bodies.add(hm.values().toArray());
        }
        ExcelVo vo = new ExcelVo(headers, headerWidths, bodies);
        SXSSFWorkbook workbook = excelService.excelDownload("목록",vo);
        model.addAttribute("locale", Locale.KOREA);
        model.addAttribute("workbook", workbook);
        model.addAttribute("workbookName", "가입 정보 목록");

        return model;
    }

    /**
     * 회원탈퇴 엑셀
     */
    public Model getWithdrawalListExcel(P_MemberJoinInputVo pMemberJoinInputVo, Model model) {
        pMemberJoinInputVo.setPageNo(0);
        pMemberJoinInputVo.setPageCnt(60000);
        ArrayList<P_MemberJoinOutputVo> list = mem_JoinDao.callWithdrawalList(pMemberJoinInputVo);
        String[] headers = null;
        headers = new String[]{"No", "회원가입일시", "가입플랫폼", "OS", "회원번호", "UserID", "닉네임", "성별", "나이", "이름", "연락처", "IP", "광고유입여부", "방생성수", "청취일수", "청취수", "결제수"};
        int[] headerWidths = {3000, 6000, 6000, 6000, 6000, 6000, 6000, 6000, 6000, 6000, 6000, 6000, 6000, 6000, 6000, 6000, 6000};

        List<Object[]> bodies = new ArrayList<>();
        for(int i = 0; i < list.size(); i++){
            HashMap hm = new LinkedHashMap();
            String osType = "";
            if(list.get(i).getOs_type() == 1){          //안드
                osType = "Android";
            }else if(list.get(i).getOs_type() == 2){    //ios
                osType = "IOS";
            }else if(list.get(i).getOs_type() == 3){    //ios
                osType = "PC";
            }
            String memSlct = "";
            if(list.get(i).getMem_slct().equals("p")){              // 폰
                memSlct = "Phone";
            }else if(list.get(i).getMem_slct().equals("f")){        //페북
                memSlct = "FaceBook";
            }else if(list.get(i).getMem_slct().equals("g")){        //구글
                memSlct = "Google";
            }else if(list.get(i).getMem_slct().equals("k")){        //카톡
                memSlct = "KAKAO";
            }else if(list.get(i).getMem_slct().equals("n")){        //네이버
                memSlct = "NAVER";
            }else if(list.get(i).getMem_slct().equals("i")){        //아이폰
                memSlct = "IOS";
            }

            hm.put("no", list.size()-i);
            hm.put("mem1",  DalbitUtil.isEmpty(list.get(i).getMemJoinDateFormat()) ? "" : list.get(i).getMemJoinDateFormat());
            hm.put("mem2",  memSlct);
            hm.put("mem3",  osType);
            hm.put("mem4",  DalbitUtil.isEmpty(list.get(i).getMem_no())            ? "" : list.get(i).getMem_no());
            hm.put("mem5",  DalbitUtil.isEmpty(list.get(i).getMem_userid())        ? "" : list.get(i).getMem_userid());
            hm.put("mem6",  DalbitUtil.isEmpty(list.get(i).getMem_nick())          ? "" : list.get(i).getMem_nick());
            hm.put("mem7",  DalbitUtil.isEmpty(list.get(i).getMem_sex())           ? "" : list.get(i).getMem_sex());
            hm.put("mem8",  DalbitUtil.isEmpty(list.get(i).getKoreaAge())          ? "" : list.get(i).getKoreaAge());
            hm.put("mem9",  DalbitUtil.isEmpty(list.get(i).getMem_name())          ? "" : list.get(i).getMem_name());
            hm.put("mem10", DalbitUtil.isEmpty(list.get(i).getMem_phone())         ? "" : list.get(i).getMem_phone());
            hm.put("mem11", DalbitUtil.isEmpty(list.get(i).getIp())                ? "" : list.get(i).getIp());
            hm.put("mem12", DalbitUtil.isEmpty(list.get(i).getJoin_path())         ? "N" : "Y");
            hm.put("mem13", DalbitUtil.isEmpty(list.get(i).getBroadcastCnt())      ? "" : list.get(i).getBroadcastCnt());
            hm.put("mem14", DalbitUtil.isEmpty(list.get(i).getListenCnt2())        ? "" : list.get(i).getListenCnt2());
            hm.put("mem15", DalbitUtil.isEmpty(list.get(i).getListenCnt())         ? "" : list.get(i).getListenCnt());
            hm.put("mem16", DalbitUtil.isEmpty(list.get(i).getPayCnt())            ? "" : list.get(i).getPayCnt());
            bodies.add(hm.values().toArray());
        }
        ExcelVo vo = new ExcelVo(headers, headerWidths, bodies);
        SXSSFWorkbook workbook = excelService.excelDownload("목록",vo);
        model.addAttribute("locale", Locale.KOREA);
        model.addAttribute("workbook", workbook);
        model.addAttribute("workbookName", "탈퇴 정보 목록");

        return model;
    }

    public String callDormancyList(P_DormancyInputVo pDormancyInputVo){
        ProcedureVo procedureVo = new ProcedureVo(pDormancyInputVo);
        ArrayList<P_DormancyOutputVo> list = mem_JoinDao.callDormancyList(procedureVo);
        P_DormancyOutputVo summary = new Gson().fromJson(procedureVo.getExt(), P_DormancyOutputVo.class);

        String result;
        if(Integer.parseInt(procedureVo.getRet()) > 0) {
            result = gsonUtil.toJson(new JsonOutputVo(Status.휴면계정조회_성공, list, new PagingVo(procedureVo.getRet()),summary));
        }else{
            result = gsonUtil.toJson(new JsonOutputVo(Status.데이터없음));
        }

        return result;
    }

    public String callMemberReturn(P_DormancyInputVo pDormancyInputVo){
        pDormancyInputVo.setOpName(MemberVo.getMyMemNo());
        ProcedureVo procedureVo = new ProcedureVo(pDormancyInputVo);
        mem_JoinDao.callMemberReturn(procedureVo);

        String result;
        if(Integer.parseInt(procedureVo.getRet()) == 0) {
            result = gsonUtil.toJson(new JsonOutputVo(Status.처리완료));
        }else{
            result = gsonUtil.toJson(new JsonOutputVo(Status.비즈니스로직오류));
        }

        return result;
    }
}
