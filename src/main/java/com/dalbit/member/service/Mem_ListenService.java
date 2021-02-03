package com.dalbit.member.service;

import com.dalbit.broadcast.dao.Bro_ListenerDao;
import com.dalbit.broadcast.vo.procedure.P_ListenForceLeaveVo;
import com.dalbit.common.code.Status;
import com.dalbit.common.vo.JsonOutputVo;
import com.dalbit.common.vo.PagingVo;
import com.dalbit.common.vo.ProcedureVo;
import com.dalbit.member.dao.Mem_ListenDao;
import com.dalbit.member.dao.Mem_MemberDao;
import com.dalbit.member.vo.MemberVo;
import com.dalbit.member.vo.procedure.P_MemberAdminMemoAddVo;
import com.dalbit.member.vo.procedure.P_MemberListenInputVo;
import com.dalbit.member.vo.procedure.P_MemberListenOutputVo;
import com.dalbit.util.*;
import com.google.gson.Gson;
import lombok.extern.slf4j.Slf4j;
import lombok.var;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;

@Slf4j
@Service
public class Mem_ListenService {

    @Autowired
    Mem_ListenDao mem_ListenDao;
    @Autowired
    GsonUtil gsonUtil;
    @Autowired
    Mem_MemberDao mem_MemberDao;
    @Autowired
    SocketUtil socketUtil;
    @Autowired
    JwtUtil jwtUtil;
    @Autowired
    Bro_ListenerDao bro_ListenerDao;
    @Autowired
    SocketRestUtil socketRestUtil;

    public String getListenHistory(P_MemberListenInputVo pMemberListenInputVo) {

        ProcedureVo procedureVo = new ProcedureVo(pMemberListenInputVo);
        ArrayList<P_MemberListenOutputVo> listenList = mem_ListenDao.callListenHistory(procedureVo);
        P_MemberListenOutputVo summary = new Gson().fromJson(procedureVo.getExt(), P_MemberListenOutputVo.class);

        for(int i=0;i<listenList.size();i++) {
            MemberVo outVo = mem_MemberDao.getMemberInfo(listenList.get(i).getDj_mem_no());
            if(!DalbitUtil.isEmpty(outVo)) {
                listenList.get(i).setDj_mem_sex(outVo.getMem_sex());
                listenList.get(i).setDj_birth_year(outVo.getMem_birth_year());
                listenList.get(i).setDj_birth_month(outVo.getMem_birth_month());
                listenList.get(i).setDj_birth_day(outVo.getMem_birth_day());
                listenList.get(i).setInner(outVo.getInner());
            }
        }

        String result;
        if(Integer.parseInt(procedureVo.getRet()) > 0) {
            result = gsonUtil.toJson(new JsonOutputVo(Status.회원정보_청취내역보기_성공, listenList, new PagingVo(procedureVo.getRet()), summary));
        }else{
            result = gsonUtil.toJson(new JsonOutputVo(Status.회원정보_청취내역보기_실패));
        }
        return result;
    }


    /**
     * 회원 청취 강제 종료
     */
    public String forcedExit(P_MemberListenInputVo pMemberListenInputVo) {
        ArrayList<P_MemberListenOutputVo> list = mem_ListenDao.callListenList(pMemberListenInputVo);

        P_MemberAdminMemoAddVo pMemberAdminMemoAddVo = new P_MemberAdminMemoAddVo();
        pMemberAdminMemoAddVo.setOpName(MemberVo.getMyMemNo());
        pMemberAdminMemoAddVo.setMem_no(pMemberListenInputVo.getMem_no());
        pMemberAdminMemoAddVo.setMemo("운영자에 의한 회원 청취 강제 종료 시도");
        ProcedureVo procedureVo = new ProcedureVo(pMemberAdminMemoAddVo);
        mem_MemberDao.callMemAdminMemoAdd(procedureVo);

        String listenForceExitResult="";
        for (int i=0; i<list.size();i++) {
            P_ListenForceLeaveVo pListenForceLeaveVo = new P_ListenForceLeaveVo();
            pListenForceLeaveVo.setOpName(MemberVo.getMyMemNo());
            pListenForceLeaveVo.setRoom_no(list.get(i).getRoom_no());
            pListenForceLeaveVo.setMem_no(pMemberListenInputVo.getMem_no());
            pListenForceLeaveVo.setMem_nickName(list.get(i).getMem_nick());
            pListenForceLeaveVo.setNotificationYn("N");
            pListenForceLeaveVo.setRoomBlock("N");
            pListenForceLeaveVo.setReport_title("");
            pListenForceLeaveVo.setReport_message("");
            pListenForceLeaveVo.setNotiMemo("");
            listenForceExitResult = socketRestUtil.listenForceExit(pListenForceLeaveVo);

            if(listenForceExitResult.equals("error") || listenForceExitResult.equals("noAuth")){
                break;
            }

            //이미 강제종료된 방에서는 바로 종료처리
            if(list.get(i).getState() == 4){
                var exitRoomMemberVo = new P_MemberListenInputVo();
                exitRoomMemberVo.setRoom_no(list.get(i).getRoom_no());
                exitRoomMemberVo.setMem_no(pMemberListenInputVo.getMem_no());
                mem_ListenDao.updateExitRoomMember(exitRoomMemberVo);
            }

            //TODO - api에서는 reqChangeCount로 팬랭킹을 내려주는데. 일단 관리자에서는 제외한다.
        }

        String result = "";
        if(listenForceExitResult.equals("error")){
            result = gsonUtil.toJson(new JsonOutputVo(Status.회원청취강제종료시도_실패));
        }else if (listenForceExitResult.equals("noAuth")){
            result = gsonUtil.toJson(new JsonOutputVo(Status.회원청취강제종료시도_권한없음));
        }else{
            result = gsonUtil.toJson(new JsonOutputVo(Status.회원청취강제종료시도_성공));
        }

        return result;
    }
}
