package com.dalbit.administrate.service;

import com.dalbit.administrate.dao.Adm_AlarmTalkDao;
import com.dalbit.administrate.vo.AlarmTalkValVo;
import com.dalbit.administrate.vo.procedure.*;
import com.dalbit.common.code.AlarmTalkTemplate;
import com.dalbit.common.code.Code;
import com.dalbit.common.code.Status;
import com.dalbit.common.vo.JsonOutputVo;
import com.dalbit.common.vo.PagingVo;
import com.dalbit.common.vo.ProcedureVo;
import com.dalbit.common.vo.SearchVo;
import com.dalbit.inforex.vo.InforexMember;
import com.dalbit.util.DalbitUtil;
import com.dalbit.util.GsonUtil;
import com.dalbit.util.InforexApiUtil;
import com.dalbit.util.RestApiUtil;
import com.google.common.collect.Lists;
import com.google.gson.Gson;
import lombok.extern.slf4j.Slf4j;
import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.stream.Collectors;

@Slf4j
@Service
public class Adm_AlarmTalkService {

    @Autowired
    Adm_AlarmTalkDao admAlarmTalkDao;

    @Autowired
    Adm_AuthorityService admAuthorityService;

    @Autowired
    GsonUtil gsonUtil;

    @Value("${alarmtalk.profile}")
    String ALARMTALK_PROFILE;
    @Value("${alarmtalk.userid}")
    String ALARMTALK_USER_ID;
    @Value("${alarmtalk.url}")
    String ALARMTALK_URL;

    private static int restApiTimeout;

    @Value("${rest.api.timeout}")
    public void setRestApiTimeout(int timeoutSecond){
        restApiTimeout = timeoutSecond;
    }


    /** 알림톡 발송 대상 리스트 */
    public List<InforexMember> callAlarmTalkTargetList(SearchVo searchVo) {

        // 검색조건 대상자 조회
        List<InforexMember> memberList = admAuthorityService.getInforexMemberList(searchVo);
        // 알림톡 발송 대상 리스트 조회
        List<P_AlarmTalkTargetListOutputVo> targetList =  admAlarmTalkDao.callAlarmTalkTarget();

        // 검색 조건에 알림톡 발송 대상 여부 체크
        for (InforexMember member : memberList) {
            member.setAlarmTalkTarget(targetList.stream().filter(inforexMember -> inforexMember.getEmp_no().equals(member.getEmp_no())).collect(Collectors.toList()).size());
        }

        return memberList;
    }

    /** 알림톡 발송 대상 수정 */
    public void targetEdit(P_AlarmTalkTargetEditVo pAlarmTalkTargetEditVo) {
        HashMap<String, Object> targets = new HashMap<>();
        List<HashMap> insertTargets = pAlarmTalkTargetEditVo.getInsertTargets();
        List<HashMap> deleteTargets = pAlarmTalkTargetEditVo.getDeleteTargets();

        targets.put("opName", pAlarmTalkTargetEditVo.getOpName());
        targets.put("insertTargets", insertTargets);
        targets.put("deleteTargets", deleteTargets);

        if(!DalbitUtil.isEmpty(insertTargets) && insertTargets.size() > 0) admAlarmTalkDao.alarmTalkTargetAdd(targets);
        if(!DalbitUtil.isEmpty(deleteTargets) && deleteTargets.size() > 0) admAlarmTalkDao.alarmTalkTargetRemove(targets);
    }



    /** 알림톡 발송 로그 리스트 */
    public String callAlarmTalkLogList(P_AlarmTalkLogListInputVo pAlarmTalkLogListInputVo) {
        String result;

        // 임직원 리스트
        HashMap<String, InforexMember> mapInforexMembers = InforexApiUtil.getInforexMemberSearchMap();

        // 로그 리스트
        int totalCnt = admAlarmTalkDao.callAlarmTalkLogList_total(pAlarmTalkLogListInputVo);
        pAlarmTalkLogListInputVo.setTotalCnt(totalCnt);

        pAlarmTalkLogListInputVo.setPageStart(pAlarmTalkLogListInputVo.getPageStart() -1);
        pAlarmTalkLogListInputVo.setPageStart(pAlarmTalkLogListInputVo.getPageStart() * pAlarmTalkLogListInputVo.getPageCnt());
        List<P_AlarmTalkLogListOutputVo> logList = admAlarmTalkDao.callAlarmTalkLogList(pAlarmTalkLogListInputVo);

        for(P_AlarmTalkLogListOutputVo log : logList){
            InforexMember target = mapInforexMembers.get(log.getEmp_no());

            if(!DalbitUtil.isEmpty(target)){
                log.setStaff_hphone(target.getStaff_hphone());
                log.setStaff_name(target.getStaff_name());
            }
        }


        if(logList != null && logList.size() > 0){
            result = gsonUtil.toJson(new JsonOutputVo(Status.알림톡로그조회_성공, logList, new PagingVo(pAlarmTalkLogListInputVo.getTotalCnt(), pAlarmTalkLogListInputVo.getPageStart(), pAlarmTalkLogListInputVo.getPageCnt())));
        }else {
            result = gsonUtil.toJson(new JsonOutputVo(Status.알림톡로그조회_데이터없음, null, new PagingVo(pAlarmTalkLogListInputVo.getTotalCnt(), pAlarmTalkLogListInputVo.getPageStart(), pAlarmTalkLogListInputVo.getPageCnt())));
        }

        return result;
    }





    /** 통계 알림톡 발송 */
    public void sendStatusAlarmTalk() {
        ProcedureVo procedureVo = new ProcedureVo();
        List<P_AlarmTalkInsertVo> sendList = new ArrayList<>();

        try {
            // 변수 데이터 조회
            admAlarmTalkDao.callSpStatGetData(procedureVo);

            if(!DalbitUtil.isEmpty(procedureVo.getRet())){// 성공
                log.info("[AlarmTalk] 통계 조회 성공 : {}", procedureVo.getRet());
                String tmpId = AlarmTalkTemplate.알림톡_달빛라이브_직원관리용_CONT1.getId();
                String msg = AlarmTalkTemplate.알림톡_달빛라이브_직원관리용_CONT1.getMsg();

                AlarmTalkValVo alarmTalkValVo = new Gson().fromJson(procedureVo.getRet(), AlarmTalkValVo.class);
                msg = msg.replace("#{1}", DalbitUtil.convertNumberType(Integer.parseInt(alarmTalkValVo.getWeb_male_cnt())));
                msg = msg.replace("#{2}", DalbitUtil.convertNumberType(Integer.parseInt(alarmTalkValVo.getWeb_female_cnt())));
                msg = msg.replace("#{3}", DalbitUtil.convertNumberType(Integer.parseInt(alarmTalkValVo.getMobile_male_cnt())));
                msg = msg.replace("#{4}", DalbitUtil.convertNumberType(Integer.parseInt(alarmTalkValVo.getMobile_female_cnt())));
                msg = msg.replace("#{5}", DalbitUtil.convertNumberType(Integer.parseInt(alarmTalkValVo.getConnect_member_cnt())));
                msg = msg.replace("#{6}", DalbitUtil.convertNumberType(Integer.parseInt(alarmTalkValVo.getConnect_nonmem_cnt())));
                msg = msg.replace("#{7}", DalbitUtil.convertNumberType(Integer.parseInt(alarmTalkValVo.getConnect_30_cnt())));
                msg = msg.replace("#{8}", DalbitUtil.convertNumberType(Integer.parseInt(alarmTalkValVo.getConnect_10_cnt())));
                msg = msg.replace("#{9}", DalbitUtil.convertNumberType(Integer.parseInt(alarmTalkValVo.getBroadcast_create_cnt())));
                msg = msg.replace("#{10}", DalbitUtil.convertNumberType(Integer.parseInt(alarmTalkValVo.getBroadcast_listener_cnt())));
                msg = msg.replace("#{11}", DalbitUtil.convertNumberType(Integer.parseInt(alarmTalkValVo.getPayment_cnt())));
                msg = msg.replace("#{12}", DalbitUtil.convertNumberType(Integer.parseInt(alarmTalkValVo.getPayment_amt())));
                msg = msg.replace("#{13}", DalbitUtil.convertNumberType(Integer.parseInt(alarmTalkValVo.getDal_pay_amt())));
                msg = msg.replace("#{14}", DalbitUtil.convertNumberType(Integer.parseInt(alarmTalkValVo.getDal_use_amt())));


                //발송 대상 조회
                List<P_AlarmTalkTargetListOutputVo> targetList =  admAlarmTalkDao.callAlarmTalkTarget();

                if(targetList.size() <= 0){
                    log.debug("[AlarmTalk] 발송 대상 미존재");
                    return;
                }

                String result = RestApiUtil.sendGet(DalbitUtil.getProperty(Code.인포렉스_임직원목록.getDesc()));
                InforexMember[] inforexMembers = new Gson().fromJson(result, InforexMember[].class);
                List<InforexMember> memberList = Arrays.asList(inforexMembers);

                for(int idx=0; idx < targetList.size(); idx++){
                    P_AlarmTalkTargetListOutputVo target = targetList.get(idx);
                    List<InforexMember> inforexMemberList = memberList.stream()
                                .filter(inforexMember -> inforexMember.getEmp_no().equals(target.getEmp_no()))
                                .collect(Collectors.toList());

                    // 어드민 계정 검증
                    if(inforexMemberList.size() <= 0){
                        log.error("[AlarmTalk] 어드민 계정 미존재 [emp_no : {}]", target.getEmp_no());
                        continue;
                    }

                    InforexMember member = inforexMemberList.get(0);

                    String targetPhone = DalbitUtil.convertInternationalPhone(member.getStaff_hphone(), "82");
                    if(targetPhone == null){
                        log.error("[AlarmTalk] 핸드폰번호 비정상 [phone : {} / {}]", member.getStaff_hphone(), targetPhone);
                        continue;
                    }

                    P_AlarmTalkInsertVo pAlarmTalkInsertVo = new P_AlarmTalkInsertVo();
                    pAlarmTalkInsertVo.setEmp_no(member.getEmp_no());
                    pAlarmTalkInsertVo.setUserid(ALARMTALK_USER_ID);
                    pAlarmTalkInsertVo.setMessage_type("at");
                    pAlarmTalkInsertVo.setPhn(targetPhone);
                    pAlarmTalkInsertVo.setProfile(ALARMTALK_PROFILE);
                    pAlarmTalkInsertVo.setTmplId(tmpId);
                    pAlarmTalkInsertVo.setMsg(msg);
                    pAlarmTalkInsertVo.setReserveDt("00000000000000");   // 즉시발송

                    sendList.add(pAlarmTalkInsertVo);
                }

                if(sendList.size() > 0){
                    // 알림톡 발송 요청
                    sendAlarmTalk(sendList, null);
                }else{
                    log.debug("[AlarmTalk] 정상 발송 대상 미존재");
                }
            }else{
                log.error("[AlarmTalk] 통계 조회 실패 : {}", procedureVo.getRet());
            }

        }catch (Exception e){
            e.printStackTrace();
            log.error("[AlarmTalk] 발송 에러 : {}", e.getMessage());
        }
    }


    public void sendAlarmTalk(List<P_AlarmTalkInsertVo> sendList, String opName){
        // 발송 그룹 키
        String group_idx = DalbitUtil.randomValueDatetime(3);

        /** 최대 알림 톡 발송 건수가 100건이므로 나눠서 발송 요청 */
        List<List<P_AlarmTalkInsertVo>> partSendList = Lists.partition(sendList, 100);
        for(List<P_AlarmTalkInsertVo> part :partSendList){
            StringBuilder result = new StringBuilder();
            String jsonMessage = new Gson().toJson(part);
            P_AlarmTalkLogInsertVo pAlarmTalkLogInsertVo = new P_AlarmTalkLogInsertVo();
            pAlarmTalkLogInsertVo.setGroup_idx(group_idx);
            pAlarmTalkLogInsertVo.setSendList(part);
            pAlarmTalkLogInsertVo.setOp_name(DalbitUtil.isEmpty(opName) ? "관리자" : opName);

            // 발송로그 적재
            admAlarmTalkDao.callAlarmTalkLogAdd(pAlarmTalkLogInsertVo);

            // 발송요청
            try {
                String sendURL = ALARMTALK_URL + "/v2/sender/send";

                URL url = new URL(sendURL);
                HttpURLConnection con = (HttpURLConnection) url.openConnection();
                con.setRequestMethod("POST");
                con.setRequestProperty("Content-Type", "application/json");
                con.setRequestProperty("userid", ALARMTALK_USER_ID);
                con.setDoInput(true);
                con.setDoOutput(true);
                con.setUseCaches(false);
                con.setDefaultUseCaches(false);

                con.setConnectTimeout(restApiTimeout); //서버에 연결되는 Timeout 시간 설정
                con.setReadTimeout(restApiTimeout); // InputStream 읽어 오는 Timeout 시간 설정

                OutputStream outputStream = con.getOutputStream();
                outputStream.write(jsonMessage.getBytes("UTF-8"));
                outputStream.flush();

                if (con.getResponseCode() == HttpURLConnection.HTTP_OK) {
                    BufferedReader br = new BufferedReader(new InputStreamReader(con.getInputStream(), "utf-8"));
                    String line;
                    while ((line = br.readLine()) != null) {
                        result.append(line);
                    }
                    br.close();

                    log.debug(result.toString());

                    JSONArray jsonArr = new JSONArray(result.toString());

                    for (int i = 0; i < jsonArr.length(); i++) {
                        JSONObject jsonObj = jsonArr.getJSONObject(i);
                        JSONObject  data = jsonObj.getJSONObject("data");

                        if(data.get("phn") != null && !data.get("phn").equals("")){
                            String resultCode = jsonObj.get("code").toString().equals("success") ? "1" : "-1";
                            P_AlarmTalkLogUpdateVo resultLog = new P_AlarmTalkLogUpdateVo();
                            resultLog.setGroup_idx(group_idx);
                            resultLog.setPhn(data.get("phn").toString());
                            resultLog.setResult_code(resultCode);
                            resultLog.setResult_cont(jsonObj.toString());

                            admAlarmTalkDao.callAlarmTalkLogUpdate(resultLog);
                        }

                        if(jsonObj.get("code").equals("fail")){
                            //실패 로그
                            log.error("[AlarmTalk] 발송 실패 {}", jsonObj.toString());
                        }else{
                            log.info("[AlarmTalk] 발송 성공 {}", jsonObj.toString());
                        }
                    }
                } else {
                    result.append(con.getResponseMessage());

                    P_AlarmTalkLogUpdateVo resultLog = new P_AlarmTalkLogUpdateVo();
                    resultLog.setGroup_idx(group_idx);
                    resultLog.setResult_code("-9");
                    resultLog.setResult_cont(result.toString());

                    admAlarmTalkDao.callAlarmTalkLogUpdate(resultLog);
                }

                log.debug("[AlarmTalk] 발송 요청 결과 : {}", result.toString());

            } catch (Exception e){
                e.printStackTrace();
                result.append(e.getMessage());

                log.error("[AlarmTalk] 발송 요청 에러 : {}", result.toString());
            }
        }
    }


}
