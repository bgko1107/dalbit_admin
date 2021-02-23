package com.dalbit.customer.controller.rest;

import com.dalbit.customer.service.Cus_BlockAdmService;
import com.dalbit.customer.vo.BlockAdmVo;
import com.dalbit.util.GsonUtil;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@Slf4j
@RestController
@RequestMapping("rest/customer/blockAdm")
public class Cus_BlockAdmRestController {

    @Autowired
    GsonUtil gsonUtil;

    @Autowired
    Cus_BlockAdmService cusBlockAdmService;

    /**
     * 차단 회원 내역 조회
     */
    @PostMapping("/list")
    public String selectBlockList(BlockAdmVo blockAdmVo) {
        return cusBlockAdmService.selectBlockList(blockAdmVo);
    }

    /**
     * 차단 내역 메시지 상세보기
     */
    @PostMapping("/detail")
    public String selectBlockDetail(BlockAdmVo blockAdmVo) {
        return cusBlockAdmService.selectBlockDetail(blockAdmVo);
    }

    /**
     * IP/Uuid 차단 (Modal)
     */
    @PostMapping("/insertBlock")
    public String insertBlock(BlockAdmVo blockAdmVo) {
        return cusBlockAdmService.insertBlock(blockAdmVo);
    }

    /**
     * 차단 내역 삭제 (차단 해지)
     */
    @PostMapping("/deleteBlock")
    public String deleteBlock(BlockAdmVo blockAdmVo) {
        return cusBlockAdmService.deleteBlock(blockAdmVo);
    }

    /**
     * 로그인 차단/해지 내역 조회
     */
    @PostMapping("/histList")
    public String historyList(BlockAdmVo blockAdmVo) {
        return cusBlockAdmService.selectBlockHistList(blockAdmVo);
    }

    /**
     * 차단 메모 조회
     */
    @PostMapping("/admin/memo")
    public String adminMemo(BlockAdmVo blockAdmVo) {
        return cusBlockAdmService.selectAdminMemo(blockAdmVo);
    }

    /**
     * 차단 메모 등록/삭제
     */
    @PostMapping("/admin/memo/ins")
    public String adminMemoIns(BlockAdmVo blockAdmVo) {
        return cusBlockAdmService.adminMemoIns(blockAdmVo);
    }

    /**
     * 차단 메모 삭제
     */
    @PostMapping("/admin/memo/del")
    public String adminMemoDel(BlockAdmVo blockAdmVo) {
        return cusBlockAdmService.adminMemoDel(blockAdmVo);
    }
}
