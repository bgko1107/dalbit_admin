package com.dalbit.clip.controller.rest;

import com.dalbit.clip.service.Cli_ClipHistoryService;
import com.dalbit.clip.vo.*;
import com.dalbit.clip.vo.procedure.*;
import com.dalbit.common.code.Status;
import com.dalbit.common.vo.JsonOutputVo;
import com.dalbit.excel.service.ExcelService;
import com.dalbit.exception.GlobalException;
import com.dalbit.util.GsonUtil;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@Slf4j
@RestController
@RequestMapping("rest/clip/history")
public class Cli_ClipHistoryRestController {

    @Autowired
    GsonUtil gsonUtil;

    @Autowired
    Cli_ClipHistoryService cliClipHistoryService;

    @Autowired
    ExcelService excelService;

    /**
     * 클립 내역 조회
     */
    @PostMapping("/list")
    public String selectClipHistoryList(ClipHistoryVo clipHistoryVo) {
//        return cliClipHistoryService.selectClipHistoryList(clipHistoryVo);
        return cliClipHistoryService.callClipHistoryList(clipHistoryVo);
    }

    /**
     * 클립 내역 조회
     */
    @PostMapping("/reg/list")
    public String selectClipRegHistoryList(ClipHistoryVo clipHistoryVo) {
//        return cliClipHistoryService.selectClipHistoryList(clipHistoryVo);
        return cliClipHistoryService.callClipRegHistoryList(clipHistoryVo);
    }

    /**
     * 클립 내역(회원) 조회
     */
    @PostMapping("/member/list")
    public String selectClipHistoryMemberList(ClipHistoryMemberVo clipHistoryMemberVo) {
        return cliClipHistoryService.callClipHistoryMemberList(clipHistoryMemberVo);
    }

    /**
     * 클립 숨기기/해제
     */
    @PostMapping("/updateHide")
    public String updateHide(ClipHistoryVo clipHistoryVo){
        return cliClipHistoryService.updateHide(clipHistoryVo);
    }

    /**
     * 클립 삭제
     */
    @PostMapping("/deleteClip")
    public String deleteClip(ClipHistoryVo clipHistoryVo){
        return cliClipHistoryService.deleteClip(clipHistoryVo);
    }

    /**
     * 클립 청취 내역 조회
     */
    @PostMapping("listen/list")
    public String selectClipHistoryListenList(ClipHistoryListenVo clipHistoryListenVo) {
//        return cliClipHistoryService.selectClipHistoryListenList(clipHistoryListenVo);
        return cliClipHistoryService.callClipHistoryListenList(clipHistoryListenVo);
    }

    /**
     * 클립 좋아요 내역 조회
     */
    @PostMapping("good/list")
    public String selectClipHistoryGoodList(ClipHistoryListenVo clipHistoryListenVo) {
        return cliClipHistoryService.callClipHistoryGoodList(clipHistoryListenVo);
    }

    /**
     * 클립 선물 내역 조회
     */
    @PostMapping("gift/list")
    public String selectClipHistoryGiftList(ClipHistoryGiftVo clipHistoryGiftVo) {
        return cliClipHistoryService.callClipHistoryGiftList(clipHistoryGiftVo);
    }

    /**
     * 클립 삭제 내역 조회
     */
    @PostMapping("remove/list")
    public String selectClipHistoryRemoveList(ClipHistoryRemoveVo clipHistoryRemoveVo) {
//        return cliClipHistoryService.selectClipHistoryRemoveList(clipHistoryRemoveVo);
        return cliClipHistoryService.callClipHistoryRemoveList(clipHistoryRemoveVo);
    }


    /**
     * 클립 댓글 내역 조회
     */
    @PostMapping("reply/list")
    public String selectReplyList(ClipHistoryReplyVo clipHistoryReplyVo) {
        return cliClipHistoryService.selectReplyList(clipHistoryReplyVo);
    }

    /**
     * 클립 댓글 내역 조회
     */
    @PostMapping("reply/detail/list")
    public String selectReplyListDetail(ClipHistoryReplyVo clipHistoryReplyVo) {
        return cliClipHistoryService.selectReplyListDetail(clipHistoryReplyVo);
    }


    /**
     * 클립 상세정보 조회
     */
    @PostMapping("/info")
    public String selectClipHistoryDetailInfo(P_ClipHistoryDetailInfoInputVo pClipHistoryDetailInfoInputVo) {
        return cliClipHistoryService.callAdminClipInfoDetail(pClipHistoryDetailInfoInputVo);
    }

    /**
     * 클립 상세정보 수정
     */
    @PostMapping("/info/edit")
    public String selectClipHistoryDetailInfoEdit(P_ClipHistoryDetailInfoEditVo pClipHistoryDetailInfoEditVo) {
        return cliClipHistoryService.callAdminClipInfoDetailEdit(pClipHistoryDetailInfoEditVo);
    }


    /**
     * 클립 상세 운영자 메모 등록
     */
    @PostMapping("/info/addmemo")
    public String selectClipHistoryDetailInfoAddMemo(P_ClipHistoryDetailInfoEditVo pClipHistoryDetailInfoEditVo) {
        return cliClipHistoryService.callAdminClipInfoDetailAddMemo(pClipHistoryDetailInfoEditVo);
    }

    /**
     * 방송방 정보수정 내역 보기
     */
    @PostMapping("/info/editHist")
    public String editHist(P_ClipHistoryDetailInfoEditHistoryVo pClipHistoryDetailInfoEditHistoryVo) {
        return cliClipHistoryService.callAdminClipEditHistory(pClipHistoryDetailInfoEditHistoryVo);
    }

    /**
     * 클립 댓글 삭제
     */
    @PostMapping("/info/delete/reply")
    public String deleteClipReply(ClipHistoryReplyVo clipHistoryReplyVo){
        return cliClipHistoryService.deleteClipReply(clipHistoryReplyVo);
    }

    /**
     * 클립 청취 상세 내역 조회
     */
    @PostMapping("play/list")
    public String callClipHistoryPlayList(ClipHistoryListenVo clipHistoryListenVo) {
//        return cliClipHistoryService.selectClipHistoryListenList(clipHistoryListenVo);
        return cliClipHistoryService.callClipHistoryPlayList(clipHistoryListenVo);
    }


    /**
     * 회원 클립 관리 등록 내역 통계
     */
    @PostMapping("member/list/summary")
    public String getClipMemberSummary(ClipMemberSummaryVo clipMemberSummaryVo){
        String result = cliClipHistoryService.getClipMemberSummary(clipMemberSummaryVo);
        return result;
    }

    /**
     * 회원 클립 청취 관리 내역 통계
     */
    @PostMapping("listen/member/list/summary")
    public String getClipListenMemberSummary(ClipMemberSummaryVo clipMemberSummaryVo){
        String result = cliClipHistoryService.getClipListenMemberSummary(clipMemberSummaryVo);
        return result;
    }

    /**
     * 클립 저작권 청취내역 조회
     */
    @PostMapping("/copyright/list")
    public String callClipCopyright(P_ClipCopyrightInputVo pClipCopyrightInputVo) {
        String result = cliClipHistoryService.callClipCopyright(pClipCopyrightInputVo);
        return result;
    }

    /**
     * 클립 저작권 청취내역 커버 곡명(관리자), 커버 가수(관리자) 편집
     */
    @PostMapping("/copyright/cover/edit")
    public String updateClipCopyrightCover(ClipCopyrightUpdateVo clipCopyrightUpdateVo) {
        String result = cliClipHistoryService.updateClipCopyrightCover(clipCopyrightUpdateVo);
        return result;
    }

    /**
     * 클립 저작권 청취내역 상세 조회
     */
    @PostMapping("/copyright/detail")
    public String callClipCopyrightDetail(P_ClipCopyrightDetailInputVo pClipCopyrightDetailInputVo) {
        String result = cliClipHistoryService.callClipCopyrightDetail(pClipCopyrightDetailInputVo);
        return result;
    }

    /**
     * 클립 저작권 청취내역 엑셀
     */
    @PostMapping("/copyright/listExcel")
    public String clipCopyrightListExcel(HttpServletRequest request, HttpServletResponse response, Model model, P_ClipCopyrightInputVo pClipCopyrightInputVo) throws GlobalException {
        Model resultModel = cliClipHistoryService.clipCopyrightListExcel(pClipCopyrightInputVo, model);
        excelService.renderMergedOutputModel(resultModel.asMap(), request, response);
        return gsonUtil.toJson(new JsonOutputVo(Status.엑셀다운로드성공));
    }
}
