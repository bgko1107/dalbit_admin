package com.dalbit.payment.service;

import com.dalbit.common.code.Status;
import com.dalbit.common.vo.JsonOutputVo;
import com.dalbit.common.vo.PagingVo;
import com.dalbit.excel.service.ExcelService;
import com.dalbit.excel.vo.ExcelVo;
import com.dalbit.member.dao.Mem_MemberDao;
import com.dalbit.payment.dao.Pay_PayDao;
import com.dalbit.payment.vo.*;
import com.dalbit.util.DalbitUtil;
import com.dalbit.util.GsonUtil;
import lombok.extern.slf4j.Slf4j;
import lombok.var;
import org.apache.poi.xssf.streaming.SXSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import javax.servlet.http.HttpServletRequest;
import java.text.ParseException;
import java.util.*;

@Slf4j
@Service
public class Pay_PayService {

    @Autowired
    Pay_PayDao payPayDao;

    @Autowired
    GsonUtil gsonUtil;

    @Autowired
    ExcelService excelService;
    @Autowired
    Mem_MemberDao mem_MemberDao;

    /**
     *  결제 목록 조회
     */
    public String getPayList(Pay_PayInputVo pay_PayInputVo) {

        pay_PayInputVo.setPageNo(pay_PayInputVo.getPageNo() -1);
        pay_PayInputVo.setPageNo(pay_PayInputVo.getPageNo() * pay_PayInputVo.getPageCnt());
        List<Pay_PayOutputVo> list = payPayDao.getPayList(pay_PayInputVo);
        int getPayListCnt = payPayDao.getPayListCnt(pay_PayInputVo);
        //summary
        Pay_PayOutputVo summary = payPayDao.getPaySummary(pay_PayInputVo);
        String result = gsonUtil.toJson(new JsonOutputVo(Status.조회, list, new PagingVo(getPayListCnt),summary));

        return result;
    }


    /**
     * 결제 엑셀
     */
    public Model getListExcel(Pay_PayInputVo payPayInputVo, Model model) {
        payPayInputVo.setPageCnt(60000);

        List<Pay_PayOutputVo> list = payPayDao.getPayList(payPayInputVo);

        String[] headers = {"No", "회원번호", "닉네임","거래번호", "수단", "정보", "시도일시", "완료일시", "결제아이템", "달 수", "결제수량", "금액", "취소 시 차감 달", "보유 달", "직원여부", "플랫폼", "취소일시", "취소실패사유", "처리자", "결제상태", "취소상태"};
        int[] headerWidths = {3000, 3000, 3000,3000, 3000, 5000, 5000, 5000, 3000, 3000, 3000, 3000, 3000, 3000, 3000, 3000, 3000, 3000, 3000, 3000, 3000};

        List<Object[]> bodies = new ArrayList<>();
        for(int i = 0; i < list.size(); i++){
            HashMap hm = new LinkedHashMap();

            String payWay = DalbitUtil.getPayWayConvert(list.get(i).getPay_way());  //결제수단 코드변환
            String platform = DalbitUtil.getPlatformConvert(list.get(i).getOs());   //플랫폼 변환

            hm.put("no", list.size() - i);
            hm.put("col1", DalbitUtil.isEmpty(list.get(i).getMem_no()) ? "" : list.get(i).getMem_no());
            hm.put("col2", DalbitUtil.isEmpty(list.get(i).getMem_nick()) ? "" : list.get(i).getMem_nick());

            hm.put("col3", DalbitUtil.isEmpty(list.get(i).getOrder_id()) ? "" : list.get(i).getOrder_id());

            hm.put("col4", DalbitUtil.isEmpty(payWay) ? "" : payWay);
            hm.put("col5", DalbitUtil.isEmpty(list.get(i).getPay_info_no()) ? "" : list.get(i).getPay_info_no() + " " + (DalbitUtil.isEmpty(list.get(i).getPay_info_nm()) ? "" : list.get(i).getPay_info_nm()));
            hm.put("col6", DalbitUtil.isEmpty(list.get(i).getPay_dt_comein()) ? "" : list.get(i).getPay_dt_comein());
            hm.put("col7", DalbitUtil.isEmpty(list.get(i).getPay_ok_date()) ? "" : list.get(i).getPay_ok_date() + " " + list.get(i).getPay_ok_time());
            hm.put("col8", DalbitUtil.isEmpty(list.get(i).getPay_code()) ? "" : list.get(i).getPay_code());
            hm.put("col9", DalbitUtil.isEmpty(list.get(i).getDal_cnt()) ? "" : DalbitUtil.comma(list.get(i).getDal_cnt()));
            hm.put("col10", DalbitUtil.isEmpty(list.get(i).getItem_amt()) ? "" : list.get(i).getItem_amt());
            hm.put("col11", DalbitUtil.isEmpty(list.get(i).getPay_amt()) ? "" : list.get(i).getPay_amt());
            hm.put("col12", DalbitUtil.isEmpty(list.get(i).getDal_cnt()) ? "" : list.get(i).getDal_cnt());
            hm.put("col13", DalbitUtil.isEmpty(list.get(i).getTot_dal_cnt()) ? "" : list.get(i).getTot_dal_cnt());
            hm.put("col14", DalbitUtil.isEmpty(list.get(i).getChrgr_yn()) ? "" : list.get(i).getChrgr_yn().equals("1") ? "Y" : "N");
            hm.put("col15", DalbitUtil.isEmpty(platform) ? "" : platform);
            hm.put("col16", DalbitUtil.isEmpty(list.get(i).getCancel_dt()) ? "" : list.get(i).getCancel_dt());
            hm.put("col17", DalbitUtil.isEmpty(list.get(i).getFail_msg()) ? "" : list.get(i).getFail_msg());
            hm.put("col18", DalbitUtil.isEmpty(list.get(i).getOp_name()) ? "" : list.get(i).getOp_name());
            hm.put("col19", DalbitUtil.isEmpty(list.get(i).getPay_yn()) ? "" : list.get(i).getPay_yn().toUpperCase());
            hm.put("col20", DalbitUtil.isEmpty(list.get(i).getCancel_state()) ? "" : list.get(i).getCancel_state().toUpperCase());

            bodies.add(hm.values().toArray());
        }
        ExcelVo vo = new ExcelVo(headers, headerWidths, bodies);
        SXSSFWorkbook workbook = excelService.excelDownload("목록",vo);
        model.addAttribute("locale", Locale.KOREA);
        model.addAttribute("workbook", workbook);
        model.addAttribute("workbookName", "결제내역");

        return model;
    }

    public String selectIosAttempList(Pay_IosAttempInputVo payIosAttempInputVo) {

        int attempCnt = payPayDao.selectIosAttempCnt(payIosAttempInputVo);
        List<Pay_IosAttempOutputVo> attempList = payPayDao.selectIosAttempList(payIosAttempInputVo);

        var resultMap = new HashMap();
        resultMap.put("attempCnt", attempCnt);
        resultMap.put("attempList", attempList);

        String result = gsonUtil.toJson(new JsonOutputVo(Status.조회, resultMap));
        return result;
    }

    public String selectCooconReceiptList(Pay_CooconReceiptInputVo payCooconReceiptInputVo) {

        int receiptCnt = payPayDao.selectCooconReceiptCnt(payCooconReceiptInputVo);
        List<Pay_CooconReceiptOutputVo> receiptList = payPayDao.selectCooconReceiptList(payCooconReceiptInputVo);

        var resultMap = new HashMap();
        resultMap.put("receiptCnt", receiptCnt);
        resultMap.put("receiptList", receiptList);

        String result = gsonUtil.toJson(new JsonOutputVo(Status.조회, resultMap));
        return result;
    }


    public Model getReceiptListExcel(Pay_CooconReceiptInputVo payCooconReceiptInputVo, Model model) {

        int getReceiptDataCnt = payPayDao.selectCooconReceiptCnt(payCooconReceiptInputVo);
        payCooconReceiptInputVo.setTotalCnt(getReceiptDataCnt);

        List<Pay_CooconReceiptOutputVo> list = payPayDao.selectCooconReceiptList(payCooconReceiptInputVo);

        String[] headers = {"일시", "이름", "주문번호", " 승인번호", "금액", "증빙종류"};
        int[] headerWidths = {3000, 4000, 10000, 3000, 3000, 3000};

        List<Object[]> bodies = new ArrayList<>();
        for(int i=0; i<list.size(); i++) {
            HashMap hm = new LinkedHashMap();

            hm.put("pay_ok_date", DalbitUtil.isEmpty(list.get(i).getPay_ok_date()) ? "" : list.get(i).getPay_ok_date());
            hm.put("rcpt_nm", DalbitUtil.isEmpty(list.get(i).getRcpt_nm()) ? "" : list.get(i).getRcpt_nm());
            hm.put("order_id", DalbitUtil.isEmpty(list.get(i).getOrder_id()) ? "" : list.get(i).getOrder_id());
            hm.put("receipt_ok_number", DalbitUtil.isEmpty(list.get(i).getReceipt_ok_number()) ? "" : list.get(i).getReceipt_ok_number());
            hm.put("pay_amt", DalbitUtil.isEmpty(list.get(i).getPay_amt()) ? "" : DalbitUtil.comma(list.get(i).getPay_amt()));
            hm.put("receipt_code", DalbitUtil.isEmpty(list.get(i).getReceipt_code()) ? "" : list.get(i).getReceipt_code());

            bodies.add(hm.values().toArray());
        }

        ExcelVo vo = new ExcelVo(headers, headerWidths, bodies);
        SXSSFWorkbook workbook = excelService.excelDownload("쿠콘 현금영수증 발행내역",vo);
        model.addAttribute("locale", Locale.KOREA);
        model.addAttribute("workbook", workbook);
        model.addAttribute("workbookName", "쿠콘 현금영수증 발행내역");

        return model;
    }

    /**
     *  결제내역 추가
     */
    public String payAdd(Pay_PayAddVo pay_PayAddVo, HttpServletRequest request) throws ParseException {
        pay_PayAddVo.setOrder_id(DalbitUtil.getTradeId(String.valueOf(System.currentTimeMillis()).substring(0,12)));
        pay_PayAddVo.setPay_ok_date(DalbitUtil.stringToDatePattern(pay_PayAddVo.getOkDate(), "yyyy-MM-dd HH:mm:ss", "yyyy-MM-dd"));
        pay_PayAddVo.setPay_ok_time(DalbitUtil.stringToDatePattern(pay_PayAddVo.getOkDate(), "yyyy-MM-dd HH:mm:ss", "HH:mm:ss"));
        pay_PayAddVo.setPay_ip(DalbitUtil.getIp(request));

        String result;
        int insertSuccess = payPayDao.payAdd(pay_PayAddVo);
        if(insertSuccess > 0){
            int updateSuccess = payPayDao.payUpdate(pay_PayAddVo);
            if(updateSuccess > 0){
                result = gsonUtil.toJson(new JsonOutputVo(Status.생성));
            }else{
                result = gsonUtil.toJson(new JsonOutputVo(Status.비즈니스로직오류));
            }
        }else{
            result = gsonUtil.toJson(new JsonOutputVo(Status.비즈니스로직오류));
        }
        return result;
    }
}
