package com.dalbit.common.code;

import lombok.Getter;

@Getter
public enum ErrorStatus {

    권한없음("E403", "http.error.accessDenied", "권한이 없는 페이지 접근 시"),
    잘못된호출("E404", "http.error.notFound", "404 혹은 파라메터가 빠진경우"),
    잘못된파람("E405", "http.error.param", "파라메터가 잘목경우"),

    쿠키생성오류("E001", "cookie.generate.error", "쿠키 생성 시 에러"),
    쿠키갱신오류("E002", "cookie.update.error", "쿠키 갱신 시 에러"),
    쿠키만료오류("E003", "cookie.expire.error", "쿠키 만료 시 에러"),

    토큰검증오류("E004", "authToken.invalid.error", "JWT 토큰 검증 시 발생한 에러"),
    토큰만료오류("E005", "authToken.expire.error", "JWT 토큰 만료 시 발생한 에러"),

    휴대폰번호검증오류("E006", "phoneNo.invalid.error", "휴대전화번호 유효성체크에서 걸린경우"),

    서버처리중오류("E007", "server.error", "서버 처리중 오류가 발생한 경우"),
    ;

    final private String ERROR_RESULT = "fail";

    final private String result;

    final private String errorCode;
    final private String messageKey;
    final private String desc;

    ErrorStatus(String errorCode, String message, String desc){
        this.result = ERROR_RESULT;
        this.errorCode = errorCode;
        this.messageKey = message;
        this.desc = desc;
    }
}
