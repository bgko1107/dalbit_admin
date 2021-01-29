package com.dalbit.content.controller.rest;

import com.dalbit.common.code.EventCode;
import com.dalbit.common.code.Status;
import com.dalbit.common.vo.JsonOutputVo;
import com.dalbit.content.service.Con_PhotoEventService;
import com.dalbit.content.vo.*;
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
@RequestMapping("rest/content/event")
public class Con_PhotoEventRestController {

    @Autowired
    ExcelService excelService;

    @Autowired
    Con_PhotoEventService con_photoEventService;

    @Autowired
    GsonUtil gsonUtil;


    @PostMapping("/photo/shot/list")
    public String photoShotList(PhotoShotVo photoShotVo) {
        photoShotVo.setEvent_idx(EventCode.인증샷.getEventIdx());
        String result = con_photoEventService.selectPhotoShotList(photoShotVo);
        return result;
    }

    @PostMapping("/photo/shot/delete")
    public String photoShotDelete(PhotoShotVo photoShotVo) {
        photoShotVo.setEvent_idx(EventCode.인증샷.getEventIdx());
        String result = con_photoEventService.deletePhotoShot(photoShotVo);
        return result;
    }

    @PostMapping("/photo/shot/excel")
    public String photoShotExcel(HttpServletRequest request, HttpServletResponse response, Model model, PhotoShotVo photoShotVo) throws GlobalException {

        Model resultModel = con_photoEventService.getPhotoListExcel(photoShotVo, model);

        excelService.renderMergedOutputModel(resultModel.asMap(), request, response);
        return gsonUtil.toJson(new JsonOutputVo(Status.엑셀다운로드성공));

    }

    @PostMapping("/knowhow/list")
    public String knowhowList(PhotoShotVo photoShotVo) {
        photoShotVo.setEvent_idx(EventCode.노하우.getEventIdx());
        String result = con_photoEventService.selectPhotoShotList(photoShotVo);
        return result;
    }

    @PostMapping("/knowhow/detail")
    public String knowhowDetail(PhotoShotVo photoShotVo) {
        photoShotVo.setEvent_idx(EventCode.노하우.getEventIdx());
        String result = con_photoEventService.selectPhotoShotDetail(photoShotVo);
        return result;
    }

    @PostMapping("/knowhow/delete")
    public String knowhowDelete(PhotoShotVo photoShotVo) {
        photoShotVo.setEvent_idx(EventCode.노하우.getEventIdx());
        String result = con_photoEventService.deletePhotoShot(photoShotVo);
        return result;
    }

    @PostMapping("/knowhow/good")
    public String knowhowGood(PhotoShotVo photoShotVo) {
        photoShotVo.setEvent_idx(EventCode.노하우.getEventIdx());
        String result = con_photoEventService.updatePhotoGood(photoShotVo);
        return result;
    }

    @PostMapping("/knowhow/excel")
    public String knowhowExcel(HttpServletRequest request, HttpServletResponse response, Model model, PhotoShotVo photoShotVo) throws GlobalException {

        Model resultModel = con_photoEventService.getKnowhowListExcel(photoShotVo, model);

        excelService.renderMergedOutputModel(resultModel.asMap(), request, response);
        return gsonUtil.toJson(new JsonOutputVo(Status.엑셀다운로드성공));

    }

    @PostMapping("/member/list")
    public String selectEventMemberList(EventMemberVo eventMemberVo){
        //eventMemberVo.setEvent_idx(EventCode.방송장비.getEventIdx());
        String result = con_photoEventService.selectEventMemberList(eventMemberVo);
        return result;
    }

    @PostMapping("/member/list/excel")
    public String memberListExcel(HttpServletRequest request, HttpServletResponse response, Model model, EventMemberVo eventMemberVo) throws GlobalException {

        Model resultModel = con_photoEventService.getEventMemberListExcel(eventMemberVo, model);

        excelService.renderMergedOutputModel(resultModel.asMap(), request, response);
        return gsonUtil.toJson(new JsonOutputVo(Status.엑셀다운로드성공));

    }

    @PostMapping("/webcam/list")
    public String photoWebcamList(PhotoShotVo photoShotVo) {
        photoShotVo.setEvent_idx(EventCode.웹캠.getEventIdx());
        //String result = con_photoEventService.selectWebcamList(photoShotVo);
        String result = con_photoEventService.selectPhotoShotList(photoShotVo);
        return result;
    }

    @PostMapping("/webcam/detail")
    public String photoWebcamDetail(PhotoShotVo photoShotVo) {
        photoShotVo.setEvent_idx(EventCode.웹캠.getEventIdx());
        //String result = con_photoEventService.selectWebcamList(photoShotVo);
        String result = con_photoEventService.selectPhotoShotDetail(photoShotVo);
        return result;
    }

}
