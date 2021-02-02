package com.dalbit.util;

import com.dalbit.administrate.dao.Adm_MenuDao;
import com.dalbit.administrate.service.Adm_AuthorityService;
import com.dalbit.broadcast.vo.procedure.P_BroadcastEditInputVo;
import com.dalbit.broadcast.vo.procedure.P_GuestListInputVo;
import com.dalbit.broadcast.vo.procedure.P_ListenForceLeaveVo;
import com.dalbit.common.vo.CookieVo;
import com.dalbit.common.vo.LocationVo;
import com.dalbit.common.vo.MenuVo;
import com.dalbit.exception.GlobalException;
import com.dalbit.main.vo.procedure.P_StatVo;
import com.dalbit.member.dao.Mem_MemberDao;
import com.dalbit.member.vo.MemberVo;
import com.dalbit.member.vo.procedure.P_MemberReportVo;
import com.dalbit.member.vo.procedure.P_MemberSetting;
import com.google.gson.Gson;
import lombok.extern.slf4j.Slf4j;
import okhttp3.FormBody;
import okhttp3.RequestBody;
import okhttp3.Response;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.i18n.LocaleContextHolder;
import org.springframework.core.env.Environment;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.stereotype.Component;

import javax.annotation.PostConstruct;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Timestamp;
import java.text.DateFormat;
import java.text.NumberFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.time.format.DateTimeFormatter;
import java.util.*;

@Slf4j
@Component
public class DalbitUtil {

    private static Environment environment;
    private static Mem_MemberDao mem_MemberDao;
    private static Adm_MenuDao adm_MenuDao;
    private static JwtUtil jwtUtil;
    private static String SERVER_API_URL;

    @Autowired
    private Environment activeEnvironment;

    @Autowired
    private Mem_MemberDao activeMem_MemberDao;

    @Autowired
    private Adm_MenuDao active_adm_MenuDao;

    @Autowired
    private JwtUtil active_jwtUtil;

    @Value("${server.api.url}")
    private String active_SERVER_API_URL;

    @PostConstruct
    private void init () {
        environment = this.activeEnvironment;
        mem_MemberDao = this.activeMem_MemberDao;
        jwtUtil = this.active_jwtUtil;
        SERVER_API_URL = this.active_SERVER_API_URL;
        adm_MenuDao = this.active_adm_MenuDao;
    }

    private static Adm_AuthorityService admAuthorityService;
    @Autowired(required=true)
    public void setAdmAuthorityService(Adm_AuthorityService admAuthorityService) {
        this.admAuthorityService = admAuthorityService;
    }

    public static boolean isNullBlank(String checkValue) {
        return checkValue == null || "".equals(checkValue);
    }

    public static String randomValue(String type, int cnt) {
        type = type.toLowerCase();

        StringBuffer strPwd = new StringBuffer();
        char[] str = new char[1];
        int i;
        if (type.equals("p")) {
            for(i = 0; i < cnt; ++i) {
                str[0] = (char)((int)(Math.random() * 94.0D + 33.0D));
                strPwd.append(str);
            }
        } else if (type.equals("a")) {
            for(i = 0; i < cnt; ++i) {
                str[0] = (char)((int)(Math.random() * 26.0D + 65.0D));
                strPwd.append(str);
            }
        } else if (type.equals("string")) {
            for(i = 0; i < cnt; ++i) {
                str[0] = (char)((int)(Math.random() * 26.0D + 97.0D));
                strPwd.append(str);
            }
        } else {
            //int i;
            if (type.equals("number")) {
                int[] strs = new int[1];

                for(i = 0; i < cnt; ++i) {
                    strs[0] = (int)(Math.random() * 9.0D);
                    strPwd.append(strs[0]);
                }
            } else if (type.equals("c")) {
                Random rnd = new Random();

                for(i = 0; i < cnt; ++i) {
                    if (rnd.nextBoolean()) {
                        strPwd.append((char)(rnd.nextInt(26) + 97));
                    } else {
                        strPwd.append(rnd.nextInt(10));
                    }
                }
            } else if(type.equals("e")){
                char[] passwordTable =  {'!', '@', '#', '$', '%', '^', '&', '*','(', ')'};
                Random random = new Random(System.currentTimeMillis());
                for(i = 0; i < cnt; i++) {
                    strPwd.append(Character.toString(passwordTable[random.nextInt(passwordTable.length)]));
                }
            }
        }

        return strPwd.toString();
    }

    /**
     * 리스트 값이 있는지 체크
     * @param list
     * @return
     */
    public static boolean isEmpty(List list){
        if(list == null){
            return true;
        }
        return 0 < list.size() ? false : true;
    }

    /**
     * Object 값이 있는지 체크
     * @param object
     * @return
     */
    public static boolean isEmpty(Object object) {
        return object != null ? false : true;
    }


    /**
     * 나이대 계산
     * @param year
     * @return
     */
    public static int ageCalculation(int year){
        Calendar calendar = new GregorianCalendar(Locale.KOREA);
        int currentYear = calendar.get(Calendar.YEAR);
        int age = currentYear - year + 1;

        String integerAge = Integer.toString(age);
        String stringAge = integerAge.substring(0,1)+"0";
        age = Integer.parseInt(stringAge);

        return age;
    }

    /**
     * DalbitUtil 생성자
     */
    public DalbitUtil() {
    }

    /**
     * 입력된 날짜가 유효한 날짜인지를 검사한다.
     * @param date 기준일자
     * @return 유효여부(true/false)
     */
    public static boolean isDate( String date ) {
        return isDate( date , null );
    }

    public static boolean isDate( String date , String format ) {
        if( date == null )
            return false;
        if( format == null )
            format = "yyyyMMdd";
        DateFormat df = new SimpleDateFormat( format , Locale.KOREA );
        df.setLenient( false );
        date = date.replaceAll( "\\D" , "" );
        try {
            df.parse( date );
            return true;
        }catch( ParseException pe ) {
            return false;
        }catch( Exception e ) {
            return false;
        }
    }


    /**
     * <p>
     * String이 비었거나("") 혹은 null 인지 검증한다.
     * </p>
     *
     * <pre>
     *  StringUtil.isEmpty(null)      = true
     *  StringUtil.isEmpty("")        = true
     *  StringUtil.isEmpty(" ")       = false
     *  StringUtil.isEmpty("bob")     = false
     *  StringUtil.isEmpty("  bob  ") = false
     * </pre>
     *
     * @param str - 체크 대상 스트링오브젝트이며 null을 허용함
     * @return <code>true</code> - 입력받은 String 이 빈 문자열 또는 null인 경우
     */
    public static boolean isEmpty(String str) {
        return str == null || str.length() == 0;
    }

    /**
     * <p>기준 문자열에 포함된 모든 대상 문자(char)를 제거한다.</p>
     *
     * <pre>
     * StringUtil.remove(null, *)       = null
     * StringUtil.remove("", *)         = ""
     * StringUtil.remove("queued", 'u') = "qeed"
     * StringUtil.remove("queued", 'z') = "queued"
     * </pre>
     *
     * @param str  입력받는 기준 문자열
     * @param remove  입력받는 문자열에서 제거할 대상 문자열
     * @return 제거대상 문자열이 제거된 입력문자열. 입력문자열이 null인 경우 출력문자열은 null
     */
    public static String remove(String str, char remove) throws NullPointerException{
        if (isEmpty(str) || str.indexOf(remove) == -1) {
            return str;
        }
        char[] chars = str.toCharArray();
        int pos = 0;
        for (int i = 0; i < chars.length; i++) {
            if (chars[i] != remove) {
                chars[pos++] = chars[i];
            }
        }
        return new String(chars, 0, pos);
    }


    /**
     * <p><code>str</code> 중 <code>searchStr</code>의 시작(index) 위치를 반환.</p>
     *
     * <p>입력값 중 <code>null</code>이 있을 경우 <code>-1</code>을 반환.</p>
     *
     * <pre>
     * StringUtil.indexOf(null, *)          = -1
     * StringUtil.indexOf(*, null)          = -1
     * StringUtil.indexOf("", "")           = 0
     * StringUtil.indexOf("aabaabaa", "a")  = 0
     * StringUtil.indexOf("aabaabaa", "b")  = 2
     * StringUtil.indexOf("aabaabaa", "ab") = 1
     * StringUtil.indexOf("aabaabaa", "")   = 0
     * </pre>
     *
     * @param str  검색 문자열
     * @param searchStr  검색 대상문자열
     * @return 검색 문자열 중 검색 대상문자열이 있는 시작 위치 검색대상 문자열이 없거나 null인 경우 -1
     */
    public static int indexOf(String str, String searchStr) throws NullPointerException{
        if (str == null || searchStr == null) {
            return -1;
        }
        return str.indexOf(searchStr);
    }

    /**
     * <p>오라클의 decode 함수와 동일한 기능을 가진 메서드이다.
     * <code>sourStr</code>과 <code>compareStr</code>의 값이 같으면
     * <code>returStr</code>을 반환하며, 다르면  <code>defaultStr</code>을 반환한다.
     * </p>
     *
     * <pre>
     * StringUtil.decode(null, null, "foo", "bar")= "foo"
     * StringUtil.decode("", null, "foo", "bar") = "bar"
     * StringUtil.decode(null, "", "foo", "bar") = "bar"
     * StringUtil.decode("하이", "하이", null, "bar") = null
     * StringUtil.decode("하이", "하이  ", "foo", null) = null
     * StringUtil.decode("하이", "하이", "foo", "bar") = "foo"
     * StringUtil.decode("하이", "하이  ", "foo", "bar") = "bar"
     * </pre>
     *
     * @param sourceStr 비교할 문자열
     * @param compareStr 비교 대상 문자열
     * @param returnStr sourceStr와 compareStr의 값이 같을 때 반환할 문자열
     * @param defaultStr sourceStr와 compareStr의 값이 다를 때 반환할 문자열
     * @return sourceStr과 compareStr의 값이 동일(equal)할 때 returnStr을 반환하며,
     *         <br/>다르면 defaultStr을 반환한다.
     */
    public static String decode(String sourceStr, String compareStr, String returnStr, String defaultStr) throws NullPointerException{
        if (sourceStr == null && compareStr == null) {
            return returnStr;
        }

        if (sourceStr == null && compareStr != null) {
            return defaultStr;
        }

        if (sourceStr.trim().equals(compareStr)) {
            return returnStr;
        }

        return defaultStr;
    }

    /**
     * <p>오라클의 decode 함수와 동일한 기능을 가진 메서드이다.
     * <code>sourStr</code>과 <code>compareStr</code>의 값이 같으면
     * <code>returStr</code>을 반환하며, 다르면  <code>sourceStr</code>을 반환한다.
     * </p>
     *
     * <pre>
     * StringUtil.decode(null, null, "foo") = "foo"
     * StringUtil.decode("", null, "foo") = ""
     * StringUtil.decode(null, "", "foo") = null
     * StringUtil.decode("하이", "하이", "foo") = "foo"
     * StringUtil.decode("하이", "하이 ", "foo") = "하이"
     * StringUtil.decode("하이", "바이", "foo") = "하이"
     * </pre>
     *
     * @param sourceStr 비교할 문자열
     * @param compareStr 비교 대상 문자열
     * @param returnStr sourceStr와 compareStr의 값이 같을 때 반환할 문자열
     * @return sourceStr과 compareStr의 값이 동일(equal)할 때 returnStr을 반환하며,
     *         <br/>다르면 sourceStr을 반환한다.
     */
    public static String decode(String sourceStr, String compareStr, String returnStr) throws NullPointerException{
        return decode(sourceStr, compareStr, returnStr, sourceStr);
    }

    /**
     * 객체가 null인지 확인하고 null인 경우 "" 로 바꾸는 메서드
     * @param object 원본 객체
     * @return resultVal 문자열
     */
    public static String isNullToString(Object object) {
        String string = "";

        if (object != null) {
            string = object.toString().trim();
        }

        return string;
    }

    public static String convertRequestParamToString(HttpServletRequest request, String parameterName){
        if(request != null && parameterName != null){
            return DalbitUtil.isNullToString(request.getParameter(parameterName)).trim();
        }
        return "";
    }

    public static int convertRequestParamToInteger(HttpServletRequest request, String parameterName){
        try{
            return Integer.valueOf(request.getParameter(parameterName));
        }catch (Exception e){
            return -1;
        }

    }


    /**
     * <p>{@link String#toLowerCase()}를 이용하여 소문자로 변환한다.</p>
     *
     * <pre>
     * StringUtil.lowerCase(null)  = null
     * StringUtil.lowerCase("")    = ""
     * StringUtil.lowerCase("aBc") = "abc"
     * </pre>
     *
     * @param str 소문자로 변환되어야 할 문자열
     * @return 소문자로 변환된 문자열, null이 입력되면 <code>null</code> 리턴
     */
    public static String lowerCase(String str) {
        if (str == null) {
            return null;
        }

        return str.toLowerCase();
    }

    /**
     * <p>{@link String#toUpperCase()}를 이용하여 대문자로 변환한다.</p>
     *
     * <pre>
     * StringUtil.upperCase(null)  = null
     * StringUtil.upperCase("")    = ""
     * StringUtil.upperCase("aBc") = "ABC"
     * </pre>
     *
     * @param str 대문자로 변환되어야 할 문자열
     * @return 대문자로 변환된 문자열, null이 입력되면 <code>null</code> 리턴
     */
    public static String upperCase(String str) {
        if (str == null) {
            return null;
        }

        return str.toUpperCase();
    }




    /**
     * 특수문자를 웹 브라우저에서 정상적으로 보이기 위해 특수문자를 처리('<' -> & lT)하는 기능이다
     * @param 	srcString 		- '<'
     * @return 	변환문자열('<' -> "&lt"
     * @exception NullPointerException
     * @see
     */
    public static String getSpclStrCnvr(String srcString) throws NullPointerException{

        String rtnStr = null;

        try {
            StringBuffer strTxt = new StringBuffer("");

            char chrBuff;
            int len = srcString.length();

            for (int i = 0; i < len; i++) {
                chrBuff = (char) srcString.charAt(i);

                switch (chrBuff) {
                    case '<':
                        strTxt.append("&lt;");
                        break;
                    case '>':
                        strTxt.append("&gt;");
                        break;
                    case '&':
                        strTxt.append("&amp;");
                        break;
                    default:
                        strTxt.append(chrBuff);
                }
            }

            rtnStr = strTxt.toString();

        } catch (NullPointerException e) {
            return srcString;
        }

        return rtnStr;
    }

    /**
     * 응용어플리케이션에서 고유값을 사용하기 위해 시스템에서17자리의TIMESTAMP값을 구하는 기능
     *
     * @param
     * @return Timestamp 값
     * @see
     */
    public static String getTimeStamp() {

        String rtnStr = null;

        // 문자열로 변환하기 위한 패턴 설정(년도-월-일 시:분:초:초(자정이후 초))
        String pattern = "yyyyMMddhhmmssSSS";

        SimpleDateFormat sdfCurrent = new SimpleDateFormat(pattern, LocaleContextHolder.getLocale());
        Timestamp ts = new Timestamp(System.currentTimeMillis());

        rtnStr = sdfCurrent.format(ts.getTime());

        return rtnStr;
    }



    public static String getStringMap(HashMap map, String key){
        try{
            return map.get(key).toString();
        }catch (Exception e){
            log.debug("StringUtil.getStringMap error - key name is [{}]", key);
            return "";
        }
    }

    public static int getIntMap(HashMap map, String key) {
        try{
            return Integer.valueOf(getStringMap(map, key));
        }catch (Exception e){
            log.debug("StringUtil.getIntMap error - key name is [{}]", key);
            return 0;
        }
    }

    public static Double getDoubleMap(HashMap map, String key){
        try{
            return Double.valueOf(getStringMap(map, key));
        }catch (Exception e){
            log.debug("StringUtil.getDoubleMap error - key name is [{}]", key);
            return 0.0;
        }
    }

    public static boolean getBooleanMap(HashMap map, String key) {
        try{
            return Boolean.valueOf(getStringMap(map, key));
        }catch (Exception e){
            log.debug("StringUtil.getBooleanMap error - key name is [{}]", key);
            return false;
        }
    }

    public static String getProperty(String key){
        return environment.getProperty(key);

    }

    public static boolean isLogin(){
        return !("anonymousUser".equals(MemberVo.getMyMemNo()) || MemberVo.getMyMemNo().startsWith("8"));
    }


    /**
     * IP 주소 가져오기
     */
    public static String getIp(HttpServletRequest request){
        String clientIp = request.getHeader("Proxy-Client-IP");
        if (clientIp == null) {
            clientIp = request.getHeader("WL-Proxy-Client-IP");
            if (clientIp == null) {
                clientIp = request.getHeader("X-Forwarded-For");
                if (clientIp == null) {
                    clientIp = request.getRemoteAddr();
                }
            }
        }
        return clientIp;
    }

    /**
     * 지역정보, 위도, 경도 가져오기
     */
    public static LocationVo getLocation(HttpServletRequest request){

        return getLocation(getIp(request));
    }
    /**
     * 지역정보, 위도, 경도 가져오기
     */
    public static LocationVo getLocation(String ip){

        String apiResult = RestApiUtil.sendGet(getProperty("geo.location.server.url") + ip);
        LocationVo locationVo = new LocationVo();
        try {
            locationVo = new Gson().fromJson(apiResult, LocationVo.class);
        }catch (Exception e){
            locationVo.setRegionName("정보없음");
        }

        return locationVo;
    }
    /**
     * 이미지 path 경로 치환
     */
    public static String replacePath(String path){
        return path.replace("/temp", "");
    }

    /**
     * UTC 로 변경
     *
     * @param dt
     * @return
     */
    public static LocalDateTime getUTC(Date dt){
        return LocalDateTime.ofInstant(dt.toInstant(), ZoneId.of("UTC"));
    }

    /**
     * UTC기준 날짜 문자 변환
     *
     * @param dt
     * @return
     */
    public static String getUTCFormat(Date dt){
        return getUTC(dt).format(DateTimeFormatter.ofPattern("yyyyMMddHHmmss"));
    }

    public static String convertDateFormat(Date date, String format){
        format = isEmpty(format) ? "yyyyMMddHHmmss" : format;

        SimpleDateFormat simpleDateFormat = new SimpleDateFormat(format);
        return simpleDateFormat.format(date);
    }

    /**
     * UTC기준 타임스탬프 변환
     *
     * @param dt
     * @return
     */
    public static long getUTCTimeStamp(Date dt){
        return Timestamp.valueOf(getUTC(dt)).getTime() / 1000;
    }

    /**
     * 로그인 권한
     * @return
     */
    public static Collection<GrantedAuthority> getAuthorities(){
        Collection<GrantedAuthority> authorities = new ArrayList<GrantedAuthority>();
        authorities.add(new SimpleGrantedAuthority("ROLE_USER"));
        return authorities;
    }

    public static Collection<GrantedAuthority> getGuestAuthorities(){
        Collection<GrantedAuthority> authorities = new ArrayList<GrantedAuthority>();
        authorities.add(new SimpleGrantedAuthority("ROLE_ANONYMOUS"));
        return authorities;
    }

    public static boolean isEmptyHeaderAuthToken(String header){
        return isEmpty(header) || "undefined".equals(header);
    }

    public static boolean isAnonymousUser(Object principal){
        return isEmpty(principal) || "anonymousUser".equals(principal);
    }

    public static String getActiveProfile(){
        return environment.getActiveProfiles()[0];
    }

    public static String setTimestampInJsonOutputVo(){
        StringBuffer sb = new StringBuffer();
        sb.append(getTimeStamp());

        sb.append("_");
        sb.append(getActiveProfile());
        return sb.toString();
    }

    public static CookieVo parseCookie(String cookieString){

        CookieVo cookieVo = new CookieVo();

        String[] cookieGubun = cookieString.split(";");


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
        return cookieVo;
    }

    public static List<CookieVo> parseCookieList(ArrayList<String> cookieStringList){
        ArrayList cookieList = new ArrayList<CookieVo>();
        cookieStringList.forEach(cookieString -> {
            cookieList.add(parseCookie(cookieString));
        });
        return cookieList;
    }

    /**
     * 배경이미지 번호 랜덤 추출
     */
    public static String randomBgValue() {
        StringBuffer strPwd = new StringBuffer();
        int[] strs = new int[1];
        for (int i = 0; i < 1; ++i) {
            strs[0] = (int) (Math.random() * 5.0D);
            strPwd.append(strs[0]);
        }
        return strPwd.toString();
    }

    /**
     * 클립이미지 번호 랜덤 추출
     */
    public static String randomClipImgValue() {
        StringBuffer bf = new StringBuffer();
        String[] num = {"0","1"};
        ArrayList<String> list = new ArrayList<>(Arrays.asList(num));
        if(list != null) {
            for(int i=0; i<list.size(); i++) {
                list.get(i);
            }
        }
        Collections.shuffle(list);

        String[] num_ = list.toArray(new String[list.size()]);
        bf.append(num_[0]);
        return bf.toString();
    }

    /**
     * 휴대폰 유효성 체크
     */
    public static boolean isSmsPhoneNoChk(String phoneNo){
        return phoneNo.matches("(01[016789])(\\d{3,4})(\\d{4})");
    }

    public static List<MenuVo> getMenuList(){
        return admAuthorityService.getLnbMemberAuthInfo(MemberVo.getUserInfo().getEmp_no());
    }

    public static String convertPhoneNo(String phoneNo){
        return phoneNo.replaceFirst("(\\d{3})(\\d{3,4})(\\d{4})", "$1-$2-$3");
    }

    public static String convertJuminNo(String phoneNo){
        return phoneNo.replaceFirst("(\\d{6})(\\d{7})", "$1-$2");
    }

    /**
     * 브라우저 정보 가져오기
     */
    public static String getUserAgent(HttpServletRequest request){
        String userAgent  = request.getHeader("User-Agent");
        String browser;
        if (userAgent .indexOf("MSIE") > -1 || userAgent .indexOf("Trident") > -1) {
            browser = "MSIE";
        } else if (userAgent .indexOf("Opera") > -1) {
            browser =  "Opera";
        } else if (userAgent .indexOf("Firefox") > -1) {
            browser = "Firefox";
        } else if (userAgent .indexOf("Chrome") > -1) {
            browser = "Chrome";
        } else if (userAgent .indexOf("Safari") > -1) {
            browser = "Safari";
        }else {
            browser = "Firefox";
        }
        return browser;
    }


    /**
     *  유니코드 디코딩
     */
    public static String uniDecode(String uni){
        StringBuffer str = new StringBuffer();
        for( int i= uni.indexOf("\\u") ; i > -1 ; i = uni.indexOf("\\u") ){// euc-kr(%u), utf-8(//u)
            str.append( uni.substring( 0, i ) );
            str.append( String.valueOf( (char)Integer.parseInt( uni.substring( i + 2, i + 6 ) ,16) ) );
            uni = uni.substring( i +6);
        }
        str.append( uni );
        return str.toString();
    }

    /**
     *  sql lpad 기능 함수
     */
    public static String lpad(String str, int len, String addStr) {
        String result = str;
        int templen   = len - result.length();

        for (int i = 0; i < templen; i++){
            result = addStr + result;
        }
        return result;
    }

    public static String exceptionUser(){
        String name = "박진";
        return name;
    }

    /**
     *  날짜 Pattern 형식에 맞춰 현재날짜 계산
     */
    public static String getDate(String pattern) {
        SimpleDateFormat formatter = new SimpleDateFormat(pattern, LocaleContextHolder.getLocale());
        Calendar cal = Calendar.getInstance();
        return formatter.format(cal.getTime());
    }

    /**
     * 1000 단위 콤마
     */
    public static String comma(int number){
        String str = String.format("%,d", number);
        return str;
    }


    /**
     *  카드취소날짜 yyyy-MM-dd HH:mm:ss 변환
     */
    public static String stringToDate(String str) throws ParseException {
        Date date  = new SimpleDateFormat("yyyyMMddHHmmss").parse(str);
        SimpleDateFormat fmt = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        return fmt.format(date);
    }


    /**
     * 결제수단 변환
     */
    public static String getPayWayConvert(String str){
        if (str.equals("CN")) {
            str = "신용카드";
        } else if (str.equals("MC")) {
            str = "휴대폰";
        } else if (str.equals("VA")) {
            str = "가상계좌";
        } else if (str.equals("InApp")) {
            str = "인앱(IOS)";
        } else if (str.equals("GM")) {
            str = "문화상품권";
        } else if (str.equals("HM")) {
            str = "해피머니상품권";
        } else if (str.equals("cashbee")) {
            str = "캐시비";
        } else if (str.equals("tmoney")) {
            str = "티머니";
        } else if (str.equals("payco")) {
            str = "페이코";
        } else if (str.equals("kakaopay")) {
            str = "카카오페이";
        } else if (str.equals("GG")) {
            str = "스마트문상(게임)";
        } else if (str.equals("GC")) {
            str = "도서문화상품권";
        } else if (str.equals("kakaoMoney")) {
            str = "카카오페이(머니)";
        } else {
            str = "-";
        }
        return str;
    }


    /**
     * 플랫폼 변환
     */
    public static String getPlatformConvert(int os){
        String platform="";
        if(os == 1){
            platform = "AOS";
        } else if (os == 2) {
            platform = "IOS";
        } else if (os == 3) {
            platform = "PC";
        } else {
            platform = "-";
        }
        return platform;
    }

    public static String convertInternationalPhone(String phone, String prefix){
        phone = phone.replaceAll("-", "");
        if(!isSmsPhoneNoChk(phone)){
            return null;
        }

        if(!phone.startsWith("01")){
            return null;
        }

        return prefix + phone.substring(1);
    }

    public static String randomValueDatetime(int suffixCnt){
        SimpleDateFormat sdf = new SimpleDateFormat("YYYYMMddHHmmssSSS");
        String dataFormat = sdf.format(new Date());

        return dataFormat + randomValue("number", suffixCnt);
    }

    /*
     * 회원 기본정보 조회
     */
    public static MemberVo getMemInfo(String mem_no){
        MemberVo memInfoOutVo = mem_MemberDao.getMemberInfo(mem_no);
        return memInfoOutVo;
    }


    public static String convertNumberType(int data){
        return NumberFormat.getInstance().format(data);
    }

    public static HashMap<String, String> getPreviousDate(P_StatVo pStatVo){

        HashMap<String, String> map = new HashMap<>();

        SimpleDateFormat dateFormatter = new SimpleDateFormat("yyyy.MM.dd");
        // 시작일
        int sYear  = Integer.parseInt(pStatVo.getStartDate().substring(0, 4));
        int sMonth = Integer.parseInt(pStatVo.getStartDate().substring(5, 7));
        int sDay = Integer.parseInt(pStatVo.getStartDate().substring(8, 10));
        Calendar sCal = Calendar.getInstance();
        sCal.set(sYear, sMonth - 1, sDay);

        // 종료일
        int eYear  = Integer.parseInt(pStatVo.getEndDate().substring(0, 4));
        int eMonth = Integer.parseInt(pStatVo.getEndDate().substring(5, 7));
        int eDay = Integer.parseInt(pStatVo.getEndDate().substring(8, 10));
        Calendar eCal = Calendar.getInstance();
        eCal.set(eYear, eMonth - 1, eDay);

        // 증감 데이터
        if(pStatVo.getSlctType() == 0){ // 시간대
            sCal.add(Calendar.DATE, -1);     // 하루 전
            eCal.add(Calendar.DATE, -1);     // 하루 전
        }else if(pStatVo.getSlctType() == 1){   //일자별
            sCal.add(Calendar.MONTH, -1);    // 한달 전
            eCal.add(Calendar.MONTH, -1);    // 한달 전
        }else if(pStatVo.getSlctType() == 2){   // 월간별
            sCal.add(Calendar.YEAR, -1);     // 1년 전
            eCal.add(Calendar.YEAR, -1);     // 1년 전
        }
        String sDate = dateFormatter.format(sCal.getTime());
        String eDate;
        if(pStatVo.getSlctType() == 0) { // 시간대
            eDate = sDate;
        }else{
            eDate = eCal.get(Calendar.YEAR) + "." + DalbitUtil.lpad(String.valueOf(eCal.get(Calendar.MONTH) + 1), 2, "0") + "." + eCal.getActualMaximum(Calendar.DAY_OF_MONTH);
        }

        map.put("sDate",sDate);
        map.put("eDate",eDate);

        return map;
    }
    /*
     * 방송 강제종료 api 호출
     */
    public static String broadcastForceExit(P_BroadcastEditInputVo pBroadcastEditInputVo){

        String authMemNo = adm_MenuDao.getMobileAuth(pBroadcastEditInputVo.getOpName());
        if(DalbitUtil.isEmpty(authMemNo)){
            return "noAuth";
        }
        OkHttpClientUtil okHttpClientUtil = new OkHttpClientUtil();
        RequestBody formBody = new FormBody.Builder()
                .add("room_no", pBroadcastEditInputVo.getRoom_no())
                .add("start_date", pBroadcastEditInputVo.getStart_date())
                .add("mem_no", pBroadcastEditInputVo.getMem_no())
                .add("roomExit", pBroadcastEditInputVo.getRoomExit())
                .build();

        String inforexLoginResult;
        try{
            String url = SERVER_API_URL + "/admin/broadcast/forceExit";
            Response response = okHttpClientUtil.sendPostApi(url, formBody, jwtUtil.generateToken(authMemNo, true));
            inforexLoginResult = response.body().string();
            log.debug(inforexLoginResult);
            return inforexLoginResult;
        }catch (IOException | GlobalException e){
            e.printStackTrace();
            return "error";
        }
    }

    public static String listenForceExit(P_ListenForceLeaveVo pListenForceLeaveVo){
        String authMemNo = adm_MenuDao.getMobileAuth(pListenForceLeaveVo.getOpName());
        if(DalbitUtil.isEmpty(authMemNo)){
            return "noAuth";
        }
        OkHttpClientUtil okHttpClientUtil = new OkHttpClientUtil();
        RequestBody formBody = new FormBody.Builder()
                .add("room_no", pListenForceLeaveVo.getRoom_no())
                .add("mem_no", pListenForceLeaveVo.getMem_no())
                .add("mem_nick", pListenForceLeaveVo.getMem_nickName())
                .add("roomBlock", pListenForceLeaveVo.getRoomBlock())
                .add("notificationYn", pListenForceLeaveVo.getNotificationYn())
                .add("report_title", pListenForceLeaveVo.getReport_title())
                .add("report_message", pListenForceLeaveVo.getReport_message())
//                .add("notiMemo", pListenForceLeaveVo.getNotiMemo())
                .build();

        String inforexLoginResult;
        try{
            String url = SERVER_API_URL + "/admin/forcedOut";
//            String url = "https://devm-bgko.dalbitlive.com:4431/admin/forcedOut";
            Response response = okHttpClientUtil.sendPostApi(url, formBody, jwtUtil.generateToken(authMemNo, true));
            inforexLoginResult = response.body().string();
            log.debug(inforexLoginResult);
            return inforexLoginResult;
        }catch (IOException | GlobalException e){
            e.printStackTrace();
            return "error";
        }
    }

    /**
     *  방송방 얼리기
     */
    public static String broadcastFreeze(P_BroadcastEditInputVo pBroadcastEditInputVo){

        String authMemNo = adm_MenuDao.getMobileAuth(pBroadcastEditInputVo.getOpName());
        if(DalbitUtil.isEmpty(authMemNo)){
            return "noAuth";
        }
        OkHttpClientUtil okHttpClientUtil = new OkHttpClientUtil();
        RequestBody formBody = new FormBody.Builder()
                .add("room_no", pBroadcastEditInputVo.getRoom_no())
                .add("mem_no", pBroadcastEditInputVo.getMem_no())
                .add("freezeMsg", pBroadcastEditInputVo.getFreezeMsg())
                .build();

        String inforexLoginResult;
        try{
            String url = SERVER_API_URL + "/admin/freeze";
            Response response = okHttpClientUtil.sendPostApi(url, formBody, jwtUtil.generateToken(authMemNo, true));
            inforexLoginResult = response.body().string();
            log.debug(inforexLoginResult);
            return inforexLoginResult;
        }catch (IOException | GlobalException e){
            e.printStackTrace();
            return "error";
        }
    }

    /*
     * 게스트 종료
     */
    public static String guestOut(P_GuestListInputVo pGuestListInputVo){

        String authMemNo = adm_MenuDao.getMobileAuth(pGuestListInputVo.getOpName());
        if(DalbitUtil.isEmpty(authMemNo)){
            return "noAuth";
        }
        OkHttpClientUtil okHttpClientUtil = new OkHttpClientUtil();
        RequestBody formBody = new FormBody.Builder()
                .add("roomNo", pGuestListInputVo.getRoom_no())
                .add("memNo", pGuestListInputVo.getMem_no())
                .add("mode", "6")
                .build();

        String inforexLoginResult;
        try{
            String url = SERVER_API_URL + "/admin/guestOut";
//            String url = "https://devm-hwlee.dalbitlive.com:4431/admin/guestOut";
            Response response = okHttpClientUtil.sendPostApi(url, formBody, jwtUtil.generateToken(authMemNo, true));
            inforexLoginResult = response.body().string();
            log.debug(inforexLoginResult);
            return inforexLoginResult;
        }catch (IOException | GlobalException e){
            e.printStackTrace();
            return "error";
        }
    }


    /*
     * 이미지 삭제
     */
    public static String sendChatImageDelete(P_MemberReportVo pMemberReportVo){

        String authMemNo = adm_MenuDao.getMobileAuth(pMemberReportVo.getOpName());
        if(DalbitUtil.isEmpty(authMemNo)){
            return "noAuth";
        }
        OkHttpClientUtil okHttpClientUtil = new OkHttpClientUtil();
        RequestBody formBody = new FormBody.Builder()
                .add("chatNo", pMemberReportVo.getChat_no())
                .add("targetMemNo", pMemberReportVo.getMem_no())
                .add("msgIdx", Integer.toString(pMemberReportVo.getImage_idx()))
                .build();

        String inforexLoginResult;
        try{
            String url = SERVER_API_URL + "/admin/declaretion/imageDelete";
//            String url = "https://devm-bgko.dalbitlive.com:4431/admin/declaretion/imageDelete";
            Response response = okHttpClientUtil.sendPostApi(url, formBody, jwtUtil.generateToken(authMemNo, true));
            inforexLoginResult = response.body().string();
//            log.debug(inforexLoginResult);
            log.info("-------------------------- imageDelete start ----------------------------");
            log.info(inforexLoginResult);
            log.info("-------------------------- imageDelete end   ----------------------------");
            return inforexLoginResult;
        }catch (IOException | GlobalException e){
            e.printStackTrace();
            return "error";
        }
    }

    /**
     * PUSH/알림 사용 여부 체크
     *
     * TRUE : 거부
     * FALSE : 승인
     *
     * */
    public static boolean isMemberPushRejection(String mem_no, String pushType){
        if(isEmpty(mem_no)){return true;}

        P_MemberSetting setting =  mem_MemberDao.getMemberSetting(mem_no);

        if(isEmpty(setting)){return true;}

        int type = Integer.parseInt(pushType);
        if(type == 11){ // DJ방송 알림
            return setting.getSet_1() == 0;
        }else if(type == 18){   // DJ 방송공지 알림
            return setting.getSet_2() == 0;
        }else if(type == 16){   //팬 알림
            return setting.getSet_3() == 0;
        }else if(type == 17){   //팬보드 알림
            return setting.getSet_4() == 0;
        }else if(type == 15 || type == 61){ //선물 알림
            return setting.getSet_5() == 0;
        }else if(type == 60){      // 1:1 문의 답변 알림
            return setting.getSet_6() == 0;
        }else if(type == 51 || type == 59 || type == 92 || type == 93 || type == 94 ) {     // 서비스 알림
            return setting.getSet_7() == 0;
        }else{     // 기타
            return setting.getAll_ok() == 0;
        }
    }

    public static String escapeCharDecode(String data){
        if(isEmpty(data)){
            return "";
        }
        data = StringUtils.replace(data, "\\\\n", "\\n");
        data = StringUtils.replace(data, "\\\\r", "\\r");
        data = StringUtils.replace(data, "\\\\t", "\\t");
        data = StringUtils.replace(data, "\\\\/", "\\/");
        data = StringUtils.replace(data, "\\\\'", "\\'");
        //data = StringUtils.replace(data, "\\\\\"", "\\\"");
        return data;
    }


    /**
     * CORS 방지를 위한 Response 헤더 세팅
     * @param request
     * @param response
     */
    public static void setHeader(HttpServletRequest request, HttpServletResponse response){
        response.setHeader("Access-Control-Allow-Methods", "POST, GET, DELETE, OPTIONS");
        response.setHeader("Access-Control-Max-Age", "3600");
        response.setHeader("Access-Control-Allow-Headers", "Origin,Accept,X-Requested-With,Content-Type,Access-Control-Request-Method,Access-Control-Request-Headers,Authorization,"+DalbitUtil.getProperty("sso.header.cookie.name")+","+DalbitUtil.getProperty("rest.custom.header.name")+",redirectUrl,Proxy-Client-IP,WL-Proxy-Client-IP,X-Forwarded-For");
        response.setHeader("Access-Control-Allow-Origin", request.getHeader("Origin"));
        response.setHeader("Access-Control-Allow-Credentials", "true");
    }

    /**
     * 스페셜DJ 환전 실수령액 계산
     * @param star
     * @param isSpecial
     * @return
     */
    public static long computeExchangeAmt(long star, int isSpecial){

        long cashBasic = star * 60;
        long specialBenefit = 0;

        //스페셜DJ 혜택
        if(isSpecial == 1){
            specialBenefit = (long) (Math.floor(cashBasic * 0.005) * 10);
        }

        long sum = cashBasic + specialBenefit;

        long incomeTax = (long) (Math.floor(sum * 0.003) * 10);
        long residentTax = (long) (Math.floor(incomeTax * 0.01) * 10);
        long taxCash = incomeTax + residentTax; //원천징수세액
        long feeCash = 500; //이체수수료

        long total = sum - taxCash - feeCash;

        return total;
    }

    /**
     *  unique한 거래번호를 위한 거래일시 (밀리세컨드까지 조회)
     */
    public static String getTradeId(String serviceId){
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyyMMddHHmmssSSSS");
        String appr_dtm =serviceId + "_" + dateFormat.format(new Date());
        return appr_dtm;
    }

    /**
     * String to Date 패턴변경
     */
    public static String stringToDatePattern(String str, String beforePattern, String afterPattern) throws ParseException{
        SimpleDateFormat beForeFormat = new SimpleDateFormat(beforePattern);
        Date beforeDate = beForeFormat.parse(str);
        SimpleDateFormat afterFormat = new SimpleDateFormat(afterPattern);
        return afterFormat.format(beforeDate);
    }

    public static String timeStampDay(int timeSecond){

        try {
            if(timeSecond <= 0){
                return "";
            }

            int day = (int) Math.floor(timeSecond / 60 / 60 / 24);
            int day_s = day * 60 * 60 * 24;
            int hours_s = timeSecond - (day_s);
            int hours = (int) Math.floor(hours_s / 60 / 60);
            int minutes_s = timeSecond - (day_s + (hours * 60 * 60));
            int minutes = (int) Math.floor(minutes_s / 60);

            String timeData = "";
            if(day != 0){
                timeData = day + "일 " + hours  + "시간";
            }else{
                if(hours != 0){
                    timeData = hours  + "시간 " + minutes + "분";
                }else{
                    timeData = minutes + "분";
                }
            }

            return timeData;
        }catch (Exception e){
            return timeSecond + "";
        }
    }
}
