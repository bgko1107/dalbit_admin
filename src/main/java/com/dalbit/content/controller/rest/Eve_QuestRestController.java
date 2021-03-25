package com.dalbit.content.controller.rest;

import com.dalbit.content.service.Eve_QuestService;
import com.dalbit.content.vo.QuestVo;
import com.dalbit.util.GsonUtil;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@Slf4j
@RestController
@RequestMapping("rest/content/event/quest")
public class Eve_QuestRestController {

    @Autowired
    GsonUtil gsonUtil;

    @Autowired
    Eve_QuestService eve_QuestService;

    /**
     * 퀘스트 이벤트 목록
     */
    @PostMapping("list")
    public String list(QuestVo questVo) {
        String result = eve_QuestService.callList(questVo);
        return result;
    }

    /**
     * 퀘스트 이벤트 상세 정보
     */
    @PostMapping("detail")
    public String detail(QuestVo questVo) {
        String result = eve_QuestService.callDetail(questVo);
        return result;
    }

    /**
     * 퀘스트 이벤트 상세 정보 수정
     */
    @PostMapping("edit")
    public String edit(QuestVo questVo) {
        String result = eve_QuestService.callEdit(questVo);
        return result;
    }

    /**
     * 퀘스트 이벤트 상세 정보 삭제
     */
    @PostMapping("delete")
    public String delete(QuestVo questVo) {
        String result = eve_QuestService.callDelete(questVo);
        return result;
    }

    /**
     * 퀘스트 이벤트 참여자 목록
     */
    @PostMapping("member")
    public String member(QuestVo questVo) {
        String result = eve_QuestService.callMember(questVo);
        return result;
    }

}
