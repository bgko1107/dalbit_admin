package com.dalbit.broadcast.service;

import com.dalbit.broadcast.dao.Bro_BroadcastDao;
import com.dalbit.broadcast.vo.procedure.*;
import com.dalbit.common.code.Status;
import com.dalbit.common.dao.CommonDao;
import com.dalbit.common.vo.*;
import com.dalbit.excel.service.ExcelService;
import com.dalbit.excel.vo.ExcelVo;
import com.dalbit.member.dao.Mem_MemberDao;
import com.dalbit.member.vo.MemberVo;
import com.dalbit.member.vo.procedure.P_MemberInfoOutputVo;
import com.dalbit.util.*;
import com.google.gson.Gson;
import lombok.extern.slf4j.Slf4j;
import okhttp3.Response;
import org.apache.poi.xssf.streaming.SXSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import javax.servlet.http.HttpServletRequest;
import java.text.SimpleDateFormat;
import java.util.*;

@Slf4j
@Service
public class Bro_BroadcastService {

    @Autowired
    Bro_BroadcastDao bro_BroadcastDao;
    @Autowired
    Mem_MemberDao mem_MemberDao;
    @Autowired
    CommonDao commonDao;
    @Autowired
    MessageUtil messageUtil;
    @Autowired
    GsonUtil gsonUtil;
    @Autowired
    ExcelService excelService;
    @Autowired
    SocketUtil socketUtil;
    @Autowired
    JwtUtil jwtUtil;

    @Value("${server.ant.url}")
    private String antServer;

    @Value("${ant.expire.hour}")
    private int antExpire;

    @Value("${ant.app.name}")
    private String antName;

    @Value("${wowza.wss.url}")
    private String WOWZA_WSS_URL;
    @Value("${wowza.real.server}")
    private String[] WOWZA_REAL_SERVER;
    @Value("${wowza.prefix}")
    private String WOWZA_PREFIX;
    @Value("${wowza.suffix}")
    private String WOWZA_SUFFIX;

    /**
     * 생방송 list 목록
     */
    public String callBroadcastList(P_BroadcastListInputVo pBroadcastListInputVo){
        ProcedureVo procedureVo = new ProcedureVo(pBroadcastListInputVo);
        ArrayList<P_BroadcastListOutputVo> broadList = bro_BroadcastDao.callBroadcastList(procedureVo);
        P_BroadcastListOutputVo summary = new Gson().fromJson(procedureVo.getExt(), P_BroadcastListOutputVo.class);

        // 종료된 총 방송방 정보 조회
        ArrayList<P_BroadcastListOutputVo> osCntList = bro_BroadcastDao.callBroadcastList_all(pBroadcastListInputVo);
        if(!DalbitUtil.isEmpty(osCntList)) {
            summary.setTotalBroadCastCnt(osCntList.get(0).getTotalBroadCastCnt());
            summary.setTotalAosCnt(osCntList.get(0).getTotalAosCnt());
            summary.setTotalIosCnt(osCntList.get(0).getTotalIosCnt());
            summary.setTotalPcCnt(osCntList.get(0).getTotalPcCnt());
        }

        ArrayList<P_BroadcastListOutputVo> djTypeCntList = bro_BroadcastDao.callBroadcastListDjType(pBroadcastListInputVo);
        if(!DalbitUtil.isEmpty(djTypeCntList)) {
            summary.setNormalDjCnt(djTypeCntList.get(0).getNormalDjCnt());
            summary.setNewDjCnt(djTypeCntList.get(0).getNewDjCnt());
            summary.setSpecialDjCnt(djTypeCntList.get(0).getSpecialDjCnt());
            summary.setNewCnt(djTypeCntList.get(0).getNewCnt());
        }

        // 오늘 년도
        String year = DalbitUtil.getDate("yyyy");

        for(int i=0;i < broadList.size(); i++){

//            fanBadgeList   주간/일간 탑DJ/팽 1,2,3
            //DB부하로 인해 주석처리
            /*HashMap fanBadgeMap = new HashMap();
            fanBadgeMap.put("mem_no", broadList.get(i).getDj_mem_no());
            fanBadgeMap.put("type", -1);
            List fanBadgeList = commonDao.callMemberBadgeSelect(fanBadgeMap);
            broadList.get(i).setFanBadgeList(fanBadgeList);*/

//            liveBadgeList    실시간1,2,3 / 회장,부회장,사장,부장,팀장
            //DB부하로 인해 주석처리
            /*HashMap liveBadgeMap = new HashMap();
            liveBadgeMap.put("mem_no", broadList.get(i).getDj_mem_no());
            liveBadgeMap.put("type", -1);
            List liveBadgeList = commonDao.callLiveBadgeSelect(liveBadgeMap);
            for(int j = (liveBadgeList.size() -1); j > -1; j--){
                if(DalbitUtil.isEmpty(((FanBadgeVo)liveBadgeList.get(j)).getIcon())){
                    liveBadgeList.remove(j);
                }
            }*/
            broadList.get(i).setLiveBadgeList(null);

            if(DalbitUtil.isEmpty(broadList.get(i).getDj_nickname())){
                MemberVo memInfoOutVo = mem_MemberDao.getMemberInfo(broadList.get(i).getDj_mem_no());
                if(!DalbitUtil.isEmpty(memInfoOutVo)) {
                    broadList.get(i).setDj_userid(memInfoOutVo.getMem_id());
                    broadList.get(i).setDj_nickname("탈퇴회원");
                    broadList.get(i).setDj_birth_year(memInfoOutVo.getMem_birth_year());
                    broadList.get(i).setDj_birth_month(memInfoOutVo.getMem_birth_month());
                    broadList.get(i).setDj_birth_day(memInfoOutVo.getMem_birth_day());
                    broadList.get(i).setDj_korean_age(Integer.toString(Integer.parseInt(year) - Integer.parseInt(memInfoOutVo.getMem_birth_year()) + 1));
                }
            }
        }

        String result;
        if(Integer.parseInt(procedureVo.getRet()) > 0) {
            result = gsonUtil.toJson(new JsonOutputVo(Status.방송기록보기성공, broadList, new PagingVo(procedureVo.getRet()),summary));
        }else{
            result = gsonUtil.toJson(new JsonOutputVo(Status.방송기록보기실패));
        }
        return result;
    }

    /**
     * 실시간 최신 생방송 엑셀
     */
    public Model callLiveListExcel(P_BroadcastListInputVo pBroadcastListInputVo, Model model) {
        pBroadcastListInputVo.setPageCnt(100000);
        ProcedureVo procedureVo = new ProcedureVo(pBroadcastListInputVo);

        List<P_BroadcastListOutputVo> list = bro_BroadcastDao.callBroadcastList(procedureVo);

        String[] headers = {"No", "방송주제", "방송제목", "프로필이미지", "태그부분"
                            , "DJID", "User 닉네임", "방송시작일시", "방송종료일시" , "진행시간"
                            , "실시간청취자", "누적청취자","좋아요", "부스터", "선물", "받은 별", "사연", "팬수"
                            , "강제퇴장", "방송연장", "이어하기"};
        int[] headerWidths = {3000, 3000, 6000, 6000, 6000
                            , 6000, 6000, 6000, 6000, 3000
                            , 3000, 3000, 3000, 3000, 3000, 3000, 3000, 3000
                            , 3000, 3000, 3000};

        List<Object[]> bodies = new ArrayList<>();
        for(int i = 0; i < list.size(); i++){
            HashMap hm = new LinkedHashMap();

            hm.put("no", list.size()-i);
            hm.put("mem2",  DalbitUtil.isEmpty(list.get(i).getSubjectType())     ? "" : list.get(i).getSubjectType());
            hm.put("mem3",  DalbitUtil.isEmpty(list.get(i).getTitle())           ? "" : list.get(i).getTitle());
            hm.put("mem4",  DalbitUtil.isEmpty(list.get(i).getDj_profileImage()) ? "" : list.get(i).getDj_profileImage());
            String tmp = "";
            if(list.get(i).getRecommBadge() == 1)tmp = "추천 ";
            if(list.get(i).getPopularBadge() == 1)tmp = tmp + "인기 ";
            if(list.get(i).getNewjdBadge() == 1)tmp = tmp + "신입";
            hm.put("mem5", tmp);
            hm.put("mem7",  DalbitUtil.isEmpty(list.get(i).getDj_userid()) ? "" : list.get(i).getDj_userid());
            hm.put("mem8",  DalbitUtil.isEmpty(list.get(i).getDj_nickname()) ? "" : list.get(i).getDj_nickname());
            hm.put("mem11", DalbitUtil.isEmpty(list.get(i).getStartDateFormat()) ? "" : list.get(i).getStartDateFormat());
            hm.put("mem12", DalbitUtil.isEmpty(list.get(i).getEndDateFormat()) ? "" : list.get(i).getEndDateFormat());
            hm.put("mem13", DalbitUtil.isEmpty(list.get(i).getAirTime()) ? "" : list.get(i).getAirTime());
            hm.put("mem14", DalbitUtil.isEmpty(list.get(i).getLiveListener()) ? "" : list.get(i).getLiveListener());
            hm.put("mem15", DalbitUtil.isEmpty(list.get(i).getTotalListener()) ? "" : list.get(i).getTotalListener());
            hm.put("mem16", DalbitUtil.isEmpty(list.get(i).getGoodCnt()) ? "" : list.get(i).getGoodCnt());
            hm.put("mem17", DalbitUtil.isEmpty(list.get(i).getBoosterCnt()) ? "" : list.get(i).getBoosterCnt());
            hm.put("mem18", DalbitUtil.isEmpty(list.get(i).getGiftCnt()) ? "" : list.get(i).getGiftCnt());
            hm.put("mem18_1", DalbitUtil.isEmpty(list.get(i).getByeolCnt()) ? "" : list.get(i).getByeolCnt());
            hm.put("mem19_1", DalbitUtil.isEmpty(list.get(i).getStoryCnt()) ? "" : list.get(i).getStoryCnt());
            hm.put("mem19", DalbitUtil.isEmpty(list.get(i).getFanCnt()) ? "" : list.get(i).getFanCnt());
            hm.put("mem20", DalbitUtil.isEmpty(list.get(i).getForcedCnt()) ? "" : list.get(i).getForcedCnt());
            hm.put("mem21", DalbitUtil.isEmpty(list.get(i).getExtend_time_count()) ? "" : list.get(i).getExtend_time_count());
            hm.put("mem22", DalbitUtil.isEmpty(list.get(i).getContinue_room()) ? "" : list.get(i).getContinue_room());

            bodies.add(hm.values().toArray());
        }
        ExcelVo vo = new ExcelVo(headers, headerWidths, bodies);
        SXSSFWorkbook workbook = excelService.excelDownload("목록",vo);
        model.addAttribute("locale", Locale.KOREA);
        model.addAttribute("workbook", workbook);
        model.addAttribute("workbookName", "실시간 최신 생방송 목록");

        return model;
    }

    /**
     * 생방송 검색 엑셀
     */
    public Model callBroadcastListExcel(P_BroadcastListInputVo pBroadcastListInputVo, Model model) {
        pBroadcastListInputVo.setPageCnt(100000);
        ProcedureVo procedureVo = new ProcedureVo(pBroadcastListInputVo);

        List<P_BroadcastListOutputVo> list = bro_BroadcastDao.callBroadcastList(procedureVo);

        String[] headers = {"No", "방송주제", "방송제목", "방송시작일시", "방송진행시간", "DJ ID", "DJ 닉네임", "누적청취자", "청취자", "좋아요", "선물", "사연수", "방송상태"};
        int[] headerWidths = {3000, 3000, 6000, 6000, 6000, 6000, 6000, 3000, 3000, 3000, 3000, 3000, 3000};

        List<Object[]> bodies = new ArrayList<>();
        for(int i = 0; i < list.size(); i++){
            HashMap hm = new LinkedHashMap();

            hm.put("no", list.size()-i);
            hm.put("mem1",  DalbitUtil.isEmpty(list.get(i).getSubjectType()) ? "" : list.get(i).getSubjectType());
            hm.put("mem2",  DalbitUtil.isEmpty(list.get(i).getTitle()) ? "" : list.get(i).getTitle());
            hm.put("mem3", DalbitUtil.isEmpty(list.get(i).getStartDateFormat()) ? "" : list.get(i).getStartDateFormat());
            hm.put("mem4", DalbitUtil.isEmpty(list.get(i).getAirTime()) ? "" : list.get(i).getAirTime());
            hm.put("mem5",  DalbitUtil.isEmpty(list.get(i).getDj_userid()) ? "" : list.get(i).getDj_userid());
            hm.put("mem6",  DalbitUtil.isEmpty(list.get(i).getDj_nickname()) ? "" : list.get(i).getDj_nickname());
            hm.put("mem7", DalbitUtil.isEmpty(list.get(i).getTotalListener()) ? "" : list.get(i).getTotalListener());
            hm.put("mem8", DalbitUtil.isEmpty(list.get(i).getLiveListener()) ? "" : list.get(i).getLiveListener());
            hm.put("mem9", DalbitUtil.isEmpty(list.get(i).getGoodCnt()) ? "" : list.get(i).getGoodCnt());
            hm.put("mem10", DalbitUtil.isEmpty(list.get(i).getGiftCnt()) ? "" : list.get(i).getGiftCnt());
            hm.put("mem11", DalbitUtil.isEmpty(list.get(i).getStoryCnt()) ? "" : list.get(i).getStoryCnt());
            hm.put("mem12", DalbitUtil.isEmpty(list.get(i).getState()) ? "" : list.get(i).getState());

            bodies.add(hm.values().toArray());
        }
        ExcelVo vo = new ExcelVo(headers, headerWidths, bodies);
        SXSSFWorkbook workbook = excelService.excelDownload("목록",vo);
        model.addAttribute("locale", Locale.KOREA);
        model.addAttribute("workbook", workbook);
        model.addAttribute("workbookName", "생방송 검색 엑셀 목록");

        return model;
    }


    /**
     * 선택한 방 정보
     */
    public String callBroadcastInfo(P_BroadcastDetailInputVo pBroadcastDetailInputVo) {
        ProcedureVo procedureVo = new ProcedureVo(pBroadcastDetailInputVo);

        bro_BroadcastDao.callBroadcastInfo(procedureVo);

        P_BroadcastDetailOutputVo broadcastDetail = new Gson().fromJson(procedureVo.getExt(), P_BroadcastDetailOutputVo.class);

        if(DalbitUtil.isEmpty(broadcastDetail.getDj_userId())){
            HashMap<P_BroadcastDetailOutputVo,String> withdrawal= bro_BroadcastDao.callBroadcastInfo_withdrawal(broadcastDetail.getDj_mem_no());
            if(!DalbitUtil.isEmpty(withdrawal)) {
                broadcastDetail.setDj_userId(withdrawal.get("dj_userId"));
                broadcastDetail.setDj_nickName(withdrawal.get("dj_nickName"));
                broadcastDetail.setDj_memSex(withdrawal.get("dj_memSex"));
            }
        }

        // 회원 배찌
        HashMap<P_MemberInfoOutputVo,String> djBadge = mem_MemberDao.callMemberInfo_badge(broadcastDetail.getDj_mem_no());
        if(!DalbitUtil.isEmpty(djBadge)) {
            broadcastDetail.setRecomm_badge(String.valueOf(djBadge.get("recomm_badge")) );
            broadcastDetail.setNewdj_badge(String.valueOf(djBadge.get("newdj_badge")));
            broadcastDetail.setSpecialdj_badge(String.valueOf(djBadge.get("specialdj_badge")));
        }


        String result;
        if(Status.방송방상세조회_성공.getMessageCode().equals(procedureVo.getRet())) {
            result = gsonUtil.toJson(new JsonOutputVo(Status.방송방상세조회_성공, broadcastDetail));
        } else if(Status.방송방상세조회_공지번호없음.getMessageCode().equals(procedureVo.getRet())) {
            result = gsonUtil.toJson(new JsonOutputVo(Status.방송방상세조회_공지번호없음));
        } else {
            result = gsonUtil.toJson(new JsonOutputVo(Status.방송방상세조회_에러));
        }

        return result;
    }

    /**
     * 방송방 정보수정 내역 보기
     */
    public String callBroadcastEditHistory(P_BroadcastEditHistInputVo pBroadcastEditHistInputVo){
        ProcedureVo procedureVo = new ProcedureVo(pBroadcastEditHistInputVo);

        ArrayList<P_BroadcastEditHistOutputVo> editList = bro_BroadcastDao.callBroadcastEditHistory(procedureVo);

        String result;

        if (Integer.parseInt(procedureVo.getRet()) > 0) {
            result = gsonUtil.toJson(new JsonOutputVo(Status.방송방수정내역조회_성공, editList, new PagingVo(procedureVo.getRet())));
        } else if(Status.방송방수정내역조회_데이터없음.getMessageCode().equals(procedureVo.getRet())) {
            result = gsonUtil.toJson(new JsonOutputVo(Status.방송방수정내역조회_데이터없음));
        } else if(Status.방송방수정내역조회_방번호없음.getMessageCode().equals(procedureVo.getRet())) {
            result = gsonUtil.toJson(new JsonOutputVo(Status.방송방수정내역조회_방번호없음));
        } else {
            result = gsonUtil.toJson(new JsonOutputVo(Status.방송방수정내역조회_에러));
        }
        return result;

    }

    /**
     * 방송방 정보수정
     */
    public String callBroadcastEdit(P_BroadcastEditInputVo pBroadcastEditInputVo) {

        //수정 전 방송정보 조회
        ProcedureVo pBroadcastDetailInputProcedureVo = new ProcedureVo(pBroadcastEditInputVo);
        bro_BroadcastDao.callBroadcastInfo(pBroadcastDetailInputProcedureVo);
        P_BroadcastDetailOutputVo broadcastDetail = new Gson().fromJson(pBroadcastDetailInputProcedureVo.getExt(), P_BroadcastDetailOutputVo.class);

        pBroadcastEditInputVo.setOpName(MemberVo.getMyMemNo());
        pBroadcastEditInputVo.setMemLogin(1);
        ProcedureVo procedureVo = new ProcedureVo(pBroadcastEditInputVo);
        bro_BroadcastDao.callBroadcastEdit(procedureVo);
        String result;

        String forceExitResult = "";
        if(Status.방송방정보수정_성공.getMessageCode().equals(procedureVo.getRet())) {
            result = gsonUtil.toJson(new JsonOutputVo(Status.방송방정보수정_성공));
            // 방송방 강제 종료 ------------------------------------
            if(pBroadcastEditInputVo.getForceExit().equals("1")){
//            if(pBroadcastEditInputVo.getForceExit().equals("1") && pBroadcastEditInputVo.getSendNoti().equals("1")){
                // 방 종료 정보 프로시져 호출
                bro_BroadcastDao.callBroadcastRoomExit(procedureVo);
                // 방송 시작시간
                bro_BroadcastDao.callBroadcastInfo(procedureVo);
                //P_BroadcastDetailOutputVo broadcastDetail = new Gson().fromJson(procedureVo.getExt(), P_BroadcastDetailOutputVo.class);

                // 방송 강제종료 api 호출
                pBroadcastEditInputVo.setStart_date(broadcastDetail.getStartDate());
                pBroadcastEditInputVo.setRoomExit("N");
                forceExitResult = DalbitUtil.broadcastForceExit(pBroadcastEditInputVo);
                if(forceExitResult.equals("error")){
                    return gsonUtil.toJson(new JsonOutputVo(Status.회원방송강제종료시도_실패));
                }else if(forceExitResult.equals("noAuth")){
                    return gsonUtil.toJson(new JsonOutputVo(Status.회원방송강제종료시도_권한없음));
                }
//            }else if(pBroadcastEditInputVo.getForceExit().equals("0") && pBroadcastEditInputVo.getSendNoti().equals("1")){
            }


            //얼리기
            if(!broadcastDetail.getFreezeMsg().equals(pBroadcastEditInputVo.getFreezeMsg())){
                DalbitUtil.broadcastFreeze(pBroadcastEditInputVo);
            }

            //option
            HashMap<String, Object> param = new HashMap<>();
            param.put("roomNo", pBroadcastEditInputVo.getRoom_no());
            param.put("memNo", pBroadcastEditInputVo.getMem_no());
            param.put("memNk", "");
            param.put("ctrlRole", "ctrlRole");
            param.put("recvType","chat");
            param.put("recvPosition","chat");
            param.put("recvLevel", 0);
            param.put("recvTime", 0);

            // message set
            Gson gson = new Gson();
            HashMap<String,Object> tmp = new HashMap();
            tmp.put("roomType", pBroadcastEditInputVo.getSubjectType());
            tmp.put("title", pBroadcastEditInputVo.getTitle());
            tmp.put("welcomMsg", pBroadcastEditInputVo.getWelcomMsg());

            if(DalbitUtil.isEmpty(pBroadcastEditInputVo.getBackgroundImage())){
                tmp.put("bgImg", new ImageVo(pBroadcastEditInputVo.getBeforBackgroundImage(), DalbitUtil.getProperty("server.photo.url")));
            }else{
                tmp.put("bgImg", new ImageVo(pBroadcastEditInputVo.getBackgroundImage(), DalbitUtil.getProperty("server.photo.url")));
            }
            tmp.put("bgImgRacy", 5);
            String message =  gson.toJson(tmp);

            socketUtil.setSocket(param, "reqRoomChangeInfo", message, jwtUtil.generateToken(pBroadcastEditInputVo.getMem_no(), true));

        } else if(Status.방송방정보수정_방번호없음.getMessageCode().equals(procedureVo.getRet())) {
            result = gsonUtil.toJson(new JsonOutputVo(Status.방송방정보수정_방번호없음));
        } else if(Status.방송방정보수정_종료된방.getMessageCode().equals(procedureVo.getRet())) {
            result = gsonUtil.toJson(new JsonOutputVo(Status.방송방정보수정_종료된방));
        } else {
            result = gsonUtil.toJson(new JsonOutputVo(Status.방송방정보수정_에러));
        }

        return result;

    }


    /**
     * 방송방 플레이어 (wowza)
     */
    public void callBroadcastWowzaSimpleInfo(HttpServletRequest request){
        String roomNo = request.getParameter("roomNo");
        if(!DalbitUtil.isEmpty(roomNo)){
            HashMap broadInfo = bro_BroadcastDao.callBroadcastSimpleInfo(roomNo);
            if(broadInfo != null){
                log.info("[WOWZA] Request URL : {}", WOWZA_WSS_URL );
                broadInfo.put("wsUrl", WOWZA_WSS_URL);
                broadInfo.put("applicationName", "edge");
                broadInfo.put("streamName", WOWZA_PREFIX + roomNo + WOWZA_SUFFIX);
                request.setAttribute("BroadInfo", gsonUtil.toJson(broadInfo));
            }
        }
    }



    /**
     * 방송방 플레이어 (구 ant)
     */
    public void callBroadcastSimpleInfo(HttpServletRequest request){
        String roomNo = request.getParameter("roomNo");
        if(!DalbitUtil.isEmpty(roomNo)){
            HashMap broadInfo = bro_BroadcastDao.callBroadcastSimpleInfo(roomNo);
            if(broadInfo != null && !DalbitUtil.isEmpty(broadInfo.get("bjStreamId"))){
                Calendar cal = Calendar.getInstance();
                cal.add(Calendar.HOUR, antExpire);
                long expire = cal.getTime().getTime() / 1000;
                String params = "expireDate=" + expire + "&type=play";
                OkHttpClientUtil httpUtil = new OkHttpClientUtil();
                try{
                    String url = antServer + "/" + antName + "/rest/v2/broadcasts/" + broadInfo.get("bjStreamId") + "/token?" + params;
                    log.info("[Ant] Request URL : {}", url );
                    Response res = httpUtil.sendGet(url);
                    if(res != null){
                        String strResBody = res.body().string();
                        if(!DalbitUtil.isEmpty(strResBody)) {
                            HashMap tokenMap = new Gson().fromJson(strResBody, HashMap.class);
                            if (tokenMap != null && !DalbitUtil.isEmpty(tokenMap.get("tokenId"))) {
                                broadInfo.put("bjPlayToken", tokenMap.get("tokenId"));
                                broadInfo.put("antUrl", DalbitUtil.getProperty("server.ant.edge.url"));
                                request.setAttribute("BroadInfo", gsonUtil.toJson(broadInfo));
                            }
                        }
                    }
                }catch(Exception e){
                    e.printStackTrace();
                }
            }
        }
    }



    /**
     * 방송방 채팅정보
     */
    public String callBroadcastLiveChatInfo(P_ChatListInputVo pChatListInputVo){
        ProcedureVo procedureVo = new ProcedureVo(pChatListInputVo);
        String result;

        try {
            ArrayList<P_ChatListOutputVo> liveChatList = bro_BroadcastDao.callBroadcastLiveChatInfo(pChatListInputVo);

            if(liveChatList != null && liveChatList.size() > 0) {
                result = gsonUtil.toJson(new JsonOutputVo(Status.방송방메시지조회_성공, liveChatList));
            }else {
                result = gsonUtil.toJson(new JsonOutputVo(Status.방송방메시지조회_데이터없음));
            }

        }catch (Exception e){
            e.printStackTrace();
            result = gsonUtil.toJson(new JsonOutputVo(Status.방송방메시지조회_에러));
        }

        return result;
    }

    /**
     * 생방송  청취자 list 목록
     */
    public String callLiveListenerList(P_BroadcastListInputVo pBroadcastListInputVo){
        ProcedureVo procedureVo = new ProcedureVo(pBroadcastListInputVo);
        ArrayList<P_LiveListenerListOutputVo> liveListenerList = bro_BroadcastDao.callLiveListenerList(procedureVo);
        P_LiveListenerListOutputVo summary = new Gson().fromJson(procedureVo.getExt(), P_LiveListenerListOutputVo.class);

        //DB 부하로 인해 뱃지리스트 주석처리
        /*for(int i=0;i<liveListenerList.size();i++) {
//            fanBadgeList   주간/일간 탑DJ/팽 1,2,3
            HashMap fanBadgeMap = new HashMap();
            fanBadgeMap.put("mem_no", liveListenerList.get(i).getMemNo());
            fanBadgeMap.put("type", -1);
            List fanBadgeList = commonDao.callMemberBadgeSelect(fanBadgeMap);
            liveListenerList.get(i).setFanBadgeList(fanBadgeList);

//            liveBadgeList    실시간1,2,3 / 회장,부회장,사장,부장,팀장
            HashMap liveBadgeMap = new HashMap();
            liveBadgeMap.put("mem_no", liveListenerList.get(i).getMemNo());
            liveBadgeMap.put("type", -1);
            List liveBadgeList = commonDao.callLiveBadgeSelect(liveBadgeMap);
            for (int j = (liveBadgeList.size() - 1); j > -1; j--) {
                if (DalbitUtil.isEmpty(((FanBadgeVo) liveBadgeList.get(j)).getIcon())) {
                    liveBadgeList.remove(j);
                }
            }
            liveListenerList.get(i).setLiveBadgeList(liveBadgeList);
        }*/
        String result = "";
        if(liveListenerList.size() > 0) {
            result = gsonUtil.toJson(new JsonOutputVo(Status.생방송청취자목록보기_성공, liveListenerList, new PagingVo(procedureVo.getRet()),summary));
        }else{
            result = gsonUtil.toJson(new JsonOutputVo(Status.생방송청취자목록보기_실패));
        }
        return result;
    }

    /**
     * 실시간 게스트 list 목록
     */
    public String callLiveGuestList(P_BroadcastListInputVo pBroadcastListInputVo){
        ProcedureVo procedureVo = new ProcedureVo(pBroadcastListInputVo);
        ArrayList<P_LiveGuestListOutputVo> liveGuestList = bro_BroadcastDao.callLiveGuestList(procedureVo);
        P_LiveGuestListOutputVo summary = new Gson().fromJson(procedureVo.getExt(), P_LiveGuestListOutputVo.class);

        String result;
        if(liveGuestList.size() > 0) {
            result = gsonUtil.toJson(new JsonOutputVo(Status.생방송게스트목록보기_성공, liveGuestList, new PagingVo(procedureVo.getRet()),summary));
        }else{
            result = gsonUtil.toJson(new JsonOutputVo(Status.생방송게스트목록보기_실패));
        }
        return result;
    }


    /**
     * 실시간/종료방송 텝 Count
     */
    public String callLiveTabCount(P_BroadcastListInputVo pBroadcastListInputVo){
        ArrayList<P_BroadcastListOutputVo> tabCountList = bro_BroadcastDao.callLiveTabCount(pBroadcastListInputVo);
        String result;
        if(tabCountList.size() > 0) {
            result = gsonUtil.toJson(new JsonOutputVo(Status.조회, tabCountList));
        }else{
            result = gsonUtil.toJson(new JsonOutputVo(Status.데이터없음));
        }
        return result;
    }
}
