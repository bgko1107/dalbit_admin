package com.dalbit.administrate.service;

import com.dalbit.administrate.dao.Adm_AuthorityDao;
import com.dalbit.administrate.dao.Adm_FaqDao;
import com.dalbit.administrate.vo.procedure.*;
import com.dalbit.common.code.Status;
import com.dalbit.common.service.CommonService;
import com.dalbit.common.vo.*;
import com.dalbit.excel.service.ExcelService;
import com.dalbit.excel.vo.ExcelVo;
import com.dalbit.exception.GlobalException;
import com.dalbit.inforex.vo.InforexDutyCode;
import com.dalbit.inforex.vo.InforexMember;
import com.dalbit.inforex.vo.InforexPosCode;
import com.dalbit.member.vo.MemberVo;
import com.dalbit.util.DalbitUtil;
import com.dalbit.util.GsonUtil;
import com.dalbit.util.InforexApiUtil;
import com.dalbit.util.MessageUtil;
import com.google.gson.Gson;
import lombok.extern.slf4j.Slf4j;
import lombok.var;
import org.apache.poi.xssf.streaming.SXSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;

import java.util.*;
import java.util.stream.Collectors;

@Slf4j
@Service
public class Adm_AuthorityService {

    @Autowired
    Adm_AuthorityDao admAuthorityDao;

    @Autowired
    MessageUtil messageUtil;
    @Autowired
    GsonUtil gsonUtil;

    @Autowired
    CommonService commonService;

    @Transactional(readOnly = false)
    public void setAuth(String[] empNos, MenuAuthVo[] menuAuthVos)throws GlobalException {
        if(DalbitUtil.isEmpty(empNos)){
            throw new GlobalException(Status.관리자권한부여_임직원번호업음);

        }else if(DalbitUtil.isEmpty(menuAuthVos)){
            throw new GlobalException(Status.관리자권한부여_메뉴없음);
        }

        for (String empNo : empNos) {

            admAuthorityDao.deleteMenuAuth(empNo);

            for (MenuAuthVo menuAuthVo : menuAuthVos) {
                menuAuthVo.setEmp_no(empNo);

                admAuthorityDao.insertMenuAuth(menuAuthVo);
            }
        }
    }

    @Transactional(readOnly = false)
    public void setMenu(MenuAuthVo[] menuAuthVos)throws GlobalException {

        if(0 < menuAuthVos.length){
            int menuIdx = menuAuthVos[0].getMenu_idx();
            admAuthorityDao.deleteMenuAuthByMenuIdx(menuIdx);
        }

        for (MenuAuthVo menuAuthVo : menuAuthVos) {
            admAuthorityDao.insertMenuAuth(menuAuthVo);
        }
    }

    public List<MenuVo> getAdminMenuInfo(){
        //메뉴1뎁스
        List<MenuVo> menuInfo = commonService.getMenuInfo(new MenuVo(1));

        //메뉴2뎁스
        List<MenuVo> twoDepth = commonService.getMenuInfo(new MenuVo(2));

        menuInfo.stream().forEach(one -> {
            var twoDepthList = new ArrayList<MenuVo>();
            twoDepth.stream().filter(two -> two.getParent_idx() == one.getIdx()).forEach(twoDepthInfo -> {
                twoDepthList.add(twoDepthInfo);
            });
            one.setTwoDepth(twoDepthList);
        });

        return menuInfo;
    }

    public List<InforexMember> getInforexMemberList(SearchVo searchVo){
        InforexPosCode[] inforexPosCodes = InforexApiUtil.getInforexPosCode();
        InforexDutyCode[] inforexDutyCode = InforexApiUtil.getInforexDutyCode();
        InforexMember[] inforexMembers = InforexApiUtil.getInforexMemberList();

        //직급, 직책 이름 매칭
        Arrays.stream(inforexMembers)
            .forEach(member -> {
                member.setStaff_pos_name(Arrays.stream(inforexPosCodes).filter(inforexPosCode -> inforexPosCode.getPos_code().equals(member.getStaff_pos())).findFirst().get().getPos_name());
                member.setStaff_duty_name(Arrays.stream(inforexDutyCode).filter(inforexPosCode -> inforexPosCode.getDuty_code().equals(member.getStaff_duty())).findFirst().get().getDuty_name());
            });

        List<InforexMember> memberList = Arrays.stream(inforexMembers).filter(member -> !(member.getNew_dept_name().equals("임원"))).collect(Collectors.toList());
        //검색
        if(!DalbitUtil.isEmpty(searchVo.getPosType())){
            memberList = memberList.stream()
                    .filter(inforexMember -> inforexMember.getStaff_pos().equals(searchVo.getPosType()))
                    .collect(Collectors.toList());
        }

        if(!DalbitUtil.isEmpty(searchVo.getDeptType())){
            memberList = memberList.stream()
                    .filter(inforexMember -> inforexMember.getDept_no().equals(searchVo.getDeptType()))
                    .collect(Collectors.toList());
        }

        if(!DalbitUtil.isEmpty(searchVo.getSearchText())){
            memberList = memberList.stream()
                    .filter(inforexMember -> inforexMember.getStaff_name().equals(searchVo.getSearchText()))
                    .collect(Collectors.toList());
        }

        //메뉴 권한 수
        for(int i=0;i<memberList.size();i ++ ){
            int authCnt = admAuthorityDao.getMemberAuthCnt(memberList.get(i).getEmp_no());
            memberList.get(i).setAuthCnt(authCnt);

            int testIdCnt = admAuthorityDao.getTestIdCnt(memberList.get(i).getEmp_no());
            memberList.get(i).setTestIdCnt(testIdCnt);
        }

        return memberList;
    }

    public List<MenuVo> getMemberAuthInfo(String empNo){
        return admAuthorityDao.getMemberAuthInfo(empNo);
    }

    public List<MenuVo> getMenuAuthInfo(int menuIdx){
        return admAuthorityDao.getMenuAuthInfo(menuIdx);
    }

    public List<MenuVo> getLnbMemberAuthInfo(String empNo){

        List<MenuVo> menuAuthList = getMemberAuthInfo(empNo);
        List<MenuVo> authList = menuAuthList.stream().filter(one -> one.getDepth() == 1).collect(Collectors.toList());

        authList.forEach(one -> {
            var twoDepthMenuList = new ArrayList<MenuVo>();
            menuAuthList.stream().filter(two -> two.getDepth() == 2 && two.getParent_idx() == one.getIdx()).forEach(twoDepthMenu-> {
                twoDepthMenuList.add(twoDepthMenu);
            });
            one.setTwoDepth(twoDepthMenuList);
        });

        return authList;

    }
}
