package com.dalbit.administrate.dao;

import com.dalbit.administrate.vo.*;
import com.dalbit.common.vo.SearchVo;
import com.dalbit.member.vo.MemberVo;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Repository
public interface Adm_TestIdDao {

    @Transactional(readOnly = true)
    MemberVo getMemberInfo(TestIdVo testIdVo);

    @Transactional(readOnly = true)
    List<TestIdVo> getTestIdInfo(TestIdVo testIdVo);

    int insertTestId(TestIdVo testIdVo);
    int insertTestId_history(TestIdVo testIdVo);

    @Transactional(readOnly = true)
    List<TestIdVo> getTestIdSummary(SearchVo searchVo);

    @Transactional(readOnly = true)
    List<TestIdListVo> getTestIdList(SearchVo searchVo);

    @Transactional(readOnly = true)
    TestIdListVo getCharge(String mem_no);

    void deleteTestId(String[] memNos);

    int updateInner(TestIdVo testIdVo);

    int updateAdminId(AdminIdVo adminIdVo);

    int updateAdminBadge(AdminIdVo adminIdVo);

    int insertMemberBadge(MemberBadgeVo memberBadgeVo);

    int deleteMemberBadge(MemberBadgeVo memberBadgeVo);

    @Transactional(readOnly = true)
    List<AdminManagerVo> selectAdminManager(AdminManagerVo adminManagerVo);

    int insertBroadAdminManager(AdminManagerVo adminManagerVo);

    int deleteBroadAdminManagerMaster(AdminManagerVo adminManagerVo);

    int deleteBroadAdminManager(AdminManagerVo adminManagerVo);
}