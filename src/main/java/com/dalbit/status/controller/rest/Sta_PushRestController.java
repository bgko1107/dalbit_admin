package com.dalbit.status.controller.rest;

import com.dalbit.status.service.Sta_PushService;
import com.dalbit.status.vo.procedure.P_PushHistoryInputVo;
import com.dalbit.status.vo.procedure.P_PushStatusInPutVo;
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
@RequestMapping("rest/status/push")
public class Sta_PushRestController {

    @Autowired
    GsonUtil gsonUtil;

    @Autowired
    MessageUtil messageUtil;

    @Autowired
    Sta_PushService sta_PushService;

    /**
     * push발송현황
     * @param pStatVo
     * @return
     */
    @PostMapping("total")
    public String total(P_StatVo pStatVo){
        if(DalbitUtil.isEmpty(pStatVo.getStartDate())){
            pStatVo.setStartDate(null);
        }
        if(DalbitUtil.isEmpty(pStatVo.getEndDate())){
            pStatVo.setEndDate(null);
        }
        String result = sta_PushService.callPushTotal(pStatVo);
        return result;
    }

    /**
     * push발송 내역 조회
     * @param pPushHistoryInputVo
     * @return
     */
    @PostMapping("history/list")
    public String historyList(P_PushHistoryInputVo pPushHistoryInputVo){

        String result = sta_PushService.callPushHistoryList(pPushHistoryInputVo);

        return result;
    }


    /**
     * 알림설정 현황
     * @param pStatVo
     * @return
     */
    @PostMapping("notice")
    public String notice(P_StatVo pStatVo){
        if(DalbitUtil.isEmpty(pStatVo.getStartDate())){
            pStatVo.setStartDate(null);
        }
        if(DalbitUtil.isEmpty(pStatVo.getEndDate())){
            pStatVo.setEndDate(null);
        }
        String result = sta_PushService.callNotice(pStatVo);
        return result;
    }


    /**
     * push 현황 시간대 현황
     * @param pPushStatusInPutVo
     * @return
     */
    @PostMapping("time")
    public String pushTime(P_PushStatusInPutVo pPushStatusInPutVo){
        String result = sta_PushService.callPushTime(pPushStatusInPutVo);
        return result;
    }

    /**
     * push 현황 일별 현황
     * @param pPushStatusInPutVo
     * @return
     */
    @PostMapping("day")
    public String pushDay(P_PushStatusInPutVo pPushStatusInPutVo){
        String result = sta_PushService.callPushDay(pPushStatusInPutVo);
        return result;
    }

    /**
     * push 현황 월간 현황
     * @param pPushStatusInPutVo
     * @return
     */
    @PostMapping("month")
    public String pushMonth(P_PushStatusInPutVo pPushStatusInPutVo){
        String result = sta_PushService.callPushMonth(pPushStatusInPutVo);
        return result;
    }

    /**
     * push 현황 연간 현황
     * @param pPushStatusInPutVo
     * @return
     */
    @PostMapping("year")
    public String pushYear(P_PushStatusInPutVo pPushStatusInPutVo){
        String result = sta_PushService.callPushYear(pPushStatusInPutVo);
        return result;
    }

    /**
     * push 수신 걸정 현황 현황
     * @param pPushStatusInPutVo
     * @return
     */
    @PostMapping("newNotice")
    public String newNotice(P_PushStatusInPutVo pPushStatusInPutVo){
        String result = sta_PushService.callNewNotice(pPushStatusInPutVo);
        return result;
    }

    /**
     * push 일간 상게 목록
     * @param pPushStatusInPutVo
     * @return
     */
    @PostMapping("day/detail/popup")
    public String dayDetailPopup(P_PushStatusInPutVo pPushStatusInPutVo){
        String result = sta_PushService.callDayDetailPopup(pPushStatusInPutVo);
        return result;
    }




    /**
     * push발송 회원 알림받기 상세 목록
     * @param pPushHistoryInputVo
     * @return
     */
    @PostMapping("history/member/notice/detail")
    public String memeberNoticeDetail(P_PushHistoryInputVo pPushHistoryInputVo){

        String result = sta_PushService.callMemeberNoticeDetail(pPushHistoryInputVo);

        return result;
    }
}
