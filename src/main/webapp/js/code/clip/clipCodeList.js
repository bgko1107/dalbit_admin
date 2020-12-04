var clip_isChoiceDate = [
    new COMMON_CODE(null, 'isChoiceDate', '검색기간')
    , new COMMON_CODE('all', '-1', '전체', 'Y')
    , new COMMON_CODE('choice', '1', '기간선택', 'Y')
];

var clip_slctType = [
    new COMMON_CODE(null, 'slctType', '검색 조건')
    , new COMMON_CODE('all', '-1', '전체', 'Y')
    , new COMMON_CODE('time', '0', '시간대별', 'N')
    , new COMMON_CODE('day', '1', '일자별', 'N')
    , new COMMON_CODE('month', '2', '월간별', 'N')
    , new COMMON_CODE('choice', '3', '선택', 'Y')
];

var clip_confirmType_select = [
    new COMMON_CODE(null, 'searchConfirm', '인증여부')
    , new COMMON_CODE('-1', '-1', '인증여부(전체)')
    , new COMMON_CODE('1', '1', '인증')
    , new COMMON_CODE('0', '0', '미인증')
];

var clip_orderByType = [
    new COMMON_CODE(null, 'clipOrderByType', '정렬')
    , new COMMON_CODE('0', '0', '최근 등록 순으로')
    , new COMMON_CODE('1', '1', '누적 등록이 많은 순으로')
    , new COMMON_CODE('2', '2', '좋아요 많은 순으로')
    , new COMMON_CODE('3', '3', '청취 수 많은 순으로')
];

var clip_orderByType_hot = [
    new COMMON_CODE(null, 'clipOrderByType', '정렬')
    , new COMMON_CODE('0', '0', '최근 등록 순으로')
    , new COMMON_CODE('5', '5', '인기 순으로')
];

var clip_orderByType_listen_clipDetail = [
    new COMMON_CODE(null, 'clipOrderByType', '정렬')
    , new COMMON_CODE('0', '0', '최근 등록 순으로')
    // , new COMMON_CODE('1', '1', '보낸 선물 많은 순으로')
    // , new COMMON_CODE('2', '2', '좋아요 많은 순으로')
    , new COMMON_CODE('3', '3', '청취 수 많은 순으로')
];


var clip_orderByType_memberDetail = [
    new COMMON_CODE(null, 'clipOrderByType', '정렬')
    , new COMMON_CODE('0', '0', '최근 등록 순으로')
    , new COMMON_CODE('4', '4', '받은 선물 별 많은 순으로')
    , new COMMON_CODE('2', '2', '좋아요 많은 순으로')
    , new COMMON_CODE('3', '3', '청취 수 많은 순으로')
];

var clip_platformType = [
    new COMMON_CODE(null, 'clipPlatformType', '플랫폼')
    , new COMMON_CODE('1', '1', 'AOS')
    , new COMMON_CODE('2', '2', 'IOS')
    , new COMMON_CODE('3', '3', 'PC')
]

var clip_typeOpen = [
    new COMMON_CODE(null, 'typeOpen', '공개여부')
    , new COMMON_CODE('0', '0', 'N')
    , new COMMON_CODE('1', '1', 'Y')
]

var clip_typeOpen_select = [
    new COMMON_CODE(null, 'searchTypeOpen', '공개여부')
    , new COMMON_CODE('-1', '-1', '공개여부(전체)')
    , new COMMON_CODE('1', '1', '공개')
    , new COMMON_CODE('0', '0', '비공개')
]

var clip_typeOpen_clipDetail = [
    new COMMON_CODE(null, 'typeOpen', '공개여부')
    , new COMMON_CODE('0', '0', 'No')
    , new COMMON_CODE('1', '1', 'Yes')
]

var clip_typeOpen_clipDetail_butten = [
    new COMMON_CODE(null, 'typeOpen', '공개여부')
    , new COMMON_CODE('0', '0', '공개')
    , new COMMON_CODE('1', '1', '비공개')
]

var clip_confirmType = [
    new COMMON_CODE(null, 'confirm', '인증여부')
    , new COMMON_CODE('0', '0', '미인증')
    , new COMMON_CODE('1', '1', '인증')
]

var clip_confirmType_update = [
    new COMMON_CODE(null, 'confirm', '인증여부')
    , new COMMON_CODE('0', '0', '인증')
    , new COMMON_CODE('1', '1', '해제')
]

var clip_confirmType_yn = [
    new COMMON_CODE(null, 'confirm', '인증여부')
    , new COMMON_CODE('0', '0', 'N')
    , new COMMON_CODE('1', '1', 'Y')
]

var clip_hide = [
    new COMMON_CODE(null, 'hide', '숨김여부')
    , new COMMON_CODE('0', '0', '')
    , new COMMON_CODE('1', '1', '숨김')
]

var clip_stateType = [
    new COMMON_CODE(null, 'stateType', '공개여부')
    , new COMMON_CODE('1', '1', '정상')
    , new COMMON_CODE('4', '4', '삭제')
    , new COMMON_CODE('5', '5', '삭제')
]

var clip_stateType_select = [
    new COMMON_CODE(null, 'searchState', '공개여부')
    , new COMMON_CODE('-1', '-1', '클립상태(전체)')
    , new COMMON_CODE('1', '1', '정상')
    , new COMMON_CODE('3', '3', '삭제(본인+운영자)')
    , new COMMON_CODE('4', '4', '삭제(본인)')
    , new COMMON_CODE('5', '5', '삭제(운영자)')
    , new COMMON_CODE('9', '9', '숨기기')
]

var clip_sex_select = [
    new COMMON_CODE(null, 'searchSex', '성별')
    , new COMMON_CODE('', '', '성별(전체)')
    , new COMMON_CODE('m', 'm', '남성')
    , new COMMON_CODE('f', 'f', '여성')
    , new COMMON_CODE('n', 'n', '알수없음')
]

var clip_entryType = [
    new COMMON_CODE(null, 'entryType', '입장제한')
    , new COMMON_CODE('0', '0', '전체')
    , new COMMON_CODE('1', '1', '팬만')
    , new COMMON_CODE('2', '2', '20세이상')
]

var clip_platform = [
    new COMMON_CODE(null, 'platform', '플랫폼구분')
    , new COMMON_CODE('all', '-1', '플랫폼(전체)')
    , new COMMON_CODE('Android', '1', 'Android')
    , new COMMON_CODE('iOS', '2', 'iOS')
    , new COMMON_CODE('PC', '3', 'PC')
];

var clip_age = [
    new COMMON_CODE(null, 'age', '플랫폼구분')
    , new COMMON_CODE('1', '1', '12세~16세')
    , new COMMON_CODE('2', '2', '17세~19세')
    , new COMMON_CODE('3', '3', '20세~25세')
    , new COMMON_CODE('4', '4', '26세~30세')
    , new COMMON_CODE('5', '5', '31세~35세')
    , new COMMON_CODE('6', '6', '36세~40세')
    , new COMMON_CODE('7', '7', '41세이상')
];

var clip_searchType = [
    new COMMON_CODE(null, 'searchType', '검색구분')
    , new COMMON_CODE('all', '-1', '검색조건(전체)')
    , new COMMON_CODE('1', '1', '클립번호')
    , new COMMON_CODE('2', '2', '클립제목')
    , new COMMON_CODE('3', '3', '회원번호')
    , new COMMON_CODE('4', '4', 'UserID')
    , new COMMON_CODE('5', '5', '닉네임')
    , new COMMON_CODE('6', '6', '연락처')
];

var clip_searchType_clipDetail = [
    new COMMON_CODE(null, 'searchType', '검색구분')
    , new COMMON_CODE('all', '-1', '검색조건(전체)')
    , new COMMON_CODE('3', '3', '회원번호')
    , new COMMON_CODE('4', '4', 'UserID')
    , new COMMON_CODE('5', '5', '닉네임')
    , new COMMON_CODE('6', '6', '연락처')
];


var clip_member_searchType = [
    new COMMON_CODE(null, 'searchType', '검색구분')
    , new COMMON_CODE('all', '-1', '검색조건(전체)')
    , new COMMON_CODE('1', '1', '회원번호')
    , new COMMON_CODE('2', '2', 'UserID')
    , new COMMON_CODE('3', '3', '닉네임')
    , new COMMON_CODE('4', '4', '연락처')
];

var clip_listen_searchType = [
    new COMMON_CODE(null, 'searchType', '검색구분')
    , new COMMON_CODE('all', '-1', '검색조건(전체)')
    , new COMMON_CODE('1', '1', '클립번호')
    , new COMMON_CODE('2', '2', '클립제목')
    , new COMMON_CODE('3', '3', '청취자 회원번호')
    , new COMMON_CODE('4', '4', '청취자 UserID')
    , new COMMON_CODE('5', '5', '청취자 닉네임')
    , new COMMON_CODE('6', '6', '청취자 연락처')
    , new COMMON_CODE('7', '7', '청취자 IP')
    , new COMMON_CODE('8', '8', '등록자 회원번호')
    , new COMMON_CODE('9', '9', '등록자 UserID')
    , new COMMON_CODE('10', '10', '등록자 닉네임')
    , new COMMON_CODE('11', '11', '등록자 연락처')
];

var clip_listen_searchType_clipDetail = [
    new COMMON_CODE(null, 'searchType', '검색구분')
    , new COMMON_CODE('all', '-1', '검색조건(전체)')
    , new COMMON_CODE('3', '3', '청취자 회원번호')
    , new COMMON_CODE('4', '4', '청취자 UserID')
    , new COMMON_CODE('5', '5', '청취자 닉네임')
    , new COMMON_CODE('6', '6', '청취자 연락처')
    , new COMMON_CODE('7', '7', '청취자 IP')
];


var clip_gift_searchType = [
    new COMMON_CODE(null, 'searchType', '검색구분')
    , new COMMON_CODE('all', '-1', '검색조건(전체)')
    , new COMMON_CODE('1', '1', '클립번호')
    , new COMMON_CODE('2', '2', '클립제목')
    , new COMMON_CODE('3', '3', '보낸 회원번호')
    , new COMMON_CODE('4', '4', '보낸 UserID')
    , new COMMON_CODE('5', '5', '보낸 닉네임')
    , new COMMON_CODE('6', '6', '보낸 연락처')
    , new COMMON_CODE('7', '7', '받은 회원번호')
    , new COMMON_CODE('8', '8', '받은 UserID')
    , new COMMON_CODE('9', '9', '받은 닉네임')
    , new COMMON_CODE('10', '10', '받은 연락처')
];

var clip_gift_searchType_clipDetail = [
    new COMMON_CODE(null, 'searchType', '검색구분')
    , new COMMON_CODE('all', '-1', '검색조건(전체)')
    , new COMMON_CODE('3', '3', '보낸 회원번호')
    , new COMMON_CODE('4', '4', '보낸 UserID')
    , new COMMON_CODE('5', '5', '보낸 닉네임')
    , new COMMON_CODE('6', '6', '보낸 연락처')
];


var clip_reply_stateType_clipDetail = [
    new COMMON_CODE(null, 'stateType', '공개여부')
    , new COMMON_CODE('1', '1', '정상')
    , new COMMON_CODE('2', '2', '삭제')
];

var clipSubjectType = [
    new COMMON_CODE(null, 'subjectType', '클립 주제')
    , new COMMON_CODE('01', '01', '커버/노래')
    , new COMMON_CODE('02', '02', '작사/작곡')
    , new COMMON_CODE('03', '03', '더빙')
    , new COMMON_CODE('04', '04', '수다/대화')
    , new COMMON_CODE('05', '05', '고민/사연')
    , new COMMON_CODE('06', '06', '힐링')
    , new COMMON_CODE('08', '08', 'ASMR')
    , new COMMON_CODE('07', '07', '성우')
    , new COMMON_CODE('09', '09', '연주')
];

var clip_copyright_subjectType = [
    new COMMON_CODE(null, 'subjectType', '클립 주제')
    , new COMMON_CODE('1', '1', '커버/노래')
    , new COMMON_CODE('2', '2', '작사/작곡')
    , new COMMON_CODE('3', '3', '더빙')
    , new COMMON_CODE('4', '4', '수다/대화')
    , new COMMON_CODE('5', '5', '고민/사연')
    , new COMMON_CODE('6', '6', '힐링')
    , new COMMON_CODE('8', '8', 'ASMR')
    , new COMMON_CODE('7', '7', '성우')
    , new COMMON_CODE('9', '9', '연주')
];

var clip_copyright_searchStateType = [
    new COMMON_CODE(null, 'stateType', '공개여부')
    , new COMMON_CODE('-1', '-1', '클립상태(전체)')
    , new COMMON_CODE('1', '1', '정상')
    , new COMMON_CODE('2', '2', '삭제(본인+운영자)')
    , new COMMON_CODE('3', '3', '삭제(본인)')
    , new COMMON_CODE('4', '4', '삭제(운영자)')
    , new COMMON_CODE('5', '5', '숨기기')
];

var clip_copyright_orderbyType = [
    new COMMON_CODE(null, 'clipOrderByType', '정렬')
    , new COMMON_CODE('1', '1', '청취 수 많은 순으로')
    , new COMMON_CODE('2', '2', '최근 등록 순으로')
    , new COMMON_CODE('3', '3', '누적 등록이 많은 순으로')
];

var clip_copyrightDetail_searchType = [
    new COMMON_CODE(null, 'searchType', '검색 조건')
    , new COMMON_CODE('all', '0', '회원검색(전체)')
    , new COMMON_CODE('memNo', '1', '회원번호')
    , new COMMON_CODE('memNick', '2', '닉네임')
    , new COMMON_CODE('userId', '3', 'userId')
    , new COMMON_CODE('memNick', '4', '전화번호')
    , new COMMON_CODE('ip', '5', 'ip')
];