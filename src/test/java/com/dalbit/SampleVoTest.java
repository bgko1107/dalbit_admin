package com.dalbit;

import com.dalbit.common.service.CommonService;
import com.dalbit.common.vo.CodeVo;
import com.dalbit.common.vo.CookieVo;
import com.dalbit.util.OkHttpClientUtil;
import com.dalbit.util.RestApiUtil;
import com.google.gson.Gson;
import lombok.extern.slf4j.Slf4j;
import lombok.var;
import okhttp3.FormBody;
import okhttp3.OkHttpClient;
import okhttp3.RequestBody;
import okhttp3.Response;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.ActiveProfiles;

import java.util.HashMap;
import java.util.List;

@Slf4j
@SpringBootTest
@ActiveProfiles({"local"})
public class SampleVoTest {

    @Autowired
    CommonService commonService;
    @Autowired
    RestApiUtil restApiUtil;

    @Test
    public void 공통코드조회(){
        List<CodeVo> codeVoList = commonService.getCodeList("subject_type");
        log.info("공통코드 : {}", codeVoList);

        //commonService.getCodeList("subject_type");
    }

    /**
     * url : http://admin.inforex.co.kr/loginout.html
     *   method : POST
     *   post data : {
     *     userid: xxxx,         // 아이디
     *     password: xxxx,       // 패스워드
     *     mode: 'login',        // 로그인인경우 해당값으로 고정.
     *     where: 'dalbit'       // 요값도 고정.
     *   }
     */
    @Test
    public void 인포렉스로그인()throws Exception{

        RequestBody formBody = new FormBody.Builder()
            .add("userid", "leejaeho1144")
            .add("password", "20706wogh!")
            .add("mode", "login")
            .add("where", "dalbit")
        .build();

        var map = new HashMap();
        map.put("userid", "leejaeho1144");
        map.put("password", "20706wogh!");
        map.put("mode", "login");
        map.put("where", "dalbit");

        OkHttpClientUtil okHttpClientUtil = new OkHttpClientUtil();
        Response response = okHttpClientUtil.sendPost("http://admin.inforex.co.kr/loginout.html", null);

        response.headers().toMultimap().get("set-cookie").stream().forEach(cookie ->{
            log.info("cookie info : {}", cookie);
        });
        log.info("data : {}", response.body().string());
    }

    @Test
    public void 인포렉스메뉴가져오기()throws Exception{

        OkHttpClientUtil okHttpClientUtil = new OkHttpClientUtil();
        String result = okHttpClientUtil.sendGet("http://admin.inforex.co.kr/getCommonMenu.php");
        log.info(result);
    }

    @Test
    public void 쿠키파싱하기(){
        String cookieString = "ADMIN_COOKIE=eJw9jtkNgzAMhnfxBAkEEGYYZAnTQ80hQqRWVafpIjzy0D26RmMU9cmf%2F8MyYYfPiC0C2zA6D0PEBkH3qqmEDYIjy4I5s3227%2F4uS4q8XCZZdIVwY74Sn73WxohWI0S%2BHy6CPabKwC6Np8WnIEqu1Z1AX5z1Ebh88A%2Fp3I8rzXPu0cTlooLh9QOpVzph; path=/; domain=.inforex.co.kr";
        String[] cookieGubun = cookieString.split(";");
        var cookieVo = new CookieVo();

        for (String cookieSlice : cookieGubun) {
            String[] temp = cookieSlice.split("=");
            if(temp[0].trim().equals("path")){
                cookieVo.setPath(temp[1]);
            }else if(temp[0].trim().equals("domain")){
                cookieVo.setDomain(temp[1]);
            }else{
                cookieVo.setKey(temp[0]);
                cookieVo.setValue(temp[1]);
            }
        }

        log.info(cookieVo.toString());

    }

}
