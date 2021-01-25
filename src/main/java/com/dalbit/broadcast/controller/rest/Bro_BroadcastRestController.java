package com.dalbit.broadcast.controller.rest;


import com.dalbit.broadcast.service.Bro_BroadcastService;
import com.dalbit.broadcast.vo.procedure.*;
import com.dalbit.common.code.Code;
import com.dalbit.common.code.Status;
import com.dalbit.common.vo.JsonOutputVo;
import com.dalbit.excel.service.ExcelService;
import com.dalbit.exception.GlobalException;
import com.dalbit.util.DalbitUtil;
import com.dalbit.util.GsonUtil;
import org.springframework.ui.Model;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@Slf4j
@RestController
@RequestMapping("rest/broadcast/broadcast")
public class Bro_BroadcastRestController {

    @Autowired
    Bro_BroadcastService bro_BroadcastService;
    @Autowired
    GsonUtil gsonUtil;
    @Autowired
    ExcelService excelService;

    /**
     * 생방송 목록
     * //@param model
     * @return
     */
    @PostMapping("list")
    public String list(P_BroadcastListInputVo pBroadcastListInputVo){
        return bro_BroadcastService.callBroadcastList(pBroadcastListInputVo);
    }

    /**
     * 실시간 최신 생방송 엑셀
     */
    @PostMapping("liveListExcel")
    public String liveListExcel(HttpServletRequest request, HttpServletResponse response, Model model, P_BroadcastListInputVo pBroadcastListInputVo) throws GlobalException {
        Model resultModel = bro_BroadcastService.callLiveListExcel(pBroadcastListInputVo, model);
        excelService.renderMergedOutputModel(resultModel.asMap(), request, response);

        return gsonUtil.toJson(new JsonOutputVo(Status.엑셀다운로드성공));
    }

    /**
     * 생방송 검색 엑셀
     */
    @PostMapping("broadcastListExcel")
    public String broadcastListExcel(HttpServletRequest request, HttpServletResponse response, Model model, P_BroadcastListInputVo pBroadcastListInputVo) throws GlobalException {
        Model resultModel = bro_BroadcastService.callBroadcastListExcel(pBroadcastListInputVo, model);
        excelService.renderMergedOutputModel(resultModel.asMap(), request, response);

        return gsonUtil.toJson(new JsonOutputVo(Status.엑셀다운로드성공));
    }

    /**
     * 방송방 상세보기
     */
    @PostMapping("info")
    public String info(P_BroadcastDetailInputVo pBroadcastDetailInputVo){
        return bro_BroadcastService.callBroadcastInfo(pBroadcastDetailInputVo);
    }

    /**
     * 방송방 정보수정 내역 보기
     */
    @PostMapping("editHist")
    public String editHist(P_BroadcastEditHistInputVo pBroadcastEditHistInputVo) {
        return bro_BroadcastService.callBroadcastEditHistory(pBroadcastEditHistInputVo);
    }

    /**
     * 방송방 정보수정
     */
    @PostMapping("edit")
    public String edit(P_BroadcastEditInputVo pBroadcastEditInputVo) {

        if(pBroadcastEditInputVo.getBackgroundImage().equals("backImageDel")) {
             int random = Integer.parseInt(DalbitUtil.randomBgValue());
             pBroadcastEditInputVo.setBackgroundImage(Code.포토_배경_디폴트_PREFIX.getCode() + "/" + Code.배경이미지_파일명_PREFIX.getCode() + "200708_" + random + ".jpg");
        }
        return bro_BroadcastService.callBroadcastEdit(pBroadcastEditInputVo);
    }


    /**
     * 방송방 플레이어 채팅 조회
     */
    @PostMapping("chat")
    public String liveChar(P_ChatListInputVo pChatListInputVo) {
        return bro_BroadcastService.callBroadcastLiveChatInfo(pChatListInputVo);
    }


    /**
     * 생방송 청취자 목록
     * //@param model
     * @return
     */
    @PostMapping("live/listener/list")
    public String liveListenerList(P_BroadcastListInputVo pBroadcastListInputVo){
        return bro_BroadcastService.callLiveListenerList(pBroadcastListInputVo);
    }

    /**
     * 실시간/종료 게스트
     * //@param model
     * @return
     */
    @PostMapping("live/guest/list")
    public String liveGuestList(P_BroadcastListInputVo pBroadcastListInputVo){
        return bro_BroadcastService.callLiveGuestList(pBroadcastListInputVo);
    }


    @PostMapping("tabCount")
    public String tabCount(P_BroadcastListInputVo pBroadcastListInputVo){
        return bro_BroadcastService.callLiveTabCount(pBroadcastListInputVo);
    }

    /**
     * 생방송 비디오 목록
     * //@param model
     * @return
     */
    @PostMapping("video/list")
    public String videoList(P_BroadcastListInputVo pBroadcastListInputVo){
        return bro_BroadcastService.callBroadcastVideoList(pBroadcastListInputVo);
    }

}
