package com.dalbit.content.service;

import com.dalbit.administrate.dao.Adm_TestIdDao;
import com.dalbit.administrate.vo.TestIdListVo;
import com.dalbit.common.code.Status;
import com.dalbit.common.vo.JsonOutputVo;
import com.dalbit.common.vo.PagingVo;
import com.dalbit.common.vo.ProcedureVo;
import com.dalbit.common.vo.SearchVo;
import com.dalbit.content.dao.PushDao;
import com.dalbit.content.vo.PushChoiceMemVo;
import com.dalbit.content.vo.procedure.*;
import com.dalbit.exception.GlobalException;
import com.dalbit.member.dao.Mem_MemberDao;
import com.dalbit.member.vo.MemberVo;
import com.dalbit.member.vo.procedure.P_MemberListOutputVo;
import com.dalbit.member.vo.procedure.P_MemberReportVo;
import com.dalbit.util.DalbitUtil;
import com.dalbit.util.GsonUtil;
import com.google.gson.Gson;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;

@Slf4j
@Service
public class PushService {

    @Autowired
    PushDao pushDao;

    @Autowired
    Mem_MemberDao memMemberDao;

    @Autowired
    Adm_TestIdDao admTestIdDao;

    @Autowired
    GsonUtil gsonUtil;

    @Value("${server.photo.url}")
    String SERVER_PHOTO_URL;
    @Value("${admin.memNo}")
    String ADMIN_MEM_NO;

    @Value("${push.logo.img.101}")
    String PUSH_LOGO_IMG_101;
    @Value("${push.logo.img.102}")
    String PUSH_LOGO_IMG_102;
    @Value("${push.logo.img.103}")
    String PUSH_LOGO_IMG_103;


    /** 푸시  리스트 */
    public String callContentsPushList(P_pushListInputVo pPushListInputVo) {
        ProcedureVo procedureVo = new ProcedureVo(pPushListInputVo);
        String result;

        try {
            int totalCnt = pushDao.callContentsPushListCnt(pPushListInputVo);
            ArrayList<P_pushListOutputVo> pushList = pushDao.callContentsPushList(pPushListInputVo);
            P_pushListOutputVo summary = new Gson().fromJson(procedureVo.getExt(), P_pushListOutputVo.class);

            if(pushList != null && pushList.size() > 0) {
                result = gsonUtil.toJson(new JsonOutputVo(Status.푸시조회_성공, pushList, new PagingVo(totalCnt), summary));
            }else {
                result = gsonUtil.toJson(new JsonOutputVo(Status.푸시조회_데이터없음));
            }

        }catch (Exception e){
            e.printStackTrace();
            result = gsonUtil.toJson(new JsonOutputVo(Status.푸시조회_에러));
        }

        return result;
    }

    /** 푸시  상세 */
    public String callContentsPushDetail(P_pushDetailInputVo pPushDetailInputVo) {
        ProcedureVo procedureVo = new ProcedureVo(pPushDetailInputVo);
        String result;

        try {
            P_pushDetailOutputVo pushDetail = pushDao.callContentsPushDetail(pPushDetailInputVo);

            // 수신대상이 지정회원일 경우 대상 정보 조회
            if(pushDetail.getIs_all() != null && pushDetail.getIs_all().equals("7")){
                if(!DalbitUtil.isEmpty(pushDetail.getMem_nos())) {
                    List arrayList = Arrays.asList(pushDetail.getMem_nos().split("\\|"));
                    List<P_MemberListOutputVo> memInfo = pushDao.selectMemInfo(arrayList);
                    pushDetail.setMem_info(memInfo);
                }
            }


            if (pushDetail != null) {
                result = gsonUtil.toJson(new JsonOutputVo(Status.푸시상세조회_성공, pushDetail));
            } else{
                result = gsonUtil.toJson(new JsonOutputVo(Status.푸시상세조회_상품코드없음));
            }

        }catch (Exception e){
            e.printStackTrace();
            result = gsonUtil.toJson(new JsonOutputVo(Status.푸시상세조회_에러));
        }

        return result;
    }

    /**
     * 푸시  등록
     */
    @Transactional(propagation=Propagation.REQUIRED, rollbackFor=GlobalException.class)
    public String callContentsPushAdd(P_pushInsertVo pPushInsertVo) throws GlobalException{
        pPushInsertVo.setOpName(MemberVo.getMyMemNo());
        ProcedureVo procedureVo = new ProcedureVo(pPushInsertVo, true);
        String result = null;

        try{
              if(DalbitUtil.isEmpty(pPushInsertVo.getSend_url())){
                if(!DalbitUtil.isEmpty(pPushInsertVo.getImage_type())){
                  /*  if(pPushInsertVo.getImage_type().equals("102")){
                        pPushInsertVo.setSend_url(SERVER_PHOTO_URL + PUSH_LOGO_IMG_102);
                    }else if(pPushInsertVo.getImage_type().equals("103")){
                        pPushInsertVo.setSend_url(SERVER_PHOTO_URL + PUSH_LOGO_IMG_103);
                    }else{
                        pPushInsertVo.setSend_url(SERVER_PHOTO_URL + PUSH_LOGO_IMG_101);
                    }*/

                    if(pPushInsertVo.getImage_type().equals("104")){
                        pPushInsertVo.setSend_url("");
                    }else{
                        pPushInsertVo.setSend_url(pPushInsertVo.getSend_url());
                    }
                }
            }

            if(pPushInsertVo.getImage_type().equals("106")){
                if(DalbitUtil.isEmpty(pPushInsertVo.getSend_url())){
                    MemberVo memInfoOutVo = DalbitUtil.getMemInfo("10000000000002");
                    if(!DalbitUtil.isEmpty(memInfoOutVo)) {
                        pPushInsertVo.setSend_url(memInfoOutVo.getImage_profile());
                    }
                }
            }

            if(DalbitUtil.isEmpty(pPushInsertVo.getPush_slct())){
                if(pPushInsertVo.getIs_all().equals("7")){
                    pPushInsertVo.setPush_slct("96");   //어드민 운영자 메시지(타겟)
                }else if(pPushInsertVo.getIs_all().equals("99")){
                    pPushInsertVo.setPush_slct("95");   //어드민 운영자 메시지(테스트계정)
                }else if(pPushInsertVo.getIs_all().equals("11")){
                    pPushInsertVo.setPush_slct("93");   //어드민 운영자 메시지(회원)
                }else if(pPushInsertVo.getIs_all().equals("21")){
                    pPushInsertVo.setPush_slct("92");   //어드민 운영자 메시지(회원 + 비회원)
                }else if(pPushInsertVo.getIs_all().equals("31")){
                    pPushInsertVo.setPush_slct("94");   //어드민 운영자 메시지(비회원)
                }
            }

            int insertResult = pushDao.callContentsPushAdd(pPushInsertVo);

            if(insertResult > 0){
                HashMap resultHash = null;
                // 지정 일 경우 푸시 발송
                 resultHash = callSendPush(pPushInsertVo);

                result = gsonUtil.toJson(new JsonOutputVo(Status.푸시등록_성공, resultHash));

            }else{
                result = gsonUtil.toJson(new JsonOutputVo(Status.푸시등록_에러));
            }
        }catch (Exception e){
            e.printStackTrace();
            throw new GlobalException(Status.푸시등록_에러);
        }

        return result;
    }

    /**
     * 푸시  수정
     */
    public String callContentsPushEdit(P_pushUpdateVo pPushUpdateVo) {
        pPushUpdateVo.setOpName(MemberVo.getMyMemNo());
        ProcedureVo procedureVo = new ProcedureVo(pPushUpdateVo, true);
        String result;

        try{
            int updateResult = pushDao.callContentsPushEdit(pPushUpdateVo);

            if(updateResult > 0){
                result = gsonUtil.toJson(new JsonOutputVo(Status.푸시수정_성공));
            }else{
                result = gsonUtil.toJson(new JsonOutputVo(Status.푸시수정_실패));
            }

        }catch (Exception e){
            e.printStackTrace();
            result = gsonUtil.toJson(new JsonOutputVo(Status.푸시수정_에러));
        }

        return result;
    }

    /**
     * 푸시  삭제
     */
    public String callContentsPushDelete(P_pushDeleteVo pPushDeleteVo) {
        pPushDeleteVo.setOpName(MemberVo.getMyMemNo());

        int sucCnt=0;
        int failCnt=0;

        String result="";

        String[] idxs = pPushDeleteVo.getPush_idx().split(",");
        for(int i=0; i < idxs.length; i++) {
            ProcedureVo procedureVo = new ProcedureVo(new P_pushDeleteVo(idxs[i]));

            pushDao.callContentsPushAndroid(new P_pushDeleteVo(idxs[i]));
            pushDao.callContentsPushWeb(new P_pushDeleteVo(idxs[i]));
            pushDao.callContentsPushWebLarge(new P_pushDeleteVo(idxs[i]));
            pushDao.callContentsPushSchedule(new P_pushDeleteVo(idxs[i]));

            int deleteResult = pushDao.callContentsPushDelete(new P_pushDeleteVo(idxs[i]));

            if (deleteResult > 0) {
                sucCnt++;
            } else {
                failCnt++;
            }
        }

        HashMap resultMap = new HashMap();
        resultMap.put("sucCnt", sucCnt);
        resultMap.put("failCnt", failCnt);

        if(0 < sucCnt){
            result = gsonUtil.toJson(new JsonOutputVo(Status.푸시삭제_성공, resultMap));
        }else{
            result = gsonUtil.toJson(new JsonOutputVo(Status.푸시삭제_실패, resultMap));
        }

        return result;
    }



    /**
     * 푸시 발송 모듈 적재
     */
    public HashMap callSendPush(P_pushInsertVo pPushInsertVo){
        String mem_nos = pPushInsertVo.getMem_nos();
        HashMap resultMap = new HashMap();
        int sucCnt=0;
        int notTokenCnt=0;
        int notMemNoCnt=0;
        int failCnt=0;
        int sucNotiCnt=0;
        int failNotiCnt=0;
        int rejectNotiCnt=0;

        // 내부 개발 테스트 표시 추가 2020.07.01
        if("local".equals(DalbitUtil.getActiveProfile())){
            String cont = "[내부개발] " + pPushInsertVo.getSend_cont();
            pPushInsertVo.setSend_cont(cont);
        }

        pPushInsertVo.setSend_url(pPushInsertVo.getSend_url().replace(SERVER_PHOTO_URL, ""));

        if(pPushInsertVo.getIs_all().equals("7")){        // 지정 일 경우 푸시 발송
            if(mem_nos != null && mem_nos.length() > 0){
                String[] arryMem_no = mem_nos.split("\\|");

                for(String target : arryMem_no){
                    P_pushStmpInsertVo pPushStmpInsertVo = new P_pushStmpInsertVo(target, pPushInsertVo);
                    pPushInsertVo.setPush_slct("96");   //어드민 운영자 메시지(타겟)
                    ProcedureVo procedureVo = new ProcedureVo(pPushStmpInsertVo);

                    // PUSH 발송
                    if(pPushInsertVo.getSend_type().equals("11") || pPushInsertVo.getSend_type().equals("10")){
                        pushDao.callStmpPushAdd(procedureVo);

                        if(Status.푸시발송_성공.getMessageCode().equals(procedureVo.getRet())){
                            log.debug("[PUSH_SEND] 푸시 발송 성공 ("  + target + ")");
                            sucCnt++;
                        }else if(Status.푸시발송_디바이스토큰미존재.getMessageCode().equals(procedureVo.getRet())){
                            log.error("[PUSH_SEND] ERROR 디바이스토큰 미존재 (" + target + ")");
                            notTokenCnt++;
                        }else if(Status.푸시발송_요청회원번호미존재.getMessageCode().equals(procedureVo.getRet())){
                            log.error("[PUSH_SEND] ERROR mem_no 미존재 (" + target + ")");
                            notMemNoCnt++;
                        } else {
                            log.error("[PUSH_SEND] ERROR [ targetMemNo:{} | 실패코드:{} | 실패내용:{} ]", target, procedureVo.getRet(), procedureVo.getExt());
                            failCnt++;
                        }
                    }

                    // 알림 발송
                    if(pPushInsertVo.getSend_type().equals("11") || pPushInsertVo.getSend_type().equals("01")){
                        try{
                            P_MemberReportVo pMemberReportVo = new P_MemberReportVo();

                            pMemberReportVo.setSlctOs(pPushStmpInsertVo.getSlctOs());
                            pMemberReportVo.setReported_mem_no(target);
                            pMemberReportVo.setType_noti(Integer.parseInt(pPushInsertVo.getSlct_push()));
                            pMemberReportVo.setTargetMemNo(pPushInsertVo.getTarget_mem_no());
                            pMemberReportVo.setTargetRoomNo(pPushInsertVo.getRoom_no());
                            pMemberReportVo.setTargetBoardIdx(pPushInsertVo.getBoard_idx());
                            pMemberReportVo.setTargetRedirectUrl(pPushInsertVo.getTarget_info());
                            pMemberReportVo.setNotiContents(pPushInsertVo.getSend_cont().replaceAll("\n", "<br>"));
                            pMemberReportVo.setNotimemo(pPushInsertVo.getSend_cont().replaceAll("\n", "<br>"));
                            pMemberReportVo.setPush_slct(pPushInsertVo.getPush_slct());
                            int notiResult;
//                            if(!DalbitUtil.isMemberPushRejection(pMemberReportVo.getMem_no(), pMemberReportVo.getPush_slct())){
                                notiResult = memMemberDao.callMemberNotification_Add(pMemberReportVo);
//                            }else {
//                                notiResult = -3;
//                            }

                            if(notiResult > 0){
                                sucNotiCnt++;
                            }else if(notiResult == -3){
                                rejectNotiCnt++;
                            }else{
                                failNotiCnt++;
                            }
                        }catch (Exception e){
                            e.printStackTrace();
                            log.error("[NOTI 발송 실패 - PUSH 발송]");
                        }
                    }
                }
            }
        }else if(pPushInsertVo.getIs_all().equals("99")){        // 테스트계정 발송
            SearchVo searchVo = new SearchVo();
             List<TestIdListVo> testIdList = admTestIdDao.getTestIdList(searchVo);

            for(TestIdListVo target : testIdList){
                P_pushStmpInsertVo pPushStmpInsertVo = new P_pushStmpInsertVo(target.getMem_no(), pPushInsertVo);
                pPushInsertVo.setPush_slct("95");   //어드민 운영자 메시지(테스트계정)
                ProcedureVo procedureVo = new ProcedureVo(pPushStmpInsertVo);

                // PUSH 발송
                if(pPushInsertVo.getSend_type().equals("11") || pPushInsertVo.getSend_type().equals("10")) {
                    pushDao.callStmpPushAdd(procedureVo);

                    if (Status.푸시발송_성공.getMessageCode().equals(procedureVo.getRet())) {
                        log.debug("[PUSH_SEND] 푸시 발송 성공  (" + target + ")");
                        sucCnt++;
                    } else if (Status.푸시발송_디바이스토큰미존재.getMessageCode().equals(procedureVo.getRet())) {
                        log.error("[PUSH_SEND] ERROR 디바이스토큰 미존재 (" + target + ") ");
                        notTokenCnt++;
                    } else if (Status.푸시발송_요청회원번호미존재.getMessageCode().equals(procedureVo.getRet())) {
                        log.error("[PUSH_SEND] ERROR mem_no 미존재 (" + target + ") ");
                        notMemNoCnt++;
                    } else {
                        log.error("[PUSH_SEND] ERROR [ targetMemNo:{} | 실패코드:{} | 실패내용:{} ]", target, procedureVo.getRet(), procedureVo.getExt());
                        failCnt++;
                    }
                }

                // 알림 발송
                if(pPushInsertVo.getSend_type().equals("11") || pPushInsertVo.getSend_type().equals("01")) {
                    try{
                        P_MemberReportVo pMemberReportVo = new P_MemberReportVo();

                        pMemberReportVo.setSlctOs(pPushStmpInsertVo.getSlctOs());
                        pMemberReportVo.setReported_mem_no(target.getMem_no());
                        pMemberReportVo.setType_noti(Integer.parseInt(pPushInsertVo.getSlct_push()));
                        pMemberReportVo.setTargetMemNo(pPushInsertVo.getTarget_mem_no());
                        pMemberReportVo.setTargetRoomNo(pPushInsertVo.getRoom_no());
                        pMemberReportVo.setTargetBoardIdx(pPushInsertVo.getBoard_idx());
                        pMemberReportVo.setTargetRedirectUrl(pPushInsertVo.getTarget_info());
                        pMemberReportVo.setNotiContents(pPushInsertVo.getSend_cont().replaceAll("\n", "<br>"));
                        pMemberReportVo.setNotimemo(pPushInsertVo.getSend_cont().replaceAll("\n", "<br>"));
                        pMemberReportVo.setPush_slct(pPushInsertVo.getPush_slct());
                        int notiResult;
//                        if(!DalbitUtil.isMemberPushRejection(pMemberReportVo.getMem_no(), pMemberReportVo.getPush_slct())){
                            notiResult = memMemberDao.callMemberNotification_Add(pMemberReportVo);
//                        }else {
//                            notiResult = -3;
//                        }

                        if(notiResult > 0){
                            sucNotiCnt++;
                        }else if(notiResult == -3){
                            rejectNotiCnt++;
                        }else{
                            failNotiCnt++;
                        }
                    }catch (Exception e){
                        log.error("[NOTI 발송 실패 - PUSH 발송]");
                    }
                }
            }

        }else if(pPushInsertVo.getIs_all().equals("11") || pPushInsertVo.getIs_all().equals("21") || pPushInsertVo.getIs_all().equals("31")){  // 회원 / 전체(회원+비회원) 발송 / 비회원
            P_pushStmpInsertVo pPushStmpInsertVo = new P_pushStmpInsertVo(ADMIN_MEM_NO, pPushInsertVo);
            if(pPushInsertVo.getIs_all().equals("11")){
                pPushInsertVo.setPush_slct("93");   // 어드민 운영자 메시지(회원)
            }else if(pPushInsertVo.getIs_all().equals("21")){
                pPushInsertVo.setPush_slct("92");   // 어드민 운영자 메시지(회원 + 비회원)
            }else if(pPushInsertVo.getIs_all().equals("31")){
                pPushInsertVo.setPush_slct("94");   // 어드민 운영자 메시지(비회원)
            }

            ProcedureVo procedureVo = new ProcedureVo(pPushStmpInsertVo);

            // PUSH 발송
            if(pPushInsertVo.getSend_type().equals("11") || pPushInsertVo.getSend_type().equals("10")) {
                pushDao.callStmpPushAdd(procedureVo);

                if (Status.푸시발송_성공.getMessageCode().equals(procedureVo.getRet())) {
                    log.debug("[PUSH_SEND] 푸시 발송 성공 (" + MemberVo.getUserInfo().getEmp_no() + ")");
                    sucCnt++;
                } else {
                    log.error("[PUSH_SEND] ERROR [ 실패코드:{} | 실패내용:{} ]", procedureVo.getRet(), procedureVo.getExt());
                    failCnt++;
                }
            }

            // 알림 발송
            //TODO 전체(회원+비회원) 발송 / 회원 / 비회원 설정 필요!!!!!!
            if(pPushInsertVo.getSend_type().equals("11") || pPushInsertVo.getSend_type().equals("01")) {
                try{
                    P_MemberReportVo pMemberReportVo = new P_MemberReportVo();

                    pMemberReportVo.setSlctOs(pPushStmpInsertVo.getSlctOs());
                    pMemberReportVo.setType_noti(Integer.parseInt(pPushInsertVo.getSlct_push()));
                    pMemberReportVo.setTargetMemNo(pPushInsertVo.getTarget_mem_no());
                    pMemberReportVo.setTargetRoomNo(pPushInsertVo.getRoom_no());
                    pMemberReportVo.setTargetBoardIdx(pPushInsertVo.getBoard_idx());
                    pMemberReportVo.setTargetRedirectUrl(pPushInsertVo.getTarget_info());
                    pMemberReportVo.setNotiContents(pPushInsertVo.getSend_cont().replaceAll("\n", "<br>"));
                    pMemberReportVo.setNotimemo(pPushInsertVo.getSend_cont().replaceAll("\n", "<br>"));
                    pMemberReportVo.setPush_slct(pPushInsertVo.getPush_slct());
                    int notiResult = memMemberDao.callMemberNotification_Add_ALL(pMemberReportVo);
                    sucNotiCnt = notiResult;

                }catch (Exception e){
                    log.error("[NOTI 발송 실패 - PUSH 발송]");
                }
            }

        }else{
            log.error("[PUSH_SEND] ERROR 발송 타입이 존재하지 않습니다. [ is_all:{}]", pPushInsertVo.getIs_all());
        }

        if(pPushInsertVo.getSend_type().equals("01")){
            sucCnt = sucNotiCnt;
            failCnt = failNotiCnt;
        }

        log.error("[PUSH_SEND] Result [ 성공:{} | 디바이스토큰 미존재:{} | mem_no 미존재:{} | 실패:{} ]", sucCnt, notTokenCnt, notMemNoCnt, failCnt);

        resultMap.put("is_all", pPushInsertVo.getIs_all());
        resultMap.put("sucCnt", sucCnt);
        resultMap.put("notTokenCnt", notTokenCnt);
        resultMap.put("notMemNoCnt", notMemNoCnt);
        resultMap.put("failCnt", failCnt);

        return resultMap;
    }

    public HashMap callSendAllPush(P_pushStmpInsertVo pPushStmpInsertVo){
        HashMap resultMap = new HashMap();

        ProcedureVo procedureVo = new ProcedureVo(pPushStmpInsertVo);

        pushDao.callStmpPushAdd(procedureVo);

        if(Status.푸시발송_성공.getMessageCode().equals(procedureVo.getRet())){
            log.debug("[ALL_PUSH_SEND] 전체 푸시 발송 성공");
        } else {
            log.debug("[ERROR] 전체 푸시 발송 실패 / 실패코드 : " + procedureVo.getRet() + " : "+ procedureVo.getExt());
        }
        return resultMap;
    }


    public String callStmpPushAdd(P_pushInsertVo pPushInsertVo) {
        ProcedureVo procedureVo = new ProcedureVo(pPushInsertVo);

        pushDao.callStmpPushAdd(procedureVo);

        String result;
        if(Status.푸시발송_성공.getMessageCode().equals(procedureVo.getRet())){
            result = gsonUtil.toJson(new JsonOutputVo(Status.푸시발송_성공));
        } else if(Status.푸시발송_요청회원번호미존재.getMessageCode().equals(procedureVo.getRet())){
            result = gsonUtil.toJson(new JsonOutputVo(Status.푸시발송_요청회원번호미존재));
        } else if(Status.푸시발송_디바이스토큰미존재.getMessageCode().equals(procedureVo.getRet())){
            result = gsonUtil.toJson(new JsonOutputVo(Status.푸시발송_디바이스토큰미존재));
        } else {
            result = gsonUtil.toJson(new JsonOutputVo(Status.푸시발송_에러));
        }

        return result;
    }





    public String sendPushReqOK(P_pushInsertVo pPushInsertVo) throws GlobalException{
//        pPushInsertVo.setMem_nos(mem_no);
//        pPushInsertVo.setSend_title("스페셜 DJ로 선정되었어요.");
//        pPushInsertVo.setSend_cont("축하해요~ 스페셜DJ로 선정되셨어요. DJ님의 FLEX한 방송을 보여주세요♥");
//        pPushInsertVo.setBoard_idx("22");
//        pPushInsertVo.setImage_type("101");
//        pPushInsertVo.setSlct_push("7");

        pPushInsertVo.setSend_cnt("1");
        pPushInsertVo.setIs_all("7");
        pPushInsertVo.setPlatform("111");
        pPushInsertVo.setStatus("0");
        pPushInsertVo.setMsg_type("0");
        pPushInsertVo.setIs_direct("0");
        if(DalbitUtil.isEmpty(pPushInsertVo.getSend_type())){       // default 10
            pPushInsertVo.setSend_type("10");
        }

        String pushResult = callContentsPushAdd(pPushInsertVo);
        log.info("[PUSH SEND RESULT] : {}" , pushResult);

        return pushResult;
    }

    /**
     * 푸시 팝업 화면에 수신 대상 지정하기
     */
    public String selectChoiceMember(PushChoiceMemVo pushChoiceMemVo) {
        String[] memNos = pushChoiceMemVo.getMemNoList().split(",");

        ArrayList<PushChoiceMemVo> list = new ArrayList();
        for(int i=0; i<memNos.length; i++) {
            PushChoiceMemVo choiceMem = pushDao.selectChoiceMember(memNos[i]);
            if(!DalbitUtil.isEmpty(choiceMem)) {
                list.add(choiceMem);
            }
        }
        return gsonUtil.toJson(new JsonOutputVo(Status.조회, list));
    }
}
