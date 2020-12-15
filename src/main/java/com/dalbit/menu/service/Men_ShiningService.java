package com.dalbit.menu.service;

import com.dalbit.common.code.Status;
import com.dalbit.common.service.CommonService;
import com.dalbit.common.vo.CodeVo;
import com.dalbit.common.vo.JsonOutputVo;
import com.dalbit.common.vo.PagingVo;
import com.dalbit.common.vo.ProcedureVo;
import com.dalbit.content.service.PushService;
import com.dalbit.excel.service.ExcelService;
import com.dalbit.excel.vo.ExcelVo;
import com.dalbit.member.dao.Mem_MemberDao;
import com.dalbit.member.vo.MemberVo;
import com.dalbit.menu.dao.Men_ShiningDao;
import com.dalbit.menu.dao.Men_SpecialDao;
import com.dalbit.menu.vo.*;
import com.dalbit.menu.vo.procedure.P_ShiningDjListOutVo;
import com.dalbit.util.DalbitUtil;
import com.dalbit.util.GsonUtil;
import com.google.gson.Gson;
import lombok.extern.slf4j.Slf4j;
import lombok.var;
import org.apache.poi.xssf.streaming.SXSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;

import java.util.*;

@Slf4j
@Service
public class Men_ShiningService {

    @Autowired
    Men_ShiningDao menShiningDao;

    @Autowired
    GsonUtil gsonUtil;

    @Autowired
    ExcelService excelService;

    /**
     * 샤이닝 DJ 목록
     */
    public String callShiningList(ShiningVo shiningVo) {
        ProcedureVo procedureVo = new ProcedureVo(shiningVo);
        List<P_ShiningDjListOutVo> expectedList = menShiningDao.callShiningList(procedureVo);
        String result = gsonUtil.toJson(new JsonOutputVo(Status.조회, expectedList, new PagingVo(procedureVo.getRet())));
        return result;
    }

    /**
     * 예상 후보 파악
     */
    public String callExpectedList(ShiningVo shiningVo) {

        ProcedureVo procedureVo = new ProcedureVo(shiningVo);

        List<ShiningVo> expectedList = menShiningDao.callExpectedList(procedureVo);

        String result = gsonUtil.toJson(new JsonOutputVo(Status.조회, expectedList, new PagingVo(procedureVo.getRet())));

        return result;
    }

    /**
     * 예상 후보 파악 엑셀 다운로드
     */
    public Model getExpectedListExcel(ShiningVo shiningVo, Model model) {

        ProcedureVo procedureVo = new ProcedureVo(shiningVo);

        List<ShiningVo> list = menShiningDao.callExpectedList(procedureVo);

        String[] headers = {
                "No", "회원번호", "닉네임", "성별"
                , "가입일", "30일 내 방송일수", "30일 내 방송 횟수", "30일 내 방송시간", "30일 내 청취자 수", "30일 내 평균 청취자수"
                , "30일 내 받은 별", "누적 신고 기록"};
        int[] headerWidths = {
                3000, 5000, 6000, 3000
                , 5000, 5000, 5000, 5000, 5000, 5000
                , 5000, 5000};

        List<Object[]> bodies = new ArrayList<>();
        for(int i=0; i<list.size(); i++) {
            HashMap hm = new LinkedHashMap();

            hm.put("no", list.size()-i);
            hm.put("mem_no", DalbitUtil.isEmpty(list.get(i).getMem_no()) ? "" : list.get(i).getMem_no());
            hm.put("mem_nick", DalbitUtil.isEmpty(list.get(i).getMemNick()) ? "" : list.get(i).getMemNick());
            hm.put("mem_sex", DalbitUtil.isEmpty(list.get(i).getMemSex()) ? "" : list.get(i).getMemSex());

            hm.put("join_date", DalbitUtil.isEmpty(list.get(i).getMemJoinDate()) ? "" : list.get(i).getMemJoinDate());
            hm.put("dateCnt", DalbitUtil.isEmpty(list.get(i).getDateCnt()) ? "" : list.get(i).getDateCnt());
            hm.put("broadcastCnt", DalbitUtil.isEmpty(list.get(i).getBroadcastCnt()) ? "" : list.get(i).getBroadcastCnt());
            hm.put("airTime", DalbitUtil.isEmpty(list.get(i).getAirTime()) ? "" : DalbitUtil.timeStampDay(list.get(i).getAirTime()));
            hm.put("sumEntry", DalbitUtil.isEmpty(list.get(i).getSumEntry()) ? "" : list.get(i).getSumEntry());
            hm.put("avgEntry", DalbitUtil.isEmpty(list.get(i).getAvgEntry()) ? "" : list.get(i).getAvgEntry());

            hm.put("byeolCnt", DalbitUtil.isEmpty(list.get(i).getByeolCnt()) ? "" : list.get(i).getByeolCnt());
            hm.put("reportedCnt", DalbitUtil.isEmpty(list.get(i).getReportedCnt()) ? "" : list.get(i).getReportedCnt());

            bodies.add(hm.values().toArray());
        }
        ExcelVo vo = new ExcelVo(headers, headerWidths, bodies);
        SXSSFWorkbook workbook = excelService.excelDownload("샤이닝DJ 예상후보파악",vo);
        model.addAttribute("locale", Locale.KOREA);
        model.addAttribute("workbook", workbook);
        model.addAttribute("workbookName", "샤이닝DJ 예상후보");

        return model;
    }



    /**
     * 샤이닝 DJ 등록
     */
    public String callAddShining(ShiningVo shiningVo) {
        shiningVo.setOpName(MemberVo.getMyMemNo());

        String[] memNo = shiningVo.getMemNo().split("@@");

        for(int i=0; i<memNo.length;i++){
            shiningVo.setMemNo(memNo[i]);
            ProcedureVo procedureVo = new ProcedureVo(shiningVo);
            menShiningDao.callAddShining(procedureVo);

            if(procedureVo.getRet().equals(Status.샤이닝DJ등록_실패_스페셜DJ.getMessageCode())){
                return gsonUtil.toJson(new JsonOutputVo(Status.샤이닝DJ등록_실패_스페셜DJ));
            }else if(procedureVo.getRet().equals(Status.샤이닝DJ등록_실패_뱃지중복.getMessageCode())){
                return gsonUtil.toJson(new JsonOutputVo(Status.샤이닝DJ등록_실패_뱃지중복));
            }else if(procedureVo.getRet().equals(Status.비즈니스로직오류.getMessageCode())){
                return gsonUtil.toJson(new JsonOutputVo(Status.비즈니스로직오류));
            }else if(procedureVo.getRet().equals(Status.DB_비즈니스로직오류.getMessageCode())){
                return gsonUtil.toJson(new JsonOutputVo(Status.비즈니스로직오류));
            }
        }
        return gsonUtil.toJson(new JsonOutputVo(Status.샤이닝DJ등록_성공));

    }

    /**
     * 샤이닝 DJ 삭제
     */
    public String callShiningDelete(ShiningVo shiningVo) {

        String[] memNo = shiningVo.getMemNo().split("@@");

        for(int i=0; i<memNo.length;i++){
            var deleteMember = new ShiningVo();
            deleteMember.setMemNo(memNo[i]);
            deleteMember.setStartDate(shiningVo.getStartDate());
            deleteMember.setEndDate(shiningVo.getEndDate());
            deleteMember.setBadgeType(10);
            ProcedureVo procedureVo = new ProcedureVo(deleteMember);
            menShiningDao.callShiningDelete(procedureVo);

            if(!procedureVo.getRet().equals(Status.샤이닝DJ삭제_성공.getMessageCode())){
                return gsonUtil.toJson(new JsonOutputVo(Status.비즈니스로직오류));
            }
        }
        return gsonUtil.toJson(new JsonOutputVo(Status.샤이닝DJ삭제_성공));

    }


}
