package com.dalbit.customer.service;

import com.dalbit.broadcast.service.Bro_BroadcastService;
import com.dalbit.broadcast.vo.procedure.P_BroadcastEditInputVo;
import com.dalbit.clip.service.Cli_ClipHistoryService;
import com.dalbit.clip.vo.ClipHistoryVo;
import com.dalbit.clip.vo.procedure.P_ClipHistoryDetailInfoEditVo;
import com.dalbit.common.code.Code;
import com.dalbit.common.code.ErrorStatus;
import com.dalbit.common.code.Status;
import com.dalbit.common.vo.JsonOutputVo;
import com.dalbit.common.vo.PagingVo;
import com.dalbit.common.vo.ProcedureVo;
import com.dalbit.customer.dao.Cus_ImageDao;
import com.dalbit.customer.vo.procedure.P_ImageBroadcastListInputVo;
import com.dalbit.customer.vo.procedure.P_ImageBroadcastListOutputVo;
import com.dalbit.customer.vo.procedure.P_ImageProfileListInputVo;
import com.dalbit.customer.vo.procedure.P_ImageProfileListOutputVo;
import com.dalbit.exception.GlobalException;
import com.dalbit.member.service.Mem_MemberService;
import com.dalbit.member.vo.MemberNoticeImgDeleteVo;
import com.dalbit.member.vo.MemberVo;
import com.dalbit.member.vo.procedure.*;
import com.dalbit.util.DalbitUtil;
import com.dalbit.util.GsonUtil;
import com.google.gson.Gson;
import com.google.gson.JsonElement;
import com.google.gson.JsonParser;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;

@Slf4j
@Service
public class Cus_ImageService {

    @Autowired
    Cus_ImageDao cusImageDao;

    @Autowired
    Mem_MemberService memMemberService;

    @Autowired
    Bro_BroadcastService broBroadcastService;

    @Autowired
    Cli_ClipHistoryService cliClipHistoryService;

    @Autowired
    GsonUtil gsonUtil;

    /**
     * profile 리스트 조회
     */
    public String getMemberList(P_ImageProfileListInputVo pImageProfileListInputVo){
        //ProcedureVo procedureVo = new ProcedureVo(pImageProfileListInputVo);
        String result;
        try {
            int totalCnt = cusImageDao.callCustomerImageProfileListCnt(pImageProfileListInputVo);
            pImageProfileListInputVo.setTotalCnt(totalCnt);
            ArrayList<P_ImageProfileListOutputVo> memberList = cusImageDao.callCustomerImageProfileList(pImageProfileListInputVo);

            if(memberList != null && memberList.size() > 0) {
                result = gsonUtil.toJson(new JsonOutputVo(Status.조회, memberList, new PagingVo(pImageProfileListInputVo.getTotalCnt(), pImageProfileListInputVo.getPageStart(), pImageProfileListInputVo.getPageCnt())));
            }else {
                result = gsonUtil.toJson(new JsonOutputVo(Status.데이터없음, null, new PagingVo(pImageProfileListInputVo.getTotalCnt(), pImageProfileListInputVo.getPageStart(), pImageProfileListInputVo.getPageCnt())));
            }

        }catch (Exception e){
            e.printStackTrace();
            result = gsonUtil.toJson(new JsonOutputVo(Status.비즈니스로직오류));
        }

        return result;
    }

    /**
     * profile 이미지 초기화 조회
     */
    public String getMemberReset(P_MemberReportVo pMemberReportVo) throws GlobalException {
        try {
            //이미지 초기화
            P_MemberEditorVo pMemberEditorVo = new P_MemberEditorVo();
            pMemberEditorVo.setMem_no(pMemberReportVo.getMem_no());
            pMemberEditorVo.setProfileImage("");
            pMemberEditorVo.setSendNoti("2");
            pMemberEditorVo.setNotiSms("0");
            pMemberEditorVo.setMemSex(pMemberReportVo.getMem_sex());
            pMemberEditorVo.setNotiContents(pMemberReportVo.getNotiContents());
            pMemberEditorVo.setNotiMemo(pMemberReportVo.getNotimemo());

            String result = memMemberService.getMemberEditor(pMemberEditorVo);
            log.debug(result);

            // 방송방 수정 성공여부 확인
            JsonParser parser = new JsonParser();
            JsonElement element;
            element = parser.parse(result);
            String codeResult = element.getAsJsonObject().get("code").getAsString();

            if(Status.회원정보수정성공.getMessageCode().equals(codeResult)){
                //정지/경고 조치
                result = memMemberService.getMemberReport(pMemberReportVo);
                log.debug(result);

                result = gsonUtil.toJson(new JsonOutputVo(Status.이미지초기화성공));
                return result;
            } else {
                return gsonUtil.toJson(new JsonOutputVo(Status.회원정보수정실패));
            }

        }catch (Exception e){
            e.printStackTrace();
            throw new GlobalException(ErrorStatus.서버처리중오류);
        }
    }




    /**
     * broadcast 리스트 조회
     */
    public String getBroadcastList(P_ImageBroadcastListInputVo pImageBroadcastListInputVo){
        ProcedureVo procedureVo = new ProcedureVo(pImageBroadcastListInputVo);
        String result;
        try {
            int totalCnt = cusImageDao.callCustomerImageBroadcastListCnt(pImageBroadcastListInputVo);
            pImageBroadcastListInputVo.setTotalCnt(totalCnt);
            ArrayList<P_ImageBroadcastListOutputVo> memberList = cusImageDao.callCustomerImageBroadcastList(pImageBroadcastListInputVo);

            if(memberList != null && memberList.size() > 0) {
                result = gsonUtil.toJson(new JsonOutputVo(Status.조회, memberList, new PagingVo(pImageBroadcastListInputVo.getTotalCnt(), pImageBroadcastListInputVo.getPageStart(), pImageBroadcastListInputVo.getPageCnt())));
            }else {
                result = gsonUtil.toJson(new JsonOutputVo(Status.데이터없음, null, new PagingVo(pImageBroadcastListInputVo.getTotalCnt(), pImageBroadcastListInputVo.getPageStart(), pImageBroadcastListInputVo.getPageCnt())));
            }

        }catch (Exception e){
            e.printStackTrace();
            result = gsonUtil.toJson(new JsonOutputVo(Status.비즈니스로직오류));
        }

        return result;
    }

    /**
     * broadcast 이미지 초기화 조회
     */
    public String getBroadcastReset(P_MemberReportVo pMemberReportVo, String room_no) throws GlobalException {

        try {
            //배경 초기화
            P_BroadcastEditInputVo pBroadcastEditInputVo = new P_BroadcastEditInputVo();
            pBroadcastEditInputVo.setRoom_no(room_no);
            pBroadcastEditInputVo.setMem_no(pMemberReportVo.getMem_no());
            pBroadcastEditInputVo.setForceExit("0");
            int random = Integer.parseInt(DalbitUtil.randomBgValue());
            pBroadcastEditInputVo.setBackgroundImage(Code.포토_배경_디폴트_PREFIX.getCode() + "/" + Code.배경이미지_파일명_PREFIX.getCode() + "200708_" + random + ".jpg");

            String result = broBroadcastService.callBroadcastEdit(pBroadcastEditInputVo);
            log.debug(result);

            // 방송방 수정 성공여부 확인
            JsonParser parser = new JsonParser();
            JsonElement element;
            element = parser.parse(result);
            String codeResult = element.getAsJsonObject().get("code").getAsString();

            if(Status.방송방정보수정_성공.getMessageCode().equals(codeResult)) {
                //정지/경고 조치
                result = memMemberService.getMemberReport(pMemberReportVo);
                log.debug(result);

                result = gsonUtil.toJson(new JsonOutputVo(Status.이미지초기화성공));
                return result;
            } else if(Status.방송방정보수정_방번호없음.getMessageCode().equals(codeResult)) {
                return gsonUtil.toJson(new JsonOutputVo(Status.방송방정보수정_방번호없음));
            } else if(Status.방송방정보수정_종료된방.getMessageCode().equals(codeResult)) {
                return gsonUtil.toJson(new JsonOutputVo(Status.방송방정보수정_종료된방));
            } else {
                return gsonUtil.toJson(new JsonOutputVo(Status.방송방정보수정_에러));
            }
        }catch (Exception e){
            e.printStackTrace();
            throw new GlobalException(ErrorStatus.서버처리중오류);
        }
    }

    /**
     * clip image 리스트 조회
     */
    public String callClipList(ClipHistoryVo clipHistoryVo) {
        ProcedureVo procedureVo = new ProcedureVo(clipHistoryVo);
        String result;
        try {
            ArrayList<ClipHistoryVo> clipList = cusImageDao.callClipList(procedureVo);
            if(clipList != null && clipList.size() > 0) {
                result = gsonUtil.toJson(new JsonOutputVo(Status.조회, clipList, new PagingVo(procedureVo.getRet())));
            }else {
                result = gsonUtil.toJson(new JsonOutputVo(Status.데이터없음));
            }

        }catch (Exception e){
            e.printStackTrace();
            result = gsonUtil.toJson(new JsonOutputVo(Status.비즈니스로직오류));
        }

        return result;
    }

    /**
     * clip 이미지 초기화 조회
     */
    public String getClipReset(P_MemberReportVo pMemberReportVo, String cast_no) throws GlobalException {

        try {
            //클립 배경 초기화
            P_ClipHistoryDetailInfoEditVo pClipHistoryDetailInfoEditVo = new P_ClipHistoryDetailInfoEditVo();
            pClipHistoryDetailInfoEditVo.setCast_no(cast_no);
            pClipHistoryDetailInfoEditVo.setMemNo(pMemberReportVo.getMem_no());
            pClipHistoryDetailInfoEditVo.setEditSlct("1");
            pClipHistoryDetailInfoEditVo.setSendNoti("1");
            int random = Integer.parseInt(DalbitUtil.randomClipImgValue());
            pClipHistoryDetailInfoEditVo.setBackgroundImage("/clip_3/clipbg_200910_" + random + ".jpg");

            String result = cliClipHistoryService.callAdminClipInfoDetailEdit(pClipHistoryDetailInfoEditVo);
            log.debug(result);

            // 방송방 수정 성공여부 확인
            JsonParser parser = new JsonParser();
            JsonElement element;
            element = parser.parse(result);
            String codeResult = element.getAsJsonObject().get("code").getAsString();

            if(Status.클립상세수정_성공.getMessageCode().equals(codeResult)){
                return gsonUtil.toJson(new JsonOutputVo(Status.클립상세수정_성공));
            }else if(Status.클립상세수정_클립번호없음.getMessageCode().equals(codeResult)){
                return gsonUtil.toJson(new JsonOutputVo(Status.클립상세수정_클립번호없음));
            }else if(Status.클립상세수정_수정변화없음.getMessageCode().equals(codeResult)){
                return gsonUtil.toJson(new JsonOutputVo(Status.클립상세수정_수정변화없음));
            }else if(Status.클립상세수정_잘못된값.getMessageCode().equals(codeResult)){
                return gsonUtil.toJson(new JsonOutputVo(Status.클립상세수정_잘못된값));
            }else if(Status.클립상세수정_이미삭제.getMessageCode().equals(codeResult)){
                return gsonUtil.toJson(new JsonOutputVo(Status.클립상세수정_이미삭제));
            }else if(Status.클립상세수정_이미처리.getMessageCode().equals(codeResult)){
                return gsonUtil.toJson(new JsonOutputVo(Status.클립상세수정_이미처리));
            }else if(Status.클립상세수정_닉네임중복.getMessageCode().equals(codeResult)){
                return gsonUtil.toJson(new JsonOutputVo(Status.클립상세수정_닉네임중복));
            }else {
                return gsonUtil.toJson(new JsonOutputVo(Status.비즈니스로직오류));
            }
        }catch (Exception e){
            e.printStackTrace();
            throw new GlobalException(ErrorStatus.서버처리중오류);
        }
    }

    /**
     * notice image 리스트 조회
     */
    public String getNoticeHistory(P_MemberNoticeInputVo pMemberNoticeInputVo) {
        String result;
        try {
            int totalCnt = cusImageDao.getNoticeHistory_totalCnt(pMemberNoticeInputVo);
            pMemberNoticeInputVo.setTotalCnt(totalCnt);
            pMemberNoticeInputVo.setPageNo(pMemberNoticeInputVo.getPageNo() -1);
            pMemberNoticeInputVo.setPageNo(pMemberNoticeInputVo.getPageNo() * pMemberNoticeInputVo.getPageCnt());
            ArrayList<P_MemberNoticeOutputVo> noticeList = cusImageDao.getNoticeHistory(pMemberNoticeInputVo);
            if(noticeList.size() > 0 && noticeList !=null ) {
                result = gsonUtil.toJson(new JsonOutputVo(Status.공지보기성공, noticeList, new PagingVo(pMemberNoticeInputVo.getTotalCnt(), pMemberNoticeInputVo.getPageNo(), pMemberNoticeInputVo.getPageCnt())));
            } else {
                result = gsonUtil.toJson(new JsonOutputVo(Status.데이터없음, null, new PagingVo(pMemberNoticeInputVo.getTotalCnt(), pMemberNoticeInputVo.getPageNo(), pMemberNoticeInputVo.getPageCnt())));
            }
        } catch(Exception e) {
            result = gsonUtil.toJson(new JsonOutputVo(Status.비즈니스로직오류));
        }
        return result;
    }

    /**
     * notice image 삭제
     */
    public String deleteNoticeImg(MemberNoticeImgDeleteVo memberNoticeImgDeleteVo) {
        memberNoticeImgDeleteVo.setOp_name(MemberVo.getMyMemNo());
        String result="";

        if(!DalbitUtil.isEmpty(memberNoticeImgDeleteVo.getIdx())) {
            int state = cusImageDao.deleteNoticeImg(memberNoticeImgDeleteVo);
            if(state > 0) {
                result = gsonUtil.toJson(new JsonOutputVo(Status.삭제));
            } else {
                result = gsonUtil.toJson(new JsonOutputVo(Status.비즈니스로직오류));
            }
        }
        return result;
    }


    /**
     * 우체통 image 리스트 조회
     */
    public String getMailboxImgList(P_MailboxImgListVo pMailboxImgListVo) {
        ProcedureVo procedureVo = new ProcedureVo(pMailboxImgListVo);
        String result;
        try {
            ArrayList<P_MailboxImgListVo> list = cusImageDao.callMailboxImgList(procedureVo);
            P_MailboxImgListVo summary = new Gson().fromJson(procedureVo.getExt(), P_MailboxImgListVo.class);
            if(list != null && list.size() > 0) {
                result = gsonUtil.toJson(new JsonOutputVo(Status.조회, list, new PagingVo(procedureVo.getRet()), summary));
            }else {
                result = gsonUtil.toJson(new JsonOutputVo(Status.데이터없음));
            }

        }catch (Exception e){
            e.printStackTrace();
            result = gsonUtil.toJson(new JsonOutputVo(Status.비즈니스로직오류));
        }

        return result;
    }

}
