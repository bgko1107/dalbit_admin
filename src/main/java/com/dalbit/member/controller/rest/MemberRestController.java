package com.dalbit.member.controller.rest;

import com.dalbit.common.code.Status;
import com.dalbit.common.vo.JsonOutputVo;
import com.dalbit.member.vo.MemberVo;
import com.dalbit.sample.service.SampleService;
import com.dalbit.util.DalbitUtil;
import com.dalbit.util.GsonUtil;
import com.google.gson.JsonObject;
import lombok.extern.slf4j.Slf4j;
import net.minidev.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.io.BufferedReader;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

@Slf4j
@RestController
@RequestMapping("rest/member/member")
public class MemberRestController {

    @Autowired
    SampleService sampleService;

    @Autowired
    GsonUtil gsonUtil;


    /**
     * 회원리스트
     * @param model
     * @return
     */

    @PostMapping("list")
    public String list(Model model){
        ArrayList<HashMap> list = new ArrayList<HashMap>();
        HashMap map = new HashMap();
        for(int i=0; i++ <20;) {
            map.put("NO", "NO");
            map.put("MemNo", "99999999999");
            map.put("UserID", "DaldalE");
            map.put("NickName", "다달이");
            map.put("Name", "양달님");
            map.put("PhoneNum", "010-9941-0000");
            map.put("JoinPlatform", "달빛");
            map.put("Login_out", "Login");
            map.put("Live", "생방중♠");


            list.add(map);
        }
        return gsonUtil.toJson(new JsonOutputVo(Status.조회, list));
    }

    //@PostMapping("")        //formdata
    @RequestMapping(value="info", produces="text/plain;Charset=UTF-8")
    @ResponseBody
    public ModelAndView info(HttpServletRequest request, @RequestBody Map<String, Object> params){
        String memNo = (String) params.get("mem_no");
        log.info("memNo: {}", memNo);

        log.info(request.getParameter("men_no"));

        ModelAndView mv = new ModelAndView();
        mv.addObject("memNo", memNo);


        log.info(DalbitUtil.convertRequestParamToString(request, "men_no"));

        //String memNo = DalbitUtil.convertRequestParamToString(request, "men_no");

        return mv;
    }

    private String readJSONStringFromRequestBody(HttpServletRequest request){
        StringBuffer json = new StringBuffer();
        String line = null;

        try {
            BufferedReader reader = request.getReader();
            while((line = reader.readLine()) != null) {
                json.append(line);
            }

        }catch(Exception e) {
            System.out.println("Error reading JSON string: " + e.toString());
        }
        return json.toString();
    }

}
