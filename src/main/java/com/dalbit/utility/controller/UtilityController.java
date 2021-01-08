package com.dalbit.utility.controller;

import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Slf4j
@Controller
@RequestMapping("utility")
public class UtilityController {

    @GetMapping("imageServerUploader")
    public String imageServerUpload() {
        return "utility/imageServerUploader";
    }

    @GetMapping("imageServerBuild")
    public String imageServerBuild() {
        return "utility/imageServerBuild";
    }
}
