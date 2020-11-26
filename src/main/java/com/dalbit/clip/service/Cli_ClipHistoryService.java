package com.dalbit.clip.service;

import com.dalbit.clip.dao.Cli_ClipHistoryDao;
import com.dalbit.clip.vo.*;
import com.dalbit.clip.vo.procedure.*;
import com.dalbit.common.code.Status;
import com.dalbit.common.vo.JsonOutputVo;
import com.dalbit.common.vo.PagingVo;
import com.dalbit.common.vo.ProcedureVo;
import com.dalbit.content.service.PushService;
import com.dalbit.content.vo.procedure.P_pushInsertVo;
import com.dalbit.member.dao.Mem_MemberDao;
import com.dalbit.member.vo.MemberVo;
import com.dalbit.member.vo.procedure.P_MemberAdminMemoAddVo;
import com.dalbit.util.DalbitUtil;
import com.dalbit.util.GsonUtil;
import com.google.gson.Gson;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.parameters.P;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.HashMap;

@Slf4j
@Service
public class Cli_ClipHistoryService {

    @Autowired
    GsonUtil gsonUtil;

    @Autowired
    Cli_ClipHistoryDao cliClipHistoryDao;
    @Autowired
    Mem_MemberDao mem_MemberDao;
    @Autowired
    PushService pushService;


    /**
     * 클립 리스트 조회
     */
    public String callClipHistoryList(ClipHistoryVo clipHistoryVo) {
        ProcedureVo procedureVo = new ProcedureVo(clipHistoryVo);
        ArrayList<ClipHistoryVo> list = cliClipHistoryDao.callClipHistoryList(procedureVo);
        ClipHistoryTotalVo summary = new Gson().fromJson(procedureVo.getExt(), ClipHistoryTotalVo.class);

        if(list.size() > 0){
            return gsonUtil.toJson(new JsonOutputVo(Status.조회, list, new PagingVo(procedureVo.getRet()), summary));
        }else if(list.size() == 0){
            return gsonUtil.toJson(new JsonOutputVo(Status.데이터없음, list, new PagingVo(procedureVo.getRet()), summary));
        }else {
            return gsonUtil.toJson(new JsonOutputVo(Status.비즈니스로직오류));
        }
    }

    /**
     * 클립 리스트 조회
     */
    public String callClipRegHistoryList(ClipHistoryVo clipHistoryVo) {
        ProcedureVo procedureVo = new ProcedureVo(clipHistoryVo);
        ArrayList<ClipHistoryVo> list = cliClipHistoryDao.callClipRegHistoryList(procedureVo);
        ClipHistoryTotalVo summary = new Gson().fromJson(procedureVo.getExt(), ClipHistoryTotalVo.class);

        if(list.size() > 0){
            return gsonUtil.toJson(new JsonOutputVo(Status.조회, list, new PagingVo(procedureVo.getRet()), summary));
        }else if(list.size() == 0){
            return gsonUtil.toJson(new JsonOutputVo(Status.데이터없음, list, new PagingVo(procedureVo.getRet()), summary));
        }else {
            return gsonUtil.toJson(new JsonOutputVo(Status.비즈니스로직오류));
        }
    }


    /**
     * 클립 회원 리스트 조회
     */
    public String callClipHistoryMemberList(ClipHistoryMemberVo clipHistoryMemberVo) {
        ProcedureVo procedureVo = new ProcedureVo(clipHistoryMemberVo);
        ArrayList<ClipHistoryMemberVo> list = cliClipHistoryDao.callClipHistoryMemberList(procedureVo);
        ClipHistoryTotalVo summary = new Gson().fromJson(procedureVo.getExt(), ClipHistoryTotalVo.class);

        if(list.size() > 0){
            return gsonUtil.toJson(new JsonOutputVo(Status.조회, list, new PagingVo(procedureVo.getRet()), summary));
        }else if(list.size() == 0){
            return gsonUtil.toJson(new JsonOutputVo(Status.데이터없음, list, new PagingVo(procedureVo.getRet()), summary));
        }else {
            return gsonUtil.toJson(new JsonOutputVo(Status.비즈니스로직오류));
        }
    }

    /**
     * 클립 숨기기/해제
     */
    @Transactional
    public String updateHide(ClipHistoryVo clipHistoryVo) {
        int result = cliClipHistoryDao.updateHide(clipHistoryVo);

        if(result > 0) {
            ClipEditHistoryVo clipEditHistoryVo = new ClipEditHistoryVo();
            clipEditHistoryVo.setCastNo(clipHistoryVo.getCastNo());
            clipEditHistoryVo.setOp_name(MemberVo.getMyMemNo());

            if(clipHistoryVo.getHide().equals("0")){ // 해제
                clipEditHistoryVo.setEdit_contents("Clip 숨기기 해제 : " + clipHistoryVo.getCastNo());
                clipEditHistoryVo.setEdit_type("0");
            }else if(clipHistoryVo.getHide().equals("1")){  //숨기기
                clipEditHistoryVo.setEdit_contents("Clip 숨기기 : " + clipHistoryVo.getCastNo());
                clipEditHistoryVo.setEdit_type("1");
            }

            cliClipHistoryDao.insertClipEditHistory(clipEditHistoryVo);

            return gsonUtil.toJson(new JsonOutputVo(Status.클립숨기기수정_성공));
        }else{
            return gsonUtil.toJson(new JsonOutputVo(Status.클립숨기기수정_에러));
        }
    }

    /**
     * 클립 삭제
     */
    @Transactional
    public String deleteClip(ClipHistoryVo clipHistoryVo) {
        int result = cliClipHistoryDao.deleteClip(clipHistoryVo);

        if(result > 0) {
            ClipEditHistoryVo clipEditHistoryVo = new ClipEditHistoryVo();
            clipEditHistoryVo.setCastNo(clipHistoryVo.getCastNo());
            clipEditHistoryVo.setOp_name(MemberVo.getMyMemNo());
            clipEditHistoryVo.setEdit_contents("Clip 삭제(어드민) : " + clipHistoryVo.getCastNo());
            clipEditHistoryVo.setEdit_type("4");

            cliClipHistoryDao.insertClipEditHistory(clipEditHistoryVo);

            return gsonUtil.toJson(new JsonOutputVo(Status.클립삭제_성공));
        }else{
            return gsonUtil.toJson(new JsonOutputVo(Status.클립삭제_에러));
        }

    }

    /**
     * 클립 청취자 리스트 조회
     */
    public String callClipHistoryListenList(ClipHistoryListenVo clipHistoryListenVo) {
        ProcedureVo procedureVo = new ProcedureVo(clipHistoryListenVo);
        ArrayList<ClipHistoryListenVo> list = cliClipHistoryDao.callClipHistoryListenList(procedureVo);
        ClipHistoryTotalVo summary = new Gson().fromJson(procedureVo.getExt(), ClipHistoryListenTotalVo.class);

        if(list.size() > 0){
            return gsonUtil.toJson(new JsonOutputVo(Status.조회, list, new PagingVo(procedureVo.getRet()), summary));
        }else if(list.size() == 0){
            return gsonUtil.toJson(new JsonOutputVo(Status.데이터없음, list, new PagingVo(procedureVo.getRet()), summary));
        }else {
            return gsonUtil.toJson(new JsonOutputVo(Status.비즈니스로직오류));
        }
    }

    /**
     * 클립 좋아요 리스트 조회
     */
    public String callClipHistoryGoodList(ClipHistoryListenVo clipHistoryListenVo) {
        int count = cliClipHistoryDao.callClipHistoryGoodListCnt(clipHistoryListenVo);
        clipHistoryListenVo.setTotalCnt(count);
        ArrayList<ClipHistoryListenVo> list = cliClipHistoryDao.callClipHistoryGoodList(clipHistoryListenVo);
        ClipHistoryTotalVo total = cliClipHistoryDao.callClipHistoryGoodTotal(clipHistoryListenVo);

        if(list.size() > 0){
            return gsonUtil.toJson(new JsonOutputVo(Status.조회, list, new PagingVo(clipHistoryListenVo.getTotalCnt()), total));
        }else if(list.size() == 0){
            return gsonUtil.toJson(new JsonOutputVo(Status.데이터없음, list, new PagingVo(clipHistoryListenVo.getTotalCnt()), total));
        }else {
            return gsonUtil.toJson(new JsonOutputVo(Status.비즈니스로직오류));
        }
    }

    /**
     * 클립 선물 리스트 조회
     */
    public String callClipHistoryGiftList(ClipHistoryGiftVo clipHistoryGiftVo) {
        ProcedureVo procedureVo = new ProcedureVo(clipHistoryGiftVo);
        ArrayList<ClipHistoryGiftVo> list = cliClipHistoryDao.callClipHistoryGiftList(procedureVo);
        ClipHistoryGiftTotalVo summary = new Gson().fromJson(procedureVo.getExt(), ClipHistoryGiftTotalVo.class);

        if(list.size() > 0){
            return gsonUtil.toJson(new JsonOutputVo(Status.조회, list, new PagingVo(procedureVo.getRet()), summary));
        }else if(list.size() == 0){
            return gsonUtil.toJson(new JsonOutputVo(Status.데이터없음, list, new PagingVo(procedureVo.getRet()), summary));
        }else {
            return gsonUtil.toJson(new JsonOutputVo(Status.비즈니스로직오류));
        }
    }


    /**
     * 클립 삭제 리스트 조회
     */
    public String callClipHistoryRemoveList(ClipHistoryRemoveVo clipHistoryRemoveVo) {
        ProcedureVo procedureVo = new ProcedureVo(clipHistoryRemoveVo);
        ArrayList<ClipHistoryRemoveVo> list = cliClipHistoryDao.callClipHistoryRemoveList(procedureVo);
        ClipHistoryTotalVo summary = new Gson().fromJson(procedureVo.getExt(), ClipHistoryTotalVo.class);

        if(list.size() > 0){
            return gsonUtil.toJson(new JsonOutputVo(Status.조회, list, new PagingVo(procedureVo.getRet()), summary));
        }else if(list.size() == 0){
            return gsonUtil.toJson(new JsonOutputVo(Status.데이터없음, list, new PagingVo(procedureVo.getRet()), summary));
        }else {
            return gsonUtil.toJson(new JsonOutputVo(Status.비즈니스로직오류));
        }
    }


    /**
     * 클립 댓글 리스트 조회
     */
    public String selectReplyList(ClipHistoryReplyVo clipHistoryReplyVo) {
        clipHistoryReplyVo.setPageCnt(Integer.MAX_VALUE);
        ArrayList<ClipHistoryReplyVo> list = cliClipHistoryDao.selectReplyList(clipHistoryReplyVo);

        return gsonUtil.toJson(new JsonOutputVo(Status.조회, list));
    }


    /**
     * 클립 댓글 리스트 조회 - 상세페이지
     */
    public String selectReplyListDetail(ClipHistoryReplyVo clipHistoryReplyVo) {
        ClipHistoryTotalVo summary = cliClipHistoryDao.selectReplySummary(clipHistoryReplyVo);
        clipHistoryReplyVo.setTotalCnt(summary.getTotalCnt());
        ArrayList<ClipHistoryReplyVo> list = cliClipHistoryDao.selectReplyList(clipHistoryReplyVo);

        return gsonUtil.toJson(new JsonOutputVo(Status.조회, list, new PagingVo(clipHistoryReplyVo.getTotalCnt()), summary));
    }

    /**
     * 클립 상세정보 조회
     */
    public String callAdminClipInfoDetail(P_ClipHistoryDetailInfoInputVo pClipHistoryDetailInfoInputVo) {
        ProcedureVo procedureVo = new ProcedureVo(pClipHistoryDetailInfoInputVo);
        cliClipHistoryDao.callAdminClipInfoDetail(procedureVo);
        P_ClipHistoryDetailInfoOutPutVo info = new Gson().fromJson(procedureVo.getExt(), P_ClipHistoryDetailInfoOutPutVo.class);

        if(Integer.parseInt(procedureVo.getRet()) == 0){
            return gsonUtil.toJson(new JsonOutputVo(Status.조회, info));
        }else if(Integer.parseInt(procedureVo.getRet()) == -1){
            return gsonUtil.toJson(new JsonOutputVo(Status.데이터없음, info));
        }else {
            return gsonUtil.toJson(new JsonOutputVo(Status.비즈니스로직오류));
        }

    }

    /**
     * 클립 상세정보 수정
     */
    public String callAdminClipInfoDetailEdit(P_ClipHistoryDetailInfoEditVo pClipHistoryDetailInfoEditVo) {
        pClipHistoryDetailInfoEditVo.setOpName(MemberVo.getMyMemNo());

        P_pushInsertVo pPushInsertVo = new P_pushInsertVo();
        if(pClipHistoryDetailInfoEditVo.getSendNoti() != null && pClipHistoryDetailInfoEditVo.getSendNoti().equals("1")) {
            pPushInsertVo.setMem_nos(pClipHistoryDetailInfoEditVo.getMemNo());
            pPushInsertVo.setPush_slct("58");   //운영자 메시지(클립 정보 수정 및 신고)
            pPushInsertVo.setImage_type("101");

            if (pClipHistoryDetailInfoEditVo.getEditSlct().equals("1")) {    // 클립 배경 초기화
                pPushInsertVo.setSlct_push("47");
                pPushInsertVo.setSend_title("달빛 라이브 운영자 메시지");
                pPushInsertVo.setSend_cont("운영정책 위반으로 클립 이미지가 초기화 되었습니다.");
                pPushInsertVo.setRoom_no(pClipHistoryDetailInfoEditVo.getCast_no());

                pClipHistoryDetailInfoEditVo.setNotiContents("달빛 라이브 운영자 메시지");
                pClipHistoryDetailInfoEditVo.setNotiMemo("운영정책 위반으로 클립 이미지가 초기화 되었습니다.");

            } else if (pClipHistoryDetailInfoEditVo.getEditSlct().equals("2")) { // 닉네임 초기화
                pPushInsertVo.setPush_slct("57");   //운영자 메시지(프로필 이미지 초기화, 닉네임 초기화)
                pPushInsertVo.setSlct_push("35");
                pPushInsertVo.setSend_title("달빛 라이브 운영자 메시지");
                pPushInsertVo.setSend_cont("닉네임에 적합하지 않은 금지어사용으로 초기화 되었습니다.");

                pClipHistoryDetailInfoEditVo.setNotiContents("달빛 라이브 운영자 메시지");
                pClipHistoryDetailInfoEditVo.setNotiMemo("닉네임에 적합하지 않은 금지어사용으로 초기화 되었습니다.");

            } else if (pClipHistoryDetailInfoEditVo.getEditSlct().equals("3")) { // 클립 비공개
                pPushInsertVo.setSlct_push("47");
                pPushInsertVo.setSend_title("달빛 라이브 운영자 메시지");
                pPushInsertVo.setSend_cont("운영정책 위반으로 클립이 비공개 처리되었습니다.");
                pPushInsertVo.setRoom_no(pClipHistoryDetailInfoEditVo.getCast_no());

                pClipHistoryDetailInfoEditVo.setNotiContents("달빛 라이브 운영자 메시지");
                pClipHistoryDetailInfoEditVo.setNotiMemo("운영정책 위반으로 클립이 비공개 처리되었습니다.");

            } else if (pClipHistoryDetailInfoEditVo.getEditSlct().equals("4")) { // 클립 삭제
                pPushInsertVo.setSlct_push("48");
                pPushInsertVo.setSend_title("달빛 라이브 운영자 메시지");
                pPushInsertVo.setSend_cont("운영정책 위반으로 클립이 삭제 처리되었습니다.");

                pClipHistoryDetailInfoEditVo.setNotiContents("달빛 라이브 운영자 메시지");
                pClipHistoryDetailInfoEditVo.setNotiMemo("운영정책 위반으로 클립이 삭제 처리되었습니다.");

            } else if (pClipHistoryDetailInfoEditVo.getEditSlct().equals("6")) { // 클립 제목 초기화
                pPushInsertVo.setSlct_push("47");
                pPushInsertVo.setSend_title("달빛 라이브 운영자 메시지");
                pPushInsertVo.setSend_cont("클립 제목에 적합하지 않은 금지어사용으로 초기화 되었습니다.");
                pPushInsertVo.setRoom_no(pClipHistoryDetailInfoEditVo.getCast_no());

                pClipHistoryDetailInfoEditVo.setNotiContents("달빛 라이브 운영자 메시지");
                pClipHistoryDetailInfoEditVo.setNotiMemo("클립 제목에 적합하지 않은 금지어사용으로 초기화 되었습니다.");

            }
        }

        ProcedureVo procedureVo = new ProcedureVo(pClipHistoryDetailInfoEditVo);
        cliClipHistoryDao.callAdminClipInfoDetailEdit(procedureVo);

        //"0: 성공
        // -1: 클립번호 없음
        // -2: 수정변화 없음
        // -3: 잘못된수정구분값
        // -4: 이미 삭제됨
        // -5: 이미 확인됨
        // -6: 닉네임중복됨"
        if(Status.클립상세수정_성공.getMessageCode().equals(procedureVo.getRet())){
            if(pClipHistoryDetailInfoEditVo.getSendNoti() != null && pClipHistoryDetailInfoEditVo.getSendNoti().equals("1")){
                try {    // PUSH 발송
                    pushService.sendPushReqOK(pPushInsertVo);
                } catch (Exception e) {
                    log.error("[PUSH 발송 실패 - 클립 수정]");
                }
            }

            return gsonUtil.toJson(new JsonOutputVo(Status.클립상세수정_성공));
        }else if(Status.클립상세수정_클립번호없음.getMessageCode().equals(procedureVo.getRet())){
            return gsonUtil.toJson(new JsonOutputVo(Status.클립상세수정_클립번호없음));
        }else if(Status.클립상세수정_수정변화없음.getMessageCode().equals(procedureVo.getRet())){
            return gsonUtil.toJson(new JsonOutputVo(Status.클립상세수정_수정변화없음));
        }else if(Status.클립상세수정_잘못된값.getMessageCode().equals(procedureVo.getRet())){
            return gsonUtil.toJson(new JsonOutputVo(Status.클립상세수정_잘못된값));
        }else if(Status.클립상세수정_이미삭제.getMessageCode().equals(procedureVo.getRet())){
            return gsonUtil.toJson(new JsonOutputVo(Status.클립상세수정_이미삭제));
        }else if(Status.클립상세수정_이미처리.getMessageCode().equals(procedureVo.getRet())){
            return gsonUtil.toJson(new JsonOutputVo(Status.클립상세수정_이미처리));
        }else if(Status.클립상세수정_닉네임중복.getMessageCode().equals(procedureVo.getRet())){
            return gsonUtil.toJson(new JsonOutputVo(Status.클립상세수정_닉네임중복));
        }else {
            return gsonUtil.toJson(new JsonOutputVo(Status.비즈니스로직오류));
        }
    }

    public String callAdminClipInfoDetailAddMemo(P_ClipHistoryDetailInfoEditVo pClipHistoryDetailInfoEditVo) {
        P_MemberAdminMemoAddVo pMemberAdminMemoAddVo = new P_MemberAdminMemoAddVo();
        pMemberAdminMemoAddVo.setOpName(MemberVo.getMyMemNo());
        pMemberAdminMemoAddVo.setMem_no(pClipHistoryDetailInfoEditVo.getCast_no());
        pMemberAdminMemoAddVo.setMemo(pClipHistoryDetailInfoEditVo.getNotiMemo());
        ProcedureVo procedureVo = new ProcedureVo(pMemberAdminMemoAddVo);
        mem_MemberDao.callMemAdminMemoAdd(procedureVo);

        if(Integer.parseInt(procedureVo.getRet()) >= 0){
            return gsonUtil.toJson(new JsonOutputVo(Status.회원운영자메모등록성공));
        }else {
            return gsonUtil.toJson(new JsonOutputVo(Status.비즈니스로직오류));
        }
    }


    /**
     * 클립 상세정보 수정 이력 리스트
     */
    public String callAdminClipEditHistory(P_ClipHistoryDetailInfoEditHistoryVo pClipHistoryDetailInfoEditHistoryVo) {
        ProcedureVo procedureVo = new ProcedureVo(pClipHistoryDetailInfoEditHistoryVo);
        ArrayList<P_ClipHistoryDetailInfoEditHistoryVo> list = cliClipHistoryDao.callAdminClipEditHistory(procedureVo);

        if(list.size() > 0){
            return gsonUtil.toJson(new JsonOutputVo(Status.조회, list, new PagingVo(procedureVo.getRet())));
        }else if(list.size() == 0){
            return gsonUtil.toJson(new JsonOutputVo(Status.데이터없음, list, new PagingVo(procedureVo.getRet()) ));
        }else {
            return gsonUtil.toJson(new JsonOutputVo(Status.비즈니스로직오류));
        }
    }


    /**
     * 클립 상세 댓글 삭제
     */
    @Transactional
    public String deleteClipReply(ClipHistoryReplyVo clipHistoryReplyVo) {
        int result = cliClipHistoryDao.deleteClipReply(clipHistoryReplyVo);

        if(result > 0) {
            ClipEditHistoryVo clipEditHistoryVo = new ClipEditHistoryVo();
            clipEditHistoryVo.setCastNo(clipHistoryReplyVo.getCastNo());
            clipEditHistoryVo.setReplyIdx(clipHistoryReplyVo.getReplyIdx());
            clipEditHistoryVo.setOp_name(MemberVo.getMyMemNo());
            clipEditHistoryVo.setEdit_contents("Clip 댓글 삭제(어드민) : " + clipHistoryReplyVo.getCastNo() + " - " + clipHistoryReplyVo.getReplyIdx());
            clipEditHistoryVo.setEdit_type("2");

            cliClipHistoryDao.insertClipEditHistory(clipEditHistoryVo);

            return gsonUtil.toJson(new JsonOutputVo(Status.클립댓글삭제_성공));
        }else{
            return gsonUtil.toJson(new JsonOutputVo(Status.클립댓글삭제_실패));
        }

    }


    /**
     * 클립 청취자 상세 리스트 조회
     */
    public String callClipHistoryPlayList(ClipHistoryListenVo clipHistoryListenVo) {
        ProcedureVo procedureVo = new ProcedureVo(clipHistoryListenVo);
        ArrayList<ClipHistoryListenVo> list = cliClipHistoryDao.callClipHistoryPlayList(procedureVo);
        ClipHistoryTotalVo summary = new Gson().fromJson(procedureVo.getExt(), ClipHistoryListenTotalVo.class);

        if(list.size() > 0){
            return gsonUtil.toJson(new JsonOutputVo(Status.조회, list, new PagingVo(procedureVo.getRet()), summary));
        }else if(list.size() == 0){
            return gsonUtil.toJson(new JsonOutputVo(Status.데이터없음, list, new PagingVo(procedureVo.getRet()), summary));
        }else {
            return gsonUtil.toJson(new JsonOutputVo(Status.비즈니스로직오류));
        }
    }

    /**
     * 회원 클립 관리 등록 내역 통계
     */
    public String getClipMemberSummary(ClipMemberSummaryVo clipMemberSummaryVo) {
        ClipMemberSummaryVo outVo = cliClipHistoryDao.getClipMemberSummary(clipMemberSummaryVo);

        return gsonUtil.toJson(new JsonOutputVo(Status.조회, outVo));
    }

    /**
     * 회원 클립 관리 등록 내역 통계
     */
    public String getClipListenMemberSummary(ClipMemberSummaryVo clipMemberSummaryVo) {
        ClipMemberSummaryVo outVo = cliClipHistoryDao.getClipListenMemberSummary(clipMemberSummaryVo);

        return gsonUtil.toJson(new JsonOutputVo(Status.조회, outVo));
    }

    /**
     * 클립 저작권 청취내역 조회
     */
    public String callClipCopyright(P_ClipCopyrightInputVo pClipCopyrightInputVo) {
        ProcedureVo procedureVo = new ProcedureVo(pClipCopyrightInputVo);
        ArrayList<P_ClipCopyrightOutputVo> list = cliClipHistoryDao.callClipCopyright(procedureVo);
        P_ClipCopyrightSummaryVo summaryVo = new Gson().fromJson(procedureVo.getExt(), P_ClipCopyrightSummaryVo.class);
        String result;

        HashMap copyrightList = new HashMap();
        if(DalbitUtil.isEmpty(list) || list.size() == 0) {
            copyrightList.put("list", new ArrayList<>());
            copyrightList.put("summary", summaryVo);
            return gsonUtil.toJson(new JsonOutputVo(Status.데이터없음, copyrightList));
        }
        if(Integer.parseInt(procedureVo.getRet()) > 0) {
            copyrightList.put("list", list);
            copyrightList.put("summary", summaryVo);

            result = gsonUtil.toJson(new JsonOutputVo(Status.조회, copyrightList));
        } else {
            result = gsonUtil.toJson(new JsonOutputVo(Status.비즈니스로직오류));
        }

        return result;
    }

    /**
     * 클립 저작권 청취내역 커버 곡명(관리자), 커버 가수(관리자) 편집
     */
    public String updateClipCopyrightCover(ClipCopyrightUpdateVo clipCopyrightUpdateVo) {
        int result = cliClipHistoryDao.updateClipCopyrightCover(clipCopyrightUpdateVo);

        if(result > 0) {
            return gsonUtil.toJson(new JsonOutputVo(Status.수정));
        } else {
            return gsonUtil.toJson(new JsonOutputVo(Status.비즈니스로직오류));
        }
    }
}