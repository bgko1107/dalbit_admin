package com.dalbit.content.service;

import com.dalbit.common.code.Status;
import com.dalbit.common.vo.JsonOutputVo;
import com.dalbit.common.vo.PagingVo;
import com.dalbit.common.vo.ProcedureVo;
import com.dalbit.content.dao.Con_EventDao;
import com.dalbit.content.vo.*;
import com.dalbit.content.vo.procedure.*;
import com.dalbit.excel.service.ExcelService;
import com.dalbit.excel.vo.ExcelVo;
import com.dalbit.exception.GlobalException;
import com.dalbit.member.dao.Mem_MemberDao;
import com.dalbit.member.vo.MemberVo;
import com.dalbit.util.DalbitUtil;
import com.dalbit.util.GsonUtil;
import com.dalbit.util.MessageUtil;
import com.google.gson.Gson;
import lombok.extern.slf4j.Slf4j;
import lombok.var;
import org.apache.commons.lang3.math.NumberUtils;
import org.apache.poi.xssf.streaming.SXSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import java.util.*;

@Slf4j
@Service
public class Con_EventService {

    @Autowired
    ExcelService excelService;
    @Autowired
    Con_EventDao con_EventDao;
    @Autowired
    Mem_MemberDao memMemberDao;
    @Autowired
    MessageUtil messageUtil;
    @Autowired
    GsonUtil gsonUtil;


    /*======================= 이벤트 관리 =======================*/

    /**
     * 이벤트 리스트 조회
     */
    public String callEventManagementList(P_EventManagementListInputVo pEventManagementListInputVo) throws GlobalException{
        ProcedureVo procedureVo = new ProcedureVo(pEventManagementListInputVo);
        String result;

        try {
            ArrayList<P_EventManagementListOutputVo> eventList = con_EventDao.callEventManagementList(procedureVo);

            if (Integer.parseInt(procedureVo.getRet()) > 0) {
                result = gsonUtil.toJson(new JsonOutputVo(Status.이벤트관리_리스트조회_성공, eventList, new PagingVo(procedureVo.getRet())));
            } else if (Status.이벤트관리_리스트조회_데이터없음.getMessageCode().equals(procedureVo.getRet())) {
                result = gsonUtil.toJson(new JsonOutputVo(Status.이벤트관리_리스트조회_데이터없음));
            } else {
                result = gsonUtil.toJson(new JsonOutputVo(Status.이벤트관리_리스트조회_실패));
            }
        } catch (Exception e) {
            result = gsonUtil.toJson(new JsonOutputVo(Status.비즈니스로직오류));
        }

        return result;

    }

    /**
     * 이벤트 상세 정보
     */
    public String callEventManagementInfo(P_EventManagementEventIdxInputVo pEventManagementEventIdxInputVo) throws GlobalException{
        ProcedureVo procedureVo = new ProcedureVo(pEventManagementEventIdxInputVo);

        String result;

        try {
            con_EventDao.callEventManagementInfo(procedureVo);
            P_EventManagementInfoOutputVo eventInfo = new Gson().fromJson(procedureVo.getExt(), P_EventManagementInfoOutputVo.class);

            pEventManagementEventIdxInputVo.setEventIdx(pEventManagementEventIdxInputVo.getEventIdx());
            ProcedureVo winnerProcedureVo = new ProcedureVo(pEventManagementEventIdxInputVo);
            con_EventDao.callEventWinnerInfo(winnerProcedureVo);
            P_EventWinnerInfoExtVo winnerInfoPrize = new Gson().fromJson(winnerProcedureVo.getExt(), P_EventWinnerInfoExtVo.class);
            eventInfo.setPrizeWinner(winnerInfoPrize.getPrizeWinner());

            if (Status.이벤트관리_상세정보조회_성공.getMessageCode().equals(procedureVo.getRet())) {
                result = gsonUtil.toJson(new JsonOutputVo(Status.이벤트관리_상세정보조회_성공, eventInfo));
            } else if (Status.이벤트관리_상세정보조회_이벤트번호없음.getMessageCode().equals(procedureVo.getRet())) {
                result = gsonUtil.toJson(new JsonOutputVo(Status.이벤트관리_상세정보조회_이벤트번호없음));
            } else {
                result = gsonUtil.toJson(new JsonOutputVo(Status.이벤트관리_상세정보조회_실패));
            }
        } catch(Exception e) {
            result = gsonUtil.toJson(new JsonOutputVo(Status.비즈니스로직오류));
        }

        return result;
    }

    /**
     * 이벤트 등록
     */
    public String callEventManagementAdd(P_EventManagementAddVo pEventManagementAddVo) throws GlobalException{
        pEventManagementAddVo.setOpName(MemberVo.getMyMemNo());
        String result;

        if(!DalbitUtil.isEmpty(pEventManagementAddVo.getTitle())) {
            if (pEventManagementAddVo.getAlwaysYn() == 1) {
                pEventManagementAddVo.setEndDate("0000-00-00 00:00:00");
            }

            if (DalbitUtil.isEmpty(pEventManagementAddVo.getAnnouncementDate())) {
                pEventManagementAddVo.setAnnouncementDate("0000-00-00 00:00:00");
            }

            ProcedureVo procedureVo = new ProcedureVo(pEventManagementAddVo);

            con_EventDao.callEventManagementAdd(procedureVo);

            if (Status.이벤트관리_이벤트등록_성공.getMessageCode().equals(procedureVo.getRet())) {
                result = gsonUtil.toJson(new JsonOutputVo(Status.이벤트관리_이벤트등록_성공));
            } else {
                result = gsonUtil.toJson(new JsonOutputVo(Status.이벤트관리_이벤트등록_실패));
            }
        } else {
            result = gsonUtil.toJson(new JsonOutputVo(Status.파라미터오류));
        }

        return result;
    }

    /**
     * 이벤트 수정
     */
    public String callEventManagementEdit(P_EventManagementEditVo pEventManagementEditVo) throws GlobalException{
        pEventManagementEditVo.setOpName(MemberVo.getMyMemNo());

        String result="";

        if(!DalbitUtil.isEmpty(pEventManagementEditVo.getEventIdx()) && !DalbitUtil.isEmpty(pEventManagementEditVo.getTitle())) {

            if (pEventManagementEditVo.getAlwaysYn() == 1) {
                pEventManagementEditVo.setEndDate("0000-00-00 00:00:00");
            }

            if (DalbitUtil.isEmpty(pEventManagementEditVo.getAnnouncementDate())) {
                pEventManagementEditVo.setAnnouncementDate("0000-00-00 00:00:00");
            }

            ProcedureVo procedureVo = new ProcedureVo(pEventManagementEditVo);

            con_EventDao.callEventManagementEdit(procedureVo);

            if (Status.이벤트관리_이벤트수정_성공.getMessageCode().equals(procedureVo.getRet())) {
                result = gsonUtil.toJson(new JsonOutputVo(Status.이벤트관리_이벤트수정_성공));
            } else if (Status.이벤트관리_이벤트수정_이벤트번호없음.getMessageCode().equals(procedureVo.getRet())) {
                result = gsonUtil.toJson(new JsonOutputVo(Status.이벤트관리_이벤트수정_이벤트번호없음));
            } else {
                result = gsonUtil.toJson(new JsonOutputVo(Status.이벤트관리_이벤트수정_실패));
            }
        } else {
            result = gsonUtil.toJson(new JsonOutputVo(Status.파라미터오류));
        }

        return result;
    }

    /**
     * 이벤트 삭제
     */
    public String callEventManagementDelete(P_EventManagementDeleteVo pEventManagementDeleteVo) throws GlobalException{

        String result = "";

        if(!DalbitUtil.isEmpty(pEventManagementDeleteVo.getEventIdx())) {
            int sucCnt = 0;
            int failCnt = 0;

            String[] idxs = pEventManagementDeleteVo.getEventIdx().split(",");
            for (String eventIdx : idxs) {
                if (NumberUtils.isDigits(eventIdx)) {
                    ProcedureVo procedureVo = new ProcedureVo(new P_EventManagementDeleteVo(eventIdx, MemberVo.getMyMemNo()));

                    con_EventDao.callEventManagementDelete(procedureVo);

                    if (Status.이벤트관리_이벤트삭제_성공.getMessageCode().equals(procedureVo.getRet())) {
                        sucCnt++;
                    } else {
                        failCnt++;
                    }
                }
            }

            HashMap resultMap = new HashMap();
            resultMap.put("sucCnt", sucCnt);
            resultMap.put("failCnt", failCnt);

            if (0 < sucCnt) {
                result = gsonUtil.toJson(new JsonOutputVo(Status.이벤트관리_이벤트삭제_성공, resultMap));
            } else {
                result = gsonUtil.toJson(new JsonOutputVo(Status.이벤트관리_이벤트삭제_실패, resultMap));
            }
        } else {
            result = gsonUtil.toJson(new JsonOutputVo(Status.파라미터오류));
        }

        return result;
    }

    /**
     * 경품 리스트 조회
     */
    public String callEventPrizeList(P_EventManagementEventIdxInputVo pEventManagementEventIdxInputVo) throws GlobalException{
        ProcedureVo procedureVo = new ProcedureVo(pEventManagementEventIdxInputVo);
        String result;

        try {
            ArrayList<P_EventPrizeListOutputVo> prizeList = con_EventDao.callEventPrizeList(procedureVo);

            if (Integer.parseInt(procedureVo.getRet()) > 0) {
                result = gsonUtil.toJson(new JsonOutputVo(Status.이벤트관리_경품리스트조회_성공, prizeList, new PagingVo(procedureVo.getRet())));
            } else if (Status.이벤트관리_경품리스트조회_데이터없음.getMessageCode().equals(procedureVo.getRet())) {
                result = gsonUtil.toJson(new JsonOutputVo(Status.이벤트관리_경품리스트조회_데이터없음));
            } else if (Status.이벤트관리_경품리스트조회_이벤트번호없음.getMessageCode().equals(procedureVo.getRet())) {
                result = gsonUtil.toJson(new JsonOutputVo(Status.이벤트관리_경품리스트조회_이벤트번호없음));
            } else {
                result = gsonUtil.toJson(new JsonOutputVo(Status.이벤트관리_경품리스트조회_실패));
            }
        } catch (Exception e) {
            result = gsonUtil.toJson(new JsonOutputVo(Status.비즈니스로직오류));
        }

        return result;
    }

    /**
     * 경품 등록
     */
    public String callEventPrizeAdd(P_EventPrizeAddVo pEventPrizeAddVo) throws GlobalException{
        pEventPrizeAddVo.setOpName(MemberVo.getMyMemNo());
        ProcedureVo procedureVo = new ProcedureVo(pEventPrizeAddVo);
        String result;

        if(!DalbitUtil.isEmpty(pEventPrizeAddVo.getEventIdx())) {
            con_EventDao.callEventPrizeAdd(procedureVo);

            if (Status.이벤트관리_경품등록_성공.getMessageCode().equals(procedureVo.getRet())) {
                result = gsonUtil.toJson(new JsonOutputVo(Status.이벤트관리_경품등록_성공));
            } else if (Status.이벤트관리_경품등록_이벤트번호없음.getMessageCode().equals(procedureVo.getRet())) {
                result = gsonUtil.toJson(new JsonOutputVo(Status.이벤트관리_경품등록_이벤트번호없음));
            } else {
                result = gsonUtil.toJson(new JsonOutputVo(Status.이벤트관리_경품등록_실패));
            }
        } else {
            result = gsonUtil.toJson(new JsonOutputVo(Status.파라미터오류));
        }

        return result;
    }

    /**
     * 경품 상세 조회
     */
    public String callEventPrizeDetail(P_EventPrizeDetailInputVo pEventPrizeDetailInputVo) throws GlobalException{
        ProcedureVo procedureVo = new ProcedureVo(pEventPrizeDetailInputVo);
        String result;

        if(!DalbitUtil.isEmpty(pEventPrizeDetailInputVo.getEventIdx()) && !DalbitUtil.isEmpty(pEventPrizeDetailInputVo.getPrizeIdx())){
            con_EventDao.callEventPrizeDetail(procedureVo);
            P_EventPrizeDetailOutputVo prizeDetail = new Gson().fromJson(procedureVo.getExt(), P_EventPrizeDetailOutputVo.class);

            if (Status.이벤트관리_경품상세조회_성공.getMessageCode().equals(procedureVo.getRet())) {
                result = gsonUtil.toJson(new JsonOutputVo(Status.이벤트관리_경품상세조회_성공, prizeDetail));
            } else if (Status.이벤트관리_경품상세조회_이벤트번호없음.getMessageCode().equals(procedureVo.getRet())) {
                result = gsonUtil.toJson(new JsonOutputVo(Status.이벤트관리_경품상세조회_이벤트번호없음));
            } else if (Status.이벤트관리_경품상세조회_경품번호없음.getMessageCode().equals(procedureVo.getRet())) {
                result = gsonUtil.toJson(new JsonOutputVo(Status.이벤트관리_경품상세조회_경품번호없음));
            } else {
                result = gsonUtil.toJson(new JsonOutputVo(Status.이벤트관리_경품상세조회_실패));
            }
        } else {
            result = gsonUtil.toJson(new JsonOutputVo(Status.파라미터오류));
        }

        return result;
    }

    /**
     * 경품 수정
     */
    public String callEventPrizeEdit(P_EventPrizeEditVo pEventPrizeEditVo) throws GlobalException{
        pEventPrizeEditVo.setOpName(MemberVo.getMyMemNo());
        ProcedureVo procedureVo = new ProcedureVo(pEventPrizeEditVo);
        String result;

        if(!DalbitUtil.isEmpty(pEventPrizeEditVo.getEventIdx())) {
            con_EventDao.callEventPrizeEdit(procedureVo);

            if (Status.이벤트관리_경품수정_성공.getMessageCode().equals(procedureVo.getRet())) {
                result = gsonUtil.toJson(new JsonOutputVo(Status.이벤트관리_경품수정_성공));
            } else if (Status.이벤트관리_경품수정_이벤트번호없음.getMessageCode().equals(procedureVo.getRet())) {
                result = gsonUtil.toJson(new JsonOutputVo(Status.이벤트관리_경품수정_이벤트번호없음));
            } else if (Status.이벤트관리_경품수정_경품번호없음.getMessageCode().equals(procedureVo.getRet())) {
                result = gsonUtil.toJson(new JsonOutputVo(Status.이벤트관리_경품수정_경품번호없음));
            } else {
                result = gsonUtil.toJson(new JsonOutputVo(Status.이벤트관리_경품수정_실패));
            }
        } else {
            result = gsonUtil.toJson(new JsonOutputVo(Status.파라미터오류));
        }

        return result;
    }

    /**
     * 경품 삭제
     */
    public String callEventPrizeDelete(P_EventPrizeDeleteVo pEventPrizeDeleteVo) throws GlobalException{
        int sucCnt = 0;
        int failCnt = 0;

        String result;

        if(!DalbitUtil.isEmpty(pEventPrizeDeleteVo.getEventIdx()) && !DalbitUtil.isEmpty(pEventPrizeDeleteVo.getPrizeIdxs())) {
            String[] idxs = pEventPrizeDeleteVo.getPrizeIdxs().split(",");
            for (int i = 0; i < idxs.length; i++) {
                if (!DalbitUtil.isEmpty(pEventPrizeDeleteVo.getPrizeIdxs())) {
                    ProcedureVo procedureVo = new ProcedureVo(new P_EventPrizeDeleteVo(idxs[i], pEventPrizeDeleteVo.getEventIdx(), MemberVo.getMyMemNo()));
                    con_EventDao.callEventPrizeDelete(procedureVo);

                    if (Status.이벤트관리_경품삭제_성공.getMessageCode().equals(procedureVo.getRet())) {
                        sucCnt++;
                    } else {
                        failCnt++;
                    }
                }
            }

            HashMap resultMap = new HashMap();
            resultMap.put("sucCnt", sucCnt);
            resultMap.put("failCnt", failCnt);

            if (0 < sucCnt) {
                result = gsonUtil.toJson(new JsonOutputVo(Status.이벤트관리_경품삭제_성공, resultMap));
            } else {
                result = gsonUtil.toJson(new JsonOutputVo(Status.이벤트관리_경품삭제_실패, resultMap));
            }
        } else {
            result = gsonUtil.toJson(new JsonOutputVo(Status.파라미터오류));
        }

        return result;
    }

    /**
     * 응모자/당첨자 정보
     */
    public String callEventWinnerInfo(P_EventManagementEventIdxInputVo pEventManagementEventIdxInputVo) throws GlobalException{
        ProcedureVo procedureVo = new ProcedureVo(pEventManagementEventIdxInputVo);
        String result;

        try {
            ArrayList<P_EventWinnerInfoOutputVo> infoList = con_EventDao.callEventWinnerInfo(procedureVo);
            P_EventWinnerInfoExtVo winnerInfoPrizeYn = new Gson().fromJson(procedureVo.getExt(), P_EventWinnerInfoExtVo.class);


            LinkedHashMap resultMap = new LinkedHashMap();
            resultMap.put("infoList", infoList);
            resultMap.put("winnerInfoPrizeYn", winnerInfoPrizeYn);

            if (Integer.parseInt(procedureVo.getRet()) > 0) {
                result = gsonUtil.toJson(new JsonOutputVo(Status.이벤트관리_응모자당첨자정보조회_성공, resultMap));
            } else if (Status.이벤트관리_응모자당첨자정보조회_리스트없음.getMessageCode().equals(procedureVo.getRet())) {
                result = gsonUtil.toJson(new JsonOutputVo(Status.이벤트관리_응모자당첨자정보조회_리스트없음));
            } else if (Status.이벤트관리_응모자당첨자정보조회_이벤트번호없음.getMessageCode().equals(procedureVo.getRet())) {
                result = gsonUtil.toJson(new JsonOutputVo(Status.이벤트관리_응모자당첨자정보조회_이벤트번호없음));
            } else {
                result = gsonUtil.toJson(new JsonOutputVo(Status.이벤트관리_응모자당첨자정보조회_실패));
            }
        } catch (Exception e) {
            result = gsonUtil.toJson(new JsonOutputVo(Status.비즈니스로직오류));
        }

        return result;
    }

    /**
     * 응모자/당첨자 리스트 조회
     */
    public String callEventWinnerApplicant(P_EventWinnerApplicantInputVo pEventWinnerApplicantInputVo) throws GlobalException{
        ProcedureVo procedureVo = new ProcedureVo(pEventWinnerApplicantInputVo);
        String result;

        try {
            ArrayList<P_EventWinnerApplicantOutputVo> ApplicantList = con_EventDao.callEventWinnerApplicant(procedureVo);

            if (Integer.parseInt(procedureVo.getRet()) > 0) {
                result = gsonUtil.toJson(new JsonOutputVo(Status.이벤트관리_응모자당첨자리스트조회_성공, ApplicantList, new PagingVo(procedureVo.getRet())));
            } else if (Status.이벤트관리_응모자당첨자리스트조회_리스트없음.getMessageCode().equals(procedureVo.getRet())) {
                result = gsonUtil.toJson(new JsonOutputVo(Status.이벤트관리_응모자당첨자리스트조회_리스트없음));
            } else if (Status.이벤트관리_응모자당첨자리스트조회_이벤트번호없음.getMessageCode().equals(procedureVo.getRet())) {
                result = gsonUtil.toJson(new JsonOutputVo(Status.이벤트관리_응모자당첨자리스트조회_이벤트번호없음));
            } else {
                result = gsonUtil.toJson(new JsonOutputVo(Status.이벤트관리_응모자당첨자리스트조회_실패));
            }
        } catch(Exception e) {
            result = gsonUtil.toJson(new JsonOutputVo(Status.비즈니스로직오류));
        }

        return result;
    }

    /**
     * 응모자/당첨자 리스트 엑셀
     */
    public Model getListExcel(P_EventWinnerApplicantInputVo pEventWinnerApplicantInputVo, Model model) throws GlobalException{
        pEventWinnerApplicantInputVo.setPageCnt(100000);
        ProcedureVo procedureVo = new ProcedureVo(pEventWinnerApplicantInputVo);
        ArrayList<P_EventWinnerApplicantOutputVo> list = con_EventDao.callEventWinnerApplicant(procedureVo);

        String[] headers = {"No", "회원번호", "닉네임", "응모 횟수", "결제 금액", "방송 시간", "좋아요", "경험치", "받은 선물", "보낸 선물", "팬 수", "당첨 여부", "등수", "응모일시"};
        int[] headerWidths = {3000, 6000, 6000, 3000, 3000, 3000, 3000, 3000, 3000, 3000, 3000, 3000, 3000, 6000};

        List<Object[]> bodies = new ArrayList<>();
        for(int i = 0; i< list.size(); i++) {
            HashMap hm = new LinkedHashMap();

            hm.put("no", list.size()-i);
            hm.put("memNo", DalbitUtil.isEmpty(list.get(i).getMem_no()) ? "" : list.get(i).getMem_no());
            hm.put("memNick", DalbitUtil.isEmpty(list.get(i).getNickName()) ? "" : list.get(i).getNickName());
            hm.put("applyCnt", DalbitUtil.isEmpty(list.get(i).getApplyCnt()) ? "" : list.get(i).getApplyCnt());
            hm.put("payAmt", DalbitUtil.isEmpty(list.get(i).getPayAmt()) ? "" : list.get(i).getPayAmt());
            hm.put("airTime", DalbitUtil.isEmpty(list.get(i).getAirTime()) ? "" : list.get(i).getAirTime());
            hm.put("goodCnt", DalbitUtil.isEmpty(list.get(i).getGoodCnt()) ? "" : list.get(i).getGoodCnt());
            hm.put("exp", DalbitUtil.isEmpty(list.get(i).getExpCnt()) ? "" : list.get(i).getExpCnt());
            hm.put("giftedCnt", DalbitUtil.isEmpty(list.get(i).getGiftedCnt()) ? "" : list.get(i).getGiftedCnt());
            hm.put("giftCnt", DalbitUtil.isEmpty(list.get(i).getGiftCnt()) ? "" : list.get(i).getGiftCnt());
            hm.put("fanCnt", DalbitUtil.isEmpty(list.get(i).getFanCnt()) ? "" : list.get(i).getFanCnt());
            hm.put("isWin", DalbitUtil.isEmpty(list.get(i).getPrizeWin()) ? "" : list.get(i).getPrizeWin());
            hm.put("grade", DalbitUtil.isEmpty(list.get(i).getPrizeRank()) ? "" : list.get(i).getPrizeRank());
            hm.put("applyDate", DalbitUtil.isEmpty(list.get(i).getApplyDate()) ? "" : list.get(i).getApplyDate());

            bodies.add(hm.values().toArray());
        }
        ExcelVo vo = new ExcelVo(headers, headerWidths, bodies);
        SXSSFWorkbook workbook = excelService.excelDownload("응모자당첨자",vo);
        model.addAttribute("locale", Locale.KOREA);
        model.addAttribute("workbook", workbook);
        model.addAttribute("workbookName", "이벤트 응모자당첨자 목록");

        return model;
    }

    /**
     * 당첨자 리스트 조회
     */
    public String callEventWinnerList(P_EventManagementEventIdxInputVo pEventManagementEventIdxInputVo) throws GlobalException{
        ProcedureVo procedureVo = new ProcedureVo(pEventManagementEventIdxInputVo);
        String result;

        try {
            ArrayList<P_EventWinnerListOutputVo> WinnerList = con_EventDao.callEventWinnerList(procedureVo);

            if (Integer.parseInt(procedureVo.getRet()) > 0) {
                result = gsonUtil.toJson(new JsonOutputVo(Status.이벤트관리_당첨자리스트조회_성공, WinnerList, new PagingVo(procedureVo.getRet())));
            } else if (Status.이벤트관리_당첨자리스트조회_리스트없음.getMessageCode().equals(procedureVo.getRet())) {
                result = gsonUtil.toJson(new JsonOutputVo(Status.이벤트관리_당첨자리스트조회_리스트없음));
            } else if (Status.이벤트관리_당첨자리스트조회_이벤트번호없음.getMessageCode().equals(procedureVo.getRet())) {
                result = gsonUtil.toJson(new JsonOutputVo(Status.이벤트관리_당첨자리스트조회_이벤트번호없음));
            } else {
                result = gsonUtil.toJson(new JsonOutputVo(Status.이벤트관리_당첨자리스트조회_실패));
            }
        } catch (Exception e) {
            result = gsonUtil.toJson(new JsonOutputVo(Status.비즈니스로직오류));
        }

        return result;
    }

    /**
     * 당첨자 추가 입력 정보 조회
     */
    public String selectEventWinnerAddInfoDetail(EventWinnerAddInfoDetailVo eventWinnerAddInfoDetailVo) throws GlobalException{
        EventWinnerAddInfoDetailVo winnerInfo = con_EventDao.selectEventWinnerAddInfoDetail(eventWinnerAddInfoDetailVo);
        String result = gsonUtil.toJson(new JsonOutputVo(Status.조회, winnerInfo));

        return result;
    }

    /**
     * 당첨자 추가
     */
    public String callEventWinnerAdd(P_EventWinnerAddVo pEventWinnerAddVo) throws GlobalException{
        pEventWinnerAddVo.setOpName(MemberVo.getMyMemNo());
        ProcedureVo procedureVo = new ProcedureVo(pEventWinnerAddVo);
        String result;

        if(!DalbitUtil.isEmpty(pEventWinnerAddVo.getEventIdx()) && !DalbitUtil.isEmpty(pEventWinnerAddVo.getPrizeIdx()) && !DalbitUtil.isEmpty(pEventWinnerAddVo.getMemNoList())) {
            con_EventDao.callEventWinnerAdd(procedureVo);

            if (Status.이벤트관리_당첨자추가_성공.getMessageCode().equals(procedureVo.getRet())) {
                result = gsonUtil.toJson(new JsonOutputVo(Status.이벤트관리_당첨자추가_성공));
            } else if (Status.이벤트관리_당첨자추가_실패.getMessageCode().equals(procedureVo.getRet())) {
                result = gsonUtil.toJson(new JsonOutputVo(Status.이벤트관리_당첨자추가_실패));
            } else if (Status.이벤트관리_당첨자추가_이벤트번호없음.getMessageCode().equals(procedureVo.getRet())) {
                result = gsonUtil.toJson(new JsonOutputVo(Status.이벤트관리_당첨자추가_이벤트번호없음));
            } else if (Status.이벤트관리_당첨자추가_경품번호없음.getMessageCode().equals(procedureVo.getRet())) {
                result = gsonUtil.toJson(new JsonOutputVo(Status.이벤트관리_당첨자추가_경품번호없음));
            } else if (Status.이벤트관리_당첨자추가_당첨인원초과.getMessageCode().equals(procedureVo.getRet())) {
                result = gsonUtil.toJson(new JsonOutputVo(Status.이벤트관리_당첨자추가_당첨인원초과));
            } else if (Status.이벤트관리_당첨자추가_응모자리스트없음.getMessageCode().equals(procedureVo.getRet())) {
                result = gsonUtil.toJson(new JsonOutputVo(Status.이벤트관리_당첨자추가_응모자리스트없음));
            } else {
                result = gsonUtil.toJson(new JsonOutputVo(Status.이벤트관리_당첨자추가_당첨자선정완료후추가안됨));
            }
        } else {
            result = gsonUtil.toJson(new JsonOutputVo(Status.파라미터오류));
        }

        return result;
    }

    /**
     * 당첨자 취소
     */
    public String callEventWinnerDelete(P_EventWinnerDeleteVo pEventWinnerDeleteVo) throws GlobalException{
        pEventWinnerDeleteVo.setOpName(MemberVo.getMyMemNo());
        ProcedureVo procedureVo = new ProcedureVo(pEventWinnerDeleteVo);
        String result;

        if(!DalbitUtil.isEmpty(pEventWinnerDeleteVo.getEventIdx()) && !DalbitUtil.isEmpty(pEventWinnerDeleteVo.getWinnerIdxList())) {
            con_EventDao.callEventWinnerDelete(procedureVo);

            if (Status.이벤트관리_당첨자취소_성공.getMessageCode().equals(procedureVo.getRet())) {
                result = gsonUtil.toJson(new JsonOutputVo(Status.이벤트관리_당첨자취소_성공));
            } else if (Status.이벤트관리_당첨자취소_실패.getMessageCode().equals(procedureVo.getRet())) {
                result = gsonUtil.toJson(new JsonOutputVo(Status.이벤트관리_당첨자취소_실패));
            } else if (Status.이벤트관리_당첨자취소_이벤트번호없음.getMessageCode().equals(procedureVo.getRet())) {
                result = gsonUtil.toJson(new JsonOutputVo(Status.이벤트관리_당첨자취소_이벤트번호없음));
            } else if (Status.이벤트관리_당첨자취소_당첨자번호리스트없음.getMessageCode().equals(procedureVo.getRet())) {
                result = gsonUtil.toJson(new JsonOutputVo(Status.이벤트관리_당첨자취소_당첨자번호리스트없음));
            } else {
                result = gsonUtil.toJson(new JsonOutputVo(Status.이벤트관리_당첨자취소_당첨자선정완료후삭제안됨));
            }
        } else {
            result = gsonUtil.toJson(new JsonOutputVo(Status.파라미터오류));
        }

        return result;
    }

    /**
     * 당첨자 선정 완료 / 재선정
     */
    public String callEventWinnerComplete(P_EventWinnerCompleteVo pEventWinnerCompleteVo) throws GlobalException{
        pEventWinnerCompleteVo.setOpName(MemberVo.getMyMemNo());
        ProcedureVo procedureVo = new ProcedureVo(pEventWinnerCompleteVo);
        String result;

        if(!DalbitUtil.isEmpty(pEventWinnerCompleteVo.getEventIdx()) && !DalbitUtil.isEmpty(pEventWinnerCompleteVo.getCompleteSlct())) {
            con_EventDao.callEventWinnerComplete(procedureVo);

            if (Status.이벤트관리_당첨자선정완료_성공.getMessageCode().equals(procedureVo.getRet())) {
                result = gsonUtil.toJson(new JsonOutputVo(Status.이벤트관리_당첨자선정완료_성공));
            } else if (Status.이벤트관리_당첨자선정완료_재선정성공.getMessageCode().equals(procedureVo.getRet())) {
                result = gsonUtil.toJson(new JsonOutputVo(Status.이벤트관리_당첨자선정완료_재선정성공));
            } else if (Status.이벤트관리_당첨자선정완료_이벤트번호없음.getMessageCode().equals(procedureVo.getRet())) {
                result = gsonUtil.toJson(new JsonOutputVo(Status.이벤트관리_당첨자선정완료_이벤트번호없음));
            } else if (Status.이벤트관리_당첨자선정완료_당첨인원안맞음.getMessageCode().equals(procedureVo.getRet())) {
                result = gsonUtil.toJson(new JsonOutputVo(Status.이벤트관리_당첨자선정완료_당첨인원안맞음));
            } else {
                result = gsonUtil.toJson(new JsonOutputVo(Status.이벤트관리_당첨자선정완료_실패));
            }
        } else {
            result = gsonUtil.toJson(new JsonOutputVo(Status.파라미터오류));
        }

        return result;
    }

    /**
     * 당첨자 상태 변경
     */
    public String callEventWinnerUpdate(P_EventWinnerUpdateVo pEventWinnerUpdateVo) throws GlobalException{
        String result;
        if(!DalbitUtil.isEmpty(pEventWinnerUpdateVo.getEventIdx()) && !DalbitUtil.isEmpty(pEventWinnerUpdateVo.getUpdateSlct())) {
            int succ_cnt = 0;
            int fail_cnt = 0;
            String[] winnerIdxArr = pEventWinnerUpdateVo.getWinnerIdxs().split(",");

            for (String winnerIdx : winnerIdxArr) {
                if (NumberUtils.isDigits(winnerIdx)) {
                    int eventIdx = pEventWinnerUpdateVo.getEventIdx();
                    int updateSlct = pEventWinnerUpdateVo.getUpdateSlct();
                    ProcedureVo procedureVo = new ProcedureVo(new P_EventWinnerUpdateVo(eventIdx, updateSlct, winnerIdx, MemberVo.getMyMemNo()));

                    con_EventDao.callEventWinnerUpdate(procedureVo);
                    if (Status.이벤트관리_당첨자상태변경_성공.getMessageCode().equals(procedureVo.getRet())) {
                        succ_cnt++;
                    } else {
                        fail_cnt++;
                    }
                }
            }

            var resultMap = new HashMap();
            resultMap.put("succ_cnt", succ_cnt);
            resultMap.put("fail_cnt", fail_cnt);

            if(0 < succ_cnt) {
                result = gsonUtil.toJson(new JsonOutputVo(Status.이벤트관리_당첨자상태변경_성공, resultMap));
            } else {
                result = gsonUtil.toJson(new JsonOutputVo(Status.이벤트관리_당첨자상태변경_실패, resultMap));
            }
        } else {
            result = gsonUtil.toJson(new JsonOutputVo(Status.이벤트관리_당첨자상태변경_변경구분값오류));
        }

        return result;
    }

    /**
     * 당첨자 발표 가져오기
     */
    public String callEventAnnouncementInfo(P_EventManagementEventIdxInputVo pEventManagementEventIdxInputVo) throws GlobalException{
        // winnerContents 부르기 위함
        ProcedureVo procedureVo = new ProcedureVo(pEventManagementEventIdxInputVo);
        String result;

        try {
            con_EventDao.callEventAnnouncementInfo(procedureVo);
            P_EventAnnouncementInfoExtVo winnerContents = new Gson().fromJson(procedureVo.getExt(), P_EventAnnouncementInfoExtVo.class);

            // 기본 경품 목록을 부르기 위함
            ArrayList<P_EventAnnouncementInfoExtVo> defaultList = con_EventDao.selectEventAnnounceListDefault(pEventManagementEventIdxInputVo);

            HashMap resultMap = new HashMap();

            resultMap.put("winnerContents", winnerContents);
            resultMap.put("defaultList", defaultList);

            if (Status.이벤트관리_당첨자발표가져오기_성공.getMessageCode().equals(procedureVo.getRet())) {
                result = gsonUtil.toJson(new JsonOutputVo(Status.이벤트관리_당첨자발표가져오기_성공, resultMap));
            } else if (Status.이벤트관리_당첨자발표가져오기_이벤트번호없음.getMessageCode().equals(procedureVo.getRet())) {
                result = gsonUtil.toJson(new JsonOutputVo(Status.이벤트관리_당첨자발표가져오기_이벤트번호없음));
            } else if (Status.이벤트관리_당첨자발표가져오기_선정완료안됨.getMessageCode().equals(procedureVo.getRet())) {
                result = gsonUtil.toJson(new JsonOutputVo(Status.이벤트관리_당첨자발표가져오기_선정완료안됨));
            } else {
                result = gsonUtil.toJson(new JsonOutputVo(Status.이벤트관리_당첨자발표가져오기_실패));
            }
        } catch (Exception e) {
            result = gsonUtil.toJson(new JsonOutputVo(Status.비즈니스로직오류));
        }

        return result;
    }

    /**
     * 당첨자 발표 등록/수정
     */
    public String callEventAnnouncementEdit(P_EventAnnouncementEditVo pEventAnnouncementEditVo) throws GlobalException{
        pEventAnnouncementEditVo.setOpName(MemberVo.getMyMemNo());
        ProcedureVo procedureVo = new ProcedureVo(pEventAnnouncementEditVo);
        String result;

        if(!DalbitUtil.isEmpty(pEventAnnouncementEditVo.getEventIdx())) {
            con_EventDao.callEventAnnouncementEdit(procedureVo);

            if (Status.이벤트관리_당첨자발표리스트등록수정_성공.getMessageCode().equals(procedureVo.getRet())) {
                result = gsonUtil.toJson(new JsonOutputVo(Status.이벤트관리_당첨자발표리스트등록수정_성공));
            } else if (Status.이벤트관리_당첨자발표리스트등록수정_이벤트번호없음.getMessageCode().equals(procedureVo.getRet())) {
                result = gsonUtil.toJson(new JsonOutputVo(Status.이벤트관리_당첨자발표리스트등록수정_이벤트번호없음));
            } else if (Status.이벤트관리_당첨자발표리스트등록수정_선정완료안됨.getMessageCode().equals(procedureVo.getRet())) {
                result = gsonUtil.toJson(new JsonOutputVo(Status.이벤트관리_당첨자발표리스트등록수정_선정완료안됨));
            } else {
                result = gsonUtil.toJson(new JsonOutputVo(Status.이벤트관리_당첨자발표리스트등록수정_실패));
            }
        } else {
            result = gsonUtil.toJson(new JsonOutputVo(Status.파라미터오류));
        }

        return result;
    }



    /*======================= 기존 이벤트 관리 ======================= */
//    /**
//     * 이벤트 목록
//     */
//    public String getEventList(P_EventListInputVo pEventListInputVo){
//        ArrayList<P_EventListOutputVo> eventList = null;
//        int totalCnt;
//
//        pEventListInputVo.setPageNo(pEventListInputVo.getPageNo() -1);
//        pEventListInputVo.setPageNo(pEventListInputVo.getPageNo() * pEventListInputVo.getPageCnt());
//
//        if(pEventListInputVo.getState() == 0) {
//            eventList = con_EventDao.callEventList(pEventListInputVo);
//            totalCnt = con_EventDao.callEventList_totalCnt(pEventListInputVo);
//        }else {
//            eventList = con_EventDao.callEventList_End(pEventListInputVo);
//            totalCnt = con_EventDao.callEventList_End_totalCnt(pEventListInputVo);
//        }
//
//        String result;
//        if(eventList.size() > 0) {
//            result = gsonUtil.toJson(new JsonOutputVo(Status.이벤트목록보기_성공, eventList, new PagingVo(totalCnt)));
//        }else{
//            result = gsonUtil.toJson(new JsonOutputVo(Status.이벤트목록보기_실패));
//        }
//        return result;
//    }
//
//    /**
//     * 이벤트 등록
//     */
//    public String setEventDelete(P_EventDeleteVo pEventDeleteVo){
//        String result;
//        pEventDeleteVo.setOpName(MemberVo.getMyMemNo());
//        con_EventDao.callEventDelete(pEventDeleteVo);
//        con_EventDao.callEventMemberDelete(pEventDeleteVo);
//        result = gsonUtil.toJson(new JsonOutputVo(Status.이벤트삭제성공));
//
//        return result;
//    }
//
//    /**
//     * 이벤트 등록
//     */
//    public String setEventInsert(P_EventUpdateVo pEventUpdateVo){
//        String result;
//        pEventUpdateVo.setOpName(MemberVo.getMyMemNo());
//        con_EventDao.callEventInsert(pEventUpdateVo);
//        result = gsonUtil.toJson(new JsonOutputVo(Status.이벤트등록성공));
//
//        return result;
//    }
//
//    /**
//     * 이벤트 수정
//     */
//    public String setEventUpdate(P_EventUpdateVo pEventUpdateVo){
//        String result;
//        pEventUpdateVo.setOpName(MemberVo.getMyMemNo());
//        con_EventDao.callEventUpdate(pEventUpdateVo);
//        result = gsonUtil.toJson(new JsonOutputVo(Status.이벤트수정성공));
//
//        return result;
//    }
//
//    /**
//     * 이벤트 응모자 목록
//     */
//    public String getEventMemberList(P_EventMemberListInputVo pEventMemberListInputVo){
//        pEventMemberListInputVo.setPageNo(pEventMemberListInputVo.getPageNo() -1);
//        pEventMemberListInputVo.setPageNo(pEventMemberListInputVo.getPageNo() * pEventMemberListInputVo.getPageCnt());
//
//        ArrayList<P_EventMemberListOutputVo> eventMemberList = con_EventDao.callEventMemberList(pEventMemberListInputVo);
//        int totalCnt = con_EventDao.callEventMemberList_totalCnt(pEventMemberListInputVo);
//        int winCnt;
//
//        int maleCnt =0;
//        int femaleCnt =0;
//        int maleWinCnt =0;
//        int femaleWinCnt =0;
//        int overlapCnt =0;
//
//        List list = new ArrayList();
//        if(!DalbitUtil.isEmpty(eventMemberList)) {
//            for (int i = 0; i < eventMemberList.size(); i++) {
//                winCnt = con_EventDao.callEventMemberList_winCnt(eventMemberList.get(i).getMem_no());
//                P_EventMemberListOutputVo outVo = new P_EventMemberListOutputVo();
//                outVo.setRowNum(eventMemberList.get(i).getRowNum());
//                outVo.setEvent_idx(eventMemberList.get(i).getEvent_idx());
//                outVo.setMem_no(eventMemberList.get(i).getMem_no());
//                outVo.setIs_win(eventMemberList.get(i).getIs_win());
//                outVo.setOrder(eventMemberList.get(i).getOrder());
//                outVo.setMem_userid(eventMemberList.get(i).getMem_userid());
//                outVo.setMem_nick(eventMemberList.get(i).getMem_nick());
//                outVo.setMem_sex(eventMemberList.get(i).getMem_sex());
//                outVo.setMem_birth_year(eventMemberList.get(i).getMem_birth_year());
//                outVo.setMem_birth_month(eventMemberList.get(i).getMem_birth_month());
//                outVo.setMem_birth_day(eventMemberList.get(i).getMem_birth_day());
//                outVo.setMem_phone(eventMemberList.get(i).getMem_phone());
//                outVo.setListenCnt(eventMemberList.get(i).getListenCnt());
//                outVo.setBroadCnt(eventMemberList.get(i).getBroadCnt());
//                outVo.setGiftCnt(eventMemberList.get(i).getGiftCnt());
//                outVo.setApplyCnt(eventMemberList.get(i).getApplyCnt());
//                outVo.setWinCnt(winCnt);
//                list.add(outVo);
//
//                if(eventMemberList.get(i).getMem_sex().equals("m")){
//                    maleCnt++;
//                    if(eventMemberList.get(i).getIs_win() == 1){
//                        maleWinCnt++;
//                    }
//                }else{
//                    femaleCnt++;
//                    if(eventMemberList.get(i).getIs_win() == 1){
//                        femaleWinCnt++;
//                    }
//                }
//                if(eventMemberList.get(i).getApplyCnt() > 1){
//                    overlapCnt++;
//                }
//            }
//        }
//
//        P_EventMemberListOutputVo summary = new P_EventMemberListOutputVo();
//        summary.setMaleCnt(maleCnt);
//        summary.setMaleWinCnt(maleWinCnt);
//        summary.setFemaleCnt(femaleCnt);
//        summary.setFemaleWinCnt(femaleWinCnt);
//        summary.setOverlapCnt(overlapCnt);
//
//
//        String result;
//        if(eventMemberList.size() > 0) {
//            result = gsonUtil.toJson(new JsonOutputVo(Status.이벤트응모자목록보기_성공, list, new PagingVo(totalCnt),summary));
//        }else{
//            result = gsonUtil.toJson(new JsonOutputVo(Status.이벤트응모자목록보기_실패));
//        }
//        return result;
//    }
//
//
//    /**
//     * 이벤트 응모자 선정
//     */
//    public String getEventMemberSelWin(P_EventMemberSelWinVo pEventMemberSelWinVo){
//        pEventMemberSelWinVo.setOpName(MemberVo.getMyMemNo());
//        con_EventDao.callEventSelWIn(pEventMemberSelWinVo);
//
//        String result;
//        result = gsonUtil.toJson(new JsonOutputVo(Status.이벤트응모자선정_성공));
//        return result;
//    }
//
//    /**
//     * 이벤트 중복 응모자 목록
//     */
//    public String getEventOverlapApplyList(P_EventMemberListInputVo pEventMemberListInputVo){
//        ArrayList<P_EventMemberListOutputVo> eventOverlapApplyList = con_EventDao.callEventOverlapApplyList(pEventMemberListInputVo);
//
//        String result;
//        if(eventOverlapApplyList.size() > 0) {
//            result = gsonUtil.toJson(new JsonOutputVo(Status.이벤트중복응모자목록보기_성공, eventOverlapApplyList));
//        }else{
//            result = gsonUtil.toJson(new JsonOutputVo(Status.이벤트중복응모자목록보기_실패));
//        }
//        return result;
//    }
//
//
//    /**
//     * 이벤트 댓글 리스트
//     */
        public String getEventReplyList(P_EventReplyListInputVo pEventReplyListInputVo) {
            int totalCnt = con_EventDao.callEventReplyList_totalCnt(pEventReplyListInputVo);
            ArrayList<P_EventReplyListOutputVo> eventReplyList = con_EventDao.callEventReplyList(pEventReplyListInputVo);

            String result;
            if(eventReplyList.size() > 0) {
                result = gsonUtil.toJson(new JsonOutputVo(Status.이벤트중복응모자목록보기_성공, eventReplyList, new PagingVo(totalCnt)));
            }else{
                result = gsonUtil.toJson(new JsonOutputVo(Status.이벤트중복응모자목록보기_실패));
            }
            return result;
        }

        /**
         * 이벤트 댓글 삭제
         */
        public String getEventReplyDelete(P_EventReplyDeleteInputVo pEventReplyDeleteInputVo) {
            String result;
            pEventReplyDeleteInputVo.setOpName(MemberVo.getMyMemNo());
            int delResult =con_EventDao.callEventReplyDelete(pEventReplyDeleteInputVo);
            if(delResult > 0){
                result = gsonUtil.toJson(new JsonOutputVo(Status.이벤트댓글삭제성공));
            }else{
                result = gsonUtil.toJson(new JsonOutputVo(Status.이벤트댓글삭제실패));
            }

            return result;
        }
}
