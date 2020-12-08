package com.dalbit.broadcast.service;


import com.dalbit.broadcast.dao.Bro_ListenerDao;
import com.dalbit.broadcast.vo.procedure.P_ListenForceLeaveVo;
import com.dalbit.broadcast.vo.procedure.P_ListenListInputVo;
import com.dalbit.broadcast.vo.procedure.P_ListenListOutputVo;
import com.dalbit.common.code.Status;
import com.dalbit.common.vo.JsonOutputVo;
import com.dalbit.common.vo.PagingVo;
import com.dalbit.common.vo.ProcedureVo;
import com.dalbit.member.dao.Mem_MemberDao;
import com.dalbit.member.vo.MemberVo;
import com.dalbit.member.vo.procedure.P_MemberAdminMemoAddVo;
import com.dalbit.member.vo.procedure.P_MemberInfoOutputVo;
import com.dalbit.util.*;
import com.google.gson.Gson;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

@Slf4j
@Service
public class Bro_ListenerService {

    @Autowired
    Bro_ListenerDao bro_ListenerDao;
    @Autowired
    MessageUtil messageUtil;
    @Autowired
    GsonUtil gsonUtil;
    @Autowired
    SocketUtil socketUtil;
    @Autowired
    JwtUtil jwtUtil;
    @Autowired
    Mem_MemberDao mem_MemberDao;
    /**
     * 생방송 청취자 목록 조회
     */
    public String getListenerList(P_ListenListInputVo pListenListInputVo){
        ProcedureVo procedureVo = new ProcedureVo(pListenListInputVo);
        ArrayList<P_ListenListOutputVo> broadList = bro_ListenerDao.callListenerList(procedureVo);

        List list = new ArrayList();
        if(!DalbitUtil.isEmpty(broadList)){
            for (int i=0; i < broadList.size(); i++){
                P_ListenListOutputVo outVo = new P_ListenListOutputVo();
                // 회원 배찌
                HashMap<P_MemberInfoOutputVo,String> djBadge = mem_MemberDao.callMemberInfo_badge(broadList.get(i).getMem_no());
                if(!DalbitUtil.isEmpty(djBadge)) {
                    outVo.setRecomm_badge(String.valueOf(djBadge.get("recomm_badge")) );
                    outVo.setNewdj_badge(String.valueOf(djBadge.get("newdj_badge")));
                    outVo.setSpecialdj_badge(String.valueOf(djBadge.get("specialdj_badge")));
                }
                outVo.setRowNum(broadList.get(i).getRowNum());
                outVo.setAuth(broadList.get(i).getAuth());
                outVo.setState(broadList.get(i).getState());
                outVo.setMem_no(broadList.get(i).getMem_no());
                outVo.setUserID(broadList.get(i).getUserID());
                outVo.setNickName(broadList.get(i).getNickName());
                outVo.setInner(broadList.get(i).getInner());
                outVo.setLevel(broadList.get(i).getLevel());
                outVo.setGrade(broadList.get(i).getGrade());
                outVo.setJoinCnt(broadList.get(i).getJoinCnt());
                outVo.setStartDateFormat(broadList.get(i).getStartDateFormat());
                outVo.setEndDateFormat(broadList.get(i).getEndDateFormat());
                outVo.setListenTime(broadList.get(i).getListenTime());
                outVo.setAuthStartDateFormat(broadList.get(i).getAuthStartDateFormat());
                outVo.setAuthEndDateFormat(broadList.get(i).getAuthEndDateFormat());

                outVo.setGoodCnt(broadList.get(i).getGoodCnt());
                outVo.setBoosterCnt(broadList.get(i).getBoosterCnt());
                outVo.setGiftCnt(broadList.get(i).getGiftCnt());
                if(DalbitUtil.isEmpty(broadList.get(i).getUserID())){
                    ArrayList<P_ListenListOutputVo> withdrawal = bro_ListenerDao.callListenerList_withdrawal(broadList.get(i).getMem_no());
                    if(withdrawal.size() > 0) {
                        outVo.setUserID(withdrawal.get(0).getUserID());
                        outVo.setNickName(withdrawal.get(0).getNickName());
                    }else {
                        outVo.setNickName("비회원");
                    }
                }
                MemberVo memInfoOutVo = mem_MemberDao.getMemberInfo(broadList.get(i).getMem_no());
                if(!DalbitUtil.isEmpty(memInfoOutVo)) {
                    outVo.setMem_sex(memInfoOutVo.getMem_sex());
                    outVo.setMem_birth_year(memInfoOutVo.getMem_birth_year());
                    outVo.setMem_birth_month(memInfoOutVo.getMem_birth_month());
                    outVo.setMem_birth_day(memInfoOutVo.getMem_birth_day());
                }

                outVo.setComplete_moon(broadList.get(i).getComplete_moon());
                list.add(outVo);
            }
        }

        P_ListenListOutputVo summary = new Gson().fromJson(procedureVo.getExt(), P_ListenListOutputVo.class);

        String result;
        if(Integer.parseInt(procedureVo.getRet()) > 0) {
            result = gsonUtil.toJson(new JsonOutputVo(Status.생방송_청취자목록조회_성공, list, new PagingVo(procedureVo.getRet()),summary));
        }else{
            result = gsonUtil.toJson(new JsonOutputVo(Status.생방송_청취자목록조회_실패));
        }
        return result;
    }

    /**
     * 생방송 청취자 강제퇴장
     */
    public String getListenerForceLeave(P_ListenForceLeaveVo pListenForceLeaveVo){
        pListenForceLeaveVo.setOpName(MemberVo.getMyMemNo());
        if(pListenForceLeaveVo.getForced().equals("forced")) {
            pListenForceLeaveVo.setRoomBlock("Y");
            pListenForceLeaveVo.setNotificationYn("Y");
            pListenForceLeaveVo.setReport_title(pListenForceLeaveVo.getNotiContents());
            pListenForceLeaveVo.setReport_message(pListenForceLeaveVo.getNotiMemo());
        }else if(pListenForceLeaveVo.getForced().equals("exit")) {
            pListenForceLeaveVo.setRoomBlock("N");
            pListenForceLeaveVo.setNotificationYn("N");
            pListenForceLeaveVo.setReport_title("");
            pListenForceLeaveVo.setReport_message("");
            // 어드민 메모 입력
            P_MemberAdminMemoAddVo pMemberAdminMemoAddVo = new P_MemberAdminMemoAddVo();
            pMemberAdminMemoAddVo.setOpName(MemberVo.getMyMemNo());
            pMemberAdminMemoAddVo.setMem_no(pListenForceLeaveVo.getMem_no());
            pMemberAdminMemoAddVo.setMemo(pListenForceLeaveVo.getNotiMemo());
            ProcedureVo procedureVo2 = new ProcedureVo(pMemberAdminMemoAddVo);
            mem_MemberDao.callMemAdminMemoAdd(procedureVo2);
        }

        pListenForceLeaveVo.setRoom_no(pListenForceLeaveVo.getRoom_no());
        pListenForceLeaveVo.setMem_no(pListenForceLeaveVo.getMem_no());
        pListenForceLeaveVo.setMem_nickName(pListenForceLeaveVo.getMem_nickName());
        String listenForceExitResult = DalbitUtil.listenForceExit(pListenForceLeaveVo);

        String result = "";
        if(listenForceExitResult.equals("error")){
            result = gsonUtil.toJson(new JsonOutputVo(Status.회원청취강제종료시도_실패));
        }else if(listenForceExitResult.equals("noAuth")){
            result = gsonUtil.toJson(new JsonOutputVo(Status.회원청취강제종료시도_권한없음));
        }else if(listenForceExitResult.indexOf("0") > 0){
            result = gsonUtil.toJson(new JsonOutputVo(Status.생방청취자강제퇴장_성공));
        }else if(listenForceExitResult.indexOf("-1") > 0){
            result = gsonUtil.toJson(new JsonOutputVo(Status.생방청취자강제퇴장_회원아님));
        }else if(listenForceExitResult.indexOf("-2") > 0){
            result = gsonUtil.toJson(new JsonOutputVo(Status.생방청취자강제퇴장_방없음));
        }else if(listenForceExitResult.indexOf("-3") > 0){
            result = gsonUtil.toJson(new JsonOutputVo(Status.생방청취자강제퇴장_종료된방));
        }else if(listenForceExitResult.indexOf("-4") > 0){
            result = gsonUtil.toJson(new JsonOutputVo(Status.생방청취자강제퇴장_청취자아님));
        }else if(listenForceExitResult.indexOf("-5") > 0){
            result = gsonUtil.toJson(new JsonOutputVo(Status.생방청취자강제퇴장_퇴장한회원));
        }

//        ProcedureVo procedureVo = new ProcedureVo(pListenForceLeaveVo);
//        bro_ListenerDao.callForceLeave(procedureVo);
//
//        if(pListenForceLeaveVo.getForced().equals("forced")) {
//            //재입장 불가능 하도록
//            bro_ListenerDao.callForceLeave_roomBlock(pListenForceLeaveVo);
//        }else if(pListenForceLeaveVo.getForced().equals("exit")) {
//            P_MemberAdminMemoAddVo pMemberAdminMemoAddVo = new P_MemberAdminMemoAddVo();
//            pMemberAdminMemoAddVo.setOpName(MemberVo.getMyMemNo());
//            pMemberAdminMemoAddVo.setMem_no(pListenForceLeaveVo.getMem_no());
//            pMemberAdminMemoAddVo.setMemo(pListenForceLeaveVo.getNotiMemo());
//            ProcedureVo procedureVo2 = new ProcedureVo(pMemberAdminMemoAddVo);
//            mem_MemberDao.callMemAdminMemoAdd(procedureVo2);
//        }

//        if(Status.생방청취자강제퇴장_성공.getMessageCode().equals(procedureVo.getRet())){
//            result = gsonUtil.toJson(new JsonOutputVo(Status.생방청취자강제퇴장_성공));
//
//            //청취자 강제 퇴장
//            HashMap<String,Object> param = new HashMap<>();
//            param.put("roomNo",pListenForceLeaveVo.getRoom_no());
//            param.put("target_memNo",pListenForceLeaveVo.getMem_no());
//            param.put("target_nickName",pListenForceLeaveVo.getMem_nickName());
//            param.put("memNo",pListenForceLeaveVo.getDj_mem_no());
//            param.put("nickName",pListenForceLeaveVo.getDj_nickname());
//            // option
//            param.put("ctrlRole","ctrlRole");
//            param.put("revcMemNo",pListenForceLeaveVo.getMem_no());     // 받는 사람
//            param.put("recvType","system");
//            param.put("recvPosition","top1");
//            param.put("recvLevel",2);
//            param.put("recvTime",1);
//
//            // message set
//            Gson gson = new Gson();
//            HashMap<String,Object> tmp = new HashMap();
//            tmp.put("revMemNo",pListenForceLeaveVo.getMem_no());     // 받는 사람
//            tmp.put("revMemNk",pListenForceLeaveVo.getMem_nickName());
//            tmp.put("sndAuth",4);
//            tmp.put("sndMemNo",pListenForceLeaveVo.getDj_mem_no());            // 보낸 사람
//            tmp.put("sndMemNk",pListenForceLeaveVo.getDj_nickname());
//            String message =  gson.toJson(tmp);
//
//            socketUtil.setSocket(param,"reqKickOut",message,jwtUtil.generateToken(pListenForceLeaveVo.getMem_no(), true));
//
//            //TODO - api에서는 reqChangeCount로 팬랭킹을 내려주는데. 일단 관리자에서는 제외한다.
//
//        } else if(Status.생방청취자강제퇴장_회원아님.getMessageCode().equals(procedureVo.getRet())){
//            result = gsonUtil.toJson(new JsonOutputVo(Status.생방청취자강제퇴장_회원아님));
//        } else if(Status.생방청취자강제퇴장_방없음.getMessageCode().equals(procedureVo.getRet())){
//            result = gsonUtil.toJson(new JsonOutputVo(Status.생방청취자강제퇴장_방없음));
//        } else if(Status.생방청취자강제퇴장_종료된방.getMessageCode().equals(procedureVo.getRet())){
//            result = gsonUtil.toJson(new JsonOutputVo(Status.생방청취자강제퇴장_종료된방));
//        } else if(Status.생방청취자강제퇴장_청취자아님.getMessageCode().equals(procedureVo.getRet())){
//            result = gsonUtil.toJson(new JsonOutputVo(Status.생방청취자강제퇴장_청취자아님));
//        } else if(Status.생방청취자강제퇴장_퇴장한회원.getMessageCode().equals(procedureVo.getRet())){
//            result = gsonUtil.toJson(new JsonOutputVo(Status.생방청취자강제퇴장_퇴장한회원));
//        }
        return result;
    }
}
