package com.dalbit.sample.service;

import com.dalbit.common.code.Status;
import com.dalbit.common.vo.JsonOutputVo;
import com.dalbit.common.vo.PagingVo;
import com.dalbit.excel.service.ExcelService;
import com.dalbit.excel.vo.ExcelVo;
import com.dalbit.sample.dao.SampleDao;
import com.dalbit.sample.vo.ErrorVo;
import com.dalbit.sample.vo.SampleVo;
import com.dalbit.util.DalbitUtil;
import com.dalbit.util.GsonUtil;
import lombok.extern.slf4j.Slf4j;
import org.apache.poi.xssf.streaming.SXSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import java.util.*;

@Slf4j
@Service
public class SampleService {

    @Autowired
    ExcelService excelService;

    @Autowired
    private SampleDao sampleDao;

    @Autowired
    GsonUtil gsonUtil;

    public int getCount(){
        int cnt = sampleDao.getCount();
        return cnt;
    }

    public List<SampleVo> getList(){
        List<SampleVo> list = sampleDao.getList();
        return list;
    }

    public void transactionTest(SampleVo sampleVo){

        sampleDao.insertSample(sampleVo);
        String[] arr = new String[1];
        log.error(arr[2]);

    }

    /**
     * 에러 데이터 로그 조회
     */
    public String getLogErrorData(ErrorVo errorVo) {

        errorVo.setPageStart(errorVo.getPageStart() -1);
        errorVo.setPageStart(errorVo.getPageStart() * errorVo.getPageCnt());

        int getLogErrorDataCnt = sampleDao.getLogErrorDataCnt(errorVo);
        errorVo.setTotalCnt(getLogErrorDataCnt);

        List<ErrorVo> errorList = sampleDao.getLogErrorData(errorVo);


        String result = gsonUtil.toJson(new JsonOutputVo(Status.조회, errorList, new PagingVo(errorVo.getTotalCnt(), errorVo.getPageStart(), errorVo.getPageCnt())));
        return result;
    }

    /**
     * 에러 데이터 로그 엑셀 출력
     */
    public Model getErrorListExcel (ErrorVo errorVo, Model model) {
        int getLogErrorDataCnt = sampleDao.getLogErrorDataCnt(errorVo);
        errorVo.setTotalCnt(getLogErrorDataCnt);

        List<ErrorVo> list = sampleDao.getLogErrorData(errorVo);

        String[] headers = {"idx", "mem_no", "ostype", "version", "build", "dtype", "ctype", "desc", "upd_date"};
        int[] headerWidths = {3000, 3000, 3000, 3000, 3000, 3000, 3000, 20000, 6000};

        List<Object[]> bodies = new ArrayList<>();
        for(int i=0; i<list.size(); i++) {
            HashMap hm = new LinkedHashMap();

            hm.put("idx", DalbitUtil.isEmpty(list.get(i).getIdx()) ? "" : list.get(i).getIdx());
            hm.put("mem_no", DalbitUtil.isEmpty(list.get(i).getMem_no()) ? "" : list.get(i).getMem_no());
            hm.put("ostype", DalbitUtil.isEmpty(list.get(i).getOstype()) ? "" : list.get(i).getOstype());
            hm.put("version", DalbitUtil.isEmpty(list.get(i).getVersion()) ? "" : list.get(i).getVersion());
            hm.put("build", DalbitUtil.isEmpty(list.get(i).getBuild()) ? "" : list.get(i).getBuild());
            hm.put("dtype", DalbitUtil.isEmpty(list.get(i).getDtype()) ? "" : list.get(i).getDtype());
            hm.put("ctype", DalbitUtil.isEmpty(list.get(i).getCtype()) ? "" : list.get(i).getCtype());
            hm.put("desc", DalbitUtil.isEmpty(list.get(i).getDesc()) ? "" : list.get(i).getDesc());
            hm.put("upd_date", DalbitUtil.isEmpty(list.get(i).getUpd_date()) ? "" : list.get(i).getUpd_date());

            bodies.add(hm.values().toArray());
        }

        ExcelVo vo = new ExcelVo(headers, headerWidths, bodies);
        SXSSFWorkbook workbook = excelService.excelDownload("Error log",vo);
        model.addAttribute("locale", Locale.KOREA);
        model.addAttribute("workbook", workbook);
        model.addAttribute("workbookName", "Error log");

        return model;
    }
}
