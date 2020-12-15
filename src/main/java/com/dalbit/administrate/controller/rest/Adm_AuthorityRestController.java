package com.dalbit.administrate.controller.rest;

import com.dalbit.administrate.service.Adm_AuthorityService;
import com.dalbit.common.code.Status;
import com.dalbit.common.service.CommonService;
import com.dalbit.common.vo.JsonOutputVo;
import com.dalbit.common.vo.MenuAuthVo;
import com.dalbit.common.vo.MenuVo;
import com.dalbit.common.vo.SearchVo;
import com.dalbit.exception.GlobalException;
import com.dalbit.inforex.vo.InforexMember;
import com.dalbit.util.GsonUtil;
import com.google.gson.Gson;
import lombok.extern.slf4j.Slf4j;
import lombok.var;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.List;

@Slf4j
@RestController
@RequestMapping("/rest/administrate/authority")
public class Adm_AuthorityRestController {

    @Autowired
    GsonUtil gsonUtil;

    @Autowired
    CommonService commonService;
    @Autowired
    Adm_AuthorityService admAuthorityService;

    @PostMapping("/list")
    public String list(SearchVo searchVo) {

        List<InforexMember> memberList = admAuthorityService.getInforexMemberList(searchVo);
        return gsonUtil.toJson(new JsonOutputVo(Status.조회, memberList));
    }

    @PostMapping("/info")
    public String info(SearchVo searchVo) {

        //관리자 메뉴 조회
        List<MenuVo> menuList = admAuthorityService.getAdminMenuInfo();

        //선택된 관리자 메뉴 조회
        List<MenuVo> memberAuthList = admAuthorityService.getMemberAuthInfo(searchVo.getEmpNo());

        var map = new HashMap();
        map.put("menuInfo", menuList);
        map.put("authInfo", memberAuthList);

        return gsonUtil.toJson(new JsonOutputVo(Status.조회, map));
    }

    @PostMapping("/setAuth")
    public String setAuth(HttpServletRequest request) throws GlobalException{

        String menuAuthArr = request.getParameter("menuAuthArr");
        String empNoArr = request.getParameter("empNoArr");
        MenuAuthVo[] menuAuthVos = new Gson().fromJson(menuAuthArr, MenuAuthVo[].class);
        String[] empNos = new Gson().fromJson(empNoArr, String[].class);
        log.debug("메뉴 : {}", request);

        admAuthorityService.setAuth(empNos, menuAuthVos);

        return gsonUtil.toJson(new JsonOutputVo(Status.관리자권한부여_성공));
    }

    @PostMapping("/selectAuthMenu")
    public String selectAuthMenu(SearchVo searchVo) throws GlobalException{

        //선택된 메뉴를 가진 직원 조회
        List<MenuVo> menuAuthList = admAuthorityService.getMenuAuthInfo(searchVo.getMenuIdx());
        var map = new HashMap();
        map.put("menuAuthList", menuAuthList);

        return gsonUtil.toJson(new JsonOutputVo(Status.조회, map));
    }

    @PostMapping("/setMenu")
    public String setMenu(HttpServletRequest request) throws GlobalException{

        String menuAuthArr = request.getParameter("menuAuthArr");
        String empNoArr = request.getParameter("empNoArr");

        MenuAuthVo[] menuAuthVos = new Gson().fromJson(menuAuthArr, MenuAuthVo[].class);
        log.debug("메뉴 : {}", menuAuthVos);

        admAuthorityService.setMenu(menuAuthVos);

        return gsonUtil.toJson(new JsonOutputVo(Status.관리자권한부여_성공));
    }
}
