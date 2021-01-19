package com.dalbit.content.service;

import com.dalbit.common.code.Status;
import com.dalbit.content.dao.IosAppDao;
import com.dalbit.member.vo.MemberVo;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;

@Slf4j
@Service
public class IosAppService {
    @Autowired
    IosAppDao iosAppDao;

    public HashMap getVersion(){
        HashMap result = new HashMap();
        HashMap data = new HashMap();
        data.put("last", iosAppDao.selectLast());
        data.put("list", iosAppDao.selectVersion());
        result.put("status", Status.조회);
        result.put("data", data);
        return result;
    }

    public HashMap getApp(HttpServletRequest request){
        HashMap result = new HashMap();
        HashMap data = new HashMap();
        data.put("list", iosAppDao.selectApp(request.getParameter("ver")));
        result.put("status", Status.조회);
        result.put("data", data);
        return result;
    }

    public Status doInsert(HttpServletRequest request){
        Status result = Status.비즈니스로직오류;
        HashMap params = new HashMap();
        params.put("opName", MemberVo.getMyMemNo());
        params.put("verName", request.getParameter("verName"));
        params.put("appBuild", request.getParameter("appBuild"));
        params.put("dirName", request.getParameter("dirName"));
        params.put("description", request.getParameter("description"));
        if(1 == iosAppDao.insertApp(params)){
            result = Status.생성;
        }
        return result;
    }

    public Status doDelete(HttpServletRequest request){
        Status result = Status.비즈니스로직오류;
        HashMap params = new HashMap();
        params.put("opName", MemberVo.getMyMemNo());
        params.put("idx", request.getParameter("idx"));
        if(1 == iosAppDao.deleteApp(params)){
            result = Status.삭제;
        }
        return result;
    }
}
