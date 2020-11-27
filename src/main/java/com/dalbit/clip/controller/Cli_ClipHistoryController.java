package com.dalbit.clip.controller;

import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Slf4j
@Controller
@RequestMapping("/clip/history")
public class Cli_ClipHistoryController {

    @GetMapping("/list")
    public String list() {
        return "clip/history/info";
    }

    @GetMapping("/popup/clipPlayerPopup")
    public String clipPlayerPopup() {
        return "clip/popup/clipPlayerPopup";
    }

    @GetMapping("/popup/clipInfoPopup")
    public String clipInfoPopup() {
        return "clip/detail/info";
    }

    @GetMapping("/popup/clipCopyrightDetailPopup")
    public String clipPlayCntInfoPopup() {
        return "clip/popup/copyrightDetailPopup";
    }
}
