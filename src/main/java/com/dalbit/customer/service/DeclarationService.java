package com.dalbit.customer.service;

import com.dalbit.common.code.Status;
import com.dalbit.common.vo.JsonOutputVo;
import com.dalbit.common.vo.PagingVo;
import com.dalbit.common.vo.ProcedureVo;
import com.dalbit.content.service.PushService;
import com.dalbit.content.vo.procedure.P_pushInsertVo;
import com.dalbit.customer.dao.DeclarationDao;
import com.dalbit.customer.vo.procedure.*;
import com.dalbit.excel.service.ExcelService;
import com.dalbit.excel.vo.ExcelVo;
import com.dalbit.member.dao.Mem_MemberDao;
import com.dalbit.member.vo.LoginBlockHistVo;
import com.dalbit.member.vo.LoginBlockVo;
import com.dalbit.member.vo.LoginHistoryVo;
import com.dalbit.member.vo.MemberVo;
import com.dalbit.util.DalbitUtil;
import com.dalbit.util.GsonUtil;
import com.dalbit.util.MessageUtil;
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
public class DeclarationService {

    @Autowired
    ExcelService excelService;

    @Autowired
    DeclarationDao declarationDao;

    @Autowired
    GsonUtil gsonUtil;

    @Autowired
    MessageUtil messageUtil;
    @Autowired
    Mem_MemberDao mem_MemberDao;
    @Autowired
    PushService pushService;

    /**
     * 신고 목록 조회
     */
    public String callServiceCenterReportList(P_DeclarationListInputVo pDeclarationListInputVo) {
        ProcedureVo procedureVo = new ProcedureVo(pDeclarationListInputVo);

        ArrayList<P_DeclarationListOutputVo> declareList = declarationDao.callServiceCenterReportList(procedureVo);

        String result;

        if(declareList.size() > 0) {

            for(int i=0;i<declareList.size();i ++ ){
                P_DeclarationListOutputVo outVo = declarationDao.getReportCount(declareList.get(i).getReported_mem_no());
                declareList.get(i).setTotalReportedCnt(outVo.getTotalReportedCnt());
                declareList.get(i).setTotalOpCnt(outVo.getTotalOpCnt());
            }

            for(int i=0;i<declareList.size();i++){
                MemberVo outVo = mem_MemberDao.getMemberInfo(declareList.get(i).getMem_no());
                if(!DalbitUtil.isEmpty(outVo)) {
                    declareList.get(i).setMem_sex(outVo.getMem_sex());
                    declareList.get(i).setMem_birth_year(outVo.getMem_birth_year());
                    declareList.get(i).setMem_birth_month(outVo.getMem_birth_month());
                    declareList.get(i).setMem_birth_day(outVo.getMem_birth_day());
                }
                MemberVo outVo2 = mem_MemberDao.getMemberInfo(declareList.get(i).getReported_mem_no());
                if(!DalbitUtil.isEmpty(outVo2)) {
                    declareList.get(i).setReported_mem_sex(outVo2.getMem_sex());
                    declareList.get(i).setReported_mem_birth_year(outVo2.getMem_birth_year());
                    declareList.get(i).setReported_mem_birth_month(outVo2.getMem_birth_month());
                    declareList.get(i).setReported_mem_birth_day(outVo2.getMem_birth_day());
                }
            }
            result = gsonUtil.toJson(new JsonOutputVo(Status.신고목록조회_성공, declareList, new PagingVo(procedureVo.getRet())));
        } else if(Status.신고목록조회_데이터없음.getMessageCode().equals(procedureVo.getRet())){
            result = gsonUtil.toJson(new JsonOutputVo(Status.신고목록조회_데이터없음));
        } else {
            result = gsonUtil.toJson(new JsonOutputVo(Status.신고목록조회_에러));
        }

        return result;
    }

    /**
     * 신고 목록 엑셀
     */
    public Model getListExcel(P_DeclarationListInputVo pDeclarationListInputVo, Model model){
        pDeclarationListInputVo.setPageCnt(100000);
        ProcedureVo procedureVo = new ProcedureVo(pDeclarationListInputVo);
        List<P_DeclarationListOutputVo> list = declarationDao.callServiceCenterReportList(procedureVo);

        String[] headers = {"No", "플랫폼", "신고구분", "신고자 UserID", "신고자 User닉네임", "신고 대상 UserID", "신고 대상 User닉네임", "접수 일시", "처리 일시", "처리 상태", "처리자"};
        int[] headerWidths = {3000, 6000, 3000, 6000, 6000, 6000, 6000, 3000, 3000, 3000, 3000};

        List<Object[]> bodies = new ArrayList<>();
        for(int i = 0; i < list.size(); i++){
            HashMap hm = new LinkedHashMap();

            hm.put("no", list.size()-i);
            hm.put("platform", DalbitUtil.isEmpty(list.get(i).getPlatform()) ? "" : list.get(i).getPlatform());
            hm.put("reason", DalbitUtil.isEmpty(list.get(i).getReason()) ? "" : list.get(i).getReason());
            hm.put("mem_id", DalbitUtil.isEmpty(list.get(i).getMem_userid()) ? "" : list.get(i).getMem_userid());
            hm.put("mem_nick", DalbitUtil.isEmpty(list.get(i).getMem_nick()) ? "" : list.get(i).getMem_nick());
            hm.put("reported_mem_id", DalbitUtil.isEmpty(list.get(i).getReported_userid()) ? "" : list.get(i).getReported_userid());
            hm.put("reported_mem_nick", DalbitUtil.isEmpty(list.get(i).getReported_nick()) ? "" : list.get(i).getReported_nick());
            hm.put("regDate", DalbitUtil.isEmpty(list.get(i).getRegDate()) ? "" : list.get(i).getRegDate());
            hm.put("opDate", DalbitUtil.isEmpty(list.get(i).getOpDate()) ? "" : list.get(i).getOpDate());
            hm.put("status", DalbitUtil.isEmpty(list.get(i).getStatus()) ? "" : list.get(i).getStatus());
            hm.put("opName", DalbitUtil.isEmpty(list.get(i).getOpName()) ? "" : list.get(i).getOpName());

            bodies.add(hm.values().toArray());
        }
        ExcelVo vo = new ExcelVo(headers, headerWidths, bodies);
        SXSSFWorkbook workbook = excelService.excelDownload("신고문의",vo);
        model.addAttribute("locale", Locale.KOREA);
        model.addAttribute("workbook", workbook);
        model.addAttribute("workbookName", "신고문의 목록");

        return model;
    }

    /**
     * 신고 목록 상세 조회
     */
    public String callServiceCenterReportDetail(P_DeclarationDetailInputVo pDeclarationDetailInputVo) {
        ProcedureVo procedureVo = new ProcedureVo(pDeclarationDetailInputVo);

        declarationDao.callServiceCenterReportDetail(procedureVo);

        P_DeclarationDetailOutputVo declarationDetail = new Gson().fromJson(procedureVo.getExt(), P_DeclarationDetailOutputVo.class);

        String result;

//        if(!DalbitUtil.isEmpty(declarationDetail)){
//            MemberVo memInfoOutVo = DalbitUtil.getMemInfo(declarationDetail.getMem_no());
//            if(!DalbitUtil.isEmpty(memInfoOutVo)) {
//                declarationDetail.setMem_birth_year(memInfoOutVo.getMem_birth_year());
//                declarationDetail.setMem_birth_month(memInfoOutVo.getMem_birth_month());
//                declarationDetail.setMem_birth_day(memInfoOutVo.getMem_birth_day());
//            }
//            MemberVo memInfoOutVo2 = DalbitUtil.getMemInfo(declarationDetail.getReported_mem_no());
//            if(!DalbitUtil.isEmpty(memInfoOutVo)) {
//                declarationDetail.setReported_mem_birth_year(memInfoOutVo2.getMem_birth_year());
//                declarationDetail.setReported_mem_birth_month(memInfoOutVo2.getMem_birth_month());
//                declarationDetail.setReported_mem_birth_day(memInfoOutVo2.getMem_birth_day());
//            }
//        }

        if(Status.신고상세조회_성공.getMessageCode().equals(procedureVo.getRet())) {
            result = gsonUtil.toJson(new JsonOutputVo(Status.신고상세조회_성공, declarationDetail));
        } else if(Status.신고상세조회_공지번호없음.getMessageCode().equals(procedureVo.getRet())){
            result = gsonUtil.toJson(new JsonOutputVo(Status.신고상세조회_공지번호없음));
        } else {
            result = gsonUtil.toJson(new JsonOutputVo(Status.신고상세조회_에러));
        }

        return result;
    }

    /**
     * 신고 처리
     */
    public String callServiceCenterReportOperate(P_DeclarationOperateVo pDeclarationOperateVo) {
        pDeclarationOperateVo.setOpName(MemberVo.getMyMemNo());

        ProcedureVo procedureVo = new ProcedureVo(pDeclarationOperateVo);

        declarationDao.callServiceCenterReportOperate(procedureVo);

        String result;

        if(Status.신고처리_성공.getMessageCode().equals(procedureVo.getRet())) {
            if(pDeclarationOperateVo.getOpCode() == 2) {    // 경고 푸시 발송
                P_DeclarationDetailInputVo pDeclarationDetailInputVo = new P_DeclarationDetailInputVo();
                pDeclarationDetailInputVo.setReportIdx(pDeclarationOperateVo.getReportIdx());
                ProcedureVo detail_procedureVo = new ProcedureVo(pDeclarationDetailInputVo);

                declarationDao.callServiceCenterReportDetail(detail_procedureVo);
                P_DeclarationDetailOutputVo declarationDetail = new Gson().fromJson(detail_procedureVo.getExt(), P_DeclarationDetailOutputVo.class);

                if (!DalbitUtil.isEmpty(declarationDetail)) {
                    try {    // PUSH 발송
                        P_pushInsertVo pPushInsertVo = new P_pushInsertVo();
                        pPushInsertVo.setMem_nos(declarationDetail.getReported_mem_no());
                        pPushInsertVo.setSlct_push("34");
                        pPushInsertVo.setPush_slct("54");   //운영자 메시지(사용자 경고)
                        pPushInsertVo.setSend_title("달빛 라이브 운영자 메시지");
                        pPushInsertVo.setSend_cont("운영정책 위반에 의한 경고 안내입니다.");
                        pPushInsertVo.setEtc_contents(pDeclarationOperateVo.getNotiContents().replaceAll("\n", "<br>"));
                        pPushInsertVo.setImage_type("101");

                        pushService.sendPushReqOK(pPushInsertVo);
                    } catch (Exception e) {
                        log.error("[PUSH 발송 실패 - 신고 처리 경고]");
                    }
                }
            }

            //차단관리 등록
            if((3 <= pDeclarationOperateVo.getOpCode() && pDeclarationOperateVo.getOpCode() <= 6) || pDeclarationOperateVo.getOpCode() == 8){

                //회원번호
                pDeclarationOperateVo.getReported_mem_no();

                LoginHistoryVo loginHistory = mem_MemberDao.memberLoginHistory(pDeclarationOperateVo.getReported_mem_no());

                var blockScopes = pDeclarationOperateVo.getBlockScope().split(",");
                String reported_mem_no = pDeclarationOperateVo.getReported_mem_no();

                int blockDay = 0;
                if(pDeclarationOperateVo.getOpCode() == 3){
                    blockDay = 1;
                }else if(pDeclarationOperateVo.getOpCode() == 4){
                    blockDay = 3;
                }else if(pDeclarationOperateVo.getOpCode() == 5){
                    blockDay = 7;
                }else if(pDeclarationOperateVo.getOpCode() == 6){
                    blockDay = 99;
                }else if(pDeclarationOperateVo.getOpCode() == 8){
                    blockDay = 98;
                }

                String blockScopeTexts = "";
                for(int i = 0; i < blockScopes.length; i++){
                    if(blockScopes[i].equals("true")){

                        int block_type = i+1;

                        String edit_contents = "";
                        if(block_type == 1){
                            blockScopeTexts = loginHistory.getDevice_uuid();
                            edit_contents = "deviceUuid 차단 등록 : " +  blockScopeTexts;
                        }else if(block_type == 2){
                            blockScopeTexts = loginHistory.getIp();
                            edit_contents = "ip 차단 등록 : " +  blockScopeTexts;
                        }else if(block_type == 3){
                            blockScopeTexts = pDeclarationOperateVo.getReported_mem_no();
                            edit_contents = "회원번호 차단 등록 : " +  blockScopeTexts;
                        }

                        if(!DalbitUtil.isEmpty(blockScopeTexts)){
                            mem_MemberDao.insertLoginBlock(new LoginBlockVo(block_type, blockScopeTexts, blockDay, pDeclarationOperateVo.getOpName(), pDeclarationOperateVo.getReportIdx()));
                            mem_MemberDao.insertLoginBlockHistory(new LoginBlockHistVo(edit_contents, 0, pDeclarationOperateVo.getOpName(), pDeclarationOperateVo.getReportIdx()));
                        }
                    }
                }
            }

            result = gsonUtil.toJson(new JsonOutputVo(Status.신고처리_성공));
        } else if(Status.신고처리_신고번호없음.getMessageCode().equals(procedureVo.getRet())) {
            result = gsonUtil.toJson(new JsonOutputVo(Status.신고처리_신고번호없음));
        } else if(Status.신고처리_이미처리되었음.getMessageCode().equals(procedureVo.getRet())) {
            result = gsonUtil.toJson(new JsonOutputVo(Status.신고처리_이미처리되었음));
        } else {
            result = gsonUtil.toJson(new JsonOutputVo(Status.신고처리_에러));
        }

        return result;
    }

    /**
     * 여러개 신고 확인완료 처리
     */
    public String callServiceCenterReportMultiOperate(P_DeclarationOperateVo pDeclarationOperateVo) {

        String[] reportIdxArr = pDeclarationOperateVo.getReportIdxs().split(",");
        String memNo = MemberVo.getMyMemNo();

        Arrays.asList(reportIdxArr).parallelStream().forEach(idx -> {
            var declaration = new P_DeclarationOperateVo();
            declaration.setReportIdx(Integer.valueOf(idx));
            declaration.setOpName(memNo);
            declaration.setOpCode(1);
            declaration.setNotiContents("");

            ProcedureVo procedureVo = new ProcedureVo(declaration);
            declarationDao.callServiceCenterReportOperate(procedureVo);

            log.error(new Gson().toJson(procedureVo));
        });

        String result = gsonUtil.toJson(new JsonOutputVo(Status.신고처리_성공));
        return result;
    }

    /**
     * 신고 처리 내역 건 수
     */
    public String callServiceCenterReportOpCount(ProcedureVo procedureVo) {

        declarationDao.callServiceCenterReportOpCount(procedureVo);

        P_DeclarationOpCountVo opCount = new Gson().fromJson(procedureVo.getExt(), P_DeclarationOpCountVo.class);

        String result;
        if(Status.신고처리내역수조회_성공.getMessageCode().equals(procedureVo.getRet())) {
            result = gsonUtil.toJson(new JsonOutputVo(Status.신고처리내역수조회_성공, opCount));
        } else {
            result = gsonUtil.toJson(new JsonOutputVo(Status.신고처리내역수조회_에러));
        }

        return result;
    }

    /**
     * 회원 신고 처리 내역 건 수
     */
    public String callServiceCenterReportOpCountTarget(P_DeclarationOperateCntInputVo pDeclarationOperateCntInputVo) {
        HashMap<P_DeclarationOpCountVo, String> OpList = declarationDao.callServiceCenterReportOpCountTarget(pDeclarationOperateCntInputVo);
        return gsonUtil.toJson(new JsonOutputVo(Status.신고처리내역수조회_성공, OpList));
    }

}
