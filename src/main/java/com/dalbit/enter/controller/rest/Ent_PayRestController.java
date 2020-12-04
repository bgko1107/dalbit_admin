package com.dalbit.enter.controller.rest;

import com.dalbit.enter.service.Ent_PayService;
import com.dalbit.enter.vo.procedure.P_PayTotalInPutVo;
import com.dalbit.enter.vo.procedure.P_PayTotalWayInPutVo;
import com.dalbit.enter.vo.procedure.P_PayTryInPutVo;
import com.dalbit.enter.vo.procedure.P_StatVo;
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
@RequestMapping("rest/enter/pay")
public class Ent_PayRestController {

    @Autowired
    GsonUtil gsonUtil;

    @Autowired
    MessageUtil messageUtil;

    @Autowired
    Ent_PayService ent_PayService;

    @PostMapping("info")
    public String payInfo(P_StatVo pStatVo){
        if(DalbitUtil.isEmpty(pStatVo.getStartDate())){
            pStatVo.setStartDate(null);
        }
        if(DalbitUtil.isEmpty(pStatVo.getEndDate())){
            pStatVo.setEndDate(null);
        }
        String result = ent_PayService.callPayInfo(pStatVo);
        return result;
    }

    // 결제 현황 총계
    @PostMapping("total")
    public String payTotal(P_PayTotalInPutVo pPayTotalInPutVo){
        String result = ent_PayService.callPayTotal(pPayTotalInPutVo);
        return result;
    }

    // 결제 현황 연령별
    @PostMapping("age")
    public String payAge(P_StatVo pStatVo){
        if(DalbitUtil.isEmpty(pStatVo.getStartDate())){
            pStatVo.setStartDate(null);
        }
        if(DalbitUtil.isEmpty(pStatVo.getEndDate())){
            pStatVo.setEndDate(null);
        }
        String result = ent_PayService.callPayAge(pStatVo);
        return result;
    }

    // 결제 현황 결제 수단 별
    @PostMapping("way")
    public String payWay(P_StatVo pStatVo){
        if(DalbitUtil.isEmpty(pStatVo.getStartDate())){
            pStatVo.setStartDate(null);
        }
        if(DalbitUtil.isEmpty(pStatVo.getEndDate())){
            pStatVo.setEndDate(null);
        }
        String result = ent_PayService.callPayWay(pStatVo);
        return result;
    }

    // 결제 현황 결제 상품 별
    @PostMapping("code")
    public String payCode(P_StatVo pStatVo){
        if(DalbitUtil.isEmpty(pStatVo.getStartDate())){
            pStatVo.setStartDate(null);
        }
        if(DalbitUtil.isEmpty(pStatVo.getEndDate())){
            pStatVo.setEndDate(null);
        }
        String result = ent_PayService.callPayCode(pStatVo);
        return result;
    }

    // 결제 현황 취소
    @PostMapping("cancel")
    public String payCancel(P_StatVo pStatVo){
        if(DalbitUtil.isEmpty(pStatVo.getStartDate())){
            pStatVo.setStartDate(null);
        }
        if(DalbitUtil.isEmpty(pStatVo.getEndDate())){
            pStatVo.setEndDate(null);
        }
        String result = ent_PayService.callPayCancel(pStatVo);
        return result;
    }

    // 결제 현황 총계
    @PostMapping("try")
    public String payTry(P_PayTryInPutVo pPayTryInPutVo){
        String result = ent_PayService.callPayTry(pPayTryInPutVo);
        return result;
    }

    // 결제 현황 월별_수단별
    @PostMapping("/month/way")
    public String payMonthWay(P_PayTotalWayInPutVo pPayTotalWayInPutVo){
        String result = ent_PayService.callPayMonthWay(pPayTotalWayInPutVo);
        return result;
    }
}
