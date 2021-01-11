package com.dalbit.status.controller.rest;

import com.dalbit.common.vo.StatVo;
import com.dalbit.status.service.Sta_ItemService;
import com.dalbit.status.vo.procedure.P_ItemBroadInputVo;
import com.dalbit.status.vo.procedure.P_ItemClipInputVo;
import com.dalbit.status.vo.procedure.P_MailboxVo;
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
@RequestMapping("rest/status/item")
public class Sta_ItemRestController {

    @Autowired
    GsonUtil gsonUtil;

    @Autowired
    MessageUtil messageUtil;

    @Autowired
    Sta_ItemService sta_ItemService;

    /**
     * 아이템 고정
     */
    @PostMapping("/live/list")
    public String itemLive(){
        String result = sta_ItemService.callItemLive();
        return result;
    }

    /**
     * 아이템 총계
     * @param StatVo
     * @return
     */
    @PostMapping("/total/list")
    public String itemTotal(StatVo StatVo){
        if(DalbitUtil.isEmpty(StatVo.getStartDate())){
            StatVo.setStartDate(null);
        }
        if(DalbitUtil.isEmpty(StatVo.getEndDate())){
            StatVo.setEndDate(null);
        }
        String result = sta_ItemService.callItemTotal(StatVo);
        return result;
    }

    /**
     * 아이템 성별
     * @param StatVo
     * @return
     */
    @PostMapping("/gender/list")
    public String itemGender(StatVo StatVo){
        if(DalbitUtil.isEmpty(StatVo.getStartDate())){
            StatVo.setStartDate(null);
        }
        if(DalbitUtil.isEmpty(StatVo.getEndDate())){
            StatVo.setEndDate(null);
        }
        String result = sta_ItemService.callItemGender(StatVo);
        return result;
    }

    /**
     * 아이템 연령별
     * @param StatVo
     * @return
     */
    @PostMapping("/age/list")
    public String itemAge(StatVo StatVo){
        if(DalbitUtil.isEmpty(StatVo.getStartDate())){
            StatVo.setStartDate(null);
        }
        if(DalbitUtil.isEmpty(StatVo.getEndDate())){
            StatVo.setEndDate(null);
        }
        String result = sta_ItemService.callItemAge(StatVo);
        return result;
    }

    /**
     * 아이템 방송별
     * @param pItemBroadInputVo
     * @return
     */
    @PostMapping("/broad/list")
    public String itembroad(P_ItemBroadInputVo pItemBroadInputVo){
        if(DalbitUtil.isEmpty(pItemBroadInputVo.getStartDate())){
            pItemBroadInputVo.setStartDate(null);
        }
        String result = sta_ItemService.callItemBroad(pItemBroadInputVo);
        return result;
    }

    /**
     * 아이템 클립별
     * @param pItemClipInputVo
     * @return
     */
    @PostMapping("/clip/list")
    public String itemClip(P_ItemClipInputVo pItemClipInputVo){
        if(DalbitUtil.isEmpty(pItemClipInputVo.getStartDate())){
            pItemClipInputVo.setStartDate(null);
        }
        String result = sta_ItemService.callItemClip(pItemClipInputVo);
        return result;
    }

    /**
     * 아이템 우체통
     * @param pItemClipInputVo
     * @return
     */
    @PostMapping("/mailbox/list")
    public String mailboxList(P_MailboxVo pMailboxVo){
        if(DalbitUtil.isEmpty(pMailboxVo.getStartDate())){
            pMailboxVo.setStartDate(null);
        }
        String result = sta_ItemService.callMailboxList(pMailboxVo);
        return result;
    }
}
