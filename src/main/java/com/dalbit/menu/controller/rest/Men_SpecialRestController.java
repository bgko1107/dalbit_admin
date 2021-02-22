package com.dalbit.menu.controller.rest;

import com.dalbit.common.code.Status;
import com.dalbit.common.vo.JsonOutputVo;
import com.dalbit.excel.service.ExcelService;
import com.dalbit.exception.GlobalException;
import com.dalbit.menu.service.Men_SpecialService;
import com.dalbit.menu.service.RecommendService;
import com.dalbit.menu.vo.*;
import com.dalbit.util.GsonUtil;
import com.google.gson.Gson;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.List;

@Slf4j
@RestController
@RequestMapping("rest/menu/special")
public class Men_SpecialRestController {

    @Autowired
    GsonUtil gsonUtil;

    @Autowired
    RecommendService recommendService;

    @Autowired
    Men_SpecialService menSpecialService;

    @Autowired
    ExcelService excelService;

    @RequestMapping("list")
    public String list(){

        RecommendVo recommendVo = new RecommendVo();
//        recommendVo.setOrderColumnName("recommend");
        List<RecommendVo> recommendVoList = recommendService.getRecommendList(recommendVo);



        return gsonUtil.toJson(new JsonOutputVo(Status.조회, recommendVoList));
    }


    /**
     * 스페셜 달D 건수
     */
    @PostMapping("summary")
    public String summary(SpecialSummaryVo specialSummaryVo){
        String result = menSpecialService.summary(specialSummaryVo);
        return result;
    }

    /**
     * 스페셜 달D 신청 목록 조회
     */
    @PostMapping("reqDalList")
    public String reqDalList(SpecialReqVo specialReqVo){
        String result = menSpecialService.getReqSpecialList(specialReqVo);
        return result;
    }

    /**
     * 스페셜 달D 신청 가능 목록 조회
     */
    @PostMapping("reqAbleList")
    public String reqAbleList(SpecialReqVo specialReqVo){
        String result = menSpecialService.selectReqAbleSpecialDjList(specialReqVo);
        return result;
    }

    /**
     * 스페셜 달D 신청 목록 엑셀
     */
    @PostMapping("reqDalListExcel")
    public String listExcel(HttpServletRequest request, HttpServletResponse response, Model model, SpecialReqVo specialReqVo) throws GlobalException {

        Model resultModel = menSpecialService.getListExcel(specialReqVo, model);

        excelService.renderMergedOutputModel(resultModel.asMap(), request, response);
        return gsonUtil.toJson(new JsonOutputVo(Status.엑셀다운로드성공));

    }

    /**
     * 스페셜 달D 신청 목록 엑셀
     */
    @PostMapping("reqAbleDalListExcel")
    public String reqAbleListExcel(HttpServletRequest request, HttpServletResponse response, Model model, SpecialReqVo specialReqVo) throws GlobalException {

        Model resultModel = menSpecialService.reqAbleListExcel(specialReqVo, model);

        excelService.renderMergedOutputModel(resultModel.asMap(), request, response);
        return gsonUtil.toJson(new JsonOutputVo(Status.엑셀다운로드성공));

    }

    /**
     * 스페셜 달D 신청 상세 목록 조회
     */
    @PostMapping("reqDalDetail")
    public String reqDalDetail(SpecialReqVo specialReqVo) {
        String result = menSpecialService.getReqSpecialDetail(specialReqVo);
        return result;
    }

    /**
     * 스페셜 달D 신청 승인
     */
    @PostMapping("reqOk")
    public String reqOk(SpecialReqVo specialReqVo) {
        String result = menSpecialService.reqOk(specialReqVo);
        return result;
    }

    /**
     * 스페셜 달D 신청 거부
     */
    @PostMapping("reqReject")
    public String reqReject(SpecialReqVo specialReqVo, SpecialVo specialVo) {
        String result = menSpecialService.reqReject(specialReqVo, specialVo);
        return result;
    }

    /**
     * 스페셜 달D 목록 조회
     */
    @PostMapping("dalList")
    public String dalList(SpecialVo specialVo){
        String result = menSpecialService.getSpecialList(specialVo);
        return result;
    }

    /**
     * 스페셜 달D 상세 목록 조회
     */
    @PostMapping("dalDetail")
    public String getSpecialDetail(SpecialVo specialVo) {
        String result = menSpecialService.getSpecialDetail(specialVo);
        return result;
    }

    /**
     * 스페셜 달D 승인 취소
     */
    @PostMapping("reqCancel")
    public String reqCancel(SpecialVo specialVo, SpecialReqVo specialReqVo) {
        String result = menSpecialService.reqCancel(specialVo, specialReqVo);
        return result;
    }

    /**
     * 스페셜 달D 순위 변경 업데이트
     */
    @PostMapping("updateOrder")
    public String updateOrder(SpecialDjOrderVo specialDjOrderVo) {
        String result = menSpecialService.updateOrder(specialDjOrderVo);
        return result;
    }

    /**
     * 스페셜 달D 신청 상세 조회
     */
    @PostMapping("selectManageInfo")
    public String manageInfo(SpecialDjManageVo specialDjManageVo) {
        String result = menSpecialService.selectManageInfo(specialDjManageVo);
        return result;
    }

    /**
     * 스페셜 달D 신청 관리 등록
     */
    @PostMapping("insertManageInfo")
    public String insertManageInfo(HttpServletRequest request) {
        String jsonData = request.getParameter("jsonData");
        SpecialDjManageVo specialDjManageVo = new Gson().fromJson(jsonData, SpecialDjManageVo.class);
        String result = menSpecialService.insertManageInfo(specialDjManageVo);
        return result;
    }

    /**
     * 스페셜 달D 신청 관리 수정
     */
    @PostMapping("updateManageInfo")
    public String updateManageInfo(HttpServletRequest request) {
        String jsonData = request.getParameter("jsonData");
        SpecialDjManageVo specialDjManageVo = new Gson().fromJson(jsonData, SpecialDjManageVo.class);
        String result = menSpecialService.updateManageInfo(specialDjManageVo);
        return result;
    }

    /**
     * 스페셜 달D 신청 관리 목록
     */
    @PostMapping("selectManageList")
    public String selectManageList(SpecialDjManageVo specialDjManageVo) {
        String result = menSpecialService.selectManageList(specialDjManageVo);
        return result;
    }

    /**
     * 스페셜 달D 신청 관리 목록
     */
    @PostMapping("bestAbleList")
    public String selectBestAbleList(SpecialDjBestVo specialDjBestVo) {
        String result = menSpecialService.selectBestAbleList(specialDjBestVo);
        return result;
    }

    /**
     * 스페셜 리그 목록
     */
    @PostMapping("specialLeague")
    public String specialLeagueList(SpecialVo specialVo) {
        String result = menSpecialService.callSpecialLeagueList(specialVo);
        return result;
    }
}
