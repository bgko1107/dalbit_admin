package com.dalbit.content.controller;

import com.dalbit.common.code.Status;
import com.dalbit.common.vo.JsonOutputVo;
import com.dalbit.content.service.AppService;
import com.dalbit.content.service.IosAppService;
import com.dalbit.util.GsonUtil;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;

@Slf4j
@Controller
@RequestMapping("/content")
public class ContentController {

    @Autowired
    AppService appService;

    @Autowired
    IosAppService iosAppService;

    @Autowired
    GsonUtil gsonUtil;

    @GetMapping("/app/list")
    public String appList() {
        return "content/app/list";
    }

    @GetMapping("/banner/list")
    public String bannerList() {
        return "content/banner/list";
    }

    @GetMapping("/boardAdm/list")
    public String boardAdmList() {
        return "content/boardAdm/list";
    }

    @GetMapping("/boardAdm/popup/editList")
    public String editList() {
        return "content/boardAdm/popup/editList";
    }

    @GetMapping("/broadCastTip/list")
    public String broadCastTipList() {
        return "content/broadCastTip/list";
    }

    @GetMapping("/crew/list")
    public String crewList() {
        return "content/crew/list";
    }

    @GetMapping("/emoticon/list")
    public String emoticonList() {
        return "content/emoticon/list";
    }

    @RequestMapping("/emoticon/popup/category/list")
    public String emoticonPopup() {
        return "content/emoticon/popup/categoryList";
    }

    @GetMapping("/event/management/list")
    public String eventManagementlist() {
        return "content/event/management/list";
    }

    @GetMapping("/event/attendance/list")
    public String attendanceList() {
        return "content/event/attendance/list";
    }

    @GetMapping("/event/attendance/calendar")
    public String attendanceCalendar() {
        return "content/event/attendance/calendar";
    }

    @GetMapping("/event/attendance/bonusList")
    public String attendanceBonusList() {
        return "content/event/attendance/bonusList";
    }

    @GetMapping("/event/attendance/giftconList")
    public String attendanceGiftconList() {
        return "content/event/attendance/giftconList";
    }

    @GetMapping("/event/photo/shot/list")
    public String photoShotList(){
        return "content/event/shot/list";
    }

    @GetMapping("/event/knowhow/list")
    public String knowhowList(){
        return "content/event/knowhow/list";
    }

    @GetMapping("/event/member/list")
    public String memberList(){
        return "content/event/member/list";
    }

    @GetMapping("/event/chuseok/freeDalList")
    public String freeDalList(){
        return "content/event/chuseok/freeDalList";
    }

    @GetMapping("/event/chuseok/purchaseList")
    public String purchaseList(){
        return "content/event/chuseok/purchaseList";
    }

    @GetMapping("/event/roulette/list")
    public String rouletteList() {
        return "content/event/roulette/list";
    }

    @GetMapping("/event/roulette/calendar")
    public String rouletteCalendar() {
        return "content/event/roulette/calendar";
    }

    @GetMapping("/event/roulette/bonusList")
    public String rouletteBonusList() {
        return "content/event/roulette/bonusList";
    }

    @GetMapping("/event/roulette/giftManage")
    public String rouletteGiftconList() {
        return "content/event/roulette/giftManage";
    }

    @GetMapping("/event/time/timeList")
    public String timeEventList() {
        return "content/event/time/timeList";
    }

    @GetMapping("/message/list")
    public String messageList() {
        return "content/message/list";
    }

    @RequestMapping("/message/popup/messagePopup")
    public String messagePopup(Model model) { return "content/message/popup/messagePopup"; }

    @GetMapping("/ios/list")
    public String iosList() {
        return "content/ios/list";
    }

    @GetMapping("/push/list")
    public String list() {
        return "content/push/list";
    }

    @GetMapping("/ios/version")
    @ResponseBody
    public String iosVersion(){
        HashMap result = iosAppService.getVersion();
        return gsonUtil.toJson(new JsonOutputVo((Status) result.get("status"), result.get("data")));
    }

    @GetMapping("/ios/app")
    @ResponseBody
    public String iosApp(HttpServletRequest request){
        HashMap result = iosAppService.getApp(request);
        return gsonUtil.toJson(new JsonOutputVo((Status) result.get("status"), result.get("data")));
    }

    @PostMapping("/ios")
    @ResponseBody
    public String iosInsert(HttpServletRequest request){
        return gsonUtil.toJson(new JsonOutputVo(iosAppService.doInsert(request)));
    }

    @DeleteMapping("/ios")
    @ResponseBody
    public String iosDelete(HttpServletRequest request){
        return gsonUtil.toJson(new JsonOutputVo(iosAppService.doDelete(request)));
    }

    @GetMapping("/item/list")
    public String itemList() {
        return "content/item/list";
    }

    @GetMapping("/item/popup/itemOrder")
    public String itemOrder() {
        return "content/item/popup/itemOrder";
    }

    @GetMapping("/notice/list")
    public String noticeList() {
        return "content/notice/list";
    }

    @GetMapping("/notice/noticeDetail")
    public String noticeDetail() {
        return "content/notice/noticeDetail";
    }

    @GetMapping("/notice/noticeEdit")
    public String noticeEdit() {
        return "content/notice/noticeEdit";
    }
    @GetMapping("/siteban/list")
    public String sitebanList() {
        return "content/siteban/list";
    }

    @GetMapping("/splash/list")
    public String splashList() {
        return "content/splash/list";
    }

    @GetMapping("/theme/list")
    public String themeList() {
        return "content/theme/list";
    }

    @GetMapping("/marketing/info")
    public String info() {
        return "content/marketing/info";
    }

    @GetMapping("/fullmoon/list")
    public String fullmoonList() {return "content/fullmoon/list";}

    @GetMapping("/newvilevel/info")
    public String newvilevelInfo() {return "content/newvilevel/info";}

    @GetMapping("/fanrank/onOffList")
    public String fanrankOnOffList() {return "content/fanrank/onOffList";}
}
