package com.dalbit.enter.service;

import com.dalbit.common.code.Status;
import com.dalbit.common.vo.JsonOutputVo;
import com.dalbit.common.vo.ProcedureVo;
import com.dalbit.enter.dao.Ent_NewJoin2Dao;
import com.dalbit.enter.vo.procedure.P_JoinAdbirxOutVo;
import com.dalbit.enter.vo.procedure.P_NewJoin2OutDetailVo;
import com.dalbit.enter.vo.procedure.P_StatVo;
import com.dalbit.excel.service.ExcelService;
import com.dalbit.excel.vo.ExcelVo;
import com.dalbit.member.vo.MemberVo;
import com.dalbit.util.DalbitUtil;
import com.dalbit.util.GsonUtil;
import com.dalbit.util.MessageUtil;
import com.google.gson.Gson;
import lombok.extern.slf4j.Slf4j;
import lombok.var;
import org.apache.poi.xssf.streaming.SXSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import java.util.*;

@Slf4j
@Service
public class Ent_NewJoin2Service {

    @Autowired
    MessageUtil messageUtil;
    @Autowired
    GsonUtil gsonUtil;
    @Autowired
    Ent_NewJoin2Dao ent_NewJoin2Dao;
    @Autowired
    ExcelService excelService;
    /**
     * 회원가입 총계
     * @param pStatVo
     * @return
     */
    public String callInfoDay(P_StatVo pStatVo){
        ProcedureVo procedureVo = new ProcedureVo(pStatVo);
        List<P_NewJoin2OutDetailVo> detailList =  ent_NewJoin2Dao.callInfoDay(procedureVo);

        P_NewJoin2OutDetailVo totalInfo = new Gson().fromJson(procedureVo.getExt(), P_NewJoin2OutDetailVo.class);

        if(Integer.parseInt(procedureVo.getRet()) <= 0){
            return gsonUtil.toJson(new JsonOutputVo(Status.데이터없음));
        }

        pStatVo.setStartDate(pStatVo.getBeforeStartDate());
        pStatVo.setEndDate(pStatVo.getBeforeEndDate());
        procedureVo = new ProcedureVo(pStatVo);
        List<P_NewJoin2OutDetailVo> detailList2 =  ent_NewJoin2Dao.callInfoDay(procedureVo);
        P_NewJoin2OutDetailVo totalInfo2 = new Gson().fromJson(procedureVo.getExt(), P_NewJoin2OutDetailVo.class);

        pStatVo.setStartDate(pStatVo.getTwoAgoStartDate());
        pStatVo.setEndDate(pStatVo.getTwoAgoEndDate());
        procedureVo = new ProcedureVo(pStatVo);
        List<P_NewJoin2OutDetailVo> detailList3 =  ent_NewJoin2Dao.callInfoDay(procedureVo);
        P_NewJoin2OutDetailVo totalInfo3 = new Gson().fromJson(procedureVo.getExt(), P_NewJoin2OutDetailVo.class);

        var result = new HashMap<String, Object>();
        result.put("totalInfo", totalInfo);
        result.put("detailList", detailList);
        result.put("totalInfo2", totalInfo2);
        result.put("detailList2", detailList2);
        result.put("totalInfo3", totalInfo3);
        result.put("detailList3", detailList3);

        return gsonUtil.toJson(new JsonOutputVo(Status.조회, result));
    }

    public String callAdbrixAdd(P_StatVo pStatVo){
        ArrayList<HashMap<String, String>> list = new Gson().fromJson(pStatVo.getAdbrixExcelList(), ArrayList.class);

        try {
            ent_NewJoin2Dao.callAdbrixAdd(list);
            return gsonUtil.toJson(new JsonOutputVo(Status.처리완료));
        }catch (Exception e){
            return gsonUtil.toJson(new JsonOutputVo(Status.비즈니스로직오류));
        }

    }

    /**
     * 애드브릭스 가입자 수치
     */
    public Model adbrixExcel(P_StatVo pStatVo, Model model) {
        ProcedureVo procedureVo = new ProcedureVo(pStatVo);
        List<P_JoinAdbirxOutVo> list =  ent_NewJoin2Dao.callStateAdbrix(procedureVo);

        String[] headers = {"날짜", "전체 가입자", "자연 가입자", "UAC", "오퍼월 IOS+AOS", "메모사항"};
        int[] headerWidths = {3000, 3000, 3000, 3000, 3000, 3000};

        List<Object[]> bodies = new ArrayList<>();
        for(int i = 0; i < list.size(); i++){
            HashMap hm = new LinkedHashMap();
            hm.put("mem1", DalbitUtil.isEmpty(list.get(i).getThe_date()) ? "" : list.get(i).getThe_date());
            hm.put("mem2", DalbitUtil.isEmpty(list.get(i).getTotal_joinCnt()) ? "" : list.get(i).getTotal_joinCnt());
            hm.put("mem3", DalbitUtil.isEmpty(list.get(i).getNatural_joinCnt()) ? "" : list.get(i).getNatural_joinCnt());
            hm.put("mem4", DalbitUtil.isEmpty(list.get(i).getUac()) ? "" : list.get(i).getUac());
            hm.put("mem5", DalbitUtil.isEmpty(list.get(i).getIos_aos()) ? "" : list.get(i).getIos_aos());
            hm.put("mem6", DalbitUtil.isEmpty(list.get(i).getMemo()) ? "" : list.get(i).getMemo());

            bodies.add(hm.values().toArray());
        }
        ExcelVo vo = new ExcelVo(headers, headerWidths, bodies);
        SXSSFWorkbook workbook = excelService.excelDownload("목록",vo);
        model.addAttribute("locale", Locale.KOREA);
        model.addAttribute("workbook", workbook);
        model.addAttribute("workbookName", "애드브릭스 가입자 수치");

        return model;
    }



    /**
     * 애드브릭스 총계
     * @param pStatVo
     * @return
     */
    public String callStateAdbrix(P_StatVo pStatVo){
        ProcedureVo procedureVo = new ProcedureVo(pStatVo);
        List<P_JoinAdbirxOutVo> detailList =  ent_NewJoin2Dao.callStateAdbrix(procedureVo);
        P_JoinAdbirxOutVo totalInfo = new Gson().fromJson(procedureVo.getExt(), P_JoinAdbirxOutVo.class);

        if(Integer.parseInt(procedureVo.getRet()) <= 0){
            return gsonUtil.toJson(new JsonOutputVo(Status.데이터없음));
        }

        var result = new HashMap<String, Object>();
        result.put("totalInfo", totalInfo);
        result.put("detailList", detailList);

        return gsonUtil.toJson(new JsonOutputVo(Status.조회, result));
    }

    /**
     * 애드브릭스 메모
     * @param pStatVo
     * @return
     */
    public String callStateAdbrixMemo(P_StatVo pStatVo){
        P_JoinAdbirxOutVo outVo =  ent_NewJoin2Dao.callStateAdbrixMemo(pStatVo);

        return gsonUtil.toJsonAdm(new JsonOutputVo(Status.조회, outVo));
    }


    public String adbrixMemoEdit(P_StatVo pStatVo){
        pStatVo.setOp_name(MemberVo.getMyMemNo());

        if(pStatVo.getGubun().equals("insert")){
            ent_NewJoin2Dao.adbrixMemoAdd(pStatVo);
        }else if(pStatVo.getGubun().equals("update")){
            ent_NewJoin2Dao.adbrixMemoUpd(pStatVo);
        }else if(pStatVo.getGubun().equals("delete")){
            ent_NewJoin2Dao.adbrixMemoDel(pStatVo);
        }

        return gsonUtil.toJson(new JsonOutputVo(Status.처리완료));
    }

}
