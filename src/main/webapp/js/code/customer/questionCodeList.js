var question_status = [
    new COMMON_CODE(null, 'question_status', '처리상태')
    , new COMMON_CODE('-1', '-1', '처리상태(전체)')
    , new COMMON_CODE('0', '0', '미처리')
    , new COMMON_CODE('1', '1', '처리완료')
    , new COMMON_CODE('2', '2', '처리중')
    , new COMMON_CODE('3', '3', '임시처리')
];


var question_searchType = [
    new COMMON_CODE(null, 'question_searchType', '사용자정보구분')
    , new COMMON_CODE('all', '-1', '사용자정보구분(전체)')
    , new COMMON_CODE('1', '1', '회원번호')
    , new COMMON_CODE('2', '2', 'UserID')
    , new COMMON_CODE('3', '3', '닉네임')
    , new COMMON_CODE('4', '4', '연락처')
];

var question_selbox_type = [
    new COMMON_CODE(null, 'question_selbox_type', '문의구분')
    , new COMMON_CODE('all', '-1', '문의구분(전체)')
    , new COMMON_CODE('5', '5', '문의 제목')
    , new COMMON_CODE('6', '6', '내용')
];

var slctDateType = [
    new COMMON_CODE(null, 'slctDateType', '조회구분')
    , new COMMON_CODE('0', '0', '날짜(전체)')
    , new COMMON_CODE('1', '1', '접수일시')
    , new COMMON_CODE('2', '2', '처리일시')
];


// ------------------------- table -----------------------------
var question_summary = [
    new COMMON_CODE('', 'totalQna', '총 1:1문의')
    , new COMMON_CODE('', 'type1Cnt', '회원정보')
    , new COMMON_CODE('', 'type2Cnt', '방송정보')
    , new COMMON_CODE('', 'type3Cnt', '청취하기')
    , new COMMON_CODE('', 'type4Cnt', '결제')
    , new COMMON_CODE('', 'type5Cnt', '건의하기')
    , new COMMON_CODE('', 'type6Cnt', '장애/버그')
    , new COMMON_CODE('', 'type7Cnt', '선물/아이템')
    , new COMMON_CODE('', 'type99Cnt', '기타')
    , new COMMON_CODE('', 'totalOpQna', '총 1:1문의')
    , new COMMON_CODE('', 'type1OpCnt', '회원정보')
    , new COMMON_CODE('', 'type2OpCnt', '방송정보')
    , new COMMON_CODE('', 'type3OpCnt', '청취하기')
    , new COMMON_CODE('', 'type4OpCnt', '결제')
    , new COMMON_CODE('', 'type5OpCnt', '건의하기')
    , new COMMON_CODE('', 'type6OpCnt', '장애/버그')
    , new COMMON_CODE('', 'type7OpCnt', '선물/아이템')
    , new COMMON_CODE('', 'type99OpCnt', '기타')
];

var question_slctType = [
    new COMMON_CODE(null, 'slct_type', 'FAQ구분')
    , new COMMON_CODE('all', '-1', 'FAQ구분(전체)')
    , new COMMON_CODE('notice', '1', '일반')
    , new COMMON_CODE('event', '2', '방송')
    , new COMMON_CODE('check', '3', '결제')
    , new COMMON_CODE('id', '5', '계정')
    , new COMMON_CODE('phone', '97', '문자답변')
    , new COMMON_CODE('update', '98', '기타')
    , new COMMON_CODE('question', '99', '1:1문의')
];

var question_platform = [
    new COMMON_CODE(null, 'platform', '플랫폼구분')
    , new COMMON_CODE('all', '', '플랫폼구분(전체)')
    , new COMMON_CODE('PC', 'PC', 'PC')
    , new COMMON_CODE('Android-Mobile', 'Android-Mobile', 'Android-Mobile')
    , new COMMON_CODE('IOS-Mobile', 'IOS-Mobile', 'IOS-Mobile')
    , new COMMON_CODE('Web-Mobile', 'Web-Mobile', 'Web-Mobile')
];

var question_mem_state = [
    new COMMON_CODE(null, 'question_mem_state', '문의자구분')
    , new COMMON_CODE('all', '0', '문의자(전체)')
    , new COMMON_CODE('1', '1', '회원')
    , new COMMON_CODE('2', '2', '비회원')
];