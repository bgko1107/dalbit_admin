var faq_searchType = [
    new COMMON_CODE(null, 'searchType', '검색구분')
    , new COMMON_CODE('all', '-1', '검색구분(전체)')
    , new COMMON_CODE('title', '1', '질문')
    , new COMMON_CODE('content', '2', '답변')
    , new COMMON_CODE('opName', '3', '작성자')
];

var faq_slctType = [
    new COMMON_CODE(null, 'slctType', 'FAQ구분')
    , new COMMON_CODE('all', '-1', 'FAQ구분(전체)')
    , new COMMON_CODE('notice', '1', '일반')
    , new COMMON_CODE('event', '2', '방송')
    , new COMMON_CODE('check', '3', '결제')
    , new COMMON_CODE('id', '5', '계정')
    , new COMMON_CODE('phone', '97', '문자답변')
    , new COMMON_CODE('update', '98', '기타')
    , new COMMON_CODE('question', '99', '1:1문의')
];

var testId_relation = [
    new COMMON_CODE(null, 'relation', '관계')
    , new COMMON_CODE('all', '', '관계 선택')
    , new COMMON_CODE('me', '1', '본인')
    , new COMMON_CODE('family', '2', '가족')
    , new COMMON_CODE('friend', '3', '친구')
    , new COMMON_CODE('kindred', '4', '친척')
    , new COMMON_CODE('company', '5', '업체')
    , new COMMON_CODE('etc', '6', '기타')
];

var testId_userInfo = [
    new COMMON_CODE(null, 'userInfo', '회원정보')
    , new COMMON_CODE('all', '', '회원정보 선택')
    , new COMMON_CODE('mem_phone', '1', '회원연락처')
    , new COMMON_CODE('mem_no', '2', '회원번호')
    , new COMMON_CODE('mem_id', '3', 'User ID')
    , new COMMON_CODE('mem_nick', '4', 'User 닉네임')
];

var testId_searchType = [
    new COMMON_CODE(null, 'searchType', '검색조건')
    , new COMMON_CODE('all', '0', '전체')
    , new COMMON_CODE('emp_name', '1', '직원명')
    , new COMMON_CODE('mem_no', '2', '회원번호')
    , new COMMON_CODE('mem_id', '3', 'User ID')
    , new COMMON_CODE('mem_nick', '4', 'User 닉네임')
    , new COMMON_CODE('mem_phone', '5', '연락처')
];

var isPopup_on_off = [
    new COMMON_CODE(null, 'isPopup_on_off', 'isPopup_on_off')
    , new COMMON_CODE('0', '0', '유지')
    , new COMMON_CODE('1', '1', '새창')
];

var isComming_on_off = [
    new COMMON_CODE(null, 'isComming_on_off', 'isComming_on_off')
    , new COMMON_CODE('1', '1', '준비중')
    , new COMMON_CODE('0', '0', '완료')
];

var isUse_on_off = [
    new COMMON_CODE(null, 'isUse_on_off', 'isUse_on_off')
    , new COMMON_CODE('0', '0', '사용안함')
    , new COMMON_CODE('1', '1', '사용')
];

var terms_type = [
    new COMMON_CODE(null, 'terms_type', 'terms_type')
    , new COMMON_CODE('0', '0', '전체')
    , new COMMON_CODE('1', '1', '이용약관')
    , new COMMON_CODE('2', '2', '운영정책')
    , new COMMON_CODE('3', '3', '개인정보 취급방침')
    , new COMMON_CODE('4', '4', '청소년 보호정책')
    , new COMMON_CODE('5', '5', '마케팅동의 정책')
];

var terms_platform = [
    new COMMON_CODE(null, 'platform', '플랫폼구분')
    , new COMMON_CODE('all', '0', '전체')
    , new COMMON_CODE('android', '1', 'Android')
    , new COMMON_CODE('ios', '2', 'IOS')
];

var message_searchType = [
    new COMMON_CODE(null, 'searchType', '검색구분')
    , new COMMON_CODE('all', '-1', '전체')
    , new COMMON_CODE('title', '1', '제목')
    , new COMMON_CODE('cont', '2', '내용')
    , new COMMON_CODE('opName', '3', '작성자')
];

var testDalByeollistSort = [
    new COMMON_CODE(null, 'testDalByeollistSort', '테스트아이디 달/별 관리')
    , new COMMON_CODE('0', '0', '최근 지급 회수 순으로')
    , new COMMON_CODE('1', '1', '달 지급 수가 많은 순으로')
    , new COMMON_CODE('2', '2', '별 지급 수가 많은 순으로')
    , new COMMON_CODE('3', '3', '달 회수 수가 많은 순으로')
    , new COMMON_CODE('4', '4', '별 회수 수가 많은 순으로')
    , new COMMON_CODE('5', '5', '최근 사용 일시 순으로')
];


var revenueProcess = [
    new COMMON_CODE(null, 'revenueProcessSlctType', '유형')
    , new COMMON_CODE('1', '1', '방송-음성')
    , new COMMON_CODE('2', '2', '방송-영상')
    , new COMMON_CODE('3', '3', '부스터-음성')
    , new COMMON_CODE('4', '4', '부스터-영상')
    , new COMMON_CODE('5', '5', '클립')
    , new COMMON_CODE('6', '6', '우체통')
];