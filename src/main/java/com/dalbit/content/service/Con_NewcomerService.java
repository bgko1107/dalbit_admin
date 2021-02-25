package com.dalbit.content.service;

import com.dalbit.common.code.Status;
import com.dalbit.common.vo.JsonOutputVo;
import com.dalbit.common.vo.PagingVo;
import com.dalbit.common.vo.ProcedureVo;
import com.dalbit.content.dao.Con_NewcomerDao;
import com.dalbit.content.vo.NewcomerVo;
import com.dalbit.member.vo.MemberVo;
import com.dalbit.util.GsonUtil;
import com.google.gson.Gson;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;

@Slf4j
@Service
public class Con_NewcomerService {

    @Autowired
    GsonUtil gsonUtil;

    @Autowired
    Con_NewcomerDao con_NewcomerDao;

    /**
     * 신입회원PUSH 목록 조회
     */
    public String selectNewcomerList(NewcomerVo newcomerVo) {

        ProcedureVo procedureVo = new ProcedureVo(newcomerVo);
        ArrayList<NewcomerVo> NewcomerList = con_NewcomerDao.callNewcomerList(procedureVo);

        String result;
        if(NewcomerList.size() > 0) {
            result = gsonUtil.toJson(new JsonOutputVo(Status.조회, NewcomerList, new PagingVo(procedureVo.getRet())));
        }else{
            result = gsonUtil.toJson(new JsonOutputVo(Status.비즈니스로직오류));
        }
        return result;
    }

    /**
     * 신입회원PUSH 상세 조회
     */
    public String selectNewcomerDetail(NewcomerVo newcomerVo) {
        ProcedureVo procedureVo = new ProcedureVo(newcomerVo);
        con_NewcomerDao.callNewcomerDetail(procedureVo);
        NewcomerVo NewcomerDetail = new Gson().fromJson(procedureVo.getExt(), NewcomerVo.class);

        String result;
        if(NewcomerDetail != null) {
            result = gsonUtil.toJson(new JsonOutputVo(Status.조회, NewcomerDetail));
        }else{
            result = gsonUtil.toJson(new JsonOutputVo(Status.비즈니스로직오류));
        }
        return result;
    }

    /**
     * 신입회원PUSH 수정
     */
    public String callNewcomerEdit(NewcomerVo newcomerVo) {
        newcomerVo.setOpName(MemberVo.getMyMemNo());
        ProcedureVo procedureVo = new ProcedureVo(newcomerVo);
        con_NewcomerDao.callNewcomerEdit(procedureVo);

        return gsonUtil.toJson(new JsonOutputVo(Status.수정));

    }

    /**
     * 신입회원PUSH 삭제
     */
    public String callNewcomerDel(NewcomerVo newcomerVo) {
        String[] memNoList = newcomerVo.getMemNoList().split("@@");

        boolean resultSw = false;
        for (int i = 0; i < memNoList.length; i++) {
            newcomerVo.setMem_no(memNoList[i]);
            ProcedureVo procedureVo = new ProcedureVo(newcomerVo);
            con_NewcomerDao.callNewcomerDel(procedureVo);
            if (!procedureVo.getRet().equals("0")) {
                resultSw = false;
                break;
            } else {
                resultSw = true;
            }
        }
        return resultSw ? gsonUtil.toJson(new JsonOutputVo(Status.처리완료)) : gsonUtil.toJson(new JsonOutputVo(Status.비즈니스로직오류));
    }

}