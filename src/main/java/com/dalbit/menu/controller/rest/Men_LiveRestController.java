package com.dalbit.menu.controller.rest;

import com.dalbit.menu.service.Men_LiveService;
import com.dalbit.menu.vo.LiveVo;
import com.dalbit.util.GsonUtil;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@Slf4j
@RestController
@RequestMapping("rest/menu/live")
public class Men_LiveRestController {

    @Autowired
    GsonUtil gsonUtil;

    @Autowired
    Men_LiveService menLiveService;


//    @RequestMapping("list")
//    public String list(@Valid RoomListVo roomListVo, BindingResult bindingResult, HttpServletRequest request){
//
//        int pageNo = DalbitUtil.isEmpty(roomListVo.getPage()) ? 1 : roomListVo.getPage();
//        int pageCnt = DalbitUtil.isEmpty(roomListVo.getRecords()) ? 10 : roomListVo.getRecords();
//
//        P_RoomListVo apiData = new P_RoomListVo();
//        apiData.setMemLogin(0);
//        apiData.setMem_no("81583121281305");
//        apiData.setSubjectType(roomListVo.getSubjectType());
//        apiData.setType_noti(roomListVo.getSlctType());
//        apiData.setPageNo(pageNo);
//        apiData.setPageCnt(pageCnt);
//
//        String result = menLiveService.callBroadCastRoomList(apiData);
//        return result;
//    }

    /**
     * 실시간 Live 리스트 조회
     */
    @PostMapping("list")
    public String list(LiveVo liveVo) {
        return menLiveService.getLiveList(liveVo);
    }
}
