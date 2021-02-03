package com.dalbit.content.controller.rest;

import com.dalbit.content.service.Con_ServicePolicyService;
import com.dalbit.content.vo.procedure.P_ServicePolicyVo;
import com.dalbit.excel.service.ExcelService;
import com.dalbit.util.GsonUtil;
import com.dalbit.util.MessageUtil;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;


@Slf4j
@RestController
@RequestMapping("rest/content/service")
public class Con_ServicePolicyRestController {

    @Autowired
    Con_ServicePolicyService conServicePolicyService;

    @Autowired
    ExcelService excelService;

    @Autowired
    GsonUtil gsonUtil;

    @Autowired
    MessageUtil messageUtil;

    /**
     * 서비스 정책 관리
     */
    @PostMapping("/policy/list")
    public String policyList(P_ServicePolicyVo pServicePolicyVo) {
        String result = conServicePolicyService.callServicePolicyList(pServicePolicyVo);
        return result;
    }

    /**
     * 서비스 정책관리
     */
    @PostMapping("/policy/edit")
    public String policyEdit(P_ServicePolicyVo pServicePolicyVo) {
        String result = conServicePolicyService.callServicePolicyEdit(pServicePolicyVo);
        return result;
    }

    /**
     * 서비스 정책관리 상세
     */
    @PostMapping("/policy/detail")
    public String policyDetail(P_ServicePolicyVo pServicePolicyVo) {
        String result = conServicePolicyService.callServicePolicyDetail(pServicePolicyVo);
        return result;
    }

    /**
     * 서비스 정책관리 삭제
     */
    @PostMapping("policy/delete")
    public String policyDelete(P_ServicePolicyVo pServicePolicyVo) {
        String result = conServicePolicyService.callServicePolicyDelete(pServicePolicyVo);
        return result;
    }

}
