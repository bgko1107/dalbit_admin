package com.dalbit.money.controller.rest;

import com.dalbit.excel.service.ExcelService;
import com.dalbit.money.service.Mon_ResourceService;
import com.dalbit.money.vo.procedure.P_ResourceInfoInPutVo;
import com.dalbit.money.vo.procedure.P_ResourcePopupInputVo;
import com.dalbit.util.GsonUtil;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@Slf4j
@RestController
@RequestMapping("rest/money/resource")
public class Mon_ResourceRestController {

    @Autowired
    Mon_ResourceService mon_ResourceService;

    @Autowired
    ExcelService excelService;

    @Autowired
    GsonUtil gsonUtil;

    @PostMapping("info")
    public String list(P_ResourceInfoInPutVo pResourceInfoInPutVo){
        String result = mon_ResourceService.resourceInfo(pResourceInfoInPutVo);
        return result;
    }

    @PostMapping("memberDataList")
    public String memberDataList(P_ResourceInfoInPutVo pResourceInfoInPutVo){
        String result = mon_ResourceService.memberDataList(pResourceInfoInPutVo);
        return result;
    }

    @PostMapping("buyDalList")
    public String buyDalList(P_ResourceInfoInPutVo pResourceInfoInPutVo){
        String result = mon_ResourceService.buyDalList(pResourceInfoInPutVo);
        return result;
    }

    @PostMapping("useDalList")
    public String useDalList(P_ResourceInfoInPutVo pResourceInfoInPutVo){
        String result = mon_ResourceService.useDalList(pResourceInfoInPutVo);
        return result;
    }

    @PostMapping("live")
    public String live(P_ResourceInfoInPutVo pResourceInfoInPutVo){
        String result = mon_ResourceService.resourceLive(pResourceInfoInPutVo);
        return result;
    }

    @PostMapping("dal/pay/detail/list")
    public String dalPayDetailList(P_ResourcePopupInputVo pResourcePopupInputVo){
        String result = mon_ResourceService.dalPayDetailList(pResourcePopupInputVo);
        return result;
    }

    @PostMapping("dal/direct/list")
    public String dalDirectList(P_ResourcePopupInputVo pResourcePopupInputVo){
        String result = mon_ResourceService.dalDirectList(pResourcePopupInputVo);
        return result;
    }

    @PostMapping("dal/member/state/list")
    public String dalMemberState(P_ResourcePopupInputVo pResourcePopupInputVo){
        String result = mon_ResourceService.dalMemberState(pResourcePopupInputVo);
        return result;
    }

    @PostMapping("byeol/detail/list")
    public String byeolDetailList(P_ResourcePopupInputVo pResourcePopupInputVo){
        String result = mon_ResourceService.byeolDetailList(pResourcePopupInputVo);
        return result;
    }

    @PostMapping("byeol/gift/list")
    public String byeolGiftList(P_ResourcePopupInputVo pResourcePopupInputVo){
        String result = mon_ResourceService.byeolGiftList(pResourcePopupInputVo);
        return result;
    }
}
