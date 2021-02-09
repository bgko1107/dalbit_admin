package com.dalbit.broadcast.controller;

import com.dalbit.broadcast.service.Bro_BroadcastService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;

@Slf4j
@Controller
@RequestMapping("/broadcast")
public class BroadcastController {

    @Autowired
    Bro_BroadcastService bro_broadcastService;

    @Value("${admin.player.type}")
    String playerType;

    /**
     * 청취자 행위 유도 메시지 조회
     */
    @GetMapping("/behavior/list")
    public String behaviorList(Model model) {
        return "broadcast/behavior/list";
    }

    /**
     * 생방송 목록
     * @param model
     * @return
     */
    @GetMapping("/broadcast/list")
    public String broadcastList(Model model) {
        return "broadcast/broadcast/list";
    }

    @RequestMapping("/broadcast/popup/broadcastPopup")
    public String broadcastPopup(Model model) { return "broadcast/broadcast/popup/broadcastPopup"; }

    @RequestMapping("/broadcast/popup/playerPopup")
    public String playerPopup(HttpServletRequest request) {
        if(playerType.equals("wowza")){
            bro_broadcastService.callBroadcastWowzaSimpleInfo(request);
            return "broadcast/broadcast/popup/playerPopup_wowza";
        }else{
            bro_broadcastService.callBroadcastSimpleInfo(request);
            return "broadcast/broadcast/popup/playerPopup";
        }
    }

    @RequestMapping("/broadcast/popup/videoPlayerPopup")
    public String videoPlayerPopup(HttpServletRequest request) {
        if(playerType.equals("wowza")){
            bro_broadcastService.callBroadcastWowzaSimpleInfo(request);
            return "broadcast/broadcast/popup/playerPopup_wowza_video";
        }else{
            bro_broadcastService.callBroadcastSimpleInfo(request);
            return "broadcast/broadcast/popup/playerPopup";
        }
    }

    /**
     * 생방송 목록
     * @param model
     * @return
     */
    @GetMapping("/live/list")
    public String list(Model model) {
        return "broadcast/live/list";
    }

    @RequestMapping("/live/popup/storyPopup")
    public String storyPopup(Model model) { return "broadcast/live/popup/storyPopup"; }

    @RequestMapping("/live/popup/noticeSendPopup")
    public String noticeSendPopup(Model model) { return "broadcast/live/popup/noticeSendPopup"; }

    @GetMapping("/live/popup/cctv")
    public String livePopupCctv(Model model) {
        return "broadcast/live/popup/cctv";
    }

}
