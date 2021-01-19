package com.dalbit.utility.controller.rest;

import com.dalbit.common.code.Status;
import com.dalbit.common.vo.JsonOutputVo;
import com.dalbit.util.GsonUtil;
import com.dalbit.util.JenkinsUtil;
import com.jcraft.jsch.JSch;
import com.jcraft.jsch.JSchException;
import com.jcraft.jsch.Session;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.HashMap;

@Slf4j
@RestController
@RequestMapping("/rest/utility")
public class UtilityRestController {

    @Autowired
    JenkinsUtil jenkinsUtil;

    @Autowired
    GsonUtil gsonUtil;

    @PostMapping("imageServerBuild")
    public String imageServerBuild() {

        jenkinsUtil.imageBuild();

        HashMap map = jenkinsUtil.imageBuild();

        return gsonUtil.toJson(new JsonOutputVo(Status.조회, map));
    }

    @GetMapping("/imageServer/upload")
    public String imageServerUpload() throws JSchException {

        JSch jsch = new JSch();
        jsch.setKnownHosts("C:\\Users\\USER\\.ssh\\known_hosts");
        Session jschSession = jsch.getSession("dalimg", "125.141.223.157");
        jschSession.setPassword("달달한이미지((99");

        java.util.Properties config = new java.util.Properties();
        config.put("StrictHostKeyChecking", "no");
        jschSession.setConfig(config);

        jschSession.connect();
        //return (ChannelSftp) jschSession.openChannel("sftp");

        return "";
    }

}
