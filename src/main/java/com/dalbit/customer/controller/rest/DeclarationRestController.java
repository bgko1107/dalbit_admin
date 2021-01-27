package com.dalbit.customer.controller.rest;

import com.dalbit.common.code.Status;
import com.dalbit.common.vo.JsonOutputVo;
import com.dalbit.common.vo.ProcedureVo;
import com.dalbit.customer.service.DeclarationService;
import com.dalbit.customer.vo.procedure.P_DeclarationDetailInputVo;
import com.dalbit.customer.vo.procedure.P_DeclarationListInputVo;
import com.dalbit.customer.vo.procedure.P_DeclarationOperateCntInputVo;
import com.dalbit.customer.vo.procedure.P_DeclarationOperateVo;
import com.dalbit.excel.service.ExcelService;
import com.dalbit.exception.GlobalException;
import com.dalbit.member.vo.MemberVo;
import com.dalbit.member.vo.procedure.P_MemberReportVo;
import com.dalbit.util.DalbitUtil;
import com.dalbit.util.GsonUtil;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;



@Slf4j
@RestController
@RequestMapping("rest/customer/declaration")
public class DeclarationRestController {

    @Autowired
    DeclarationService declarationService;

    @Autowired
    ExcelService excelService;

    @Autowired
    GsonUtil gsonUtil;


    /**
     * 신고 목록 조회
     */
    @PostMapping("list")
    public String list(P_DeclarationListInputVo pDeclarationListInputVo) {

        String result = declarationService.callServiceCenterReportList(pDeclarationListInputVo);

        return result;
    }

    /**
     * 신고 목록 엑셀
     */
    @PostMapping("listExcel")
    public String listExcel(HttpServletRequest request, HttpServletResponse response, Model model, P_DeclarationListInputVo pDeclarationListInputVo) throws GlobalException {

        Model resultModel = declarationService.getListExcel(pDeclarationListInputVo, model);

        excelService.renderMergedOutputModel(resultModel.asMap(), request, response);
        return gsonUtil.toJson(new JsonOutputVo(Status.엑셀다운로드성공));

    }


    /**
     * 신고 목록 상세 조회
     */
    @PostMapping("detail")
    public String detail(P_DeclarationDetailInputVo pDeclarationDetailInputVo) {

        String result = declarationService.callServiceCenterReportDetail(pDeclarationDetailInputVo);

        return result;
    }

    /**
     * 신고 처리
     */
    @PostMapping("operate")
    public String operate(P_DeclarationOperateVo pDeclarationOperateVo) {

        String result = declarationService.callServiceCenterReportOperate(pDeclarationOperateVo);

        return result;
    }

    /**
     * 신고 처리
     */
    @PostMapping("multi/operate")
    public String multiOperate(P_DeclarationOperateVo pDeclarationOperateVo) {

        String result = declarationService.callServiceCenterReportMultiOperate(pDeclarationOperateVo);

        return result;
    }

    /**
     * 신고 처리 내역 건 수
     */
    @PostMapping("opCount")
    public String opCount(ProcedureVo procedureVo) {

        String result = declarationService.callServiceCenterReportOpCount(procedureVo);

        return result;
    }

    /**
     * 회원 신고 처리 내역 건 수
     */
    @PostMapping("opCount_target")
    public String opCount_target(P_DeclarationOperateCntInputVo pDeclarationOperateCntInputVo) {
        String result = declarationService.callServiceCenterReportOpCountTarget(pDeclarationOperateCntInputVo);
        return result;
    }

    /**
     * 신고 목록 조회
     */
    @PostMapping("image/list")
    public String imageList(P_DeclarationListInputVo pDeclarationListInputVo) {

        String result = declarationService.callImageList(pDeclarationListInputVo);

        return result;
    }

    /**
     * 이미지 신고 처리
     */
    @PostMapping("image/operate")
    public String imageOperate(P_MemberReportVo pMemberReportVo, HttpServletRequest request) throws GlobalException {

        pMemberReportVo.setOpName(MemberVo.getMyMemNo());
        pMemberReportVo.setBrowser(DalbitUtil.getUserAgent(request));

        String result = declarationService.callImageOperate(pMemberReportVo);

        return result;
    }
}
