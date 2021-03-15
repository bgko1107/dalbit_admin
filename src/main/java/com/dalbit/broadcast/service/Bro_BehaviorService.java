package com.dalbit.broadcast.service;

import com.dalbit.broadcast.dao.Bro_BehaviorDao;
import com.dalbit.broadcast.vo.procedure.*;
import com.dalbit.common.code.Status;
import com.dalbit.common.dao.CommonDao;
import com.dalbit.common.vo.*;
import com.dalbit.member.vo.MemberVo;
import com.dalbit.util.*;
import com.google.gson.Gson;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.*;

@Slf4j
@Service
public class Bro_BehaviorService {

    @Autowired
    Bro_BehaviorDao bro_behaviorDao;
    @Autowired
    CommonDao commonDao;
    @Autowired
    MessageUtil messageUtil;
    @Autowired
    GsonUtil gsonUtil;
    @Autowired
    SocketUtil socketUtil;
    @Autowired
    JwtUtil jwtUtil;

    /**
     * 청취자 행위 유도 메시지 리스트 조회
     */
    public String callBroadcastBehaviorList(P_BehaviorListInputVo pBehaviorListInputVo) {
        ProcedureVo procedureVo = new ProcedureVo(pBehaviorListInputVo);
        ArrayList<P_BehaviorListOutputVo> list = bro_behaviorDao.callBroadcastBehaviorList(procedureVo);
        String result;
        HashMap msgList = new HashMap();
        if(DalbitUtil.isEmpty(list) || list.size() == 0) {
            msgList.put("list", new ArrayList<>());
            return gsonUtil.toJson(new JsonOutputVo(Status.청취유도메시지조회_데이터없음));
        }
        if (Integer.parseInt(procedureVo.getRet()) > 0) {

            HashMap resultMap = new Gson().fromJson(procedureVo.getExt(), HashMap.class);
            msgList.put("list", list);
            msgList.put("paging", new PagingVo(DalbitUtil.getIntMap(resultMap, "totalCnt"), DalbitUtil.getIntMap(resultMap, "pageNo"), DalbitUtil.getIntMap(resultMap, "pageCnt")));

            result = gsonUtil.toJson(new JsonOutputVo(Status.청취유도메시지조회_성공, msgList));
        } else {
            result = gsonUtil.toJson(new JsonOutputVo(Status.청취유도메시지조회_실패));
        }
        return result;
    }

    /**
     * 청취자 행위 유도 메시지 상세 조회
     */
    public String callBroadcastBehaviorDetail(P_BehaviorDetailInputVo pBehaviorDetailInputVo) {
        ProcedureVo procedureVo = new ProcedureVo(pBehaviorDetailInputVo);
        bro_behaviorDao.callBroadcastBehaviorDetail(procedureVo);
        String result;

        if (Status.청취유도메시지상세조회_성공.getMessageCode().equals(procedureVo.getRet())) {
            P_BehaviorDetailOutputVo outputVo = new Gson().fromJson(procedureVo.getExt(), P_BehaviorDetailOutputVo.class);
            result = gsonUtil.toJson(new JsonOutputVo(Status.청취유도메시지상세조회_성공, outputVo));
        } else {
            result = gsonUtil.toJson(new JsonOutputVo(Status.청취유도메시지상세조회_실패));
        }
        return result;
    }

    /**
     * 청취자 행위 유도 메시지 추가 / 수정
     */
    public String broadcastBehaviorApply(P_BehaviorListAddUpdateVo pBehaviorListAddUpdateVo) {
        pBehaviorListAddUpdateVo.setOpName(MemberVo.getMyMemNo());
        ProcedureVo procedureVo = new ProcedureVo(pBehaviorListAddUpdateVo);
        String result;
        if(DalbitUtil.isEmpty(pBehaviorListAddUpdateVo.getIdx()) || pBehaviorListAddUpdateVo.getIdx() == 0) {
            // 추가
            bro_behaviorDao.callBroadcastBehaviorAdd(procedureVo);
            if (Status.청취자유도메시지추가_성공.getMessageCode().equals(procedureVo.getRet())) {
                result = gsonUtil.toJson(new JsonOutputVo(Status.청취자유도메시지추가_성공));
            } else if (Status.청취자유도메시지_등장시간중복.getMessageCode().equals(procedureVo.getRet())) {
                result = gsonUtil.toJson(new JsonOutputVo(Status.청취자유도메시지_등장시간중복));
            } else {
                result = gsonUtil.toJson(new JsonOutputVo(Status.청취자유도메시지추가_실패));
            }
        } else {
            // 수정
            bro_behaviorDao.callBroadcastBehaviorEdit(procedureVo);
            if (Status.청취자유도메시지수정_성공.getMessageCode().equals(procedureVo.getRet())) {
                result = gsonUtil.toJson(new JsonOutputVo(Status.청취자유도메시지수정_성공));
            } else if (Status.청취자유도메시지수정_메시지번호없음.getMessageCode().equals(procedureVo.getRet())) {
                result = gsonUtil.toJson(new JsonOutputVo(Status.청취자유도메시지수정_메시지번호없음));
            } else if (Status.청취자유도메시지_등장시간중복.getMessageCode().equals(procedureVo.getRet())) {
                result = gsonUtil.toJson(new JsonOutputVo(Status.청취자유도메시지_등장시간중복));
            } else {
                result = gsonUtil.toJson(new JsonOutputVo(Status.청취자유도메시지수정_실패));
            }
        }

        return result;
    }

    /**
     * 청취자 행위 유도 메시지 삭제
     */
    public String callBroadcastBehaviorDelete(P_BehaviorListDeleteVo pBehaviorListDeleteVo) {
        pBehaviorListDeleteVo.setOpName(MemberVo.getMyMemNo());
        ProcedureVo procedureVo = new ProcedureVo(pBehaviorListDeleteVo);
        bro_behaviorDao.callBroadcastBehaviorDelete(procedureVo);

        String result;
        if (Status.청취자유도메시지삭제_성공.getMessageCode().equals(procedureVo.getRet())) {
            result = gsonUtil.toJson(new JsonOutputVo(Status.청취자유도메시지삭제_성공));
        } else {
            result = gsonUtil.toJson(new JsonOutputVo(Status.청취자유도메시지삭제_실패));
        }
        return result;
    }

}
