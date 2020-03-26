package com.dalbit.content.controller.rest;

import com.dalbit.common.code.Status;
import com.dalbit.common.vo.JsonOutputVo;
import com.dalbit.common.vo.PagingVo;
import com.dalbit.content.service.EventService;
import com.dalbit.content.vo.EventVo;
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
@RequestMapping("rest/content/event")
public class EventRestController {

    @Autowired
    EventService service;

    @Autowired
    GsonUtil gsonUtil;

    /**
     * 이벤트
     */
    @PostMapping("event")
    public String eventList(HttpServletRequest request, EventVo eventVo) {
        int totalCnt = 100;
        int startIdx = eventVo.getPageStart();

        ArrayList<EventVo> list = new ArrayList<EventVo>();
        for(int i = 0; i < eventVo.getPageCnt(); i++){
            EventVo data = new EventVo();
            data.setRowNum((totalCnt - startIdx));
            data.setEvent_col1(DalbitUtil.randomValue("number", 1));
            data.setEvent_col2(DalbitUtil.randomValue("number", 1));
            data.setEvent_col3("진행 제목 이란다 ㅋㅋㅋㅋㅋ _" + data.getEvent_col1());
            data.setEvent_col4(new Date());
            data.setEvent_col5(DalbitUtil.randomValue("number", 1));
            data.setEvent_col6(new Date());
            data.setEvent_col7("YOOSIN");

            list.add(data);
            startIdx++;
        }

        return gsonUtil.toJson(new JsonOutputVo(Status.조회, list, new PagingVo(totalCnt)));
    }


    @PostMapping("pastevent")
    public String pastEventsList(HttpServletRequest request, EventVo eventVo) {
        int totalCnt = 100;
        int startIdx = eventVo.getPageStart();

        ArrayList<EventVo> list = new ArrayList<EventVo>();
        for(int i = 0; i < eventVo.getPageCnt(); i++){
            EventVo data = new EventVo();
            data.setRowNum((totalCnt - startIdx));
            data.setEvent_col1(DalbitUtil.randomValue("number", 1));
            data.setEvent_col2(DalbitUtil.randomValue("number", 1));
            data.setEvent_col3("마감 이벤트 제목 이란다 ㅋㅋㅋㅋㅋ _" + data.getEvent_col1());
            data.setEvent_col4(new Date());
            data.setEvent_col5(DalbitUtil.randomValue("number", 1));
            data.setEvent_col6(new Date());
            data.setEvent_col7("YOOSIN");

            list.add(data);
            startIdx++;
        }

        return gsonUtil.toJson(new JsonOutputVo(Status.조회, list, new PagingVo(totalCnt)));
    }


    @PostMapping("reportstatistics")
    public String statisticsList(HttpServletRequest request, EventVo eventVo) {
        int totalCnt = 100;
        int startIdx = eventVo.getPageStart();

        ArrayList<EventVo> list = new ArrayList<EventVo>();

        EventVo data = new EventVo();
        data.setRowNum((totalCnt - startIdx));
        data.setEvent_col1(DalbitUtil.randomValue("number", 1));
        data.setEvent_col2(DalbitUtil.randomValue("number", 1));
        data.setEvent_col3(DalbitUtil.randomValue("number", 1));
        data.setEvent_col5(DalbitUtil.randomValue("number", 1));
        data.setEvent_col7(DalbitUtil.randomValue("number", 1));

        list.add(data);

        return gsonUtil.toJson(new JsonOutputVo(Status.조회, list, new PagingVo(totalCnt)));
    }



    @PostMapping("report")
    public String reportList(HttpServletRequest request, EventVo eventVo) {
        int totalCnt = 100;
        int startIdx = eventVo.getPageStart();

        ArrayList<EventVo> list = new ArrayList<EventVo>();
        for(int i = 0; i < totalCnt; i++){
            EventVo data = new EventVo();
            data.setRowNum((totalCnt - startIdx));
            data.setEvent_col1(DalbitUtil.randomValue("number", 1));
            data.setEvent_col2(DalbitUtil.randomValue("number", 1));
            data.setEvent_col3("응모자/담청자 이란다 ㅋㅋㅋㅋㅋ _" + data.getEvent_col1());
            data.setEvent_col4(new Date());
            data.setEvent_col5(DalbitUtil.randomValue("number", 1));
            data.setEvent_col6(new Date());
            data.setEvent_col7("YOOSIN");

            list.add(data);
            startIdx++;
        }

        ArrayList<EventVo> summaryList = new ArrayList<EventVo>();

        EventVo data = new EventVo();
        data.setRowNum((totalCnt - startIdx));
        data.setEvent_col1(DalbitUtil.randomValue("number", 1));
        data.setEvent_col2(DalbitUtil.randomValue("number", 1));
        data.setEvent_col3(DalbitUtil.randomValue("number", 1));
        data.setEvent_col5(DalbitUtil.randomValue("number", 1));
        data.setEvent_col7(DalbitUtil.randomValue("number", 1));

        summaryList.add(data);

        return gsonUtil.toJson(new JsonOutputVo(Status.조회, list, new PagingVo(totalCnt), summaryList));

    }


}
