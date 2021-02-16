package com.dalbit.common.service;

import com.dalbit.common.dao.CommonMemberDao;
import com.dalbit.common.vo.MemberBadgeVo;
import com.dalbit.common.vo.ProcedureVo;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Slf4j
@Service
public class CommonMemberService {

    @Autowired
    CommonMemberDao commonMemberDao;

    public ProcedureVo memberBadgeAdd(MemberBadgeVo memberBadgeVo){
        ProcedureVo procedureVo = new ProcedureVo(memberBadgeVo);
        commonMemberDao.callMemberBadgeAdd(procedureVo);
        return procedureVo;
    }

    public ProcedureVo memberBadgeDelete(MemberBadgeVo memberBadgeVo){
        ProcedureVo procedureVo = new ProcedureVo(memberBadgeVo);
        commonMemberDao.callMemberBadgeDelete(procedureVo);
        return procedureVo;
    }


}
