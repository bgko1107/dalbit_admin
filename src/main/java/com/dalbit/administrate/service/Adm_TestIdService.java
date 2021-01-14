package com.dalbit.administrate.service;

import com.dalbit.administrate.dao.Adm_TestIdDao;
import com.dalbit.administrate.vo.*;
import com.dalbit.common.code.Status;
import com.dalbit.common.vo.JsonOutputVo;
import com.dalbit.common.vo.SearchVo;
import com.dalbit.excel.service.ExcelService;
import com.dalbit.excel.vo.ExcelVo;
import com.dalbit.member.vo.MemberVo;
import com.dalbit.util.DalbitUtil;
import com.dalbit.util.GsonUtil;
import com.dalbit.util.MessageUtil;
import lombok.extern.slf4j.Slf4j;
import lombok.var;
import org.apache.poi.xssf.streaming.SXSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;

import java.util.*;

@Slf4j
@Service
public class Adm_TestIdService {

    @Autowired
    Adm_TestIdDao admTestIdDao;

    @Autowired
    MessageUtil messageUtil;
    @Autowired
    GsonUtil gsonUtil;

    @Autowired
    ExcelService excelService;

    public MemberVo getMemberInfo(TestIdVo testIdVo){
        MemberVo memberInfo = admTestIdDao.getMemberInfo(testIdVo);
        return memberInfo;
    }

    public List<TestIdVo> getTestIdInfo(TestIdVo testIdVo){
        List<TestIdVo> testIdVoList = admTestIdDao.getTestIdInfo(testIdVo);
        return testIdVoList;
    }

    public int insertTestId(TestIdVo testIdVo){
        int result = admTestIdDao.insertTestId(testIdVo);
        admTestIdDao.insertTestId_history(testIdVo);

        // 내부직원 테스트 여부 1 update
        testIdVo.setInner(1);
        result = admTestIdDao.updateInner(testIdVo);
        return result;
    }

    public List<TestIdVo> getTestIdSummary(SearchVo searchVo){
        List<TestIdVo> testIdSummary = admTestIdDao.getTestIdSummary(searchVo);
        return testIdSummary;
    }

    public List<TestIdListVo> getTestIdList(SearchVo searchVo){
        List<TestIdListVo> testIdList = admTestIdDao.getTestIdList(searchVo);

        for(int i=0;i<testIdList.size();i++){
            TestIdListVo chargeVo = admTestIdDao.getCharge(testIdList.get(i).getMem_no());
            if(!DalbitUtil.isEmpty(chargeVo)) {
                testIdList.get(i).setType(chargeVo.getType());
                testIdList.get(i).setCharge(chargeVo.getCharge());
                testIdList.get(i).setChargeDate(chargeVo.getChargeDate());
                testIdList.get(i).setLastOpName(chargeVo.getLastOpName());
            }
        }

        return testIdList;
    }

    public void deleteTestId(String[] memNos){
        admTestIdDao.deleteTestId(memNos);
        // 내부직원 테스트 여부 0 update
        TestIdVo testIdVo = new TestIdVo();
        testIdVo.setMem_no(memNos[0]);
        testIdVo.setInner(0);
        admTestIdDao.updateInner(testIdVo);

        //운영자 아이디 삭제
        var memberBadgeVo = new MemberBadgeVo();
        memberBadgeVo.setMemNos(memNos);
        memberBadgeVo.setSlct_type(6);
        memberBadgeVo.setBadge_value(1);
        admTestIdDao.deleteMemberBadge(memberBadgeVo);
    }

    /**
     * 회원 엑셀
     */
    public Model getListExcel(SearchVo searchVo, Model model) {
        searchVo.setPageCnt(60000);
        List<TestIdListVo> list = admTestIdDao.getTestIdList(searchVo);

        for(int i=0;i<list.size();i++){
            TestIdListVo chargeVo = admTestIdDao.getCharge(list.get(i).getMem_no());
            if(!DalbitUtil.isEmpty(chargeVo)) {
                list.get(i).setType(chargeVo.getType());
                list.get(i).setCharge(chargeVo.getCharge());
                list.get(i).setChargeDate(chargeVo.getChargeDate());
            }
        }

        String[] headers = {"No", "사번", "직원명", "관계","회원번호","User ID","User 닉네임","성별","달/별 충전일","보유 달/별 수","연락처","레벨/등급","등록일","최근수정일","최근로그인","상태"};
        int[] headerWidths = {3000,3000,3000,3000,3000,3000,3000,3000,3000,3000,3000,3000,3000,3000,3000,3000};

        List<Object[]> bodies = new ArrayList<>();
        for(int i = 0; i < list.size(); i++){
            HashMap hm = new LinkedHashMap();


            String mem3 = "";
            if(list.get(i).getRelation().equals("1")) mem3 = "본인";
            else if(list.get(i).getRelation().equals("2")) mem3 = "가족";
            else if(list.get(i).getRelation().equals("3")) mem3 = "친구";
            else if(list.get(i).getRelation().equals("4")) mem3 = "친척";
            else if(list.get(i).getRelation().equals("5")) mem3 = "업체";
            else if(list.get(i).getRelation().equals("6")) mem3 = "기타";

            String mem7 = "";
            if(list.get(i).getMem_sex().equals("m")) mem7 = "남자";
            else if(list.get(i).getMem_sex().equals("f")) mem7 = "여자";
            else if(list.get(i).getMem_sex().equals("n")) mem7 = "알수없음";

            String mem15 = "";
            if(list.get(i).getMem_state().equals("1")) mem15 = "정상";
            else if(list.get(i).getMem_state().equals("2")) mem15 = "경고";
            else if(list.get(i).getMem_state().equals("3")) mem15 = "1일정지";
            else if(list.get(i).getMem_state().equals("4")) mem15 = "3일정지";
            else if(list.get(i).getMem_state().equals("5")) mem15 = "7일정지";
            else if(list.get(i).getMem_state().equals("6")) mem15 = "영구정지";
            else if(list.get(i).getMem_state().equals("7")) mem15 = "강제탈퇴";

            hm.put("no", list.size() - i);
            hm.put("mem1", DalbitUtil.isEmpty(list.get(i).getEmp_no()) ? "" : list.get(i).getEmp_no());
            hm.put("mem2", DalbitUtil.isEmpty(list.get(i).getEmp_name()) ? "" : list.get(i).getEmp_name());
            hm.put("mem3", mem3);
            hm.put("mem4", DalbitUtil.isEmpty(list.get(i).getMem_no()) ? "" : list.get(i).getMem_no());
            hm.put("mem5", DalbitUtil.isEmpty(list.get(i).getMem_userId()) ? "" : list.get(i).getMem_userId());
            hm.put("mem6", DalbitUtil.isEmpty(list.get(i).getMem_nick()) ? "" : list.get(i).getMem_nick());
            hm.put("mem7", mem7);
            hm.put("mem8", DalbitUtil.isEmpty(list.get(i).getType()) ? "" : list.get(i).getType() + ": " + list.get(i).getCharge() +" / "+ list.get(i).getChargeDate());
            hm.put("mem9", DalbitUtil.isEmpty(list.get(i).getDal()) ? "" : "달: " + list.get(i).getDal() + " / 별: " + list.get(i).getByeol());
            hm.put("mem10", DalbitUtil.isEmpty(list.get(i).getMem_phone()) ? "" : list.get(i).getMem_phone());
            hm.put("mem11",  list.get(i).getLevel() + " / " + list.get(i).getGrade());
            hm.put("mem12", DalbitUtil.isEmpty(list.get(i).getReg_date()) ? "" : list.get(i).getReg_date());
            hm.put("mem13", DalbitUtil.isEmpty(list.get(i).getLastOpDate()) ? "" : list.get(i).getLastOpDate());
            hm.put("mem14", DalbitUtil.isEmpty(list.get(i).getLastLoginDatetime()) ? "" : list.get(i).getLastLoginDatetime());
            hm.put("mem15", mem15);

            bodies.add(hm.values().toArray());
        }
        ExcelVo vo = new ExcelVo(headers, headerWidths, bodies);
        SXSSFWorkbook workbook = excelService.excelDownload("목록",vo);
        model.addAttribute("locale", Locale.KOREA);
        model.addAttribute("workbook", workbook);
        model.addAttribute("workbookName", "회원 목록");

        return model;
    }

    @Transactional
    public String updateAdminId(AdminIdVo adminIdVo){

        var adminManagerVo = new AdminManagerVo();
        try {
            var memberBadgeVo = new MemberBadgeVo();
             memberBadgeVo.setMem_no(adminIdVo.getMem_no());
             memberBadgeVo.setSlct_type(6);
             memberBadgeVo.setBadge_value(1);
            if(adminIdVo.getIs_admin() == 0){
                // 운영자 뱃지 등록
                admTestIdDao.deleteMemberBadge(memberBadgeVo);

                // 매니저 해제
                adminManagerVo.setIs_admin(1);
                adminManagerVo.setMem_no(adminIdVo.getMem_no());

                // tb_member_broadcast_manager에서 mem_no 삭제하기
                admTestIdDao.deleteBroadAdminManagerMaster(adminManagerVo);
                // tb_member_broadcast_manager에서 manager_mem_no 삭제하기
                admTestIdDao.deleteBroadAdminManager(adminManagerVo);
            }else{
                // 매니저 등록
                adminManagerVo.setIs_admin(adminIdVo.getIs_admin());
                List<AdminManagerVo> managerList = admTestIdDao.selectAdminManager(adminManagerVo);
                for(int i=0; i<managerList.size(); i++) {
                    // 운영자 아이디로 등록된 회원번호 목록들(내가 버튼을 누른 회원번호)
                    //운영자 아이디를 모두 매니저로 등록
                    adminManagerVo.setManager_mem_no(managerList.get(i).getMem_no());
                    adminManagerVo.setMem_no(adminIdVo.getMem_no());
                    adminManagerVo.setControl("1000000001");
                    admTestIdDao.insertBroadAdminManager(adminManagerVo);

                    //운영자 아이디에 넘어온 mem_no를 매니저로 등록
                    adminManagerVo.setManager_mem_no(adminIdVo.getMem_no());
                    adminManagerVo.setMem_no(managerList.get(i).getMem_no());
                    adminManagerVo.setControl("1000000001");
                    admTestIdDao.insertBroadAdminManager(adminManagerVo);
                }
                admTestIdDao.insertMemberBadge(memberBadgeVo);
            }

            admTestIdDao.updateAdminId(adminIdVo);
            admTestIdDao.updateAdminBadge(adminIdVo);

            if(adminIdVo.getIs_admin() == 0){
                return gsonUtil.toJson(new JsonOutputVo(Status.운영자아이디해제));
            }else{
                 return gsonUtil.toJson(new JsonOutputVo(Status.운영자아이디등록));
            }
        }catch (Exception e){
            return gsonUtil.toJson(new JsonOutputVo(Status.비즈니스로직오류));
        }

    }
}
