package com.dalbit.customer.service;

import com.dalbit.common.code.Status;
import com.dalbit.common.service.EmailService;
import com.dalbit.common.service.SmsService;
import com.dalbit.common.vo.*;
import com.dalbit.content.service.PushService;
import com.dalbit.content.vo.procedure.P_pushInsertVo;
import com.dalbit.customer.dao.Cus_QuestionDao;
import com.dalbit.customer.vo.FaqVo;
import com.dalbit.customer.vo.procedure.*;
import com.dalbit.excel.service.ExcelService;
import com.dalbit.excel.vo.ExcelVo;
import com.dalbit.exception.GlobalException;
import com.dalbit.member.dao.Mem_MemberDao;
import com.dalbit.member.vo.MemberVo;
import com.dalbit.member.vo.procedure.P_MemberReportVo;
import com.dalbit.util.DalbitUtil;
import com.dalbit.util.GsonUtil;
import com.google.gson.Gson;
import lombok.extern.slf4j.Slf4j;
import org.apache.poi.xssf.streaming.SXSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
import java.net.URL;
import java.net.URLConnection;
import java.text.SimpleDateFormat;
import java.util.*;

@Slf4j
@Service
public class Cus_QuestionService {

    @Autowired
    PushService pushService;
    @Autowired
    Mem_MemberDao memMemberDao;
    @Autowired
    Cus_QuestionDao cus_questionDao;
    @Autowired
    GsonUtil gsonUtil;
    @Autowired
    ExcelService excelService;
    @Autowired
    SmsService smsService;
    @Autowired
    EmailService emailService;

    @Value("${admin.memNo}")
    String ADMIN_MEM_NO;

    public String getQuestionList(P_QuestionListInputVo pQuestionListInputVo) {
        ProcedureVo procedureVo = new ProcedureVo(pQuestionListInputVo);

        ArrayList<P_QuestionListOutputVo> questionList = cus_questionDao.callQuestionList(procedureVo);
        P_QuestionListOutputVo summary = new Gson().fromJson(procedureVo.getExt(), P_QuestionListOutputVo.class);

        for(int i=0;i<questionList.size();i ++ ){
            P_QuestionListOutputVo outVo = cus_questionDao.getQuestionCount(questionList.get(i).getMem_no());
            questionList.get(i).setTotalQnaCnt(outVo.getTotalQnaCnt());
            questionList.get(i).setTotalOpCnt(outVo.getTotalOpCnt());

            P_QuestionListOutputVo outVo2 = cus_questionDao.getAdminCount(questionList.get(i).getQnaIdx());
            if(!DalbitUtil.isEmpty(outVo2)) {
                questionList.get(i).setAdminMemoCnt(outVo2.getAdminMemoCnt());
            }

//            MemberVo memInfoOutVo = DalbitUtil.getMemInfo(questionList.get(i).getMem_no());
//            if(!DalbitUtil.isEmpty(memInfoOutVo)) {
//                questionList.get(i).setMem_userid(memInfoOutVo.getMem_userid());
//                questionList.get(i).setMem_birth_year(memInfoOutVo.getMem_birth_year());
//                questionList.get(i).setMem_birth_month(memInfoOutVo.getMem_birth_month());
//                questionList.get(i).setMem_birth_day(memInfoOutVo.getMem_birth_day());
//            }
        }

        String result;

        if(Integer.parseInt(procedureVo.getRet()) > 0) {
            result = gsonUtil.toJson(new JsonOutputVo(Status.문의목록조회_성공, questionList, new PagingVo(procedureVo.getRet()),summary));
        } else {
            result = gsonUtil.toJson(new JsonOutputVo(Status.문의목록조회_실패));
        }

        return result;
    }

    /**
     *  1:1 문의하기 상세 조회
     */
    public String callServiceCenterQnaDetail(P_QuestionDetailInputVo pQuestionDetailInputVo) {
        ProcedureVo procedureVo = new ProcedureVo(pQuestionDetailInputVo);
        cus_questionDao.callServiceCenterQnaDetail(procedureVo);
        P_QuestionDetailOutputVo questionDetail = new Gson().fromJson(procedureVo.getExt(), P_QuestionDetailOutputVo.class);

        String result;

        if(Status.일대일문의상세조회_성공.getMessageCode().equals(procedureVo.getRet())) {
            result = gsonUtil.toJson(new JsonOutputVo(Status.일대일문의상세조회_성공, questionDetail));
        } else if(Status.일대일문의상세조회_문의번호없음.getMessageCode().equals(procedureVo.getRet())) {
            result = gsonUtil.toJson(new JsonOutputVo(Status.일대일문의상세조회_문의번호없음));
        } else {
            result = gsonUtil.toJson(new JsonOutputVo(Status.일대일문의상세조회_에러));
        }

        return result;
    }

    /**
     *  1:1 문의하기 처리하기
     */
    public String callServiceCenterQnaOperate(P_QuestionOperateVo pQuestionOperateVo) throws GlobalException, InterruptedException, UnsupportedEncodingException {
        P_QuestionDetailOutputVo outVo = cus_questionDao.callServiceCenterQnaState(pQuestionOperateVo);
        String result = "";
        String _answer = pQuestionOperateVo.getAnswer();
        pQuestionOperateVo.setOpName(MemberVo.getMyMemNo());

        pQuestionOperateVo.setAnswer(pQuestionOperateVo.getAnswer().replaceAll("\\'","\'"));
        pQuestionOperateVo.setAnswer(pQuestionOperateVo.getAnswer().replaceAll("\n","<br>"));
        if(outVo.getState() == 0 || outVo.getState() == 3 || (outVo.getState() == 2 && MemberVo.getMyMemNo().equals(outVo.getOp_name()))){

            ProcedureVo procedureVo = new ProcedureVo(pQuestionOperateVo,true);
            cus_questionDao.callServiceCenterQnaOperate(procedureVo);

            if(Status.일대일문의처리_성공.getMessageCode().equals(procedureVo.getRet())) {

                cus_questionDao.callServiceCenterQnaDetail(procedureVo);
                P_QuestionDetailOutputVo questionDetail = new Gson().fromJson(procedureVo.getExt(), P_QuestionDetailOutputVo.class);

                try{    // PUSH 발송
                    P_pushInsertVo pPushInsertVo = new P_pushInsertVo();

                    pPushInsertVo.setMem_nos(questionDetail.getMem_no());
                    pPushInsertVo.setSlct_push("37");
                    pPushInsertVo.setPush_slct("60");       //1:1 문의 답변
                    pPushInsertVo.setSend_title("1:1문의 답변이 등록되었어요!");
                    pPushInsertVo.setSend_cont("등록한 1:1문의에 답변이 등록되었습니다.");
                    pPushInsertVo.setImage_type("101");
                    pushService.sendPushReqOK(pPushInsertVo);
                }catch (Exception e){
                    log.error("[PUSH 발송 실패 - 일대일문의처리]");
                }

                try{
                    P_MemberReportVo pMemberReportVo = new P_MemberReportVo();

                    pMemberReportVo.setReported_mem_no(questionDetail.getMem_no());
                    pMemberReportVo.setType_noti(37);
                    pMemberReportVo.setTargetMemNo(ADMIN_MEM_NO);
                    pMemberReportVo.setNotiContents("등록한 1:1문의에 답변이 등록되었습니다.");
                    pMemberReportVo.setNotimemo("등록한 1:1문의에 답변이 등록되었습니다.");
                    memMemberDao.callMemberNotification_Add(pMemberReportVo);
                }catch (Exception e){
                    log.error("[NOTI 발송 실패 - 일대일문의처리]");
                }

                result = gsonUtil.toJson(new JsonOutputVo(Status.일대일문의처리_성공));
            } else if(Status.일대일문의처리_문의번호없음.getMessageCode().equals((procedureVo.getRet()))) {
                result = gsonUtil.toJson(new JsonOutputVo(Status.일대일문의처리_문의번호없음));
            } else if(Status.일대일문의처리_이미처리됐음.getMessageCode().equals(procedureVo.getRet())) {
                result = gsonUtil.toJson(new JsonOutputVo(Status.일대일문의처리_이미처리됐음));
            } else {
                result = gsonUtil.toJson(new JsonOutputVo(Status.일대일문의처리_에러));
            }
        }else{
            if(outVo.getState() == 1){
                int updateResult = cus_questionDao.callServiceCenterQnaUpdate(pQuestionOperateVo);
                if(updateResult == 1) {
                    result = gsonUtil.toJson(new JsonOutputVo(Status.일대일문의수정_성공));
                } else {
                    result = gsonUtil.toJson(new JsonOutputVo(Status.일대일문의처리_에러));
                }
             }else if(outVo.getState() == 2){
                result = gsonUtil.toJson(new JsonOutputVo(Status.일대일문의처리_이미_진행중));
            }
        }

        if(pQuestionOperateVo.getNoticeType() == 2){      // 메일답변
            String sHtml = "";
            StringBuffer mailContent = new StringBuffer();
            BufferedReader in = null;
            try{
                URL url = new URL("http://image.dalbitlive.com/resource/mailForm/mailing.txt");
                URLConnection urlconn = url.openConnection();
                in = new BufferedReader(new InputStreamReader(urlconn.getInputStream(),"utf-8"));

                while((sHtml = in.readLine()) != null){
                    mailContent.append("\n");
                    mailContent.append(sHtml);
                }

                String msgCont;
                SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy.MM.dd");
                String today = dateFormat.format(new Date());

                msgCont = mailContent.toString().replaceAll("@@qnaTime@@", today);
                msgCont = msgCont.replaceAll("@@qnaType@@", pQuestionOperateVo.getQnaType());
                msgCont = msgCont.replaceAll("@@qnaTitle@@", pQuestionOperateVo.getQnaTitle());
                msgCont = msgCont.replaceAll("@@qnaContent@@", pQuestionOperateVo.getQnaContent());
                if(!DalbitUtil.isEmpty(pQuestionOperateVo.getFileName())){
                    msgCont = msgCont.replaceAll("@@fileName@@", pQuestionOperateVo.getFileName());
                }else{
                    msgCont = msgCont.replaceAll("@@fileName@@", "");
                }
                msgCont = msgCont.replaceAll("@@answer@@", _answer);

                EmailInputVo emailInputVo = new EmailInputVo();
                emailInputVo.setTitle("[달빛라이브] 1:1문의에 대한 답변을 보내드립니다.");
                emailInputVo.setMsgCont(msgCont);
                emailInputVo.setRcvMail(pQuestionOperateVo.getEmail());
                emailService.sendEmail(emailInputVo);
            }
            catch(Exception e){
                System.out.println("연결 에러");
            }

        }else{          // 문자 or ( 문자 and 메일 )
            String answer = _answer;
            String[] array_word = answer.split(""); //배열에 한글자씩 저장하기

            answer = "";
            int count = 1000;
            boolean smsSw;
            for(int i=0;i<array_word.length;i++) {
                answer = answer + array_word[i];
                smsSw = false;
                if(i != 0) {
                    if (i % count == 0) {
                        smsSw = true;
                    } else {
                        if (array_word.length <= count) {
                            if ((i + 1) == array_word.length) {
                                smsSw = true;
                            }
                        }
                    }
                }

                if(smsSw){
                    Thread.sleep(1500);
                    SmsVo smsSendVo = new SmsVo(pQuestionOperateVo.getTitle(), answer, pQuestionOperateVo.getPhone(), "5");
                    smsSendVo.setSend_name(MemberVo.getMyMemNo());
                    smsSendVo.setMem_no(pQuestionOperateVo.getMem_no());
                    smsSendVo.setCinfo("");
                    int smsResult = smsService.sendMms(smsSendVo);
                    if(smsResult != 1){
                        //result = gsonUtil.toJson(new JsonOutputVo(Status.문자발송_실패));
                        break;
                    }
                    answer = "";
                    count+=1000;
                }
            }
        }

        return result;
    }

    /**
     *  1:1 문의하기 수정하기
     */
    public String callServiceCenterQnaUpdate(P_QuestionOperateVo pQuestionOperateVo){
        pQuestionOperateVo.setOpName(MemberVo.getMyMemNo());
        int updateResult = cus_questionDao.callServiceCenterQnaUpdate(pQuestionOperateVo);

        String result;
        if(updateResult == 1) {
            result = gsonUtil.toJson(new JsonOutputVo(Status.일대일문의수정_성공));
        } else {
            result = gsonUtil.toJson(new JsonOutputVo(Status.일대일문의처리_에러));
        }

        return result;
    }

    public List<FaqVo> getFaqGroupList(){
        return cus_questionDao.getFaqGroupList();
    }

    public List<FaqVo> getFaqSubList(FaqVo faqVo){
        return cus_questionDao.getFaqSubList(faqVo);
    }

    /**
     * 회원 1:1문의 내역 건 수
     */
    public String getQuestionCountTarget(P_QuestionListInputVo pQuestionListInputVo) {
        HashMap<P_QuestionListOutputVo, String> questionList = cus_questionDao.callQuestionCountTarget(pQuestionListInputVo);
        return gsonUtil.toJson(new JsonOutputVo(Status.문의목록조회_성공, questionList));
    }


    /**
     * 회원 1:1문의 내역 건 삭제
     */
    public String getQuestionDelete(P_QuestionDeleteVo pQuestionDeleteVo){
        cus_questionDao.callQuestionDelete(pQuestionDeleteVo);

        String result;
        result = gsonUtil.toJson(new JsonOutputVo(Status.삭제));
        return result;
    }

    /**
     * 문의 엑셀
     */
    public Model getListExcel(P_QuestionListInputVo pQuestionListInputVo, Model model) {
        pQuestionListInputVo.setPageCnt(100000);
        ProcedureVo procedureVo = new ProcedureVo(pQuestionListInputVo);

        List<P_QuestionListOutputVo> list = cus_questionDao.callQuestionList(procedureVo);

        String[] headers = {"No", "문의유형", "플랫폼", "Browser", "문의자UserId", "문의자닉네임", "문의제목","문의내용", "접수일시","처리일시", "처리상태", "처리자"};
        int[] headerWidths = {3000, 3000, 3000, 3000, 3000, 3000, 3000, 3000, 3000, 3000, 3000, 3000};

        List<Object[]> bodies = new ArrayList<>();
        for(int i = 0; i < list.size(); i++){
            HashMap hm = new LinkedHashMap();


            String slctType = null;
            if(list.get(i).getSlct_type() == 1) slctType = "회원정보";
            else if(list.get(i).getSlct_type() == 2) slctType = "회원정보";
            else if(list.get(i).getSlct_type() == 3) slctType = "청취하기";
            else if(list.get(i).getSlct_type() == 4) slctType = "결제";
            else if(list.get(i).getSlct_type() == 5) slctType = "건의하기";
            else if(list.get(i).getSlct_type() == 6) slctType = "장애/버그";
            else if(list.get(i).getSlct_type() == 7) slctType = "선물/아이템";
            else if(list.get(i).getSlct_type() == 99) slctType = "기타";

            hm.put("no", list.size() - i);
            hm.put("mem1", DalbitUtil.isEmpty(slctType) ? "" : slctType);
            hm.put("mem2", DalbitUtil.isEmpty(list.get(i).getPlatform()) ? "" : list.get(i).getPlatform());
            hm.put("mem3", DalbitUtil.isEmpty(list.get(i).getBrowser()) ? "" : list.get(i).getBrowser());
            hm.put("mem4", DalbitUtil.isEmpty(list.get(i).getMem_userid()) ? "" : list.get(i).getMem_userid());
            hm.put("mem5", DalbitUtil.isEmpty(list.get(i).getMem_nick()) ? "" : list.get(i).getMem_nick());
            hm.put("mem6", DalbitUtil.isEmpty(list.get(i).getQuestion_title()) ? "" : list.get(i).getQuestion_title());
            hm.put("mem7", DalbitUtil.isEmpty(list.get(i).getQuestion_contents()) ? "" : list.get(i).getQuestion_contents());
            hm.put("mem8", DalbitUtil.isEmpty(list.get(i).getWriteDateFormat()) ? "" :list.get(i).getWriteDateFormat());
            hm.put("mem9", DalbitUtil.isEmpty(list.get(i).getOpDateFormat()) ? "" :list.get(i).getOpDateFormat());
            if(list.get(i).getState() == 0){
                hm.put("mem10", "미처리");
            }else if(list.get(i).getState() == 1){
                hm.put("mem10", "처리완료");
            }else if(list.get(i).getState() == 2){
                hm.put("mem10", "처리중");
            }
            hm.put("mem11", DalbitUtil.isEmpty(list.get(i).getOp_name()) ? "" : list.get(i).getOp_name());

            bodies.add(hm.values().toArray());
        }
        ExcelVo vo = new ExcelVo(headers, headerWidths, bodies);
        SXSSFWorkbook workbook = excelService.excelDownload("목록",vo);
        model.addAttribute("locale", Locale.KOREA);
        model.addAttribute("workbook", workbook);
        model.addAttribute("workbookName", "회원 목록");

        return model;
    }


    /**
     *  1:1 문의하기 처리중 상태 변경
     */
    public String callServiceCenterQnaCatch(P_QuestionOperateVo pQuestionOperateVo){
        pQuestionOperateVo.setOpName(MemberVo.getMyMemNo());
        int check;
        if(DalbitUtil.exceptionUser().indexOf(MemberVo.getMyMemNo()) > -1){
            check = 2;
        }else {
//            cus_questionDao.callServiceCenterQnaChatchRelease_all(pQuestionOperateVo);

            check = cus_questionDao.callServiceCenterQnaStateCheck(pQuestionOperateVo);
        }
        String result;
        if(check == 1){
            result = gsonUtil.toJson(new JsonOutputVo(Status.일대일문의처리중_상태변경_실패));
        }else if (check == 2){
            result = gsonUtil.toJson(new JsonOutputVo(Status.일대일문의처리중_상태변경_안함));
        }else{
            cus_questionDao.callServiceCenterQnaCatch(pQuestionOperateVo);
            result = gsonUtil.toJson(new JsonOutputVo(Status.일대일문의처리중_상태변경_성공, pQuestionOperateVo));
        }

        return result;
    }

    /**
     *  1:1 문의하기 처리중 상태 해제
     */
    public String callServiceCenterQnaChatchRelease(P_QuestionOperateVo pQuestionOperateVo){
        pQuestionOperateVo.setOpName(MemberVo.getMyMemNo());

        int check = cus_questionDao.callServiceCenterQnaStateCheck(pQuestionOperateVo);

        String result;
        if(check > 0){
            cus_questionDao.callServiceCenterQnaChatchRelease(pQuestionOperateVo);
            result = gsonUtil.toJson(new JsonOutputVo(Status.일대일문의처리중_상태해제_성공));
        }else{
            result = gsonUtil.toJson(new JsonOutputVo(Status.일대일문의처리중_상태해제_실패));
        }

        return result;
    }

    public String callAdminMemoQuestionAdd(P_QuestionOperateVo pQuestionOperateVo){
        pQuestionOperateVo.setOpName(MemberVo.getMyMemNo());
        int resultInt = cus_questionDao.callAdminMemoQuestionAdd(pQuestionOperateVo);
        String result;
        if(resultInt > 0) {
            result = gsonUtil.toJson(new JsonOutputVo(Status.처리완료));
        }else{
            result = gsonUtil.toJson(new JsonOutputVo(Status.파라미터오류));
        }
        return result;
    }

    public String callAdminMemoList(P_QuestionOperateVo pQuestionOperateVo) {

        pQuestionOperateVo.setPageNo(pQuestionOperateVo.getPageNo() -1);
        pQuestionOperateVo.setPageNo(pQuestionOperateVo.getPageNo() * pQuestionOperateVo.getPageCnt());
        ArrayList<P_QuestionAdminMemoListOutputVo> questionList = cus_questionDao.callQuestionAdminList(pQuestionOperateVo);
        int totalCnt = cus_questionDao.callQuestionAdminList_totalCnt(pQuestionOperateVo);

        String result;

        if(questionList.size() > 0) {
            result = gsonUtil.toJson(new JsonOutputVo(Status.문의목록조회_성공, questionList, new PagingVo(totalCnt)));
        } else {
            result = gsonUtil.toJson(new JsonOutputVo(Status.문의목록조회_실패));
        }

        return result;
    }

    public String callQustionFileDel(P_QuestionOperateVo pQuestionOperateVo) {
        int success = cus_questionDao.callQuestionFileDel(pQuestionOperateVo);
        String result;
        if(success > 0) {
            result = gsonUtil.toJson(new JsonOutputVo(Status.문의첨부문서삭제_성공));
        } else {
            result = gsonUtil.toJson(new JsonOutputVo(Status.문의첨부문서삭제_실패));
        }

        return result;
    }



    public String callMacroList(P_MacroVo pMacroVo) {
        ProcedureVo procedureVo = new ProcedureVo(pMacroVo);
        ArrayList<P_MacroVo> list = cus_questionDao.callMacroList(procedureVo);
        P_MacroVo ext = new Gson().fromJson(procedureVo.getExt(), P_MacroVo.class);

        String result;

        if(Integer.parseInt(procedureVo.getRet()) > 0) {
            result = gsonUtil.toJson(new JsonOutputVo(Status.조회, list, new PagingVo(procedureVo.getRet()),ext));
        } else {
            result = gsonUtil.toJson(new JsonOutputVo(Status.데이터없음));
        }

        return result;
    }

    public String callMacroDetail(P_MacroVo pMacroVo) {
        ProcedureVo procedureVo = new ProcedureVo(pMacroVo);
        cus_questionDao.callMacroDetail(procedureVo);
        P_MacroVo ext = new Gson().fromJson(procedureVo.getExt(), P_MacroVo.class);

        String result;

        if(Integer.parseInt(procedureVo.getRet()) == 0) {
            result = gsonUtil.toJson(new JsonOutputVo(Status.조회, ext));
        } else {
            result = gsonUtil.toJson(new JsonOutputVo(Status.데이터없음));
        }

        return result;
    }

    public String callMacroEdit(P_MacroVo pMacroVo) {
        pMacroVo.setOpName(MemberVo.getMyMemNo());
        ProcedureVo procedureVo = new ProcedureVo(pMacroVo);
        cus_questionDao.callMacroEdit(procedureVo);
        P_MacroVo ext = new Gson().fromJson(procedureVo.getExt(), P_MacroVo.class);

        String result;

        if(Integer.parseInt(procedureVo.getRet()) == 0) {
            result = gsonUtil.toJson(new JsonOutputVo(Status.처리완료, ext));
        } else {
            result = gsonUtil.toJson(new JsonOutputVo(Status.비즈니스로직오류));
        }

        return result;
    }

    public String callMacroDel(P_MacroVo pMacroVo) {

        String[] idxs = pMacroVo.getIdxs().split("@");
        for(int i=0; i < idxs.length; i++) {
            pMacroVo.setIdx(Integer.parseInt(idxs[i]));
            cus_questionDao.callMacroDel(pMacroVo);
        }

        return gsonUtil.toJson(new JsonOutputVo(Status.처리완료));
    }
}
