package com.dalbit.member.controller.rest;

import com.dalbit.common.code.Status;
import com.dalbit.common.vo.JsonOutputVo;
import com.dalbit.excel.service.ExcelService;
import com.dalbit.exception.GlobalException;
import com.dalbit.member.service.Mem_WalletService;
import com.dalbit.member.vo.procedure.P_WalletByeolVo;
import com.dalbit.member.vo.procedure.P_WalletDalVo;
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
@RequestMapping("rest/member/wallet")
public class Mem_WalletRestController {

    @Autowired
    Mem_WalletService mem_walletService;

    @Autowired
    ExcelService excelService;

    @Autowired
    GsonUtil gsonUtil;

    /**
     * 내지갑 달 사용 목록
     */
    @PostMapping("dal/list")
    public String dalList(P_WalletDalVo dalVo){
        String result = mem_walletService.callMemberWalletDal(dalVo);
        return result;

    }

    /**
     * 내지갑 달 사용 목록 엑셀 다운로드
     */
    @PostMapping("dal/excel")
    public String dalListExcel(HttpServletRequest request, HttpServletResponse response, Model model, P_WalletDalVo dalVo) throws GlobalException {
        Model resultModel = mem_walletService.getWalletDalListExcel(dalVo, model);
        excelService.renderMergedOutputModel(resultModel.asMap(), request, response);

        return gsonUtil.toJson(new JsonOutputVo(Status.엑셀다운로드성공));
    }


    /**
     * 내지갑 별 사용 목록
     */
    @PostMapping("byeol/list")
    public String byeolList(P_WalletByeolVo byeolVo){
        String result = mem_walletService.callMemberWalletByeol(byeolVo);
        return result;

    }


    /**
     * 내지갑 달 사용 목록 엑셀 다운로드
     */
    @PostMapping("byeol/excel")
    public String byeolListExcel(HttpServletRequest request, HttpServletResponse response, Model model, P_WalletByeolVo byeolVo) throws GlobalException {
        Model resultModel = mem_walletService.getWalletByeolListExcel(byeolVo, model);
        excelService.renderMergedOutputModel(resultModel.asMap(), request, response);

        return gsonUtil.toJson(new JsonOutputVo(Status.엑셀다운로드성공));
    }




    /**
     * 내지갑 달 사용 목록
     */
    @PostMapping("/new/dal/list")
    public String newDalList(P_WalletDalVo dalVo){
        String result = mem_walletService.getNewDalList(dalVo);
        return result;

    }

    /**
     * 내지갑 별 사용 목록
     */
    @PostMapping("/new/byeol/list")
    public String newByeolList(P_WalletByeolVo pByeolVo){
        String result = mem_walletService.getNewByeolList(pByeolVo);
        return result;

    }
}
