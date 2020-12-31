package com.dalbit.customer.controller.rest;

import com.dalbit.clip.vo.ClipHistoryVo;
import com.dalbit.customer.service.Cus_ImageService;
import com.dalbit.customer.vo.procedure.P_ImageBroadcastListInputVo;
import com.dalbit.customer.vo.procedure.P_ImageProfileListInputVo;
import com.dalbit.exception.GlobalException;
import com.dalbit.member.vo.MemberNoticeImgDeleteVo;
import com.dalbit.member.vo.procedure.P_MailboxImgListVo;
import com.dalbit.member.vo.procedure.P_MemberNoticeInputVo;
import com.dalbit.member.vo.procedure.P_MemberReportVo;
import com.dalbit.util.DalbitUtil;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.servlet.http.HttpServletRequest;

@Slf4j
@RestController
@RequestMapping("rest/customer/image")
public class Cus_ImageRestController {

    @Autowired
    Cus_ImageService cusImageService;

    /**
     * profile image 리스트 조회
     */
    @PostMapping("/profile/list")
    public String getProfileList(P_ImageProfileListInputVo pImageProfileListInputVo, HttpServletRequest request) {
         String result = cusImageService.getMemberList(pImageProfileListInputVo);
        return result;
    }

    /**
     * profile image 초기화 및 신고
     */
    @PostMapping("/reset")
    public String reportProfile(P_MemberReportVo pMemberReportVo, HttpServletRequest request) throws GlobalException {
        pMemberReportVo.setIp(DalbitUtil.getIp(request));
        pMemberReportVo.setBrowser(DalbitUtil.getUserAgent(request));

        String room_no = request.getParameter("room_no");
        String cast_no = request.getParameter("cast_no");

        String result;
        if(room_no != null && !room_no.equals("")){ // 배경이미지 초기화
            result = cusImageService.getBroadcastReset(pMemberReportVo, room_no);
        } else if(cast_no != null && !cast_no.equals("")) {   // 클립이미지 초기화
            result = cusImageService.getClipReset(pMemberReportVo, cast_no);
        } else {    // 프로필 이미지 초기화
            result = cusImageService.getMemberReset(pMemberReportVo);
        }



        return result;
    }

    /**
     * broadcast image 리스트 조회
     */
    @PostMapping("/broadcast/list")
    public String getBroadcastList(P_ImageBroadcastListInputVo pImageBroadcastListInputVo) {
        String result = cusImageService.getBroadcastList(pImageBroadcastListInputVo);
        return result;
    }

    /**
     * clip image 리스트 조회
     */
    @PostMapping("/clip/list")
    public String callClipList(ClipHistoryVo clipHistoryVo) {
        String result = cusImageService.callClipList(clipHistoryVo);
        return result;
    }

    /**
     * notice image 리스트 조회
     */
    @PostMapping("/notice/list")
    public String getNoticeHistory(P_MemberNoticeInputVo pMemberNoticeInputVo) {
        String result = cusImageService.getNoticeHistory(pMemberNoticeInputVo);
        return result;
    }

    /**
     * notice image 삭제
     */
    @PostMapping("/notice/imgDelete")
    public String getNoticeImgDelete(MemberNoticeImgDeleteVo memberNoticeImgDeleteVo) {
        String result = cusImageService.deleteNoticeImg(memberNoticeImgDeleteVo);
        return result;
    }

    /**
     * notice image 리스트 조회
     */
    @PostMapping("/mailbox/list")
    public String getMailboxImgList(P_MailboxImgListVo pMailboxImgListVo) {
        String result = cusImageService.getMailboxImgList(pMailboxImgListVo);
        return result;
    }
}
