
var state = [
    new COMMON_CODE(null, 'state', '처리상태')
    , new COMMON_CODE('0', '0', '미처리')
    , new COMMON_CODE('1', '1', '처리완료')
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
];

var question_slctType = [
    new COMMON_CODE(null, 'slct_type', 'FAQ구분')
    , new COMMON_CODE('all', '-1', '전체')
    , new COMMON_CODE('notice', '1', '일반')
    , new COMMON_CODE('event', '2', '방송')
    , new COMMON_CODE('check', '3', '결제')
    , new COMMON_CODE('update', '4', '기타')
];

var question_platform = [
    new COMMON_CODE(null, 'platform', '플랫폼구분')
    , new COMMON_CODE('all', '', '전체')
    , new COMMON_CODE('PC', 'PC', 'PC')
    , new COMMON_CODE('Android-Mobile', 'Android-Mobile', 'Android-Mobile')
    , new COMMON_CODE('IOS-Mobile', 'IOS-Mobile', 'IOS-Mobile')
    , new COMMON_CODE('Web-Mobile', 'Web-Mobile', 'Web-Mobile')
];