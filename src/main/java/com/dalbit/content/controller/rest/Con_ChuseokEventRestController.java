package com.dalbit.content.controller.rest;

import com.dalbit.content.service.Con_ChuseokEventService;
import com.dalbit.content.vo.*;
import com.dalbit.excel.service.ExcelService;
import com.dalbit.util.GsonUtil;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@Slf4j
@RestController
@RequestMapping("rest/content/event")
public class Con_ChuseokEventRestController {

    @Autowired
    ExcelService excelService;

    @Autowired
    Con_ChuseokEventService con_chuseokEventService;

    @Autowired
    GsonUtil gsonUtil;

    @PostMapping("/chuseok/freeDalList")
    public String chuseokFreeDalList(ChuseokEventVo chuseokEventVo) {
        String result = con_chuseokEventService.selectFreeDalList(chuseokEventVo);
        return result;
    }

    @PostMapping("/chuseok/purchaseList")
    public String chuseokPurchaseList(ChuseokEventVo chuseokEventVo) {
        String result = con_chuseokEventService.selectPurchaseList(chuseokEventVo);
        return result;
    }

}