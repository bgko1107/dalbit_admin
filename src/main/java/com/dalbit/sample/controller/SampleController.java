package com.dalbit.sample.controller;

import com.dalbit.broadcast.service.Bro_BroadcastService;
import com.dalbit.sample.service.SampleService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;

@Slf4j
@Controller
@RequestMapping("sample")
public class SampleController {

    @Autowired
    SampleService sampleService;

    @Autowired
    Bro_BroadcastService bro_broadcastService;

    @GetMapping("list")
    public String list(Model model){
        return "sample/list";
    }

    @GetMapping("select")
    public String select(Model model){
        return "sample/select";
    }

    @GetMapping("select_date")
    public String select_date(Model model){
        return "sample/select_date";
    }

    @GetMapping("select_date_edit")
    public String select_date_edit(Model model){
        return "sample/select_date_edit";
    }
    @GetMapping("broadcast")
    public String broadcast(Model model){return "sample/broadcast";}

    @GetMapping("index")
    public String index(Model model){
        return "sample/index";
    }

    @GetMapping("detail")
    public String detail(){
        return "sample/detail";
    }

    @GetMapping("detail2")
    public String detail2(){
        return "sample/detail2";
    }

    @GetMapping("recommend")
    public String recommend(){ return "sample/recommend";}

    @GetMapping("excel")
    public String init(){
        return "sample/excel";
    }

    @GetMapping("chart")
    public String chart(){
        return "sample/chart";
    }

    @GetMapping("editor")
    public String editor(){
        return "sample/editor";
    }

    @GetMapping("layer")
    public String layer(){
        return "sample/layer";
    }

    @GetMapping("function")
    public String function(){
        return "sample/function";
    }

    @GetMapping("datepicker")
    public String datepicker(){
        return "sample/datepicker";
    }

    @GetMapping("inforexAdminLogin")
    public String inforexAdminLogin(){ return "sample/inforexAdminLogin";}

    @GetMapping("inforexAdminMenu")
    public String inforexAdminMenu(){ return "sample/inforexAdminMenu";}

    @GetMapping("inforexPosCodeList")
    public String inforexPosCodeList(){ return "sample/inforexPosCodeList";}

    @GetMapping("confirmError")
    public String confirmError(){return "sample/confirmError";}

    @GetMapping("tree")
    public String tree(){return "sample/tree";}


    @GetMapping("push")
    public String push(){return "sample/push";}

    @GetMapping("player")
    public String player(HttpServletRequest request){
        bro_broadcastService.callBroadcastSimpleInfo(request);
        return "sample/player_ant";
    }

    @GetMapping("excelUpload")
    public String excelUpload(){return "sample/excelUpload";}


    @GetMapping("wowza/player")
    public String wowzaPlayer(HttpServletRequest request){
        bro_broadcastService.callBroadcastWowzaSimpleInfo(request);
        return "sample/player_wowza";
    }

}
