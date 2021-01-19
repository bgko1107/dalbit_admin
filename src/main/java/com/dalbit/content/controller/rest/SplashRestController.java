package com.dalbit.content.controller.rest;

import com.dalbit.common.code.Status;
import com.dalbit.common.vo.JsonOutputVo;
import com.dalbit.common.vo.PagingVo;
import com.dalbit.content.vo.SplashVo;
import com.dalbit.util.DalbitUtil;
import com.dalbit.util.GsonUtil;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.servlet.http.HttpServletRequest;
import java.util.ArrayList;
import java.util.Date;

@Slf4j
@RestController
@RequestMapping("rest/content/splash")
public class SplashRestController {

    @Autowired
    GsonUtil gsonUtil;

    /**
     * 푸시 메시지
     */
    @PostMapping("list")
    public String list(HttpServletRequest request, SplashVo splashVo) {
        int totalCnt = 100;
        int startIdx = splashVo.getPageStart();

        ArrayList<SplashVo> list = new ArrayList<SplashVo>();
        for(int i = 0; i < splashVo.getPageCnt(); i++){
            SplashVo data = new SplashVo();
            data.setRowNum((totalCnt - startIdx));
            data.setSplash_col1(DalbitUtil.randomValue("number", 1));
            data.setSplash_col2(DalbitUtil.randomValue("number", 1));
            data.setSplash_col3("메시지 제목 이란다 ㅋㅋㅋㅋㅋ _" + data.getSplash_col1());
            data.setSplash_col4(new Date());
            data.setSplash_col5(DalbitUtil.randomValue("number", 1));
            data.setSplash_col6(new Date());
            data.setSplash_col7("YOOSIN");

            list.add(data);
            startIdx++;
        }

        return gsonUtil.toJson(new JsonOutputVo(Status.조회, list, new PagingVo(totalCnt)));
    }

}
