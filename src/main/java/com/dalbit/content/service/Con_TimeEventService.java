package com.dalbit.content.service;

import com.dalbit.common.code.Status;
import com.dalbit.common.vo.JsonOutputVo;
import com.dalbit.common.vo.PagingVo;
import com.dalbit.content.dao.Con_ChuseokEventDao;
import com.dalbit.content.dao.Con_TimeEventDao;
import com.dalbit.content.vo.ChuseokEventVo;
import com.dalbit.content.vo.TimeEventVo;
import com.dalbit.content.vo.procedure.P_bannerInsertVo;
import com.dalbit.content.vo.procedure.P_bannerUpdateVo;
import com.dalbit.member.vo.MemberVo;
import com.dalbit.util.DalbitUtil;
import com.dalbit.util.GsonUtil;
import com.dalbit.util.MessageUtil;
import lombok.extern.slf4j.Slf4j;
import lombok.var;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Slf4j
@Service
public class Con_TimeEventService {

    @Autowired
    Con_TimeEventDao conTimeEventDao;
    @Autowired
    MessageUtil messageUtil;
    @Autowired
    GsonUtil gsonUtil;

    @Autowired
    Con_BannerService conBannerService;

    /**
     * 타임 이벤트 목록 조회
     */
    public String selectTimeList(TimeEventVo timeEventVo) {

        int totalCnt = conTimeEventDao.selectTimeListCnt(timeEventVo);
        timeEventVo.setTotalCnt(totalCnt);

        List<TimeEventVo> list = conTimeEventDao.selectTimeList(timeEventVo);
        String result = gsonUtil.toJson(new JsonOutputVo(Status.조회, list, new PagingVo(timeEventVo.getTotalCnt(), timeEventVo.getPageStart(), timeEventVo.getPageCnt())));

        return result;
    }

    public String selectTimeDetail(TimeEventVo timeEventVo){
        TimeEventVo detail = conTimeEventDao.selectTimeDetail(timeEventVo);

        String result = "";
        if(DalbitUtil.isEmpty(detail)){
            result = gsonUtil.toJson(new JsonOutputVo(Status.데이터없음));
        }else{
            result = gsonUtil.toJson(new JsonOutputVo(Status.조회, detail));
        }

        return result;
    }

    public String saveTimeEvent(TimeEventVo timeEventVo){

        //배너 공통 파라메터
        String banner_title = "[타임이벤트]"+timeEventVo.getStart_date() + " ~ " + timeEventVo.getEnd_date();
        String banner_platform = timeEventVo.getPlatform();
        int banner_ios_judge_view_on = timeEventVo.getIos_judge_view_on();
        int banner_view_type = 0;
        int banner_sex = 1;
        int banner_frequency_rate = 100;
        int banner_term_type = 1;
        String banner_start_datetime = timeEventVo.getStart_date().replace(".", "").replace(":", "");
        String banner_end_datetime = timeEventVo.getEnd_date().replace(".", "").replace(":", "");
        int banner_is_pop = 0;
        int banner_is_view = 1;
        String banner_desc = "타임이벤트 등록 시 자동으로 등록된 배너입니다.";
        String week_time_type = "0";

        if(timeEventVo.getIdx() == 0){

            //메인 탑 배너 등록
            var mainTopBanner = new P_bannerInsertVo();
            mainTopBanner.setTitle(banner_title);
            mainTopBanner.setPlatform(banner_platform);
            mainTopBanner.setIosJudgeViewOn(banner_ios_judge_view_on);
            mainTopBanner.setView_type(banner_view_type);
            mainTopBanner.setSex(banner_sex);
            mainTopBanner.setFrequency_rate(banner_frequency_rate);
            mainTopBanner.setTerm_type(banner_term_type);
            mainTopBanner.setStart_datetime(banner_start_datetime);
            mainTopBanner.setEnd_datetime(banner_end_datetime);
            mainTopBanner.setIs_pop(banner_is_pop);
            mainTopBanner.setIs_view(banner_is_view);
            mainTopBanner.setPosition(1); //메인 탑
            mainTopBanner.setPc_img_url(timeEventVo.getMain_top_pc_image_url());
            mainTopBanner.setMobile_img_url(timeEventVo.getMain_top_mobile_image_url());
            //링크 적용 시에만 url 등록
            mainTopBanner.setPc_link_url(timeEventVo.getMain_top_banner_link_yn() == 1 ? timeEventVo.getPc_link_url() : "");
            mainTopBanner.setMobile_link_url(timeEventVo.getMain_top_banner_link_yn() == 1 ? timeEventVo.getMobile_link_url() : "");

            mainTopBanner.setOpName(MemberVo.getMyMemNo());
            mainTopBanner.setDesc(banner_desc);
            mainTopBanner.setContent_scheduleWeekTime(week_time_type);


            //메인 센터 배너 등록
            var mainCenterBanner = new P_bannerInsertVo();
            mainCenterBanner.setTitle(banner_title);
            mainCenterBanner.setPlatform(banner_platform);
            mainCenterBanner.setIosJudgeViewOn(banner_ios_judge_view_on);
            mainCenterBanner.setView_type(banner_view_type);
            mainCenterBanner.setSex(banner_sex);
            mainCenterBanner.setFrequency_rate(banner_frequency_rate);
            mainCenterBanner.setTerm_type(banner_term_type);
            mainCenterBanner.setStart_datetime(banner_start_datetime);
            mainCenterBanner.setEnd_datetime(banner_end_datetime);
            mainCenterBanner.setIs_pop(banner_is_pop);
            mainCenterBanner.setIs_view(banner_is_view);
            mainCenterBanner.setPosition(9); //메인 센터
            mainCenterBanner.setPc_img_url(timeEventVo.getMain_center_pc_image_url());
            mainCenterBanner.setMobile_img_url(timeEventVo.getMain_center_mobile_image_url());
            //링크 적용 시에만 url 등록
            mainCenterBanner.setPc_link_url(timeEventVo.getMain_center_banner_link_yn() == 1 ? timeEventVo.getPc_link_url() : "");
            mainCenterBanner.setMobile_link_url(timeEventVo.getMain_center_banner_link_yn() == 1 ? timeEventVo.getMobile_link_url() : "");

            mainCenterBanner.setOpName(MemberVo.getMyMemNo());
            mainCenterBanner.setDesc(banner_desc);
            mainCenterBanner.setContent_scheduleWeekTime(week_time_type);

            //스토어 배너 등록
            var storeBanner = new P_bannerInsertVo();
            storeBanner.setTitle(banner_title);
            storeBanner.setPlatform(banner_platform);
            storeBanner.setIosJudgeViewOn(banner_ios_judge_view_on);
            storeBanner.setView_type(banner_view_type);
            storeBanner.setSex(banner_sex);
            storeBanner.setFrequency_rate(banner_frequency_rate);
            storeBanner.setTerm_type(banner_term_type);
            storeBanner.setStart_datetime(banner_start_datetime);
            storeBanner.setEnd_datetime(banner_end_datetime);
            storeBanner.setIs_pop(banner_is_pop);
            storeBanner.setIs_view(banner_is_view);
            storeBanner.setPosition(4); //스토어
            storeBanner.setPc_img_url(timeEventVo.getStore_pc_image_url());
            storeBanner.setMobile_img_url(timeEventVo.getStore_mobile_image_url());
            //링크 적용 시에만 url 등록
            storeBanner.setPc_link_url(timeEventVo.getStore_banner_link_yn() == 1 ? timeEventVo.getPc_link_url() : "");
            storeBanner.setMobile_link_url(timeEventVo.getStore_banner_link_yn() == 1 ? timeEventVo.getMobile_link_url() : "");

            storeBanner.setOpName(MemberVo.getMyMemNo());
            storeBanner.setDesc(banner_desc);
            storeBanner.setContent_scheduleWeekTime(week_time_type);

            //메인탑 배너 등록
            conBannerService.callContentsBannerAdd(mainTopBanner);
            timeEventVo.setMain_top_banner_idx(mainTopBanner.getIdx());

            //메인센터 배너 등록
            conBannerService.callContentsBannerAdd(mainCenterBanner);
            timeEventVo.setMain_center_banner_idx(mainCenterBanner.getIdx());

            //스토어 배너 등록
            conBannerService.callContentsBannerAdd(storeBanner);
            timeEventVo.setStore_banner_idx(storeBanner.getIdx());

            //타임 이벤트 등록
            timeEventVo.setView_yn(1);
            timeEventVo.setState(0);
            conTimeEventDao.insertTimeEvent(timeEventVo);

        }else{
           /* //메인탑 배너 수정
            conBannerService.callContentsBannerEdit(mainTopBanner);
            timeEventVo.setMain_top_banner_idx(mainTopBanner.getIdx());

            //메인센터 배너 수정
            conBannerService.callContentsBannerAdd(mainCenterBanner);
            timeEventVo.setMain_center_banner_idx(mainCenterBanner.getIdx());

            //스토어 배너 수정
            conBannerService.callContentsBannerAdd(storeBanner);
            timeEventVo.setStore_banner_idx(storeBanner.getIdx());*/

            //타임 이벤트 수정
            timeEventVo.setView_yn(1);
            timeEventVo.setState(0);
            conTimeEventDao.insertTimeEvent(timeEventVo);
        }


        return gsonUtil.toJson(new JsonOutputVo(Status.수정));
    }

}
