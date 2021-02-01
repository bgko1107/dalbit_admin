package com.dalbit.customer.service;

import com.dalbit.common.service.SmsService;
import com.dalbit.common.vo.JsonOutputVo;
import com.dalbit.common.vo.PagingVo;
import com.dalbit.common.vo.SmsVo;
import com.dalbit.customer.dao.Cus_SmsDao;
import com.dalbit.customer.vo.SmsHistoryVo;
import com.dalbit.excel.service.ExcelService;
import com.dalbit.excel.vo.ExcelVo;
import com.dalbit.exception.GlobalException;
import com.dalbit.member.vo.MemberVo;
import com.dalbit.util.DalbitUtil;
import com.dalbit.util.GsonUtil;
import lombok.extern.slf4j.Slf4j;
import org.apache.poi.xssf.streaming.SXSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.dalbit.common.code.*;
import org.springframework.ui.Model;

import java.util.*;

@Slf4j
@Service
public class Cus_SmsService {

    @Autowired
    Cus_SmsDao cusSmsDao;

    @Autowired
    SmsService smsService;

    @Autowired
    GsonUtil gsonUtil;

    @Autowired
    ExcelService excelService;

    /**
     * sms 리스트 조회
     */
    public String getSmsList(SmsHistoryVo smsHistoryVo) {
        String logDate = smsHistoryVo.getTxt_startSel().replaceAll("\\.", "").substring(0,6);
        smsHistoryVo.setLogDateTableName(logDate);

        int count = cusSmsDao.getSmsListCnt(smsHistoryVo);
        smsHistoryVo.setTotalCnt(count);

        List<SmsHistoryVo> list = cusSmsDao.getSmsList(smsHistoryVo);

        String result = gsonUtil.toJson(new JsonOutputVo(Status.조회, list, new PagingVo(smsHistoryVo.getTotalCnt(), smsHistoryVo.getPageStart(), smsHistoryVo.getPageCnt())));
        return result;
    }


    /**
     * sms 상세 조회
     */
    public String getSmsDetail(SmsHistoryVo smsHistoryVo) {

        SmsHistoryVo detail = cusSmsDao.getSmsDetail(smsHistoryVo);

        String result = gsonUtil.toJson(new JsonOutputVo(Status.조회, detail));
        return result;
    }


    /**
     * sms 발송
     */
    public String smsSend(SmsHistoryVo smsHistoryVo) {
        smsHistoryVo.setSend_name(MemberVo.getMyMemNo());
        smsHistoryVo.setCinfo(DalbitUtil.randomValueDatetime(3));
        int sucCnt = 0;
        int failCnt = 0;

        if(smsHistoryVo.getIs_all() == 7){ //지정
            for(HashMap<String, String> target : smsHistoryVo.getMem_nos()){
                String mem_no = target.get("mem_no");
                String phone = target.get("phone");

                SmsVo smsSendVo = new SmsVo(smsHistoryVo.getSubject(), smsHistoryVo.getMsg_body(), phone, smsHistoryVo.getVxml_file());
                smsSendVo.setSend_time(smsHistoryVo.getSend_time());
                smsSendVo.setSend_name(smsHistoryVo.getSend_name());
                smsSendVo.setMem_no(mem_no);
                smsSendVo.setCinfo(smsHistoryVo.getCinfo());

                try {
                    if (smsHistoryVo.getMsg_type().equals("0")) {
                        smsService.sendSms(smsSendVo);
                        sucCnt++;
                    }else{
                        smsService.sendMms(smsSendVo);
                        sucCnt++;
                    }
                }catch (GlobalException e){
                    failCnt++;
                    e.printStackTrace();
                    log.error("[문자 발송 실패] : {}", e.getMessage());
                }
            }
        }else if(smsHistoryVo.getIs_all() == 99) { // 테스트
            SmsVo smsSendVo = new SmsVo(smsHistoryVo.getSubject(), smsHistoryVo.getMsg_body(), "", smsHistoryVo.getVxml_file());
            smsSendVo.setSend_time(smsHistoryVo.getSend_time());
            smsSendVo.setSend_name(smsHistoryVo.getSend_name());
            smsSendVo.setCinfo(smsHistoryVo.getCinfo());

            try {
                if (smsHistoryVo.getMsg_type().equals("0")) {
                    sucCnt = smsService.sendSmsTargetTest(smsSendVo);
                }else{
                    sucCnt = smsService.sendMmsTargetTest(smsSendVo);
                }
            }catch (GlobalException e){
                e.printStackTrace();
                log.error("[문자 발송 실패] : {}", e.getMessage());
            }
        }else if(smsHistoryVo.getIs_all() == 11) { // 전체
            SmsVo smsSendVo = new SmsVo(smsHistoryVo.getSubject(), smsHistoryVo.getMsg_body(), "", smsHistoryVo.getVxml_file());
            smsSendVo.setSend_time(smsHistoryVo.getSend_time());
            smsSendVo.setSend_name(smsHistoryVo.getSend_name());
            smsSendVo.setCinfo(smsHistoryVo.getCinfo());

            try {
                if (smsHistoryVo.getMsg_type().equals("0")) {
                    sucCnt = smsService.sendSmsTargetMemberAll(smsSendVo);
                }else{
                    sucCnt = smsService.sendMmsTargetMemberAll(smsSendVo);
                }
            }catch (GlobalException e){
                e.printStackTrace();
                log.error("[문자 발송 실패] : {}", e.getMessage());
            }
        }


        HashMap resultMap = new HashMap();
        resultMap.put("sucCnt", sucCnt);
        resultMap.put("failCnt", failCnt);

        return gsonUtil.toJson(new JsonOutputVo(Status.생성, resultMap));
    }

    /**
     * sms 예약문자 삭제
     */
    public String smsDel(SmsHistoryVo smsHistoryVo) {
        cusSmsDao.smsDel(smsHistoryVo);
        String result = gsonUtil.toJson(new JsonOutputVo(Status.삭제));
        return result;
    }

    /**
     * sms 엑셀 출력
     */
    public Model getListExcel(SmsHistoryVo smsHistoryVo, Model model) {
        String logDate = smsHistoryVo.getTxt_startSel().replaceAll("\\.", "").substring(0,6);
        smsHistoryVo.setLogDateTableName(logDate);

        int count = cusSmsDao.getSmsListCnt(smsHistoryVo);
        smsHistoryVo.setTotalCnt(count);

        List<SmsHistoryVo> list = cusSmsDao.getSmsList(smsHistoryVo);

        String[] headers = {"No", "발신번호", "통신사", "수신번호", "회원 ID", "회원 닉네임", "발송상태", "발송일", "LMS 제목", "발송내용", "구분", "요청자"};
        int[] headerWidths = {2000, 4000, 2000, 4000, 4000, 4000, 2000, 5000, 6000, 20000, 2000, 2000};

        List<Object[]> bodies = new ArrayList<>();
        for(int i=0; i<list.size(); i++) {
            HashMap hm = new LinkedHashMap();

            hm.put("No", DalbitUtil.isEmpty(list.get(i).getCmid()) ? "" : list.get(i).getCmid());
            hm.put("send_phone", DalbitUtil.isEmpty(list.get(i).getSend_phone()) ? "" : list.get(i).getSend_phone());
            hm.put("phone", DalbitUtil.isEmpty(list.get(i).getWap_info()) ? "" : list.get(i).getWap_info());
            hm.put("dest_phone", DalbitUtil.isEmpty(list.get(i).getDest_phone()) ? "" : list.get(i).getDest_phone());
            hm.put("mem_id", DalbitUtil.isEmpty(list.get(i).getMem_id()) ? "" : list.get(i).getMem_id());
            hm.put("mem_nick", DalbitUtil.isEmpty(list.get(i).getMem_nick()) ? "" : list.get(i).getMem_nick());
            hm.put("status", DalbitUtil.isEmpty(list.get(i).getStatus()) ? "" : list.get(i).getStatus());
            hm.put("report_time", DalbitUtil.isEmpty(list.get(i).getReport_time()) ? "" : list.get(i).getReport_time());
            hm.put("subject", DalbitUtil.isEmpty(list.get(i).getSubject()) ? "" : list.get(i).getSubject());
            hm.put("msg_body", DalbitUtil.isEmpty(list.get(i).getMsg_body()) ? "" : list.get(i).getMsg_body());
            hm.put("vxml_file", DalbitUtil.isEmpty(list.get(i).getVxml_file()) ? "" : list.get(i).getVxml_file());
            hm.put("send_name", DalbitUtil.isEmpty(list.get(i).getSend_name()) ? "" : list.get(i).getSend_name());

            bodies.add(hm.values().toArray());
        }

        ExcelVo vo = new ExcelVo(headers, headerWidths, bodies);
        SXSSFWorkbook workbook = excelService.excelDownload("문자 발송내역",vo);
        model.addAttribute("locale", Locale.KOREA);
        model.addAttribute("workbook", workbook);
        model.addAttribute("workbookName", "문자 발송내역");

        return model;
    }

}
