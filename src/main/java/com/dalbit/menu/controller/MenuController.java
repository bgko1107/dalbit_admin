package com.dalbit.menu.controller;

import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Slf4j
@Controller
@RequestMapping("menu")
public class MenuController {

    @RequestMapping("/best/list")
    public String bestList(){
        return "menu/best/list";
    }

    @RequestMapping("/live/list")
    public String liveList(){
        return "menu/live/list";
    }

    @RequestMapping("/rank/djRankList")
    public String djRankList(){
        return "menu/rank/rankList";
    }

    @RequestMapping("/rank/fanRankList")
    public String fanRankList(){
        return "menu/rank/fanRankList";
    }

    @RequestMapping("/rank/addDjPoint")
    public String addDjPoint(){
        return "menu/rank/addDjPoint";
    }

    @RequestMapping("/rank/goodRank")
    public String goodRank(){
        return "menu/rank/goodRank";
    }

    @RequestMapping("/special/list")
    public String specialList(){
        return "menu/special/list";
    }

    @RequestMapping("/shining/list")
    public String shiningList(){
        return "menu/shining/list";
    }

    @RequestMapping("/rank/awardsVote")
    public String awardsVote(){
        return "menu/rank/awardsVote";
    }

    @RequestMapping("/rank/awardsVoteMember")
    public String awardsVoteMember(){
        return "menu/rank/awardsVoteMember";
    }

    @RequestMapping("/rank/awardsDj")
    public String awardsDj(){
        return "menu/rank/awardsDj";
    }

    @RequestMapping("/rank/awardsFan")
    public String awardsFan(){
        return "menu/rank/awardsFan";
    }

    @RequestMapping("/rank/popup/voteDetail")
    public String voteDetail(){
        return "menu/rank/popup/voteDetail";
    }

    @RequestMapping("/recomm/list")
    public String recommList(){
        return "menu/recomm/list";
    }

}
