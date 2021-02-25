package com.dalbit.content.controller.rest;

import com.dalbit.content.service.Con_NewcomerService;
import com.dalbit.content.vo.NewcomerVo;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@Slf4j
@RestController
@RequestMapping("/rest/content/newcomer")
public class Con_NewcomerRestController {

    @Autowired
    Con_NewcomerService con_NewcomerService;

    /**
     * 신입회원 PUSH 대상
     */
    @PostMapping("/list")
    public String selectNewcomerList(NewcomerVo newcomerVo) {
        return con_NewcomerService.selectNewcomerList(newcomerVo);
    }

    /**
     * 신입회원PUSH 상세조회
     */
    @PostMapping("/detail")
    public String NewcomerDetail(NewcomerVo newcomerVo) {
        return con_NewcomerService.selectNewcomerDetail(newcomerVo);
    }

    /**
     * 신입회원 PUSH 등록/수정
     */
    @PostMapping("/edit")
    public String NewcomerEdit(NewcomerVo newcomerVo) {
        return con_NewcomerService.callNewcomerEdit(newcomerVo);
    }

    /**
     * 신입회원 PUSH 삭제
     */
    @PostMapping("/delete")
    public String NewcomerDel(NewcomerVo newcomerVo) {
        return con_NewcomerService.callNewcomerDel(newcomerVo);
    }

}
