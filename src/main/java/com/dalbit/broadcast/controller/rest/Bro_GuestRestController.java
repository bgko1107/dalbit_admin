package com.dalbit.broadcast.controller.rest;


import com.dalbit.broadcast.service.Bro_GuestService;
import com.dalbit.broadcast.vo.procedure.P_GuestListInputVo;
import com.dalbit.util.GsonUtil;
import com.fasterxml.jackson.core.JsonProcessingException;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@Slf4j
@RestController
@RequestMapping("rest/broadcast/guest")
public class Bro_GuestRestController {

    @Autowired
    Bro_GuestService broGuestService;
    @Autowired
    GsonUtil gsonUtil;

    /**
     * 방송방 게스트 리스트
     * //@param model
     * @return
     */
    @PostMapping("list")
    public String list(P_GuestListInputVo p_guestListInputVo){
        return broGuestService.getGuestList(p_guestListInputVo);
    }

    @PostMapping("pro/list")
    public String getProposeList(P_GuestListInputVo p_guestListInputVo){
        return broGuestService.getProposeList(p_guestListInputVo);
    }

    /*게스트 종료 호출*/
    @PostMapping("out")
    public String callGuestOut(P_GuestListInputVo p_guestListInputVo) throws JsonProcessingException {
        return broGuestService.callGuestOut(p_guestListInputVo);
    }

}
