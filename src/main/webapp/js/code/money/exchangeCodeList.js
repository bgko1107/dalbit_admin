var search_exchange_years = [
    new COMMON_CODE(null, 'search_year', '년')
    , new COMMON_CODE('2020', '2020', '2020년')
    , new COMMON_CODE('2021', '2021', '2021년')
];

var search_exchange_months = [
    new COMMON_CODE(null, 'search_month', '월')
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

var search_exchange_type = [
    new COMMON_CODE(null, 'search_type', '검색조건')
    , new COMMON_CODE('all', '', '회원검색(전체)')
    , new COMMON_CODE('mem_no', 'mem_no', '회원번호')
    , new COMMON_CODE('mem_id', 'user_id', 'User ID')
    , new COMMON_CODE('mem_nick', 'mem_nick', 'User 닉네임')
    , new COMMON_CODE('mem_phone', 'mem_phone', '연락처')
]

var search_exchange_state = [
    new COMMON_CODE(null, 'search_state', '처리상태')
    , new COMMON_CODE('all', '-1', '처리상태(전체)')
    , new COMMON_CODE('wait', '0', '미처리')
    , new COMMON_CODE('ok', '1', '완료')
    , new COMMON_CODE('reject', '2', '취소')
]

var exchange_sort = [
    new COMMON_CODE(null, 'exchange_sort', '환전내역정렬')
    , new COMMON_CODE('0', '0', '최근 환전 신청 순으로')
    , new COMMON_CODE('4', '4', '실수령액이 많은 순으로')
    , new COMMON_CODE('5', '5', '환전 누적금액이 많은 순으로')
    , new COMMON_CODE('1', '1', '신청 별 수 많은 순으로')
    , new COMMON_CODE('2', '2', '보유 별 수 많은 순으로')
    , new COMMON_CODE('3', '3', '최근 처리일 순으로')
]

var inforex_bank_code = [
    new COMMON_CODE(null, 'bank_code', '은행코드')
    , new COMMON_CODE('39', '39', '경남은행')
    , new COMMON_CODE('34', '34', '광주은행')
    , new COMMON_CODE('4', '4', '국민은행')
    , new COMMON_CODE('3', '3', '기업은행')
    , new COMMON_CODE('11', '11', '농협')
    , new COMMON_CODE('31', '31', '대구은행')
    , new COMMON_CODE('55', '55', '도이치은행')
    , new COMMON_CODE('32', '32', '부산은행')
    , new COMMON_CODE('61', '61', '비엔피파리바은행')
    , new COMMON_CODE('64', '64', '산림조합중앙회')
    , new COMMON_CODE('2', '2', '산업은행')
    , new COMMON_CODE('50', '50', '저축은행')
    , new COMMON_CODE('45', '45', '새마을금고중앙회')
    , new COMMON_CODE('8', '8', '수출입은행')
    , new COMMON_CODE('7', '7', '수협은행')
    , new COMMON_CODE('88', '88', '신한은행')
    , new COMMON_CODE('48', '48', '신협')
    , new COMMON_CODE('20', '20', '우리은행')
    , new COMMON_CODE('71', '71', '우체국')
    , new COMMON_CODE('37', '37', '전북은행')
    , new COMMON_CODE('35', '35', '제주은행')
    , new COMMON_CODE('67', '67', '중국건설은행')
    , new COMMON_CODE('62', '62', '중국공상은행')
    , new COMMON_CODE('90', '90', '카카오뱅크')
    , new COMMON_CODE('89', '89', '케이뱅크')
    , new COMMON_CODE('294', '294', '펀드온라인코리아')
    , new COMMON_CODE('27', '27', '한국씨티은행')
    , new COMMON_CODE('60', '60', 'BOA은행')
    , new COMMON_CODE('54', '54', 'HSBC은행')
    , new COMMON_CODE('57', '57', '제이피모간체이스은행')
    , new COMMON_CODE('81', '81', '하나은행')
    , new COMMON_CODE('23', '23', 'SC제일은행')
    , new COMMON_CODE('247', '247', 'NH투자증권')
    , new COMMON_CODE('261', '261', '교보증권')
    , new COMMON_CODE('267', '267', '대신증권')
    , new COMMON_CODE('287', '287', '메리츠종합금융증권')
    , new COMMON_CODE('238', '238', '미래에셋대우')
    , new COMMON_CODE('290', '290', '부국증권')
    , new COMMON_CODE('240', '240', '삼성증권')
    , new COMMON_CODE('291', '291', '신영증권')
    , new COMMON_CODE('278', '278', '신한금융투자')
    , new COMMON_CODE('209', '209', '유안타증권')
    , new COMMON_CODE('280', '280', '유진투자증권')
    , new COMMON_CODE('265', '265', '이베스트투자증권')
    , new COMMON_CODE('292', '292', '케이프투자증권')
    , new COMMON_CODE('264', '264', '키움증권')
    , new COMMON_CODE('270', '270', '하나금융투자')
    , new COMMON_CODE('262', '262', '하이투자증권')
    , new COMMON_CODE('243', '243', '한국투자증권')
    , new COMMON_CODE('269', '269', '한화투자증권')
    , new COMMON_CODE('263', '263', '현대차증권')
    , new COMMON_CODE('279', '279', 'DB금융투자')
    , new COMMON_CODE('218', '218', 'KB증권')
    , new COMMON_CODE('227', '227', 'KTB투자증권')
    , new COMMON_CODE('266', '266', 'SK증권')
]

var exchange_cancel_type = [
    new COMMON_CODE(null, 'send_type', '환전취소 사유')
    , new COMMON_CODE('0', '0', '미선택')
    , new COMMON_CODE('1', '1', '증빙서류 화질문제')
    , new COMMON_CODE('2', '2', '미비한 증빙서류 ')
    , new COMMON_CODE('3', '3', '입력정보 불일치')
    , new COMMON_CODE('4', '4', '기타 직접작성')
]

var changeList_searchType = [
    new COMMON_CODE(null, 'changeList', '교환 내역 sort')
    , new COMMON_CODE('0', '0', '최근 교환 순으로')
    , new COMMON_CODE('1', '1', '교환 별 수 많은 순으로')
    , new COMMON_CODE('2', '2', '교환 달 수 많은 순으로')
    , new COMMON_CODE('3', '3', '교환 횟 수 많은 순으로')
    , new COMMON_CODE('4', '4', '남은 별 수 많은 순으로')
    , new COMMON_CODE('5', '5', '남은 달 수 많은 순으로')
    , new COMMON_CODE('6', '6', '교환 오래된 순으로')
]

var autoChangeList_order = [
    new COMMON_CODE(null, 'autoChange_order', '자동 교환 설정내역 sort')
    , new COMMON_CODE('0', '0', '최근 자동교환 설정회원')
    , new COMMON_CODE('1', '1', '최근 자동교환 회원')
    , new COMMON_CODE('2', '2', '자동 교환 건 많은 순')
    , new COMMON_CODE('3', '3', '자동 교환 별 많은 순')
    , new COMMON_CODE('4', '4', '누적 자동 교환 별 많은 순')
]

var gender = [
    new COMMON_CODE(null, 'gender', '성별')
    , new COMMON_CODE('0', '0', '전체')
    , new COMMON_CODE('m', 'm', '남')
    , new COMMON_CODE('f', 'f', '여')
    , new COMMON_CODE('n', 'n', '알수없음')
]