package com.dalbit.content.service;

import com.dalbit.content.dao.SitebanDao;
import com.dalbit.content.vo.SitebanVo;
import com.dalbit.excel.service.ExcelService;
import com.dalbit.excel.vo.ExcelVo;
import com.dalbit.util.DalbitUtil;
import com.dalbit.util.JwtUtil;
import com.dalbit.util.SocketUtil;
import com.google.gson.Gson;
import lombok.extern.slf4j.Slf4j;
import org.apache.poi.xssf.streaming.SXSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;

import java.util.*;

@Slf4j
@Service
public class SitebanService {

    @Autowired
    SitebanDao sitebanDao;

    @Autowired
    SocketUtil socketUtil;

    @Autowired
    ExcelService excelService;

    @Autowired
    JwtUtil jwtUtil;

    public SitebanVo selectBanword(SitebanVo paramSitebanVo){
        SitebanVo sitebanVo = sitebanDao.selectBanword(paramSitebanVo);
        return sitebanVo;
    }

    @Transactional(readOnly = false)
    public int updateBanword(SitebanVo sitebanVo){

        int result = sitebanDao.updateBanword(sitebanVo);

        Gson gson = new Gson();
        HashMap<String,Object> message = new HashMap();
        String publicChanel = DalbitUtil.getProperty("socket.global.room");
        message.put("channel", publicChanel);
        message.put("memNo", "");

        HashMap<String,Object> param = new HashMap<>();
        param.put("roomNo", publicChanel);

        Map<String, Object> data =  socketUtil.setSocket(param,"reqBanWord", gson.toJson(message), jwtUtil.generateToken(DalbitUtil.getProperty("temp.memNo"), true));

        return result;
    }

    /**
     * 엑셀
     */
    public Model getListExcel(Model model, SitebanVo sitebanVo) {
        String banWord = sitebanDao.excelBanword(sitebanVo);

        //List<String> list = new ArrayList<String>();
        String[] splitStr = banWord.split("\\|");

        String[] headers = {"No", "ban_word"};
        int[] headerWidths = {3000, 9000};

        List<Object[]> bodies = new ArrayList<>();
        for(int i=0; i<splitStr.length; i++) {
            HashMap hm = new LinkedHashMap();
            hm.put("No", i+1);
            hm.put("ban_word", splitStr[i]);

            bodies.add(hm.values().toArray());
        }

        ExcelVo vo = new ExcelVo(headers, headerWidths, bodies);
        SXSSFWorkbook workbook = excelService.excelDownload("금지어 관리",vo);
        model.addAttribute("locale", Locale.KOREA);
        model.addAttribute("workbook", workbook);
        model.addAttribute("workbookName", "금지어 관리");

        return model;

    }
}