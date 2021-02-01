package com.dalbit.customer.controller.rest;

import com.dalbit.common.code.Status;
import com.dalbit.common.vo.JsonOutputVo;
import com.dalbit.member.dao.Mem_MemberDao;
import com.dalbit.member.vo.MemberVo;
import com.dalbit.member.vo.procedure.P_MemberInfoInputVo;
import com.dalbit.util.DalbitUtil;
import com.dalbit.util.GsonUtil;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;


@Slf4j
@RestController
@RequestMapping("rest/customer/member")
public class Cus_MemberRestController {

    @Autowired
    GsonUtil gsonUtil;

    @Autowired
    Mem_MemberDao mem_MemberDao;


    /**
     * 회원 정보
     */
    @PostMapping("info")
    public String memberInfo(P_MemberInfoInputVo pMemberInfoInputVo){
        MemberVo memInfoOutVo = DalbitUtil.getMemInfo(pMemberInfoInputVo.getMem_no());

        return gsonUtil.toJson(new JsonOutputVo(Status.조회, memInfoOutVo));
    }
}
