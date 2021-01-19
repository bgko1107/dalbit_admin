package com.dalbit.administrate.controller.rest;

import com.dalbit.administrate.service.Adm_TestDalByeolService;
import com.dalbit.administrate.vo.TestIdVo;
import com.dalbit.common.service.CommonService;
import com.dalbit.excel.service.ExcelService;
import com.dalbit.util.GsonUtil;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@Slf4j
@RestController
@RequestMapping("/rest/administrate/testDalByeol")
public class Adm_TestDalByeolRestController {

    @Autowired
    GsonUtil gsonUtil;

    @Autowired
    CommonService commonService;
    @Autowired
    Adm_TestDalByeolService adm_TestDalByeolService;

    @Autowired
    ExcelService excelService;

    @PostMapping("/list")
    public String list(TestIdVo testIdVo) {
        String testIdList = adm_TestDalByeolService.getTestDalByeolList(testIdVo);
        return testIdList;
    }


    @PostMapping("/dal/send/list")
    public String dalSendList(TestIdVo testIdVo) {
        String testIdList = adm_TestDalByeolService.getDalSendList(testIdVo);
        return testIdList;
    }

    @PostMapping("/byeol/send/list")
    public String byeolSendList(TestIdVo testIdVo) {
        String testIdList = adm_TestDalByeolService.getByeolSendList(testIdVo);
        return testIdList;
    }
}
