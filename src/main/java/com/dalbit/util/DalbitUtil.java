package com.dalbit.util;

import com.dalbit.administrate.service.Adm_AuthorityService;
import com.dalbit.common.vo.CookieVo;
import com.dalbit.common.vo.LocationVo;
import com.dalbit.common.vo.MenuVo;
import com.dalbit.member.vo.MemberVo;
import com.google.gson.Gson;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.i18n.LocaleContextHolder;
import org.springframework.core.env.Environment;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.stereotype.Component;

import javax.annotation.PostConstruct;
import javax.servlet.http.HttpServletRequest;
import java.sql.Timestamp;
import java.text.DateFormat;
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

    @Autowired
    private Environment activeEnvironment;

    @PostConstruct
    private void init () {
        environment = this.activeEnvironment;
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
        if(list != null){
            return false;
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
            strs[0] = (int) (Math.random() * 6.0D);
            strPwd.append(strs[0]);
        }
        return strPwd.toString();
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

    /**
     *  날짜 Pattern 형식에 맞춰 현재날짜 계산
     */
    public static String getDate(String pattern) {
        SimpleDateFormat formatter = new SimpleDateFormat(pattern, LocaleContextHolder.getLocale());
        Calendar cal = Calendar.getInstance();
        return formatter.format(cal.getTime());
    }
}
