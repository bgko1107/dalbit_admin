package com.dalbit.common.code;

import lombok.Getter;

@Getter
public enum Code {

    //포토 배경 이미지 PREFIX
    포토_배경_PREFIX("/bg_0", "포토서버 배경 이미지 실제 경로(done) prefix"),
    포토_배경_임시_PREFIX("/bg_1", "포토서버 배경 이미지 임시 경로 prefix "),
    포토_배경_썸네일_PREFIX("/bg_2", "포토서버 배경 이미지 썸네일 prefix"),
    포토_배경_디폴트_PREFIX("/bg_3", "포토서버 배경 이미지 배경 디폴트 prefix"),

    //포토 프로필 이미지 PREFIX
    포토_프로필_PREFIX("/profile_0", "포토서버 프로필 실제 경로 prefix"),
    포토_프로필_임시_PREFIX("/profile_1", "포토서버 프로필 임시 경로 prefix"),
    포토_프로필_썸네일_PREFIX("/profile_2", "포토서버 프로필 이미지 썸네일 prefix"),
    포토_프로필_디폴트_PREFIX("/profile_3", "포토서버 배경 이미지 배경 디폴트 prefix"),

    배경이미지_파일명_PREFIX("roombg_", "배경이미지 파일명"),
    프로필이미지_파일명_PREFIX("profile_", "배경이미지 파일명"),

    포토_이미지_경로("_0/", "실제 파일이 올라갈 경로 -done 이후 경로"),
    포토_이미지_임시경로("_1/", "이미지가 올라가는 임시 경로"),

    인포렉스_메뉴("inforex.menu.key", "inforex.api.menu.url"),
    인포렉스_직급코드("inforex.posCode.key", "inforex.api.posCode.url"),
    인포렉스_부서코드("inforex.deptCode.key", "inforex.api.deptCode.url"),
    인포렉스_직책코드("inforex.dutyCode.key", "inforex.api.dutyCode.url"),
    인포렉스_임직원목록("inforex.memberList.key", "inforex.api.memberList.url"),
    
    
    SMS발송_회원가입("0", "회원가입"),
    SMS발송_비밀번호변경("1", "비밀번호변경"),
    SMS발송_환전완료("2", "환전완료"),
    SMS발송_환전불가("3", "환전취소"),
    SMS발송_가상계좌("4", "가상계좌"),
    SMS발송_운영자발송("7", "운영자발송"),

    //푸시타입 정리
    PUSH타입_방송방("1", "방송방 [room_no]"),
    PUSH타입_메인("2", "메인"),
    PUSH타입_캐스트("4", "등록된 케스트"),
    PUSH타입_스페셜DJ_선정페이지("5", "스페셜DJ 선정페이지"),
    PUSH타입_이벤트_상세("6", "이벤트 페이지 > 해당이벤트 [board_idx]"),
    PUSH타입_공지사항_상세("7", "공지사항상세 [board_idx]"),

    PUSH타입_마이페이지_팬보드("31", "마이페이지 > 팬보드 [mem_no]"),
    PUSH타입_마이페이지_내지갑("32", "마이페이지 > 내지갑 [mem_no]"),
    PUSH타입_마이페이지_클립_정보변경("33", "마이페이지 > 클립 > 클립 정보 변경 페이지"),
    PUSH타입_마이페이지_알림_상세("34", "마이페이지 > 알림 > 해당 알림 글 [mem_no]"),
    PUSH타입_마이페이지("35", "마이페이지 [mem_no]"),
    PUSH타입_레벨업("36", "레벨업 [mem_no]"),
    PUSH타입_일대일문의("37", "1:1문의"),
    PUSH타입_마이페이지_방송공지("38", "마이페이지 방송공지"),
    PUSH타입_랭킹_좋아요_주간("39", "랭킹 > 좋아요 > 주간"),

    PUSH타입_랭킹_좋아요_일간("40", "랭킹 > 좋아요 > 일간"),
    PUSH타입_랭킹_DJ_일간("41", "랭킹 > 좋아요 > 일간"),
    PUSH타입_랭킹_DJ_주간("42", "랭킹 > DJ > 주간"),
    PUSH타입_랭킹_팬_일간("43", "랭킹 > 팬 > 일간"),
    PUSH타입_랭킹_팬_주간("44", "랭킹 > 팬 > 주간"),
    PUSH타입_클립_플레이("45", "클립 플레이"),
    PUSH타입_클립_댓글("46", "클립 댓글"),
    PUSH타입_랭킹_DJ_타임("47", "랭킹 > DJ > 타임"),
    PUSH타입_랭킹_팬_타임("48", "랭킹 > FAN > 타임"),

    PUSH타입_링크지정("50", "링크 지정"),

    PUSH타입_랭킹_클립_일간("60", "랭킹 > 클립 > 일간"),
    PUSH타입_랭킹_클립_주간("61", "랭킹 > 클립 > 주간"),

   ;

    final private String code;
    final private String desc;

    Code(String code, String desc){
        this.code = code;
        this.desc = desc;
    }
}
