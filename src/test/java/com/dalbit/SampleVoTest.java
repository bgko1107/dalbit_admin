package com.dalbit;

import com.dalbit.common.service.CommonService;
import com.dalbit.common.service.EmailService;
import com.dalbit.common.service.SmsService;
import com.dalbit.socket.service.SocketService;
import com.dalbit.util.JwtUtil;
import com.dalbit.util.RestApiUtil;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.ActiveProfiles;

@Slf4j
@SpringBootTest
@ActiveProfiles({"local"})
public class SampleVoTest {

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


//    @Test
//    public void 공통코드조회(){
//        List<CodeVo> codeVoList = commonService.getCodeList("subject_type");
//        log.info("공통코드 : {}", codeVoList);
//
//        //commonService.getCodeList("subject_type");
//    }
//
//    @Test
//    public void 인포렉스로그인()throws Exception{
//
//        RequestBody formBody = new FormBody.Builder()
//            .add("userid", "leejaeho1144")
//            .add("password", "20706wogh!")
//            .add("mode", "login")
//            .add("where", "dalbit")
//        .build();
//
//        OkHttpClientUtil okHttpClientUtil = new OkHttpClientUtil();
//        Response response = okHttpClientUtil.sendPost("http://admin.inforex.co.kr/loginout.html", null);
//
//        response.headers().toMultimap().get("set-cookie").stream().forEach(cookie ->{
//            log.info("cookie info : {}", cookie);
//        });
//        log.info("data : {}", response.body().string());
//    }
//
//    @Test
//    public void 인포렉스메뉴가져오기()throws Exception{
//
//        OkHttpClientUtil okHttpClientUtil = new OkHttpClientUtil();
//        String result = okHttpClientUtil.sendGet("http://admin.inforex.co.kr/dalbit/getCommonMenu.php", null,"", "");
//        log.info(result);
//    }
//
//    @Test
//    public void 쿠키파싱하기(){
//        String cookieString = "ADMIN_COOKIE=eJw9jtkNgzAMhnfxBAkEEGYYZAnTQ80hQqRWVafpIjzy0D26RmMU9cmf%2F8MyYYfPiC0C2zA6D0PEBkH3qqmEDYIjy4I5s3227%2F4uS4q8XCZZdIVwY74Sn73WxohWI0S%2BHy6CPabKwC6Np8WnIEqu1Z1AX5z1Ebh88A%2Fp3I8rzXPu0cTlooLh9QOpVzph; path=/; domain=.inforex.co.kr";
//        String[] cookieGubun = cookieString.split(";");
//        CookieVo cookieVo = new CookieVo();
//
//        for (String cookieSlice : cookieGubun) {
//            String[] temp = cookieSlice.split("=");
//            if(temp[0].trim().equals("path")){
//                cookieVo.setPath(temp[1]);
//            }else if(temp[0].trim().equals("domain")){
//                cookieVo.setDomain(temp[1]);
//            }else{
//                cookieVo.setKey(temp[0]);
//                cookieVo.setValue(temp[1]);
//            }
//        }
//
//        log.info(cookieVo.toString());
//
//    }
//
//    @Test
//    public void API서버콜테스트() throws GlobalException {
//        RequestBody formBody = new FormBody.Builder()
//                .add("userid", "leejaeho1144")
//                .add("mode", "login")
//                .add("where", "dalbit")
//                .build();
//
//        OkHttpClientUtil okHttpClientUtil = new OkHttpClientUtil();
//        Response response = okHttpClientUtil.sendPost("https://devm-hwlee.dalbitlive.com:4431/self/auth/res", formBody);
//    }
//
//    @Test
//    public void 메뉴테스트()throws Exception{
//        OkHttpClientUtil okHttpClientUtil = new OkHttpClientUtil();
//        Response response = okHttpClientUtil.sendGet("http://admin.inforex.co.kr/dalbit/getCommonMenu.php");
//    }
//
//    @Test
//    public void 직급코드()throws Exception{
//        String result = RestApiUtil.sendGet("http://admin.inforex.co.kr/dalbit/getPosCodeList.php");
//
//        InforexPosCode[] inforexPosCodes = new Gson().fromJson(result, InforexPosCode[].class);
//        log.info("결과 : {}", inforexPosCodes);
//        log.info("파싱 결과 : {}", inforexPosCodes);
//    }
//    @Test
//    public void 소켓테스트()throws Exception{
//
//        log.info("@@@@@@@@@@@@@@@@  1");
//        socketService.kickout("91585616496431","11584406236831","11583120797169",jwtUtil.generateToken("11584406236831", true),true);
//
//        log.info("@@@@@@@@@@@@@@@@  2");
//    }
//
//    @Test
//    public void 문자발송테스트()throws GlobalException{
////        smsService.sendSms(new SmsHistoryVo("[내용]내용이에요 안드로이드는 제목이 보이죠?", "01073041558"));
//    }
//
//    @Test
//    public void 휴대폰유효성체크(){
//        log.info("검증결과 : {}", DalbitUtil.isSmsPhoneNoChk("01055606434"));
//        log.info("검증결과 : {}", DalbitUtil.isSmsPhoneNoChk("0105560643"));
//        log.info("검증결과 : {}", DalbitUtil.isSmsPhoneNoChk("010556064311"));
//        log.info("검증결과 : {}", DalbitUtil.isSmsPhoneNoChk("331230556064311"));
//        log.info("검증결과 : {}", DalbitUtil.isSmsPhoneNoChk("1234567890"));
//    }
//
//    @Test
//    public void 메뉴가져오기테스트(){
//        List<MenuVo> allMenuList = commonService.getMenuInfo(new MenuVo());
//        List<MenuVo> oneDepthMenuList = commonService.getMenuInfo(new MenuVo(1));
//        List<MenuVo> twoDepthMenuList = commonService.getMenuInfo(new MenuVo(2));
//        log.debug("test");
//
//    }
//
//    @Test
//    public void 지정특수문자만난수테스트(){
//        int pwdLength = 2;
//        char[] passwordTable =  {'!', '@', '#', '$', '%', '^', '&', '*','(', ')'};
//        Random random = new Random(System.currentTimeMillis());
//        int tablelength = passwordTable.length;
//        String password = "";
//        for(int i = 0; i < pwdLength; i++) {
//            password = password + Character.toString(passwordTable[random.nextInt(tablelength)]);
//        }
//        log.info(password);
//        log.debug("test");
//
//    }
//
//    @Test
//    public void 난수테스트(){
//        log.info(DalbitUtil.randomValue("p", 6));
//        log.info(DalbitUtil.randomValue("a", 6));
//        log.info(DalbitUtil.randomValue("String", 6));
//        log.info(DalbitUtil.randomValue("number", 6));
//        log.info(DalbitUtil.randomValue("c", 6));
//        log.info(DalbitUtil.randomValue("e", 6));
//
//    }
//
//    @Test
//    @Async("threadTaskExecutor")
//    public void API호출(){
//        HashMap map = new HashMap();
//        map.put("test", "test");
//
//        String result = RestApiUtil.sendPost("https://devm-leejaeho1144.dalbitlive.com:4431/splash", new Gson().toJson(map));
//        log.debug(result);
//    }
//
//    @Test
//    public void 이메일발송테스트()throws UnsupportedEncodingException {
//
//        emailService.sendEmail();
//    }

//    @Test
//    public void 파일내용읽기테스트(){
//        URL url = null;
//        try {
////            url = new URL("http://image.dalbitlive.com/resource/mailForm/mailTest.txt");
//            url = new URL("http://image.dalbitlive.com/resource/mailForm/mailTest.txt");
//        } catch(MalformedURLException e1) {
//            e1.printStackTrace();
//        }
//
//        InputStream in;
//        try {
//            in = url.openStream();
//            byte[] buffer = new byte[128];
//            int readCount;
//            StringBuilder result = new StringBuilder();
//
//            while((readCount = in.read(buffer)) != -1) {
//                String part = new String(buffer, 0, readCount);
//                result.append(part);
//            }
//            //replace
//            String msgCont = result.toString().replaceAll("@@ANSWER@@", "답변이다 임마");
//
//            EmailInputVo emailInputVo = new EmailInputVo();
//            emailInputVo.setTitle("답변 : ");
//            emailInputVo.setMsgCont(msgCont);
//            emailInputVo.setRcvMail("zox5702@naver.com");
//            emailService.sendEmail(emailInputVo);
//
//        }
//        catch (IOException e) {
//            e.printStackTrace();
//        }

//        BufferedReader bReader = null;
//        try {
//            String s;
//            StringBuffer result = new StringBuffer();
////            File file = new File("D:\\workspace\\radio_admin\\src\\main\\webapp\\html\\mailTest.html");
//            File file = new File("http://image.dalbitlive.com/resource/mailForm/mailTest.txt");
//            bReader = new BufferedReader(new FileReader(file));
//
//            while((s = bReader.readLine()) != null) {
//                result.append(s);
//            }
//
//            //replace
//            String msgCont = result.toString().replaceAll("@@ANSWER@@", "답변이다 임마");
//
//            EmailInputVo emailInputVo = new EmailInputVo();
//            emailInputVo.setTitle("답변 : ");
//            emailInputVo.setMsgCont(msgCont);
//            emailInputVo.setRcvMail("zox5702@naver.com");
//            emailService.sendEmail(emailInputVo);
//
//        } catch(IOException e) {
//            e.printStackTrace();
//        } finally {
//            try {
//                if(bReader != null) bReader.close();
//            } catch(IOException e) {
//                e.printStackTrace();
//            }
//        }
//    }
}
