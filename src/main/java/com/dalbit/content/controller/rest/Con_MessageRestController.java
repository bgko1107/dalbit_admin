package com.dalbit.content.controller.rest;

import com.dalbit.content.service.Con_MessageService;
import com.dalbit.content.vo.procedure.P_MessageDetailInputVo;
import com.dalbit.content.vo.procedure.P_MessageInsertVo;
import com.dalbit.content.vo.procedure.P_MessageListInputVo;
import com.dalbit.exception.GlobalException;
import com.dalbit.util.GsonUtil;
import com.dalbit.util.MessageUtil;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@Slf4j
@RestController
@RequestMapping("rest/content/message")
public class Con_MessageRestController {

    @Autowired
    Con_MessageService con_MessageService;

    @Autowired
    GsonUtil gsonUtil;

    @Autowired
    MessageUtil messageUtil;

    /**
     * Message 보기
     */
    @PostMapping("list")
    public String list(P_MessageListInputVo pMessageListInputVo) {
        String result = con_MessageService.callContentsMessageList(pMessageListInputVo);
        return result;
    }

    /**
     * Message 조회
     */
    @PostMapping("detail")
    public String detail(P_MessageDetailInputVo pMessageDetailInputVo) {
        String result = con_MessageService.callContentsMessageDetail(pMessageDetailInputVo);
        return result;
    }

    /**
     * Message 등록
     */
    @PostMapping("insert")
    public String insert(P_MessageInsertVo pMessageInsertVo) throws GlobalException {
        String result = con_MessageService.callContentsMessageAdd(pMessageInsertVo);
        return result;
    }

}
