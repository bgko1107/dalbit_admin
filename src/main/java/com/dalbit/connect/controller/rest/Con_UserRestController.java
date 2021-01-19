package com.dalbit.connect.controller.rest;

import com.dalbit.connect.service.Con_UserService;
import com.dalbit.connect.vo.procedure.P_UserCurrentInputVo;
import com.dalbit.util.GsonUtil;
import com.dalbit.util.MessageUtil;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@Slf4j
@RestController
@RequestMapping("rest/connect/user")
public class Con_UserRestController {

    @Autowired
    GsonUtil gsonUtil;

    @Autowired
    MessageUtil messageUtil;

    @Autowired
    Con_UserService con_UserService;

    @PostMapping("info/total")
    public String total(P_UserCurrentInputVo pUserCurrentInputVo){
        String result = con_UserService.callUserTotal(pUserCurrentInputVo);
        return result;
    }
    @PostMapping("info/current")
    public String currentUser(P_UserCurrentInputVo pUserCurrentInputVo){
        String result = con_UserService.callUserCurrentUser(pUserCurrentInputVo);
        return result;
    }
}
