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
import com.dalbit.util.DalbitUtil;
import com.dalbit.util.GsonUtil;
import com.dalbit.util.JwtUtil;
import com.dalbit.util.SocketUtil;
import com.google.gson.Gson;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

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
    public String forcedExit(MemberVo MemberVo) {
        ArrayList<P_MemberListenOutputVo> list = mem_ListenDao.callListenList(MemberVo);

        P_MemberAdminMemoAddVo pMemberAdminMemoAddVo = new P_MemberAdminMemoAddVo();
        pMemberAdminMemoAddVo.setOpName(MemberVo.getMyMemNo());
        pMemberAdminMemoAddVo.setMem_no(MemberVo.getMem_no());
        pMemberAdminMemoAddVo.setMemo("운영자에 의한 회원 청취 강제 종료 시도");
        ProcedureVo procedureVo = new ProcedureVo(pMemberAdminMemoAddVo);
        mem_MemberDao.callMemAdminMemoAdd(procedureVo);

        for (int i=0; i<list.size();i++) {
            P_ListenForceLeaveVo pListenForceLeaveVo = new P_ListenForceLeaveVo();
            pListenForceLeaveVo.setRoom_no(list.get(i).getRoom_no());
            pListenForceLeaveVo.setMem_no(MemberVo.getMem_no());
            ProcedureVo procedureVo2 = new ProcedureVo(pListenForceLeaveVo);
            bro_ListenerDao.callForceLeave(procedureVo2);

            //청취자 강제 퇴장
            HashMap<String, Object> param = new HashMap<>();
            param.put("roomNo", list.get(i).getRoom_no());
            param.put("target_memNo", MemberVo.getMem_no());
            param.put("target_nickName", list.get(i).getMem_nick());
            param.put("memNo", list.get(i).getDj_mem_no());
            param.put("nickName", list.get(i).getDj_nickName());
            // option
            param.put("ctrlRole", "ctrlRole");
            param.put("revMemNo", MemberVo.getMem_no());     // 받는 사람
            param.put("recvType", "system");
            param.put("recvPosition", "top1");
            param.put("recvLevel", 2);
            param.put("recvTime", 1);

            // message set
            Gson gson = new Gson();
            HashMap<String, Object> tmp = new HashMap();
            tmp.put("revMemNo", MemberVo.getMem_no());     // 받는 사람
            tmp.put("revMemNk", list.get(i).getMem_nick());
            tmp.put("sndAuth", 4);
            tmp.put("sndMemNo", list.get(i).getDj_mem_no());            // 보낸 사람
            tmp.put("sndMemNk", list.get(i).getDj_nickName());
            String message = gson.toJson(tmp);

            socketUtil.setSocket(param, "reqKickOut", message, jwtUtil.generateToken(MemberVo.getMem_no(), true));

            //TODO - api에서는 reqChangeCount로 팬랭킹을 내려주는데. 일단 관리자에서는 제외한다.
        }

        String result = "";
        result = gsonUtil.toJson(new JsonOutputVo(Status.회원청취강제종료시도_성공));

        return result;
    }
}
