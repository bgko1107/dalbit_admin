package com.dalbit.clip.controller;

import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Slf4j
@Controller
@RequestMapping("/clip")
public class ClipController {

    @GetMapping("/category/list")
    public String categoryList() {
        return "clip/category/info";
    }

    @GetMapping("/history/list")
    public String historyList() {
        return "clip/history/info";
    }

    @GetMapping("/history/popup/clipPlayerPopup")
    public String clipPlayerPopup() {
        return "clip/popup/clipPlayerPopup";
    }

    @GetMapping("/history/popup/clipInfoPopup")
    public String clipInfoPopup() {
        return "clip/detail/info";
    }

    @GetMapping("/history/popup/clipCopyrightDetailPopup")
    public String clipPlayCntInfoPopup() {
        return "clip/popup/copyrightDetailPopup";
    }

    @GetMapping("/status/list")
    public String statusList() {
        return "clip/status/info";
    }

    @GetMapping("/status/popup/detail")
    public String statusDetailPopup() {
        return "clip/popup/statusDetailPopup";
    }

    @GetMapping("/category/recommendClip")
    public String recommendClip() {
        return "clip/category/recommendClip";
    }

    @GetMapping("/category/popup/clipList")
    public String clipList() {
        return "clip/category/popup/clipList";
    }
}
