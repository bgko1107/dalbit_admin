package com.dalbit.content.service;

import com.dalbit.common.code.Status;
import com.dalbit.common.vo.JsonOutputVo;
import com.dalbit.common.vo.PagingVo;
import com.dalbit.common.vo.ProcedureVo;
import com.dalbit.content.dao.Con_BannerDao;
import com.dalbit.content.dao.Con_VideoSettingDao;
import com.dalbit.content.vo.BannerOrderVo;
import com.dalbit.content.vo.BannerStatVo;
import com.dalbit.content.vo.procedure.*;
import com.dalbit.member.vo.MemberVo;
import com.dalbit.util.GsonUtil;
import com.google.gson.Gson;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;

@Slf4j
@Service
public class Con_VideoSettingService {

    @Autowired
    Con_VideoSettingDao videoSettingDao;

    @Autowired
    GsonUtil gsonUtil;


    /** 영상대화 세팅값 리스트 */
    public String callVideoSettingList() {
        ProcedureVo procedureVo = new ProcedureVo();
        String result;

        ArrayList<P_VideoSettingListVo> settingList = videoSettingDao.callVideoSettingList(procedureVo);

        if(settingList != null && settingList.size() > 0) {
            result = gsonUtil.toJson(new JsonOutputVo(Status.조회, settingList));
        }else {
            result = gsonUtil.toJson(new JsonOutputVo(Status.데이터없음));
        }
        return result;
    }

    /** 영상대화 수정내역 */
    public String callVideoSettingDetail(P_VideoSettingDetailVo pVideoSettingDetailVo) {
        ProcedureVo procedureVo = new ProcedureVo(pVideoSettingDetailVo);
        String result;

        ArrayList<P_VideoSettingDetailVo> detailList = videoSettingDao.callVideoSettingDetail(procedureVo);

        if(detailList != null && detailList.size() > 0) {
            result = gsonUtil.toJson(new JsonOutputVo(Status.조회, detailList));
        }else {
            result = gsonUtil.toJson(new JsonOutputVo(Status.데이터없음));
        }
        return result;
    }

    public String callVideoSettingEdit(P_VideoSettingEditVo pVideoSettingEditVo) {
        pVideoSettingEditVo.setOp_name(MemberVo.getMyMemNo());
        ProcedureVo procedureVo = new ProcedureVo(pVideoSettingEditVo);
        videoSettingDao.callVideoSettingEdit(procedureVo);
        String result;
        if(Status.영상대화설정_수정_성공.getMessageCode().equals(procedureVo.getRet())) {
            result = gsonUtil.toJson(new JsonOutputVo(Status.영상대화설정_수정_성공));
        } else {
            result = gsonUtil.toJson(new JsonOutputVo(Status.영상대화설정_수정_에러));
        }
        return result;
    }
}
