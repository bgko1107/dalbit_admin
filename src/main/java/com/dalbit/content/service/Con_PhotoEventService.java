package com.dalbit.content.service;

import com.dalbit.common.code.EventCode;
import com.dalbit.common.code.Status;
import com.dalbit.common.vo.JsonOutputVo;
import com.dalbit.common.vo.PagingVo;
import com.dalbit.content.dao.Con_PhotoEventDao;
import com.dalbit.content.vo.*;
import com.dalbit.excel.service.ExcelService;
import com.dalbit.excel.vo.ExcelVo;
import com.dalbit.member.dao.Mem_MemberDao;
import com.dalbit.member.vo.MemberVo;
import com.dalbit.util.DalbitUtil;
import com.dalbit.util.GsonUtil;
import com.dalbit.util.MessageUtil;
import lombok.extern.slf4j.Slf4j;
import org.apache.poi.xssf.streaming.SXSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import java.util.*;

@Slf4j
@Service
public class Con_PhotoEventService {

    @Autowired
    ExcelService excelService;
    @Autowired
    Con_PhotoEventDao con_photoEventDao;
    @Autowired
    Mem_MemberDao memMemberDao;
    @Autowired
    MessageUtil messageUtil;
    @Autowired
    GsonUtil gsonUtil;


    public String selectPhotoShotList(PhotoShotVo photoShotVo){

        int totalCnt = con_photoEventDao.selectPhotoShotCnt(photoShotVo);
        photoShotVo.setTotalCnt(totalCnt);
        List<PhotoShotVo> giftconList = con_photoEventDao.selectPhotoShotList(photoShotVo);

        return gsonUtil.toJson(new JsonOutputVo(Status.조회, giftconList, new PagingVo(totalCnt)));
    }

    public String selectPhotoShotDetail(PhotoShotVo photoShotVo){

        photoShotVo.setTotalCnt(1);
        photoShotVo.setSearchStartNo(1);
        photoShotVo.setSearchEndNo(1);
        List<PhotoShotVo> giftconList = con_photoEventDao.selectPhotoShotList(photoShotVo);
        return gsonUtil.toJson(new JsonOutputVo(Status.조회, giftconList.get(0)));
    }

    public Model getPhotoListExcel(PhotoShotVo photoShotVo, Model model) {
        photoShotVo.setTotalCnt(1000000);
        photoShotVo.setEvent_idx(EventCode.인증샷.getEventIdx());
        List<PhotoShotVo> list = con_photoEventDao.selectPhotoShotList(photoShotVo);

        String[] headers = {"No", "회원번호", "UID", "닉네임", "참여일시"};
        int[] headerWidths = {3000, 5000, 5000, 6000, 6000};

        List<Object[]> bodies = new ArrayList<>();
        for(int i=0; i<list.size(); i++) {
            HashMap hm = new LinkedHashMap();

            hm.put("no", list.size()-i);
            hm.put("mem_no", DalbitUtil.isEmpty(list.get(i).getMem_no()) ? "" : list.get(i).getMem_no());
            hm.put("mem_userid", DalbitUtil.isEmpty(list.get(i).getMem_userid()) ? "" : list.get(i).getMem_userid());
            hm.put("mem_nick", DalbitUtil.isEmpty(list.get(i).getMem_nick()) ? "" : list.get(i).getMem_nick());
            hm.put("reg_date", DalbitUtil.isEmpty(list.get(i).getReg_date()) ? "" : list.get(i).getReg_date());

            bodies.add(hm.values().toArray());
        }
        ExcelVo vo = new ExcelVo(headers, headerWidths, bodies);
        SXSSFWorkbook workbook = excelService.excelDownload("인증샷이벤트 신청 목록",vo);
        model.addAttribute("locale", Locale.KOREA);
        model.addAttribute("workbook", workbook);
        model.addAttribute("workbookName", "인증샷이벤트 신청 목록");

        return model;
    }

    public String deletePhotoShot(PhotoShotVo photoShotVo){
        photoShotVo.setIdxArr(photoShotVo.getIdxs().split(","));
        photoShotVo.setDel_yn(1);
        photoShotVo.setOpName(MemberVo.getMyMemNo());

        int deleteMemCnt = con_photoEventDao.deleteEventMember(photoShotVo);
        int deletePhotoCnt = con_photoEventDao.deletePhotoShot(photoShotVo);

        return gsonUtil.toJson(new JsonOutputVo(Status.삭제));
    }

    public Model getKnowhowListExcel(PhotoShotVo photoShotVo, Model model) {
        photoShotVo.setTotalCnt(1000000);
        photoShotVo.setEvent_idx(EventCode.노하우.getEventIdx());
        List<PhotoShotVo> list = con_photoEventDao.selectPhotoShotList(photoShotVo);

        String[] headers = {"No", "회원번호", "UID", "닉네임", "참여일시"
                , "추천수", "조회수", "구분", "디바이스", "기종1"
                , "기종2", "채택여부"};
        int[] headerWidths = {3000, 5000, 5000, 6000, 6000
                , 3000, 3000, 5000, 5000, 8000
                , 8000, 3000};

        List<Object[]> bodies = new ArrayList<>();
        for(int i=0; i<list.size(); i++) {
            HashMap hm = new LinkedHashMap();

            hm.put("no", list.size()-i);
            hm.put("mem_no", DalbitUtil.isEmpty(list.get(i).getMem_no()) ? "" : list.get(i).getMem_no());
            hm.put("mem_userid", DalbitUtil.isEmpty(list.get(i).getMem_userid()) ? "" : list.get(i).getMem_userid());
            hm.put("mem_nick", DalbitUtil.isEmpty(list.get(i).getMem_nick()) ? "" : list.get(i).getMem_nick());
            hm.put("reg_date", DalbitUtil.isEmpty(list.get(i).getReg_date()) ? "" : list.get(i).getReg_date());
            hm.put("good_cnt", DalbitUtil.isEmpty(list.get(i).getGood_cnt()) ? "" : list.get(i).getGood_cnt());
            hm.put("view_cnt", DalbitUtil.isEmpty(list.get(i).getView_cnt()) ? "" : list.get(i).getView_cnt());

            String slct_device = "mobile";
            if(list.get(i).getSlct_device() < 3){
                slct_device = "pc";
            }
            hm.put("slct_device", slct_device);
            hm.put("device1", DalbitUtil.isEmpty(list.get(i).getDevice1()) ? "" : list.get(i).getDevice1());
            hm.put("device2", DalbitUtil.isEmpty(list.get(i).getDevice2()) ? "" : list.get(i).getDevice2());
            hm.put("is_check", list.get(i).getIs_check() == 0 ? "N" : "Y");

            bodies.add(hm.values().toArray());
        }
        ExcelVo vo = new ExcelVo(headers, headerWidths, bodies);
        SXSSFWorkbook workbook = excelService.excelDownload("노하우이벤트 신청 목록",vo);
        model.addAttribute("locale", Locale.KOREA);
        model.addAttribute("workbook", workbook);
        model.addAttribute("workbookName", "노하우이벤트 신청 목록");

        return model;
    }

    public String updatePhotoGood(PhotoShotVo photoShotVo){
        photoShotVo.setOpName(MemberVo.getMyMemNo());
        int goodResult = con_photoEventDao.updatePhotoGood(photoShotVo);

        return gsonUtil.toJson(new JsonOutputVo(Status.수정, goodResult));
    }

    public String selectEventMemberList(EventMemberVo eventMemberVo){
        int totalCnt = con_photoEventDao.selectEventMemberCnt(eventMemberVo);
        eventMemberVo.setTotalCnt(totalCnt);
        List<EventMemberVo> list = con_photoEventDao.selectEventMemberList(eventMemberVo);

        return gsonUtil.toJson(new JsonOutputVo(Status.조회, list, new PagingVo(totalCnt)));
    }

    public Model getEventMemberListExcel(EventMemberVo eventMemberVo, Model model) {
        eventMemberVo.setTotalCnt(1000000);
        eventMemberVo.setEvent_idx(EventCode.방송장비.getEventIdx());
        List<EventMemberVo> list = con_photoEventDao.selectEventMemberList(eventMemberVo);

        String[] headers = {"No", "회원번호", "닉네임", "신청일", "이름", "연락처", "방송소개"};
        int[] headerWidths = {3000, 5000, 5000, 6000, 6000, 10000};

        List<Object[]> bodies = new ArrayList<>();
        for(int i=0; i<list.size(); i++) {
            HashMap hm = new LinkedHashMap();

            hm.put("no", list.size()-i);
            hm.put("mem_no", DalbitUtil.isEmpty(list.get(i).getMem_no()) ? "" : list.get(i).getMem_no());
            hm.put("mem_nick", DalbitUtil.isEmpty(list.get(i).getMem_nick()) ? "" : list.get(i).getMem_nick());
            hm.put("reg_date", DalbitUtil.isEmpty(list.get(i).getReg_date()) ? "" : list.get(i).getReg_date());
            hm.put("name", DalbitUtil.isEmpty(list.get(i).getName()) ? "" : list.get(i).getName());
            hm.put("contact_no", DalbitUtil.isEmpty(list.get(i).getContact_no()) ? "" : list.get(i).getContact_no());
            hm.put("recv_data_1", DalbitUtil.isEmpty(list.get(i).getRecv_data_1()) ? "" : list.get(i).getRecv_data_1());

            bodies.add(hm.values().toArray());
        }
        ExcelVo vo = new ExcelVo(headers, headerWidths, bodies);
        SXSSFWorkbook workbook = excelService.excelDownload("방송지원 신청 목록",vo);
        model.addAttribute("locale", Locale.KOREA);
        model.addAttribute("workbook", workbook);
        model.addAttribute("workbookName", "방송지원 신청 목록");

        return model;
    }

    public String selectWebcamList(PhotoShotVo photoShotVo){

        int totalCnt = con_photoEventDao.selectWebcamCnt(photoShotVo);
        photoShotVo.setTotalCnt(totalCnt);
        List<PhotoShotVo> giftconList = con_photoEventDao.selectWebcamList(photoShotVo);

        return gsonUtil.toJson(new JsonOutputVo(Status.조회, giftconList, new PagingVo(totalCnt)));
    }
}
