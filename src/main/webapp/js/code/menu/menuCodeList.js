
/** =------ Ranking / Live ---------- */
var searchType = [
    new COMMON_CODE(null, 'searchType', '사용자정보구분')
    , new COMMON_CODE('all', '0', '사용자정보구분(전체)')
    , new COMMON_CODE('userNo', '1', '회원번호')
    , new COMMON_CODE('userId', '2', 'User ID')
    , new COMMON_CODE('userNick', '3', 'User 닉네임')
    , new COMMON_CODE('phone', '4', '연락처')
];


var timeRound = [
    new COMMON_CODE(null, 'timeRound', '타임')
    , new COMMON_CODE('1', '1', '0시~10시')
    , new COMMON_CODE('2', '2', '10시~19시')
    , new COMMON_CODE('3', '3', '19시~00시')
];

/** =------ special ---------- */
var special_state = [
    new COMMON_CODE(null, 'stateType', '상태구분')
    , new COMMON_CODE('wait', '1', '대기')
    , new COMMON_CODE('ok', '2', '완료')
    , new COMMON_CODE('reject', '3', '거부')
];

var special_isForce= [
    new COMMON_CODE(null, 'isForce', '관리자 등록여부')
    , new COMMON_CODE('no', '0', 'N')
    , new COMMON_CODE('yes', '1', 'Y')
];

var special_searchType = [
    new COMMON_CODE(null, 'searchType', '사용자정보구분')
    , new COMMON_CODE('all', '-1', '전체')
    , new COMMON_CODE('userNo', '1', '회원번호')
    , new COMMON_CODE('userId', '2', 'User ID')
    , new COMMON_CODE('userNick', '3', 'User 닉네임')
    , new COMMON_CODE('phone', '4', '연락처')
];

var special_selectYears = [
    new COMMON_CODE(null, 'select_year', '년')
    , new COMMON_CODE('2022', '2022', '2022년')
    , new COMMON_CODE('2021', '2021', '2021년')
    , new COMMON_CODE('2020', '2020', '2020년')
];

var special_selectMonths = [
    new COMMON_CODE(null, 'select_month', '월')
    , new COMMON_CODE('12', '12', '12월')
    , new COMMON_CODE('11', '11', '11월')
    , new COMMON_CODE('10', '10', '10월')
    , new COMMON_CODE('9', '09', '9월')
    , new COMMON_CODE('8', '08', '8월')
    , new COMMON_CODE('7', '07', '7월')
    , new COMMON_CODE('6', '06', '6월')
    , new COMMON_CODE('5', '05', '5월')
    , new COMMON_CODE('4', '04', '4월')
    , new COMMON_CODE('3', '03', '3월')
    , new COMMON_CODE('2', '02', '2월')
    , new COMMON_CODE('1', '01', '1월')
];

var special_roundNos = [
    new COMMON_CODE(null, 'round_no', '기수')
    , new COMMON_CODE('all', '', '기수'),
    , new COMMON_CODE('1', '1', '1기'),
    , new COMMON_CODE('2', '2', '2기'),
    , new COMMON_CODE('3', '3', '3기'),
    , new COMMON_CODE('4', '4', '4기'),
    , new COMMON_CODE('5', '5', '5기'),
    , new COMMON_CODE('7', '7', '7기'),
    , new COMMON_CODE('8', '8', '8기'),
    , new COMMON_CODE('9', '9', '9기'),
    , new COMMON_CODE('6', '6', '6기')
    , new COMMON_CODE('10', '10', '10기')
    , new COMMON_CODE('11', '11', '11기')
    , new COMMON_CODE('12', '12', '12기')
];

var special_manage_contentType = [
    new COMMON_CODE(null, 'content_type', '컨텐츠타입')
    , new COMMON_CODE('image', 'image', '이미지')
    , new COMMON_CODE('button', 'button', '버튼')
]

var special_manage_content_button_type = [
    new COMMON_CODE(null, 'button_type', '컨텐츠 버튼 타입')
    , new COMMON_CODE('link', 'link', '링크이동')
    , new COMMON_CODE('popup', 'popup', '팝업')
    , new COMMON_CODE('function', 'function', '기능')
]