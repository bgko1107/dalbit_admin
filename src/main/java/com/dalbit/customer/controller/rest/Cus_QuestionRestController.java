package com.dalbit.customer.controller.rest;

import com.dalbit.common.code.Status;
import com.dalbit.common.vo.JsonOutputVo;
import com.dalbit.customer.service.Cus_QuestionService;
import com.dalbit.customer.vo.FaqVo;
import com.dalbit.customer.vo.procedure.*;
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
import java.io.UnsupportedEncodingException;
import java.util.HashMap;
import java.util.List;

@Slf4j
@RestController
@RequestMapping("rest/customer/question")
public class Cus_QuestionRestController {

    @Autowired
    Cus_QuestionService cus_questionService;

    @Autowired
    GsonUtil gsonUtil;

    @Autowired
    ExcelService excelService;

    /**
     * 1:1 신고 목록 조회
     */
    @PostMapping("list")
    public String list(P_QuestionListInputVo pQuestionListInputVo) {

        String result = cus_questionService.getQuestionList(pQuestionListInputVo);

        return result;
    }

    /**
     *  1:1 문의하기 상세 조회
     */
    @PostMapping("detail")
    public String detail(P_QuestionDetailInputVo pQuestionDetailInputVo) {
        return cus_questionService.callServiceCenterQnaDetail(pQuestionDetailInputVo);
    }

    /**
     *  1:1 문의하기 처리하기
     */
    @PostMapping("operate")
    public String operate(P_QuestionOperateVo pQuestionOperateVo) throws GlobalException, InterruptedException, UnsupportedEncodingException {
        return cus_questionService.callServiceCenterQnaOperate(pQuestionOperateVo);
    }
    /**
     *  1:1 문의하기 수정하기
     */
    @PostMapping("update")
    public String update(P_QuestionOperateVo pQuestionOperateVo) {
        return cus_questionService.callServiceCenterQnaUpdate(pQuestionOperateVo);
    }

    @PostMapping("getFaqGroupList")
    public String getFaqGroupList(FaqVo faqVo){

        if(faqVo.getSlct_type() == 0){
            faqVo.setSlct_type(1);
        }

        List<FaqVo> faqGroupList = cus_questionService.getFaqGroupList();
        List<FaqVo> faqSubList = cus_questionService.getFaqSubList(faqVo);

        HashMap map = new HashMap();
        map.put("faqGroupList", faqGroupList);
        map.put("faqSubList", faqSubList);

        return gsonUtil.toJson(new JsonOutputVo(Status.조회, map));
    }

    @PostMapping("getFaqSubList")
    public String getFaqSubList(FaqVo faqVo){

        if(faqVo.getSlct_type() == 0){
            faqVo.setSlct_type(1);
        }

        List<FaqVo> faqSubList = cus_questionService.getFaqSubList(faqVo);

        HashMap map = new HashMap();
        map.put("faqSubList", faqSubList);

        return gsonUtil.toJson(new JsonOutputVo(Status.조회, map));
    }

    /**
     * 회원 문의 내역 건 수
     */
    @PostMapping("questionCount_target")
    public String questionCount_target(P_QuestionListInputVo pQuestionListInputVo) {
        String result = cus_questionService.getQuestionCountTarget(pQuestionListInputVo);
        return result;
    }

    /**
     * 회원 문의 내역 건 삭제
     */
    @PostMapping("delete")
    public String delete(P_QuestionDeleteVo pQuestionDeleteVo){
        return cus_questionService.getQuestionDelete(pQuestionDeleteVo);
    }


    /**
     * 문의 엑셀
     */
    @PostMapping("listExcel")
    public String listExcel(HttpServletRequest request, HttpServletResponse response, Model model, P_QuestionListInputVo pQuestionListInputVo) throws GlobalException {

        Model resultModel = cus_questionService.getListExcel(pQuestionListInputVo, model);
        excelService.renderMergedOutputModel(resultModel.asMap(), request, response);

        return gsonUtil.toJson(new JsonOutputVo(Status.엑셀다운로드성공));
    }

    /**
     *  1:1 문의하기 처리중 상태 변경
     */
    @PostMapping("qnaCatch")
    public String qnaCatch(P_QuestionOperateVo pQuestionOperateVo) {
        return cus_questionService.callServiceCenterQnaCatch(pQuestionOperateVo);
    }
    /**
     *  1:1 문의하기 처리중 상태 해제
     */
    @PostMapping("chatchRelease")
    public String chatchRelease(P_QuestionOperateVo pQuestionOperateVo) {
        return cus_questionService.callServiceCenterQnaChatchRelease(pQuestionOperateVo);
    }

    /**
     *  1:1 문의 운영자 메모 등록
     */
    @PostMapping("adminMemoAdd")
    public String callAdminMemoQuestionAdd(P_QuestionOperateVo pQuestionOperateVo){
        return cus_questionService.callAdminMemoQuestionAdd(pQuestionOperateVo);
    }

    /**
     *  1:1 문의 운영자 메모 목록
     */
    @PostMapping("adminMemo/list")
    public String adminMemoList(P_QuestionOperateVo pQuestionOperateVo){
        return cus_questionService.callAdminMemoList(pQuestionOperateVo);
    }

    /**
     *  1:1 문의 운영자 메모 목록
     */
    @PostMapping("file/del")
    public String fileDel(P_QuestionOperateVo pQuestionOperateVo){
        return cus_questionService.callQustionFileDel(pQuestionOperateVo);
    }



    /**
     *  자동답변 목록
     */
    @PostMapping("macro/list")
    public String macroList(P_MacroVo pMacroVo){
        return cus_questionService.callMacroList(pMacroVo);
    }

    /**
     *  자동답변 상세 정보
     */
    @PostMapping("macro/detail")
    public String macroDetail(P_MacroVo pMacroVo){
        return cus_questionService.callMacroDetail(pMacroVo);
    }

    /**
     *  자동답변 상세 등록/수정
     */
    @PostMapping("macro/edit")
    public String macroEdit(P_MacroVo pMacroVo){
        return cus_questionService.callMacroEdit(pMacroVo);
    }

    /**
     *  자동답변 목록 삭제
     */
    @PostMapping("macro/del")
    public String macroDel(P_MacroVo pMacroVo){
        return cus_questionService.callMacroDel(pMacroVo);
    }

}
