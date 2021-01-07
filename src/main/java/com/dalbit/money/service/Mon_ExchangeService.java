package com.dalbit.money.service;

import com.dalbit.common.code.Status;
import com.dalbit.common.service.SmsService;
import com.dalbit.common.vo.JsonOutputVo;
import com.dalbit.common.vo.ProcedureVo;
import com.dalbit.content.service.PushService;
import com.dalbit.content.vo.procedure.P_pushInsertVo;
import com.dalbit.enter.vo.procedure.P_StatVo;
import com.dalbit.excel.service.ExcelService;
import com.dalbit.excel.vo.ExcelVo;
import com.dalbit.exception.GlobalException;
import com.dalbit.member.dao.Mem_MemberDao;
import com.dalbit.member.vo.MemberVo;
import com.dalbit.member.vo.procedure.P_MemberParentsAgreeInputVo;
import com.dalbit.member.vo.procedure.P_MemberParentsAgreeOutputVo;
import com.dalbit.money.dao.Mon_ExchangeDao;
import com.dalbit.money.vo.*;
import com.dalbit.money.vo.procedure.P_ExchangeCancelInputVo;
import com.dalbit.payment.dao.Pay_PayDao;
import com.dalbit.payment.vo.Pay_PaySumOutputVo;
import com.dalbit.util.AES;
import com.dalbit.util.DalbitUtil;
import com.dalbit.util.GsonUtil;
import com.google.gson.Gson;
import lombok.extern.slf4j.Slf4j;
import lombok.var;
import org.apache.poi.xssf.streaming.SXSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import java.util.*;

@Slf4j
@Service
public class Mon_ExchangeService {

    @Autowired
    Mon_ExchangeDao monExchangeDao;

    @Autowired
    ExcelService excelService;

    @Autowired
    GsonUtil gsonUtil;

    @Autowired
    SmsService smsService;

    @Autowired
    PushService pushService;

    @Autowired
    Mem_MemberDao mem_MemberDao;

    @Autowired
    Pay_PayDao pay_PayDao;

    public String selectExchangeList(Mon_ExchangeInputVo monExchangeInputVo){

        var resultMap = new HashMap<>();

        if(DalbitUtil.isEmpty(monExchangeInputVo.getIsSpecial())){  //환전가능리스트
            if(monExchangeInputVo.getViewName().equals("enableList")) {
                Mon_EnableOutputVo outVo = monExchangeDao.selectEnableCnt(monExchangeInputVo);
                monExchangeInputVo.setTotalCnt(outVo.getEnableCnt());
                ArrayList<Mon_EnableOutputVo> enableList = monExchangeDao.selectEnableList(monExchangeInputVo);

                P_StatVo pStatVo = new P_StatVo();
                Pay_PaySumOutputVo outTotalPay = pay_PayDao.getTotalPaySum(pStatVo);

                //Mon_EnableOutputVo outExchangeVo = monExchangeDao.totalExchangeCash(monExchangeInputVo);

                monExchangeInputVo.setIsSpecial(0);
                Mon_EnableOutputVo generalMember = monExchangeDao.selectExchangeCash(monExchangeInputVo);
                long generalTotal = 0;
                if(0 < generalMember.getTotalGold()){
                    generalTotal = DalbitUtil.computeExchangeAmt(generalMember.getTotalGold(), 0);
                }

                monExchangeInputVo.setIsSpecial(1);
                Mon_EnableOutputVo specialMember = monExchangeDao.selectExchangeCash(monExchangeInputVo);
                long specialTotal = 0;
                if(0 < specialMember.getTotalGold()){
                    specialTotal = DalbitUtil.computeExchangeAmt(specialMember.getTotalGold(), 1);
                }


                var monEnableSummaryVo = new Mon_EnableSummaryVo();
                monEnableSummaryVo.setSearch_testId(monExchangeInputVo.getSearch_testId());
                monEnableSummaryVo.setSearch_exchangeYn(monExchangeInputVo.getSearch_exchangeYn());

                ArrayList<Mon_EnableSummaryVo> summaryList = monExchangeDao.selectEnableSummary(monEnableSummaryVo);

                int notExchangeMemberCnt = 0;
                long notExchangeMemberByeol = 0;
                long notExchangeMemberAmt = 0;
                int monthNot3ExchangeMemberCnt = 0;
                long monthNot3ExchangeMemberByeol = 0;
                long monthNot3ExchangeMemberAmt = 0;
                int month3ExchangeMemberCnt = 0;
                long month3ExchangeMemberByeol = 0;
                long month3ExchangeMemberAmt = 0;
                int exchangeTotal = 0;
                long exchangeByeolTotal = 0;
                long exchangeAmtTotal = 0;

                for(int i=0; i < summaryList.size(); i++){
                    exchangeTotal += summaryList.get(i).getCount();
                    exchangeByeolTotal += summaryList.get(i).getGeneral() + summaryList.get(i).getSpecial();

                    long tmp_1 = 0 < summaryList.get(i).getGeneral() ? DalbitUtil.computeExchangeAmt(summaryList.get(i).getGeneral(), 0): 0;
                    long tmp_2 = 0 < summaryList.get(i).getSpecial() ? DalbitUtil.computeExchangeAmt(summaryList.get(i).getSpecial(), 1): 0;
                    exchangeAmtTotal += tmp_1 + tmp_2;
                    if(i == 0){
                        notExchangeMemberCnt = summaryList.get(i).getCount();
                        notExchangeMemberByeol = summaryList.get(i).getGeneral() + summaryList.get(i).getSpecial();

                        tmp_1 = 0 < summaryList.get(i).getGeneral() ? DalbitUtil.computeExchangeAmt(summaryList.get(i).getGeneral(), 0): 0;
                        tmp_2 = 0 < summaryList.get(i).getSpecial() ? DalbitUtil.computeExchangeAmt(summaryList.get(i).getSpecial(), 1): 0;
                        notExchangeMemberAmt =  tmp_1 + tmp_2;
                    }else if(i == 1){
                        month3ExchangeMemberCnt = summaryList.get(i).getCount();
                        month3ExchangeMemberByeol = summaryList.get(i).getGeneral() + summaryList.get(i).getSpecial();

                        tmp_1 = 0 < summaryList.get(i).getGeneral() ? DalbitUtil.computeExchangeAmt(summaryList.get(i).getGeneral(), 0): 0;
                        tmp_2 = 0 < summaryList.get(i).getSpecial() ? DalbitUtil.computeExchangeAmt(summaryList.get(i).getSpecial(), 1): 0;
                        month3ExchangeMemberAmt = tmp_1 + tmp_2;
                    }else if(i == 2){
                        monthNot3ExchangeMemberCnt = summaryList.get(i).getCount();
                        monthNot3ExchangeMemberByeol = summaryList.get(i).getGeneral() + summaryList.get(i).getSpecial();

                        tmp_1 = 0 < summaryList.get(i).getGeneral() ? DalbitUtil.computeExchangeAmt(summaryList.get(i).getGeneral(), 0): 0;
                        tmp_2 = 0 < summaryList.get(i).getSpecial() ? DalbitUtil.computeExchangeAmt(summaryList.get(i).getSpecial(), 1): 0;
                        monthNot3ExchangeMemberAmt = tmp_1 + tmp_2;
                    }
                }

                resultMap.put("enableCnt", outVo.getEnableCnt());
                resultMap.put("totalGold", generalMember.getTotalGold() + specialMember.getTotalGold());
                //resultMap.put("totalSpecialCnt", outVo.getTotalSpecialCnt());
                resultMap.put("enableList", enableList);
                resultMap.put("totalSuccAmt", outTotalPay.getTotalSuccAmt());
                resultMap.put("totalExchangeAmt", generalTotal + specialTotal);

                resultMap.put("notExchangeMemberCnt", notExchangeMemberCnt);
                resultMap.put("notExchangeMemberByeol", notExchangeMemberByeol);
                resultMap.put("notExchangeMemberAmt", notExchangeMemberAmt);
                resultMap.put("monthNot3ExchangeMemberCnt", monthNot3ExchangeMemberCnt);
                resultMap.put("monthNot3ExchangeMemberByeol", monthNot3ExchangeMemberByeol);
                resultMap.put("monthNot3ExchangeMemberAmt", monthNot3ExchangeMemberAmt);
                resultMap.put("month3ExchangeMemberCnt", month3ExchangeMemberCnt);
                resultMap.put("month3ExchangeMemberByeol", month3ExchangeMemberByeol);
                resultMap.put("month3ExchangeMemberAmt", month3ExchangeMemberAmt);
                resultMap.put("exchangeTotal", exchangeTotal);
                resultMap.put("exchangeByeolTotal", exchangeByeolTotal);
                resultMap.put("exchangeAmtTotal", exchangeAmtTotal);

                return gsonUtil.toJson(new JsonOutputVo(Status.조회, resultMap));

                //}else if(monExchangeInputVo.getViewName().equals("rejectList")){
            }else{
                //monExchangeInputVo.setLast_reject(0);

                int rejectCnt = monExchangeDao.selectExchangeCnt(monExchangeInputVo);
                monExchangeInputVo.setTotalCnt(rejectCnt);
                ArrayList<Mon_ExchangeOutputVo> rejectList = monExchangeDao.selectExchangeList(monExchangeInputVo);

                for(int i=0;i<rejectList.size();i++) {
                    MemberVo outVo = mem_MemberDao.getMemberInfo(rejectList.get(i).getMem_no());
                    if (!DalbitUtil.isEmpty(outVo)) {
                        rejectList.get(i).setMem_sex(outVo.getMem_sex());
                        rejectList.get(i).setMem_birth_year(outVo.getMem_birth_year());
                        rejectList.get(i).setMem_birth_month(outVo.getMem_birth_month());
                        rejectList.get(i).setMem_birth_day(outVo.getMem_birth_day());
                    }
                }
                resultMap.put("rejectCnt", rejectCnt);
                resultMap.put("rejectList", rejectList);
                return gsonUtil.toJson(new JsonOutputVo(Status.조회, resultMap));
            }

        }else{  //환전내역
            if(!DalbitUtil.isEmpty(monExchangeInputVo.getBaseDay())){
                monExchangeInputVo.setEnd_day(monExchangeInputVo.getEnd_day().length() == 1 ? "0"+monExchangeInputVo.getEnd_day() : monExchangeInputVo.getEnd_day());
                monExchangeInputVo.setSearch_day(monExchangeInputVo.getSearch_day().length() == 1 ? "0"+monExchangeInputVo.getSearch_day() : monExchangeInputVo.getSearch_day());
            }

            monExchangeInputVo.setLast_reject(1);

            int exchangeCnt = monExchangeDao.selectExchangeCnt(monExchangeInputVo);
            monExchangeInputVo.setTotalCnt(exchangeCnt);
            ArrayList<Mon_ExchangeOutputVo> exchangeList = monExchangeDao.selectExchangeList(monExchangeInputVo);

            for(int i=0;i<exchangeList.size();i++) {
                MemberVo outVo = mem_MemberDao.getMemberInfo(exchangeList.get(i).getMem_no());
                if(!DalbitUtil.isEmpty(outVo)) {
                    exchangeList.get(i).setMem_sex(outVo.getMem_sex());
                    exchangeList.get(i).setMem_birth_year(outVo.getMem_birth_year());
                    exchangeList.get(i).setMem_birth_month(outVo.getMem_birth_month());
                    exchangeList.get(i).setMem_birth_day(outVo.getMem_birth_day());
                }
                // 테스트 아이디 등록 여부
                int testidCnt = monExchangeDao.testid_historyCnt(exchangeList.get(i).getMem_no());
                if(testidCnt > 0){
                    exchangeList.get(i).setTestid_history("Y");
                }else{
                    exchangeList.get(i).setTestid_history("N");
                }
            }

            resultMap.put("exchangeCnt", exchangeCnt);
            resultMap.put("exchangeList", exchangeList);
            return gsonUtil.toJson(new JsonOutputVo(Status.조회, resultMap));
        }
    }

    public String selectExchangeSummary(Mon_ExchangeInputVo monExchangeInputVo){

        monExchangeInputVo.setIsSpecial(1);
        ArrayList<Integer> specialSummaryList = monExchangeDao.selectSummaryInfo(monExchangeInputVo);

        monExchangeInputVo.setIsSpecial(0);
        ArrayList<Integer> generalSummaryList = monExchangeDao.selectSummaryInfo(monExchangeInputVo);

        var resultMap = new HashMap<>();
        resultMap.put("specialSummaryList", specialSummaryList);
        resultMap.put("generalSummaryList", generalSummaryList);

        return gsonUtil.toJson(new JsonOutputVo(Status.조회, resultMap));
    }

    public String selectStatSummaryInfo(Mon_ExchangeInputVo monExchangeInputVo){

        monExchangeInputVo.setIsSpecial(1);
        ArrayList<Mon_ExchangeSummaryOutputVo> specialSummaryList = monExchangeDao.selectStatSummaryInfo(monExchangeInputVo);

        monExchangeInputVo.setIsSpecial(0);
        ArrayList<Mon_ExchangeSummaryOutputVo> generalSummaryList = monExchangeDao.selectStatSummaryInfo(monExchangeInputVo);

        var resultMap = new HashMap<>();
        resultMap.put("specialSummaryList", specialSummaryList);
        resultMap.put("generalSummaryList", generalSummaryList);

        return gsonUtil.toJson(new JsonOutputVo(Status.조회, resultMap));
    }

    public Model getListExcel(Mon_ExchangeInputVo monExchangeInputVo, Model model) {

        ArrayList<Mon_ExchangeOutputVo> exchangeList = monExchangeDao.selectExchangeList(monExchangeInputVo);

        String[] specialDj_headers = {
            "No", "아이디", "이름", "예금주", "금액",
            "스페셜DJ혜택", "과세금액", "소득세", "주민세", "수수료",
            "실지급액",  "주민번호", "연락처", "은행명", "계좌번호",
            "주소"
        };

        int[] specialDj_headerWidths = {
            1000, 4000, 3000, 3000, 3000,
            3000, 3000, 2000, 2000, 3000,
            4000, 3500, 3000, 5000, 10000,
            10000
        };

        String[] general_headers = {
                "No", "아이디", "이름", "예금주", "금액",
                /*"스페셜DJ혜택", "과세금액",*/ "소득세", "주민세", "수수료",
                "실지급액",  "주민번호", "연락처", "은행명", "계좌번호",
                "주소"
        };

        int[] general_headerWidths = {
                1000, 4000, 3000, 3000, 3000,
                /*3000, 3000,*/ 2000, 2000, 3000,
                4000, 3500, 3000, 5000, 10000,
                10000
        };

        int cashBasicTotal = 0;
        int benefitTotal = 0;
        int incomeTaxTotal = 0;
        int residentTaxTotal = 0;
        int transferFeeTotal = 0;
        int exchangeCashTotal = 0;

        List<Object[]> bodies = new ArrayList<>();
        for(int i = 0; i < exchangeList.size(); i++){
            var exchangeVo = exchangeList.get(i);

            HashMap hm = new LinkedHashMap();

            hm.put("no", i+1);
            hm.put("id", DalbitUtil.isEmpty(exchangeVo.getMem_id()) ? "" : exchangeVo.getMem_id());
            hm.put("name", DalbitUtil.isEmpty(exchangeVo.getMem_name()) ? "" : exchangeVo.getMem_name());
            hm.put("accountName", DalbitUtil.isEmpty(exchangeVo.getAccount_name()) ? "" : exchangeVo.getAccount_name());

            hm.put("cashBasic", exchangeVo.getCash_basic());
            cashBasicTotal += exchangeVo.getCash_basic();

            if(monExchangeInputVo.getIsSpecial() == 1){
                hm.put("benefit", exchangeVo.getBenefit());
                benefitTotal += exchangeVo.getBenefit();

                hm.put("cashSum", exchangeVo.getCash_basic() + exchangeVo.getBenefit());
            }

            hm.put("income_tax", exchangeVo.getIncome_tax());
            incomeTaxTotal += exchangeVo.getIncome_tax();

            hm.put("resident_tax", exchangeVo.getResident_tax());
            residentTaxTotal += exchangeVo.getResident_tax();

            hm.put("transfer_fee", exchangeVo.getTransfer_fee());
            transferFeeTotal += exchangeVo.getTransfer_fee();

            hm.put("exchangeCash", exchangeVo.getCash_real());
            exchangeCashTotal += exchangeVo.getCash_real();

            hm.put("socialNo", DalbitUtil.isEmpty(exchangeVo.getSocial_no()) ? "" : DalbitUtil.convertJuminNo(AES.decrypt(exchangeVo.getSocial_no(), DalbitUtil.getProperty("social.secret.key"))));
            hm.put("phoneNo", DalbitUtil.isEmpty(exchangeVo.getPhone_no()) ? "" : DalbitUtil.convertPhoneNo(exchangeVo.getPhone_no()));

            hm.put("bankName", exchangeVo.getBank_name());
            hm.put("accountNo", DalbitUtil.isEmpty(exchangeVo.getAccount_no()) ? "" : exchangeVo.getAccount_no());

            String address = DalbitUtil.isEmpty(exchangeVo.getAddress_1()) ? "" : exchangeVo.getAddress_1();
            address += DalbitUtil.isEmpty(exchangeVo.getAddress_2()) ? "" : " "+ exchangeVo.getAddress_2();
            hm.put("address", address);

            bodies.add(hm.values().toArray());
        }

        if(0 < exchangeList.size()){
            HashMap totalMap = new LinkedHashMap();
            totalMap.put("no", "");
            totalMap.put("id", "합계");
            totalMap.put("name", "");
            totalMap.put("accountName", "");
            totalMap.put("cashBasic", cashBasicTotal);

            if(monExchangeInputVo.getIsSpecial() == 1) {
                totalMap.put("benefit", benefitTotal);
                totalMap.put("cashSum", cashBasicTotal + benefitTotal);
            }

            totalMap.put("income_tax", incomeTaxTotal);
            totalMap.put("resident_tax", residentTaxTotal);
            totalMap.put("transfer_fee", transferFeeTotal);
            totalMap.put("exchangeCash", exchangeCashTotal);
            totalMap.put("socialNo", "");
            totalMap.put("phoneNo", "");
            totalMap.put("bankName", "");
            totalMap.put("accountNo", "");
            totalMap.put("address", "");

            bodies.add(totalMap.values().toArray());
        }

        var excelVo = new ExcelVo();
        if(monExchangeInputVo.getIsSpecial() == 1){
            excelVo.setHeaders(specialDj_headers);
            excelVo.setHeaderWidths(specialDj_headerWidths);

        }else{
            excelVo.setHeaders(general_headers);
            excelVo.setHeaderWidths(general_headerWidths);
        }
        excelVo.setBodies(bodies);

        SXSSFWorkbook workbook = excelService.excelDownload("환전",excelVo);
        model.addAttribute("locale", Locale.KOREA);
        model.addAttribute("workbook", workbook);
        model.addAttribute("workbookName", "환전 목록");
        model.addAttribute("listSize", exchangeList.size());
        model.addAttribute("body", excelVo.getBodies());

        return model;
    }

    public String selectExchangeDetail(Mon_ExchangeInputVo monExchangeInputVo){

        Mon_ExchangeOutputVo monExchangeOutputVo = monExchangeDao.selectExchangeDetail(monExchangeInputVo);
        monExchangeOutputVo.setSocial_no(AES.decrypt(monExchangeOutputVo.getSocial_no(), DalbitUtil.getProperty("social.secret.key")));
        monExchangeOutputVo.setPrevSocialNo(AES.decrypt(monExchangeOutputVo.getPrevSocialNo(), DalbitUtil.getProperty("social.secret.key")));
        P_MemberParentsAgreeInputVo pMemberParentsAgreeInputVo = new P_MemberParentsAgreeInputVo();
        pMemberParentsAgreeInputVo.setMemNo(monExchangeOutputVo.getMem_no());
        P_MemberParentsAgreeOutputVo memberParentsAgreeOutputVo = mem_MemberDao.getParentsAgreeInfo(pMemberParentsAgreeInputVo);

        var resultMap = new HashMap<>();
        resultMap.put("detail", monExchangeOutputVo);
        resultMap.put("parentInfo", memberParentsAgreeOutputVo);

        return gsonUtil.toJson(new JsonOutputVo(Status.조회, resultMap));
    }

    public String updateExchangeDetail(Mon_ExchangeOutputVo monExchangeOutputVo){

        monExchangeOutputVo.setSocial_no(AES.encrypt(monExchangeOutputVo.getSocial_no(), DalbitUtil.getProperty("social.secret.key")));
        monExchangeDao.updateExchangeDetail(monExchangeOutputVo);
        return gsonUtil.toJson(new JsonOutputVo(Status.수정));
    }

    public String updateExchangeComplete(Mon_ExchangeOutputVo monExchangeOutputVo) throws GlobalException {

        monExchangeOutputVo.setSocial_no(AES.encrypt(monExchangeOutputVo.getSocial_no(), DalbitUtil.getProperty("social.secret.key")));

        //최근 불가 모두 0으로 업데이트
        monExchangeDao.updateLastReject(monExchangeOutputVo);

        monExchangeDao.updateExchangeComplete(monExchangeOutputVo);
        if(monExchangeOutputVo.getState().equals("1")) {
            var message = new StringBuffer();
            message.append("[달빛라이브] 회원님께서 신청하신 환전요청 건이 승인이 완료되어 요청금액이 입금되었습니다.");
            //message.append("\n\n※ 마이페이지>내지갑에서도 내역을 확인할 수 있습니다.");

            //smsService.sendSms(new SmsVo(message.toString(), monExchangeOutputVo.getPhone_no(), Code.SMS발송_환전완료.getCode()));
            //smsService.sendMms(new SmsHistoryVo("[달빛라이브]", message.toString(), monExchangeOutputVo.getPhone_no(), Code.SMS발송_환전완료.getCode()));

            try{    // PUSH 발송

                var monExchangeInputVo = new Mon_ExchangeInputVo();
                monExchangeInputVo.setIdx(monExchangeOutputVo.getIdx());
                Mon_ExchangeOutputVo exchangeInfo = monExchangeDao.selectExchangeDetail(monExchangeInputVo);

                P_pushInsertVo pPushInsertVo = new P_pushInsertVo();
                pPushInsertVo.setMem_nos(exchangeInfo.getMem_no());
                pPushInsertVo.setSlct_push("2");
                pPushInsertVo.setPush_slct("62");   //환전 완료
                pPushInsertVo.setSend_title("회원님께서 신청하신 환전처리가 완료되었습니다.");
                pPushInsertVo.setSend_cont("마이페이지 > 내지갑을 확인해주세요.");
                pPushInsertVo.setImage_type("101");
                pushService.sendPushReqOK(pPushInsertVo);
            }catch (Exception e){
                log.error("[PUSH 발송 실패 - 환전 성공]");
            }

        }else if(monExchangeOutputVo.getState().equals("2")){
            P_ExchangeCancelInputVo pExchangeCancelInputVo = new P_ExchangeCancelInputVo();
            pExchangeCancelInputVo.setExchangeIdx(monExchangeOutputVo.getIdx());
            var procedureVo = new ProcedureVo(pExchangeCancelInputVo);
            monExchangeDao.callExchangeCancel(procedureVo);

            if(procedureVo.getRet().equals(Status.환전_취소_없는환전번호.getMessageCode())){
                return gsonUtil.toJson(new JsonOutputVo(Status.환전_취소_없는환전번호));

            }else if(procedureVo.getRet().equals(Status.환전_취소_취소상태아님.getMessageCode())){
                return gsonUtil.toJson(new JsonOutputVo(Status.환전_취소_취소상태아님));

            }else if(procedureVo.getRet().equals(Status.환전_취소_회원번호없음.getMessageCode())){
                return gsonUtil.toJson(new JsonOutputVo(Status.환전_취소_회원번호없음));

            }else if(procedureVo.getRet().equals(Status.환전_취소_이미완료.getMessageCode())){
                return gsonUtil.toJson(new JsonOutputVo(Status.환전_취소_이미완료));
            }



//            String subject = "환전신청이 승인되지 않았습니다.";
//            var message = new StringBuffer();
//            message.append("신청하신 환전정보 중 첨부파일이 명확하게 확인되지 않아 승인이 거부되었습니다.\n");
//            message.append("회원님의 정보 또는 통장사본의 정보가 정확하게 확인될 수 있도록 다시 캡쳐 또는 사진을 찍어 첨부하여 신청해주시기 바랍니다.\n");
//            message.append("[달빛라이브] 회원님께서 신청하신 환전요청 정보가 부적합하여 정상처리가 되지않았습니다.");
            //message.append("신청정보를 다시 확인하시고, 재신청하여 주시기 바랍니다.\n\n");
            //message.append("※ 궁금한 사항은 1:1문의로 연락해 주시기바랍니다.\n");


            // TODO 양부장님 요청으로 인한 MMS 발송 중단 2020.06.12 (06.15 확인 필요)
            //smsService.sendMms(new SmsHistoryVo("[달빛라이브]", monExchangeOutputVo.getSend_title() + "\n\n" + monExchangeOutputVo.getSend_cont(), monExchangeOutputVo.getPhone_no(), Code.SMS발송_환전불가.getCode()));
            //smsService.sendMms(new SmsHistoryVo("[달빛라이브]", message.toString(), monExchangeOutputVo.getPhone_no(), Code.SMS발송_환전불가.getCode()));

            try{    // PUSH 발송

                var monExchangeInputVo = new Mon_ExchangeInputVo();
                monExchangeInputVo.setIdx(monExchangeOutputVo.getIdx());
                Mon_ExchangeOutputVo exchangeInfo = monExchangeDao.selectExchangeDetail(monExchangeInputVo);

                P_pushInsertVo pPushInsertVo = new P_pushInsertVo();
                pPushInsertVo.setMem_nos(exchangeInfo.getMem_no());
                pPushInsertVo.setSlct_push("2");
                pPushInsertVo.setPush_slct("63");   //환전 취소
//                pPushInsertVo.setSend_title("회원님께서 신청하신 환전처리가 불가처리 되었습니다.");
//                pPushInsertVo.setSend_cont("자세한 사항은 1:1문의로 연락해 주시기바랍니다.");
                pPushInsertVo.setSend_title(monExchangeOutputVo.getSend_title());
                pPushInsertVo.setSend_cont(monExchangeOutputVo.getSend_cont());
                pPushInsertVo.setImage_type("101");
                pushService.sendPushReqOK(pPushInsertVo);
            }catch (Exception e){
                log.error("[PUSH 발송 실패 - 환전 취소]");
            }

        }

        return gsonUtil.toJson(new JsonOutputVo(Status.수정));
    }

    public String updateExchangeMultiComplete(Mon_ExchangeInputVo monExchangeInputVo){

        monExchangeDao.updateExchangeMultiComplete(monExchangeInputVo);
        return gsonUtil.toJson(new JsonOutputVo(Status.수정));
    }

    public List<Object[]> getExcelData(Mon_ExchangeInputVo monExchangeInputVo, Model model){

        ArrayList<Mon_ExchangeOutputVo> exchangeList = monExchangeDao.selectExchangeList(monExchangeInputVo);

        int cashBasicTotal = 0;
        int benefitTotal = 0;
        int incomeTaxTotal = 0;
        int residentTaxTotal = 0;
        int transferFeeTotal = 0;
        int exchangeCashTotal = 0;

        List<Object[]> bodies = new ArrayList<>();
        for(int i = 0; i < exchangeList.size(); i++){
            var exchangeVo = exchangeList.get(i);

            HashMap hm = new LinkedHashMap();

            hm.put("no", i+1);
            hm.put("id", DalbitUtil.isEmpty(exchangeVo.getMem_userid()) ? "" : exchangeVo.getMem_userid());
            /*hm.put("name", DalbitUtil.isEmpty(exchangeVo.getMem_name()) ? "" : exchangeVo.getMem_name());
            hm.put("socialNo", DalbitUtil.isEmpty(exchangeVo.getSocial_no()) ? "" : DalbitUtil.convertJuminNo(AES.decrypt(exchangeVo.getSocial_no(), DalbitUtil.getProperty("social.secret.key"))));*/
            hm.put("name", DalbitUtil.isEmpty(exchangeVo.getPrevAccountName()) ? exchangeVo.getAccount_name() : exchangeVo.getPrevAccountName());
            hm.put("socialNo", DalbitUtil.isEmpty(exchangeVo.getPrevSocialNo()) ? DalbitUtil.convertJuminNo(AES.decrypt(exchangeVo.getSocial_no(), DalbitUtil.getProperty("social.secret.key"))) : DalbitUtil.convertJuminNo(AES.decrypt(exchangeVo.getPrevSocialNo(), DalbitUtil.getProperty("social.secret.key"))));
            hm.put("accountName", DalbitUtil.isEmpty(exchangeVo.getAccount_name()) ? "" : exchangeVo.getAccount_name());

            hm.put("cashBasic", exchangeVo.getCash_basic());
            cashBasicTotal += exchangeVo.getCash_basic();

            if(monExchangeInputVo.getIsSpecial() == 1){
                hm.put("benefit", exchangeVo.getBenefit());
                benefitTotal += exchangeVo.getBenefit();

                hm.put("cashSum", exchangeVo.getCash_basic() + exchangeVo.getBenefit());
            }

            hm.put("income_tax", exchangeVo.getIncome_tax());
            incomeTaxTotal += exchangeVo.getIncome_tax();

            hm.put("resident_tax", exchangeVo.getResident_tax());
            residentTaxTotal += exchangeVo.getResident_tax();

            hm.put("transfer_fee", exchangeVo.getTransfer_fee());
            transferFeeTotal += exchangeVo.getTransfer_fee();

            hm.put("exchangeCash", exchangeVo.getCash_real());
            exchangeCashTotal += exchangeVo.getCash_real();

            hm.put("phoneNo", DalbitUtil.isEmpty(exchangeVo.getPhone_no()) ? "" : DalbitUtil.convertPhoneNo(exchangeVo.getPhone_no()));

            hm.put("bankName", exchangeVo.getBank_name());
            hm.put("accountNo", DalbitUtil.isEmpty(exchangeVo.getAccount_no()) ? "" : exchangeVo.getAccount_no());

            String address = DalbitUtil.isEmpty(exchangeVo.getAddress_1()) ? "" : exchangeVo.getAddress_1();
            address += DalbitUtil.isEmpty(exchangeVo.getAddress_2()) ? "" : " "+ exchangeVo.getAddress_2();
            hm.put("address", address);
            hm.put("reg_date", exchangeVo.getReg_date());

            bodies.add(hm.values().toArray());
        }

        if(0 < exchangeList.size()){
            HashMap totalMap = new LinkedHashMap();
            totalMap.put("no", "");
            totalMap.put("id", "합계");
            totalMap.put("name", "");
            totalMap.put("socialNo", "");
            totalMap.put("accountName", "");
            totalMap.put("cashBasic", cashBasicTotal);

            if(monExchangeInputVo.getIsSpecial() == 1) {
                totalMap.put("benefit", benefitTotal);
                totalMap.put("cashSum", cashBasicTotal + benefitTotal);
            }

            totalMap.put("income_tax", incomeTaxTotal);
            totalMap.put("resident_tax", residentTaxTotal);
            totalMap.put("transfer_fee", transferFeeTotal);
            totalMap.put("exchangeCash", exchangeCashTotal);
            totalMap.put("phoneNo", "");
            totalMap.put("bankName", "");
            totalMap.put("accountNo", "");
            totalMap.put("address", "");
            totalMap.put("reg_date", "");

            bodies.add(totalMap.values().toArray());
        }

        return bodies;
    }

    public List<Object[]> getCompleteExcelData(Mon_ExchangeInputVo monExchangeInputVo, Model model){

        ArrayList<Mon_ExchangeOutputVo> exchangeList = monExchangeDao.selectCompleteExchangeList(monExchangeInputVo);

        int cashBasicTotal = 0;
        int benefitTotal = 0;
        int incomeTaxTotal = 0;
        int residentTaxTotal = 0;
        int transferFeeTotal = 0;
        int exchangeCashTotal = 0;

        List<Object[]> bodies = new ArrayList<>();
        for(int i = 0; i < exchangeList.size(); i++){
            var exchangeVo = exchangeList.get(i);

            HashMap hm = new LinkedHashMap();

            hm.put("no", i+1);
            hm.put("id", DalbitUtil.isEmpty(exchangeVo.getMem_userid()) ? "" : exchangeVo.getMem_userid());
//            hm.put("name", DalbitUtil.isEmpty(exchangeVo.getMem_name()) ? "" : exchangeVo.getMem_name());
            hm.put("name", DalbitUtil.isEmpty(exchangeVo.getPrevAccountName()) ? exchangeVo.getAccount_name() : exchangeVo.getPrevAccountName());
            hm.put("socialNo", DalbitUtil.isEmpty(exchangeVo.getSocial_no()) ? "" : DalbitUtil.convertJuminNo(AES.decrypt(exchangeVo.getSocial_no(), DalbitUtil.getProperty("social.secret.key"))));

            hm.put("accountName", DalbitUtil.isEmpty(exchangeVo.getAccount_name()) ? "" : exchangeVo.getAccount_name());

            hm.put("cashBasic", exchangeVo.getCash_basic());
            cashBasicTotal += exchangeVo.getCash_basic();

            hm.put("benefit", exchangeVo.getBenefit());
            benefitTotal += exchangeVo.getBenefit();

            hm.put("cashSum", exchangeVo.getCash_basic() + exchangeVo.getBenefit());

            hm.put("income_tax", exchangeVo.getIncome_tax());
            incomeTaxTotal += exchangeVo.getIncome_tax();

            hm.put("resident_tax", exchangeVo.getResident_tax());
            residentTaxTotal += exchangeVo.getResident_tax();

            hm.put("transfer_fee", exchangeVo.getTransfer_fee());
            transferFeeTotal += exchangeVo.getTransfer_fee();

            hm.put("exchangeCash", exchangeVo.getCash_real());
            exchangeCashTotal += exchangeVo.getCash_real();

            hm.put("phoneNo", DalbitUtil.isEmpty(exchangeVo.getPhone_no()) ? "" : DalbitUtil.convertPhoneNo(exchangeVo.getPhone_no()));

            hm.put("bankName", exchangeVo.getBank_name());
            hm.put("accountNo", DalbitUtil.isEmpty(exchangeVo.getAccount_no()) ? "" : exchangeVo.getAccount_no());

            String address = DalbitUtil.isEmpty(exchangeVo.getAddress_1()) ? "" : exchangeVo.getAddress_1();
            address += DalbitUtil.isEmpty(exchangeVo.getAddress_2()) ? "" : " "+ exchangeVo.getAddress_2();
            hm.put("address", address);
            hm.put("reg_date", exchangeVo.getReg_date());

            bodies.add(hm.values().toArray());
        }

        if(0 < exchangeList.size()){
            HashMap totalMap = new LinkedHashMap();
            totalMap.put("no", "");
            totalMap.put("id", "");
            totalMap.put("name", "");
            totalMap.put("socialNo", "");
            totalMap.put("accountName", "합계");
            totalMap.put("cashBasic", cashBasicTotal);

            totalMap.put("benefit", benefitTotal);
            totalMap.put("cashSum", cashBasicTotal + benefitTotal);

            totalMap.put("income_tax", incomeTaxTotal);
            totalMap.put("resident_tax", residentTaxTotal);
            totalMap.put("transfer_fee", transferFeeTotal);
            totalMap.put("exchangeCash", exchangeCashTotal);
            totalMap.put("phoneNo", "");
            totalMap.put("bankName", "");
            totalMap.put("accountNo", "");
            totalMap.put("address", "");
            totalMap.put("reg_date", "");


            bodies.add(totalMap.values().toArray());
        }

        return bodies;
    }

    public String selectEnableSummary(Mon_EnableSummaryVo monEnableSummaryVo){

        ArrayList<Mon_EnableSummaryVo> summaryList = monExchangeDao.selectEnableSummary(monEnableSummaryVo);

        Mon_EnableSummaryVo total = new Mon_EnableSummaryVo();
        summaryList.forEach(summary ->{
            summary.setGeneralAmt(0 < summary.getGeneral() ? DalbitUtil.computeExchangeAmt(summary.getGeneral(), 0): 0);
            summary.setSpecialAmt(0 < summary.getSpecial() ? DalbitUtil.computeExchangeAmt(summary.getSpecial(), 1): 0);
            summary.setTotalAmt(summary.getGeneralAmt() + summary.getSpecialAmt());

            total.setCount(total.getCount() + summary.getCount());
            total.setGeneral(total.getGeneral() + summary.getGeneral());
            total.setGeneralAmt(total.getGeneralAmt() + summary.getGeneralAmt());
            total.setSpecial(total.getSpecial() + summary.getSpecial());
            total.setSpecialAmt(total.getSpecialAmt() + summary.getSpecialAmt());
        });

        summaryList.add(total);

        return gsonUtil.toJson(new JsonOutputVo(Status.조회, summaryList));
    }


    public String callExchangeList(Mon_ExchangeInputVo monExchangeInputVo){

        var resultMap = new HashMap<>();
        ProcedureVo procedureVo = new ProcedureVo(monExchangeInputVo);
        ArrayList<Mon_ExchangeOutputVo> exchangeList = monExchangeDao.callExchangeList(procedureVo);
        Mon_ExchangeOutputVo totalInfo = new Gson().fromJson(procedureVo.getExt(), Mon_ExchangeOutputVo.class);

        resultMap.put("exchangeCnt", totalInfo.getTotalCnt());
        resultMap.put("exchangeList", exchangeList);
        return gsonUtil.toJson(new JsonOutputVo(Status.조회, resultMap));
    }
}
