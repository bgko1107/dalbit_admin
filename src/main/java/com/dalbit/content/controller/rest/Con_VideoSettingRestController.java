package com.dalbit.content.controller.rest;

import com.dalbit.content.service.Con_VideoSettingService;
import com.dalbit.content.vo.procedure.P_VideoSettingDetailVo;
import com.dalbit.content.vo.procedure.P_VideoSettingEditVo;
import com.dalbit.content.vo.procedure.P_bannerDetailInputVo;
import com.dalbit.util.GsonUtil;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@Slf4j
@RestController
@RequestMapping("rest/content/video/setting")
public class Con_VideoSettingRestController {

    @Autowired
    Con_VideoSettingService con_videoSettingService;

    @Autowired
    GsonUtil gsonUtil;


    /**
     * 영상대화 차감세팅 리스트
     */
    @PostMapping("list")
    public String videoSettingList() {
        String result = con_videoSettingService.callVideoSettingList();
        return result;
    }

    /**
     * 세팅 수정 내역
     */
    @PostMapping("detail")
    public String videoSettingDetail(P_VideoSettingDetailVo pVideoSettingDetailVo) {
        String result = con_videoSettingService.callVideoSettingDetail(pVideoSettingDetailVo);
        return result;
    }

    /**
     * 수정하기
     */
    @PostMapping("edit")
    public String videoSettingEdit(P_VideoSettingEditVo pVideoSettingEditVo) {
        String result = con_videoSettingService.callVideoSettingEdit(pVideoSettingEditVo);
        return result;
    }

}
