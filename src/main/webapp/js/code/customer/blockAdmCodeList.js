var block_searchType = [
    new COMMON_CODE(null, 'searchType', '검색 조건')
    , new COMMON_CODE('all', '-1', '검색 조건(전체)')
    , new COMMON_CODE('memno', '1', '회원번호')
    , new COMMON_CODE('memid', '2', 'UserID')
    , new COMMON_CODE('memnick', '3', 'User닉네임')
    , new COMMON_CODE('phone', '4', '연락처')
    , new COMMON_CODE('list', '5', '차단내역')
    , new COMMON_CODE('opname', '6', '등록자')
];

var block_blockType = [
    new COMMON_CODE(null, 'blockType', '검색 조건')
  , new COMMON_CODE('all', '-1', '차단 유형(전체)')
  , new COMMON_CODE('deviceUuid', '1', 'deviceUuid')
  , new COMMON_CODE('ip', '2', 'IP')
  , new COMMON_CODE('memNo', '3', '회원번호')
  , new COMMON_CODE('memPhone', '4', '휴대폰번호')
];

var block_blockRadio = [
    new COMMON_CODE(null, 'radioBlock', '검색 조건')
    , new COMMON_CODE('deviceUuid', 1, 'deviceUuid')
    , new COMMON_CODE('ip', 2, 'IP')
    , new COMMON_CODE('memNo', 3, '회원번호')
    , new COMMON_CODE('memPhone', 4, '휴대폰번호')
];

var block_blockDay = [
    new COMMON_CODE(null, 'block_day', '')
    , new COMMON_CODE('-1', -1, '제재 종류(전체)')
    , new COMMON_CODE('1', 1, '1일 정지')
    , new COMMON_CODE('3', 3, '3일 정지')
    , new COMMON_CODE('7', 7, '7일 정지')
    , new COMMON_CODE('98', 98, '임시 정지')
    , new COMMON_CODE('99', 99, '영구 정지')
];

var blockHist_reviseType = [
    new COMMON_CODE(null, 'edit_type', '')
    , new COMMON_CODE('add', 0, '등록')
    , new COMMON_CODE('update', 1, '해제')
];

var blockHist_histType = [
    new COMMON_CODE(null, 'searchType', '검색 조건')
    , new COMMON_CODE('all', '-1', '검색 조건(전체)')
    , new COMMON_CODE('contents', '1', '수정 내용')
    , new COMMON_CODE('opname', '2', '등록자')
];