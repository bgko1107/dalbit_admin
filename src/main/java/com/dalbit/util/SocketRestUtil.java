package com.dalbit.util;

import com.dalbit.administrate.dao.Adm_MenuDao;
import com.dalbit.broadcast.vo.procedure.P_BroadcastEditInputVo;
import com.dalbit.broadcast.vo.procedure.P_GuestListInputVo;
import com.dalbit.broadcast.vo.procedure.P_ListenForceLeaveVo;
import com.dalbit.exception.GlobalException;
import com.dalbit.member.vo.procedure.P_MemberReportVo;
import lombok.extern.slf4j.Slf4j;
import okhttp3.FormBody;
import okhttp3.RequestBody;
import okhttp3.Response;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

import java.io.IOException;

@Slf4j
@Component
public class SocketRestUtil {

    @Value("${server.api.url}")
    private String SERVER_API_URL;

    @Autowired
    Adm_MenuDao adm_MenuDao;

    @Autowired
    JwtUtil jwtUtil;
    
    /*
     * 방송 강제종료 api 호출
     */
    public String broadcastForceExit(P_BroadcastEditInputVo pBroadcastEditInputVo){

        String authMemNo = adm_MenuDao.getMobileAuth(pBroadcastEditInputVo.getOpName());
        if(DalbitUtil.isEmpty(authMemNo)){
            return "noAuth";
        }
        OkHttpClientUtil okHttpClientUtil = new OkHttpClientUtil();
        RequestBody formBody = new FormBody.Builder()
                .add("room_no", pBroadcastEditInputVo.getRoom_no())
                .add("start_date", pBroadcastEditInputVo.getStart_date())
                .add("mem_no", pBroadcastEditInputVo.getMem_no())
                .add("roomExit", pBroadcastEditInputVo.getRoomExit())
                .build();

        String inforexLoginResult;
        try{
            String url = SERVER_API_URL + "/admin/broadcast/forceExit";
            Response response = okHttpClientUtil.sendPostApi(url, formBody, jwtUtil.generateToken(authMemNo, true));
            inforexLoginResult = response.body().string();
            log.debug(inforexLoginResult);
            return inforexLoginResult;
        }catch (IOException | GlobalException e){
            e.printStackTrace();
            return "error";
        }
    }

    public String listenForceExit(P_ListenForceLeaveVo pListenForceLeaveVo){
        String authMemNo = adm_MenuDao.getMobileAuth(pListenForceLeaveVo.getOpName());
        if(DalbitUtil.isEmpty(authMemNo)){
            return "noAuth";
        }
        OkHttpClientUtil okHttpClientUtil = new OkHttpClientUtil();
        RequestBody formBody = new FormBody.Builder()
                .add("room_no", pListenForceLeaveVo.getRoom_no())
                .add("mem_no", pListenForceLeaveVo.getMem_no())
                .add("mem_nick", pListenForceLeaveVo.getMem_nickName())
                .add("roomBlock", pListenForceLeaveVo.getRoomBlock())
                .add("notificationYn", pListenForceLeaveVo.getNotificationYn())
                .add("report_title", pListenForceLeaveVo.getReport_title())
                .add("report_message", pListenForceLeaveVo.getReport_message())
//                .add("notiMemo", pListenForceLeaveVo.getNotiMemo())
                .build();

        String inforexLoginResult;
        try{
            String url = SERVER_API_URL + "/admin/forcedOut";
//            String url = "https://devm-bgko.dalbitlive.com:4431/admin/forcedOut";
            Response response = okHttpClientUtil.sendPostApi(url, formBody, jwtUtil.generateToken(authMemNo, true));
            inforexLoginResult = response.body().string();
            log.debug(inforexLoginResult);
            return inforexLoginResult;
        }catch (IOException | GlobalException e){
            e.printStackTrace();
            return "error";
        }
    }

    /**
     *  방송방 얼리기
     */
    public String broadcastFreeze(P_BroadcastEditInputVo pBroadcastEditInputVo){

        String authMemNo = adm_MenuDao.getMobileAuth(pBroadcastEditInputVo.getOpName());
        if(DalbitUtil.isEmpty(authMemNo)){
            return "noAuth";
        }
        OkHttpClientUtil okHttpClientUtil = new OkHttpClientUtil();
        RequestBody formBody = new FormBody.Builder()
                .add("room_no", pBroadcastEditInputVo.getRoom_no())
                .add("mem_no", pBroadcastEditInputVo.getMem_no())
                .add("freezeMsg", pBroadcastEditInputVo.getFreezeMsg())
                .build();

        String inforexLoginResult;
        try{
            String url = SERVER_API_URL + "/admin/freeze";
            Response response = okHttpClientUtil.sendPostApi(url, formBody, jwtUtil.generateToken(authMemNo, true));
            inforexLoginResult = response.body().string();
            log.debug(inforexLoginResult);
            return inforexLoginResult;
        }catch (IOException | GlobalException e){
            e.printStackTrace();
            return "error";
        }
    }

    /*
     * 게스트 종료
     */
    public String guestOut(P_GuestListInputVo pGuestListInputVo){

        String authMemNo = adm_MenuDao.getMobileAuth(pGuestListInputVo.getOpName());
        if(DalbitUtil.isEmpty(authMemNo)){
            return "noAuth";
        }
        OkHttpClientUtil okHttpClientUtil = new OkHttpClientUtil();
        RequestBody formBody = new FormBody.Builder()
                .add("roomNo", pGuestListInputVo.getRoom_no())
                .add("memNo", pGuestListInputVo.getMem_no())
                .add("mode", "6")
                .build();

        String inforexLoginResult;
        try{
            String url = SERVER_API_URL + "/admin/guestOut";
//            String url = "https://devm-hwlee.dalbitlive.com:4431/admin/guestOut";
            Response response = okHttpClientUtil.sendPostApi(url, formBody, jwtUtil.generateToken(authMemNo, true));
            inforexLoginResult = response.body().string();
            log.debug(inforexLoginResult);
            return inforexLoginResult;
        }catch (IOException | GlobalException e){
            e.printStackTrace();
            return "error";
        }
    }


    /*
     * 이미지 삭제
     */
    public String sendChatImageDelete(P_MemberReportVo pMemberReportVo){

        String authMemNo = adm_MenuDao.getMobileAuth(pMemberReportVo.getOpName());
        if(DalbitUtil.isEmpty(authMemNo)){
            return "noAuth";
        }
        OkHttpClientUtil okHttpClientUtil = new OkHttpClientUtil();
        RequestBody formBody = new FormBody.Builder()
                .add("chatNo", pMemberReportVo.getChat_no())
                .add("targetMemNo", pMemberReportVo.getMem_no())
                .add("msgIdx", Integer.toString(pMemberReportVo.getImage_idx()))
                .build();

        String inforexLoginResult;
        try{
            String url = SERVER_API_URL + "/admin/declaretion/imageDelete";
//            String url = "https://devm-bgko.dalbitlive.com:4431/admin/declaretion/imageDelete";
            Response response = okHttpClientUtil.sendPostApi(url, formBody, jwtUtil.generateToken(authMemNo, true));
            inforexLoginResult = response.body().string();
//            log.debug(inforexLoginResult);
            log.info("-------------------------- imageDelete start ----------------------------");
            log.info(inforexLoginResult);
            log.info("-------------------------- imageDelete end   ----------------------------");
            return inforexLoginResult;
        }catch (IOException | GlobalException e){
            e.printStackTrace();
            return "error";
        }
    }

    public String memberForceLogout(P_MemberReportVo pMemberReportVo){

        String authMemNo = adm_MenuDao.getMobileAuth(pMemberReportVo.getOpName());
        if(DalbitUtil.isEmpty(authMemNo)){
            return "noAuth";
        }

        OkHttpClientUtil okHttpClientUtil = new OkHttpClientUtil();
        RequestBody formBody = new FormBody.Builder()
                .add("mem_no", pMemberReportVo.getMem_no())
                .add("message", pMemberReportVo.getNotimemo())
                .build();

        String inforexLoginResult;
        try{
            String url = SERVER_API_URL + "/admin/member/forceLogout";
            Response response = okHttpClientUtil.sendPostApi(url, formBody, jwtUtil.generateToken(authMemNo, true));
            inforexLoginResult = response.body().string();
            log.debug(inforexLoginResult);
            return inforexLoginResult;
        }catch (IOException | GlobalException e){
            e.printStackTrace();
            return "error";
        }
    }
}
