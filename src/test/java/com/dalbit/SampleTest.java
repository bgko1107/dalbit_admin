package com.dalbit;

import com.dalbit.administrate.service.Adm_AlarmTalkService;
import com.dalbit.common.service.CommonService;
import com.dalbit.common.service.EmailService;
import com.dalbit.common.service.SmsService;
import com.dalbit.socket.service.SocketService;
import com.dalbit.util.JwtUtil;
import com.dalbit.util.RestApiUtil;
import lombok.extern.slf4j.Slf4j;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.ActiveProfiles;

import java.text.NumberFormat;


@Slf4j
@SpringBootTest
@ActiveProfiles({"local"})
public class SampleTest {

    @Autowired
    CommonService commonService;
    @Autowired
    RestApiUtil restApiUtil;
    @Autowired
    SocketService socketService;
    @Autowired
    JwtUtil jwtUtil;
    @Autowired
    SmsService smsService;
    @Autowired
    EmailService emailService;

    @Autowired
    Adm_AlarmTalkService alarmTalkService;

    @Test
    public void 알림톡테스트(){
        System.out.println(NumberFormat.getInstance().format("12345"));
    }


    @Test
    public void 테스트() throws JSONException {
        System.out.println(100%99);
        System.out.println(100%1);
        System.out.println(100%200);

        String json = "[{\"code\":\"success\",\"data\":{\"phn\":\"821045990513\",\"msgid\":\"WEB20200618170130816644\",\"type\":\"AT\"},\"message\":\"K000\"},{\"code\":\"success\",\"data\":{\"phn\":\"01045990513\",\"msgid\":\"WEB20200618170130905736\",\"type\":\"AT\"},\"message\":\"K000\"},{\"code\":\"fail\",\"data\":{\"phn\":\"444\",\"msgid\":\"WEB20200618170130991730\",\"type\":\"AT\"},\"message\":\"E104:InvalidPhoneNumber\"},{\"code\":\"fail\",\"data\":{\"phn\":null,\"msgid\":\"WEB20200618170131031320\",\"type\":\"AT\"},\"message\":\"E104:InvalidPhoneNumber\"}]";


        JSONArray jsonArr = new JSONArray(json);

        for (int i = 0; i < jsonArr.length(); i++)
        {
            JSONObject jsonObj = jsonArr.getJSONObject(i);

            JSONObject  data = jsonObj.getJSONObject("data");
            System.out.println(jsonObj);
            System.out.println(data);
        }



        /*
        P_EventReplyDeleteInputVo p1 = new P_EventReplyDeleteInputVo();
        p1.setOpName("t1");

        P_EventReplyDeleteInputVo p2 = new P_EventReplyDeleteInputVo();
        p2.setOpName("t2");

        List<P_EventReplyDeleteInputVo> l1 = new ArrayList<>();
        l1.add(p1);
        l1.add(p2);

        System.out.println(new Gson().toJson(l1));



        String phone = "01055606434";

        log.debug(DalbitUtil.convertPhoneNo(phone));

        */
    }

}
