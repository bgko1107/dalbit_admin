package com.dalbit.member.service;

import com.dalbit.common.code.Status;
import com.dalbit.common.vo.JsonOutputVo;
import com.dalbit.common.vo.PagingVo;
import com.dalbit.excel.service.ExcelService;
import com.dalbit.excel.vo.ExcelVo;
import com.dalbit.member.dao.Mem_JoinDao;
import com.dalbit.member.vo.procedure.P_MemberJoinInputVo;
import com.dalbit.member.vo.procedure.P_MemberJoinOutputVo;
import com.dalbit.util.DalbitUtil;
import com.dalbit.util.GsonUtil;
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
        pMemberJoinInputVo.setPageCnt(100000);
        pMemberJoinInputVo.getSearchText();
        ArrayList<P_MemberJoinOutputVo> list = mem_JoinDao.callJoinList(pMemberJoinInputVo);
        String[] headers = null;
        headers = new String[]{"No", "회원가입일시", "가입플랫폼", "OS", "회원번호", "로그인ID", "UserID", "닉네임", "이름", "연락처", "IP"};
        int[] headerWidths = {3000, 6000, 6000, 6000, 6000, 6000, 6000, 6000, 6000, 6000, 6000};

        List<Object[]> bodies = new ArrayList<>();
        for(int i = 0; i < list.size(); i++){
            HashMap hm = new LinkedHashMap();

            hm.put("no", list.size()-i);
            hm.put("mem1", DalbitUtil.isEmpty(list.get(i).getMemJoinDateFormat()) ? "" : list.get(i).getMemJoinDateFormat());
            hm.put("mem2",  DalbitUtil.isEmpty(list.get(i).getMem_slct())          ? "" : list.get(i).getMem_slct());
            hm.put("mem3", DalbitUtil.isEmpty(list.get(i).getOs_type())            ? "" : list.get(i).getOs_type());
            hm.put("mem4",  DalbitUtil.isEmpty(list.get(i).getMem_no())            ? "" : list.get(i).getMem_no());
            hm.put("mem5",  DalbitUtil.isEmpty(list.get(i).getMem_id())            ? "" : list.get(i).getMem_id());
            hm.put("mem6",  DalbitUtil.isEmpty(list.get(i).getMem_userid())        ? "" : list.get(i).getMem_userid());
            hm.put("mem7",  DalbitUtil.isEmpty(list.get(i).getMem_nick())          ? "" : list.get(i).getMem_nick());
            hm.put("mem8",  DalbitUtil.isEmpty(list.get(i).getMem_name())          ? "" : list.get(i).getMem_name());
            hm.put("mem9",  DalbitUtil.isEmpty(list.get(i).getMem_phone())         ? "" : list.get(i).getMem_phone());
            hm.put("mem10", DalbitUtil.isEmpty(list.get(i).getIp())                ? "" : list.get(i).getIp());
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
        pMemberJoinInputVo.setPageCnt(100000);
        ArrayList<P_MemberJoinOutputVo> list = mem_JoinDao.callWithdrawalList(pMemberJoinInputVo);
        String[] headers = null;
        headers = new String[]{"No", "회원탈퇴일시", "가입플랫폼", "OS", "회원번호", "로그인ID", "UserID", "닉네임", "이름", "연락처", "IP"};
        int[] headerWidths = {3000, 6000, 6000, 6000, 6000, 6000, 6000, 6000, 6000, 6000, 6000};

        List<Object[]> bodies = new ArrayList<>();
        for(int i = 0; i < list.size(); i++){
            HashMap hm = new LinkedHashMap();

            hm.put("no", list.size()-i);
            hm.put("mem1", DalbitUtil.isEmpty(list.get(i).getLastUpdDateFormat())  ? "" : list.get(i).getLastUpdDateFormat());
            hm.put("mem2",  DalbitUtil.isEmpty(list.get(i).getMem_slct())          ? "" : list.get(i).getMem_slct());
            hm.put("mem3", DalbitUtil.isEmpty(list.get(i).getOs_type())            ? "" : list.get(i).getOs_type());
            hm.put("mem4",  DalbitUtil.isEmpty(list.get(i).getMem_no())            ? "" : list.get(i).getMem_no());
            hm.put("mem5",  DalbitUtil.isEmpty(list.get(i).getMem_id())            ? "" : list.get(i).getMem_id());
            hm.put("mem6",  DalbitUtil.isEmpty(list.get(i).getMem_userid())        ? "" : list.get(i).getMem_userid());
            hm.put("mem7",  DalbitUtil.isEmpty(list.get(i).getMem_nick())          ? "" : list.get(i).getMem_nick());
            hm.put("mem8",  DalbitUtil.isEmpty(list.get(i).getMem_name())          ? "" : list.get(i).getMem_name());
            hm.put("mem9",  DalbitUtil.isEmpty(list.get(i).getMem_phone())         ? "" : list.get(i).getMem_phone());
            hm.put("mem10", DalbitUtil.isEmpty(list.get(i).getIp())                ? "" : list.get(i).getIp());
            bodies.add(hm.values().toArray());
        }
        ExcelVo vo = new ExcelVo(headers, headerWidths, bodies);
        SXSSFWorkbook workbook = excelService.excelDownload("목록",vo);
        model.addAttribute("locale", Locale.KOREA);
        model.addAttribute("workbook", workbook);
        model.addAttribute("workbookName", "탈퇴 정보 목록");

        return model;
    }

}
