package com.dalbit.clip.controller.rest;

import com.dalbit.clip.service.Cli_ClipCategoryService;
import com.dalbit.clip.vo.procedure.P_ClipRank;
import com.dalbit.clip.vo.procedure.P_ClipRecommend;
import com.dalbit.common.code.Status;
import com.dalbit.common.service.CommonService;
import com.dalbit.common.vo.CodeVo;
import com.dalbit.common.vo.JsonOutputVo;
import com.dalbit.content.service.ThemeService;
import com.dalbit.content.vo.ThemeVo;
import com.dalbit.util.GsonUtil;
import com.google.gson.Gson;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

@Slf4j
@RestController
@RequestMapping("rest/clip/category")
public class Cli_ClipCategoryRestController {

    @Autowired
    GsonUtil gsonUtil;

    @Autowired
    Cli_ClipCategoryService cliClipCategoryService;
    @Autowired
    CommonService commonService;
    @Autowired
    ThemeService themeService;

    @PostMapping("clip/list")
    public String clipCodeList(HttpServletRequest request, ThemeVo splashVo) {
        List<CodeVo> roomTypeList = commonService.getCodeList("clipType");

        return gsonUtil.toJson(new JsonOutputVo(Status.조회, roomTypeList));
    }

    @PostMapping("clip/submit")
    public String clipCodeUpdate(HttpServletRequest request) {
        String codeType = request.getParameter("codeType");
        String codeVoArr = request.getParameter("codeVoArr");

        CodeVo[] codeVos = new Gson().fromJson(codeVoArr, CodeVo[].class);

        themeService.callContentsThemeEdit(codeType, codeVos);
        //API splash Reload
        themeService.sendSplashApi();

        return gsonUtil.toJson(new JsonOutputVo(Status.수정));
    }


    /**
     * 클립 랭킹 조회
     */
    @PostMapping("/rank/list")
    public String callClipRankList(P_ClipRank pClipRank) {
        String result = cliClipCategoryService.callClipRankList(pClipRank);
        return result;
    }

    /**
     * 주간 클립 테이블 조회
     */
    @PostMapping("/recommend/list")
    public String callClipRecommendList(P_ClipRecommend pClipRecommend) {
        String result = cliClipCategoryService.callClipRecommendList(pClipRecommend);
        return result;
    }

    /**
     * 주간 클립 테이블 등록
     */
    @PostMapping("/recommend/edit")
    public String callClipRecommendEdit(P_ClipRecommend pClipRecommend) {
        String result = cliClipCategoryService.callClipRecommendEdit(pClipRecommend);
        return result;
    }

    /**
     * 주간 클립 테이블 상세 정보
     */
    @PostMapping("/recommend/detail")
    public String callClipRecommendDetail(P_ClipRecommend pClipRecommend) {
        String result = cliClipCategoryService.callClipRecommendDetail(pClipRecommend);
        return result;
    }

    /**
     * 주간 클립 테이블 삭제
     */
    @PostMapping("/recommend/delete")
    public String callClipRecommendDelete(P_ClipRecommend pClipRecommend) {
        String result = cliClipCategoryService.callClipRecommendDelete(pClipRecommend);
        return result;
    }

    @PostMapping("recommend/leaderCheck")
    public String getLeaderCheck(P_ClipRecommend pClipRecommend) {
        String result = cliClipCategoryService.getLeaderCheck(pClipRecommend);
        return result;
    }

}
