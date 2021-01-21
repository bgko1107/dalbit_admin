package com.dalbit.status.controller.rest;

import com.dalbit.status.service.Sta_MailboxService;
import com.dalbit.status.vo.procedure.P_StatVo;
import com.dalbit.util.DalbitUtil;
import com.dalbit.util.GsonUtil;
import com.dalbit.util.MessageUtil;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@Slf4j
@RestController
@RequestMapping("rest/status/mailbox")
public class Sta_MailboxRestController {

    @Autowired
    GsonUtil gsonUtil;

    @Autowired
    MessageUtil messageUtil;

    @Autowired
    Sta_MailboxService sta_MailboxService;

    /**
     * 1:1문의 총계
     * @param pStatVo
     * @return
     */
    @PostMapping("time")
    public String time(P_StatVo pStatVo){
        if(DalbitUtil.isEmpty(pStatVo.getStartDate())){
            pStatVo.setStartDate(null);
        }
        if(DalbitUtil.isEmpty(pStatVo.getEndDate())){
            pStatVo.setEndDate(null);
        }
        String result = sta_MailboxService.callMailboxTime(pStatVo);
        return result;
    }
}
