package com.dalbit.util;

import com.dalbit.common.code.ErrorStatus;
import com.dalbit.common.service.CommonService;
import com.dalbit.exception.GlobalException;
import com.dalbit.member.vo.TokenVo;
import io.jsonwebtoken.*;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

import javax.servlet.http.HttpServletRequest;
import java.util.Date;

@Slf4j
@Component
public class JwtUtil {

    @Autowired
    HttpServletRequest request;
    @Autowired
    CommonService commonService;

    @Value("${spring.jwt.secret}")
    private String JWT_SECRET_KEY;
    @Value("${spring.jwt.duration}")
    private int JWT_DURATION;

    final String JWT_SEPARATOR = "@";

    JwtUtil(){}
    public JwtUtil(String JWT_SECRET_KEY, int JWT_DURATION){
        this.JWT_SECRET_KEY = JWT_SECRET_KEY;
        this.JWT_DURATION = JWT_DURATION;
    }

    /**
     * 이름으로 Jwt Token을 생성한다.
     */
    public String generateToken(String name, long expireTime) {
        return Jwts.builder()
                .setId(name)
                .setIssuedAt(new Date(System.currentTimeMillis())) // 토큰 발행일자
                .setExpiration(new Date(System.currentTimeMillis() + expireTime)) // 유효시간 설정 (30일 기준)
                .signWith(SignatureAlgorithm.HS256, JWT_SECRET_KEY) // 암호화 알고리즘, secret값 세팅
                .compact();
    }

    public String generateToken(String name) {
        return generateToken(name, 2592000000L);
    }
    public String generateToken(String memNo, boolean isLogin) {
        return generateToken(memNo, isLogin, false, 2592000000L);
    }

    public String generateToken(String memNo, boolean isLogin, int isAdmin) {
        return generateToken(memNo, isLogin, isAdmin > 0, 2592000000L);
    }
    public String generateToken(String memNo, boolean isLogin, boolean isAdmin) {
        return generateToken(memNo, isLogin, isAdmin, 2592000000L);
    }
    public String generateToken(String memNo, boolean isLogin, long expireTime) {
        return generateToken(memNo, isLogin, false, expireTime);
    }
    public String generateToken(String memNo, boolean isLogin, boolean isAdmin, long expireTime) {
        return generateToken(memNo + JWT_SEPARATOR + isLogin + JWT_SEPARATOR + isAdmin, expireTime);

    }

    /**
     * Jwt Token을 복호화 하여 이름을 얻는다.
     */
    public String getUserNameFromJwt(String jwt) throws GlobalException {
        return getClaims(jwt).getBody().getId();
    }

    public TokenVo getTokenVoFromJwt(String jwt) throws GlobalException{
        try {
            String[] splitStrArr = getUserNameFromJwt(jwt).split(JWT_SEPARATOR);
            if (2 <= splitStrArr.length) {

                if(DalbitUtil.isEmpty(splitStrArr[0]) || DalbitUtil.isEmpty(splitStrArr[1])){
                    throw new GlobalException(ErrorStatus.토큰검증오류, "회원번호 or 로그인 여부가 null값 입니다.");
                }

                boolean isLogin = Boolean.valueOf(splitStrArr[1]);
                boolean isAdmin = false;
                if(splitStrArr.length == 3){
                    isAdmin = Boolean.valueOf(splitStrArr[2]);
                }

                // 프로퍼티에(JWT_DURATION)시간 이내(현재 24 시간) 토큰일경우 재발행 하지 않음
                boolean isNew = true;
                Jws<Claims> jwtClaims = getClaims(jwt);
                Object issuedAt = jwtClaims.getBody().get(Claims.ISSUED_AT);
                if(issuedAt != null){
                    long issuedTs = Long.valueOf(issuedAt.toString());
                    if((new Date().getTime() / 1000 - issuedTs) < (3600 * JWT_DURATION)){
                        isNew = false;
                    }
                }
                return isNew ? new TokenVo(generateToken(splitStrArr[0], isLogin, isAdmin), splitStrArr[0], isLogin, isAdmin) : new TokenVo(jwt, splitStrArr[0], isLogin, isAdmin);

            }else{
                throw new GlobalException(ErrorStatus.토큰검증오류, "회원번호 or 로그인 여부가 없습니다.");
            }
        }catch (Exception e){
            e.printStackTrace();
            throw new GlobalException(ErrorStatus.토큰검증오류, "이상한 토큰이 넘어왔어요.");
        }
    }

    /**
     * Jwt Token의 유효성을 체크한다.
     */
    public boolean validateToken(String jwt) throws GlobalException {
        return this.getClaims(jwt) != null;
    }

    private Jws<Claims> getClaims(String jwt) throws GlobalException {
        try {
            return Jwts.parser().setSigningKey(JWT_SECRET_KEY).parseClaimsJws(jwt);
        } catch (SignatureException ex) {
            log.debug("Invalid JWT signature");
            throwGlobalException(ErrorStatus.토큰검증오류);

        } catch (MalformedJwtException ex) {
            log.debug("Invalid JWT token");
            throwGlobalException(ErrorStatus.토큰검증오류);

        } catch (ExpiredJwtException ex) {
            log.debug("Expired JWT token");
            throwGlobalException(ErrorStatus.토큰만료오류);

        } catch (UnsupportedJwtException ex) {
            log.debug("Unsupported JWT token");
            throwGlobalException(ErrorStatus.토큰검증오류);

        } catch (IllegalArgumentException ex) {
            log.debug("JWT claims string is empty.");
            throwGlobalException(ErrorStatus.토큰검증오류);
        }

        return null;
    }

    private void throwGlobalException(ErrorStatus errorStatus) throws GlobalException {
        throw new GlobalException(errorStatus);
    }
}
