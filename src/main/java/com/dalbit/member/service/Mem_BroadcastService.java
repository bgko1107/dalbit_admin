package com.dalbit.member.service;

import com.dalbit.broadcast.dao.Bro_BroadcastDao;
import com.dalbit.broadcast.vo.procedure.P_BroadcastDetailOutputVo;
import com.dalbit.broadcast.vo.procedure.P_BroadcastEditInputVo;
import com.dalbit.common.code.Status;
import com.dalbit.common.vo.JsonOutputVo;
import com.dalbit.common.vo.PagingVo;
import com.dalbit.common.vo.ProcedureVo;
import com.dalbit.member.dao.Mem_BroadcastDao;
import com.dalbit.member.dao.Mem_MemberDao;
import com.dalbit.member.vo.MemberVo;
import com.dalbit.member.vo.procedure.P_AuthVo;
import com.dalbit.member.vo.procedure.P_MemberBroadcastInputVo;
import com.dalbit.member.vo.procedure.P_MemberBroadcastOutputVo;
import com.dalbit.util.*;
import com.google.gson.Gson;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import java.util.ArrayList;

@Slf4j
@Service
public class Mem_BroadcastService {

    @Autowired
    Mem_BroadcastDao mem_BroadcastDao;
    @Autowired
    GsonUtil gsonUtil;
    @Autowired
    Mem_MemberDao mem_MemberDao;
    @Autowired
    SocketUtil socketUtil;
    @Autowired
    JwtUtil jwtUtil;
    @Autowired
    Bro_BroadcastDao bro_BroadcastDao;
    @Autowired
    SocketRestUtil socketRestUtil;

    @Value("${server.ant.url}")
    private String antServer;

    @Value("${ant.expire.hour}")
    private int antExpire;

    @Value("${ant.app.name}")
    private String antName;

    @Value("${server.api.url}")
    private String SERVER_API_URL;

    public String getBroadHistory(P_MemberBroadcastInputVo pMemberBroadcastInputVo){

        ProcedureVo procedureVo = new ProcedureVo(pMemberBroadcastInputVo);
        ArrayList<P_MemberBroadcastOutputVo> broacastList = mem_BroadcastDao.callBroadHistory(procedureVo);
        P_MemberBroadcastOutputVo summary = new Gson().fromJson(procedureVo.getExt(), P_MemberBroadcastOutputVo.class);

        String result;
        if(Integer.parseInt(procedureVo.getRet()) > 0) {
            result = gsonUtil.toJson(new JsonOutputVo(Status.회원정보_방송내역보기_성공, broacastList, new PagingVo(procedureVo.getRet()), summary));
        }else{
            result = gsonUtil.toJson(new JsonOutputVo(Status.회원정보_방송내역보기_실패));
        }
        return result;
    }

    /**
     * 회원 방송 강제 종료
     */
    public String forcedEnd(MemberVo MemberVo) {
        ArrayList<P_MemberBroadcastOutputVo> list = mem_BroadcastDao.callbroadCastList(MemberVo);

//        P_MemberAdminMemoAddVo pMemberAdminMemoAddVo = new P_MemberAdminMemoAddVo();
//        pMemberAdminMemoAddVo.setOpName(MemberVo.getMyMemNo());
//        pMemberAdminMemoAddVo.setMem_no(MemberVo.getMem_no());
//        pMemberAdminMemoAddVo.setMemo("운영자에 의한 회원 방송 강제 종료 시도");
//        ProcedureVo procedureVo = new ProcedureVo(pMemberAdminMemoAddVo);
//        mem_MemberDao.callMemAdminMemoAdd(procedureVo);
//
//        if(!DalbitUtil.isEmpty(MemberVo.getRoom_no())) {
//            pMemberAdminMemoAddVo.setOpName(MemberVo.getMyMemNo());
//            pMemberAdminMemoAddVo.setMem_no(MemberVo.getRoom_no());
//            pMemberAdminMemoAddVo.setMemo("운영자에 의한 회원 방송 강제 종료 시도");
//            procedureVo = new ProcedureVo(pMemberAdminMemoAddVo);
//            mem_MemberDao.callMemAdminMemoAdd(procedureVo);
//        }

        String room_no;
        String forceExitResult ="";
        for (int i=0; i<list.size();i++) {
            room_no = list.get(i).getRoom_no();
            // 방송 시작시간
            P_MemberBroadcastInputVo pMemberBroadcastInputVo = new P_MemberBroadcastInputVo();
            pMemberBroadcastInputVo.setRoom_no(room_no);
            ProcedureVo procedureVo2 = new ProcedureVo(pMemberBroadcastInputVo);
            bro_BroadcastDao.callBroadcastInfo(procedureVo2);

            P_BroadcastDetailOutputVo broadcastDetail = new Gson().fromJson(procedureVo2.getExt(), P_BroadcastDetailOutputVo.class);

            // 방송 강제종료 api 호출
            P_BroadcastEditInputVo pBroadcastEditInputVo = new P_BroadcastEditInputVo();
            pBroadcastEditInputVo.setMem_no(MemberVo.getMem_no());
            pBroadcastEditInputVo.setRoom_no(room_no);
            pBroadcastEditInputVo.setStart_date(broadcastDetail.getStartDate());
            pBroadcastEditInputVo.setOpName(MemberVo.getMyMemNo());
            pBroadcastEditInputVo.setRoomExit("Y");
            forceExitResult = socketRestUtil.broadcastForceExit(pBroadcastEditInputVo);
            log.info(forceExitResult);
            if(forceExitResult.equals("error") || forceExitResult.equals("noAuth")){
                break;
            }
        }

        String result;
        if(forceExitResult.equals("error")){
            return gsonUtil.toJson(new JsonOutputVo(Status.회원방송강제종료시도_실패));
        }else if (forceExitResult.equals("noAuth")){
            return gsonUtil.toJson(new JsonOutputVo(Status.회원방송강제종료시도_권한없음));
        }else{
            result = gsonUtil.toJson(new JsonOutputVo(Status.회원방송강제종료시도_성공));
        }

        return result;
    }


    /**
     * 임시점검 (전체 방 강제종료, 생성 제한)
     */
    public String inspectionCheck(P_AuthVo pAuthVo) {

        P_AuthVo outvo = mem_BroadcastDao.getInspectionCheck(pAuthVo);

        return gsonUtil.toJson(new JsonOutputVo(Status.조회, outvo));
    }

    /**
     * 임시점검 (전체 방 강제종료, 생성 제한)
     */
    public String inspection(P_AuthVo pAuthVo) {

        String result;

        if(pAuthVo.getType() == 1) {
            ArrayList<P_MemberBroadcastOutputVo> list = mem_BroadcastDao.getLiveBroadCastList(pAuthVo);

            pAuthVo.setType(0);
            pAuthVo.setOpName(MemberVo.getMyMemNo());
            mem_BroadcastDao.setInspectionHistory(pAuthVo);

            pAuthVo.setType(0);
            mem_BroadcastDao.setUpdateCodeDefine(pAuthVo);

            String forceExitResult = "";
            for (int i = 0; i < list.size(); i++) {
                // 방송 시작시간
                P_MemberBroadcastInputVo pMemberBroadcastInputVo = new P_MemberBroadcastInputVo();
                pMemberBroadcastInputVo.setRoom_no(list.get(i).getRoom_no());
                ProcedureVo procedureVo2 = new ProcedureVo(pMemberBroadcastInputVo);
                bro_BroadcastDao.callBroadcastInfo(procedureVo2);
                P_BroadcastDetailOutputVo broadcastDetail = new Gson().fromJson(procedureVo2.getExt(), P_BroadcastDetailOutputVo.class);

                // 방송 강제종료 api 호출
                P_BroadcastEditInputVo pBroadcastEditInputVo = new P_BroadcastEditInputVo();
                pBroadcastEditInputVo.setMem_no(list.get(i).getMem_no());
                pBroadcastEditInputVo.setRoom_no(list.get(i).getRoom_no());
                pBroadcastEditInputVo.setStart_date(broadcastDetail.getStartDate());
                pBroadcastEditInputVo.setOpName(MemberVo.getMyMemNo());
                pBroadcastEditInputVo.setRoomExit("Y");
                forceExitResult = socketRestUtil.broadcastForceExit(pBroadcastEditInputVo);
                log.info(forceExitResult);
                if(forceExitResult.equals("error") || forceExitResult.equals("noAuth")){
                    break;
                }
            }

            if (forceExitResult.equals("error")) {
                return gsonUtil.toJson(new JsonOutputVo(Status.회원방송강제종료시도_실패));
            } else if (forceExitResult.equals("noAuth")) {
                return gsonUtil.toJson(new JsonOutputVo(Status.회원방송강제종료시도_권한없음));
            } else {
                result = gsonUtil.toJson(new JsonOutputVo(Status.임시점검설정_성공));
            }
        }else{
            pAuthVo.setType(1);
            mem_BroadcastDao.setUpdateCodeDefine(pAuthVo);

            result = gsonUtil.toJson(new JsonOutputVo(Status.임시점검해제_성공));
        }

        return result;
    }
}
