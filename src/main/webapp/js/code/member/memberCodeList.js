var joinDate = [
    new COMMON_CODE('', 'joinDate', '날짜선택')
    , new COMMON_CODE('0', '0', '월별')
    , new COMMON_CODE('1', '1', '주별')
    , new COMMON_CODE('2', '2', '전일')
    , new COMMON_CODE('3', '3', '당일')
    , new COMMON_CODE('4', '4', '날짜선택')
];


var mem_state = [
    new COMMON_CODE('', 'mem_state', '회원상태')
    , new COMMON_CODE('1', '1', '정상')
    , new COMMON_CODE('2', '2', '경고')
    , new COMMON_CODE('3', '3', '정지')
    , new COMMON_CODE('5', '5', '영구정지')
    , new COMMON_CODE('51', '51', '임시정지')
    , new COMMON_CODE('4', '4', '탈퇴')
    , new COMMON_CODE('6', '6', '휴면상태')
    , new COMMON_CODE('7', '7', '자동탈퇴')
];

var broadCast_summary = [
    new COMMON_CODE('', 'totalListenCnt', '청취 수')
    , new COMMON_CODE('', 'totalListenerCnt', '청취자')
    , new COMMON_CODE('', 'totalGiftCnt', '선물 건')
    , new COMMON_CODE('', 'totalByeol', '받은 별')
    , new COMMON_CODE('', 'totalGood', '좋아요')
    , new COMMON_CODE('', 'totalBooster', '부스터')
    , new COMMON_CODE('', 'totalBooster', '보름달 완료 수')
    , new COMMON_CODE('', 'totalAudioBroadcastCnt', '라디오')
    , new COMMON_CODE('', 'totalVideoBroadcastCnt', '비디오')
    , new COMMON_CODE('', 'totalBroadCastCnt', '누적방송')
];

var member_listen_summary = [
    new COMMON_CODE('', 'totalforcedCnt', '강제퇴장')
    , new COMMON_CODE('', 'totalGift', '선물건')
    , new COMMON_CODE('', 'totalDal', '보낸 달')
    // , new COMMON_CODE('', 'totalByeol', '총 보낸 별')
    , new COMMON_CODE('', 'totalGood', '좋아요')
    , new COMMON_CODE('', 'totalBooster', '부스터')
    , new COMMON_CODE('', 'totalBooster', '보름달 완료 수')
];

var pay = [
    new COMMON_CODE(null, 'pay', '단계')
    ,new COMMON_CODE('all',  '-1','전체')
    ,new COMMON_CODE('pay',  '0','결제')
    ,new COMMON_CODE('cancel', '1','취소')
    ,new COMMON_CODE('Impossible', '2','불가')
];

var gift = [
    new COMMON_CODE(null, 'gift', '선물구분')
    ,new COMMON_CODE('all',  '-1','구분(전체)')
    ,new COMMON_CODE('present',  '0','보낸선물')
    ,new COMMON_CODE('gift', '1','받은선물')
];
var gift_dalbyeol = [
    new COMMON_CODE(null, 'gift_dalbyeol', '아이템구분')
    ,new COMMON_CODE('all',  '-1','아이템명(전체)')
    ,new COMMON_CODE('dal',  '0','달')
    ,new COMMON_CODE('byeol', '1','별')
];
var gift_date = [
    new COMMON_CODE(null, 'gift_date', '날짜 구분')
    ,new COMMON_CODE('all', '-1','전체')
    ,new COMMON_CODE('day', '0','일별')
    ,new COMMON_CODE('month', '1','월별')
]

var question = [
    new COMMON_CODE(null, 'question', '문의구분')
    ,new COMMON_CODE('all',  '-1','전체')
    ,new COMMON_CODE('one',  '0','1:1문의')
    ,new COMMON_CODE('call', '1','전화')
    ,new COMMON_CODE('email', '2','메일')
];

var member_declaration_slctType = [
    new COMMON_CODE(null, 'slctType', '제재 조치')
    , new COMMON_CODE('warning', '2', '경고')
    , new COMMON_CODE('stop1', '3', '1일정지')
    , new COMMON_CODE('stop3', '4', '3일정지')
    , new COMMON_CODE('stop7', '5', '7일정지')
    , new COMMON_CODE('withdrawal', '6', '영구정지')
    , new COMMON_CODE('stop15', '7', '강제탈퇴')
    , new COMMON_CODE('pause', '8', '임시정지')
];

var declaration_summary = [
    new COMMON_CODE('','cnt','미처리 건')
    ,new COMMON_CODE('','cnt','누적 처리 건')
    ,new COMMON_CODE('','cnt','제재 조치')
    ,new COMMON_CODE('','cnt','강제탈퇴')
    ,new COMMON_CODE('','cnt','영구정지')
];

var testId = [
    new COMMON_CODE('','testId','테스트아이디여부')
    ,new COMMON_CODE('-1','-1','전체')
    ,new COMMON_CODE('0','0','Test-ID 제외')
];

var testId_withdrawal = [
    new COMMON_CODE('','testId_withdrawal','테스트아이디여부')
    ,new COMMON_CODE('-1','-1','전체')
    ,new COMMON_CODE('0','0','Test-ID 제외')
];

var dalPointEditStory = [
    new COMMON_CODE('','pointEditStory','달/별수정사유')
    ,new COMMON_CODE('-1','-1','지급사유 선택')
    ,new COMMON_CODE('12','12','소실금액 복구')
    ,new COMMON_CODE('13','13','직원 테스트')
    ,new COMMON_CODE('23','23','이벤트 지급')
    ,new COMMON_CODE('22','22','스페셜DJ 혜택')
    ,new COMMON_CODE('12','12','운영자 지급')
];


var byeolPointEditStory = [
    new COMMON_CODE('','pointEditStory','달/별수정사유')
    ,new COMMON_CODE('-1','-1','지급사유 선택')
    ,new COMMON_CODE('6','6','소실금액 복구')
    ,new COMMON_CODE('7','7','직원 테스트')
    ,new COMMON_CODE('23','23','이벤트 지급')
    ,new COMMON_CODE('22','22','스페셜DJ 혜택')
];


var memJoinDateSort = [
    new COMMON_CODE('','memJoinDateSort','가입일시정렬')
    ,new COMMON_CODE('-1','-1','가입일시')
    ,new COMMON_CODE('0','0','오름차순')
    ,new COMMON_CODE('1','1','내림차순')
];

var memNickSort = [
    new COMMON_CODE('','memNickSort','닉네임정렬')
    ,new COMMON_CODE('-1','-1','닉네임')
    ,new COMMON_CODE('0','0','오름차순')
    ,new COMMON_CODE('1','1','내림차순')
];

var memLoginIdSort = [
    new COMMON_CODE('','memLoginIdSort','로그인ID정렬')
    ,new COMMON_CODE('-1','-1','로그인ID')
    ,new COMMON_CODE('0','0','오름차순')
    ,new COMMON_CODE('1','1','내림차순')
];

var memIpSort = [
    new COMMON_CODE('','memIpSort','IP정렬')
    ,new COMMON_CODE('-1','-1','IP')
    ,new COMMON_CODE('0','0','오름차순')
    ,new COMMON_CODE('1','1','내림차순')
];


var loginHistoryOsType = [
    new COMMON_CODE(null, 'ostype', 'os구분')
    , new COMMON_CODE('all', '', 'os구분')
    , new COMMON_CODE('android', '1', '안드로이드')
    , new COMMON_CODE('ios', '2', 'IOS')
    , new COMMON_CODE('PC', '3', 'PC')
    , new COMMON_CODE('web', 'WEB', 'WEB')
    , new COMMON_CODE('api', 'API', 'API')
    , new COMMON_CODE('server', 'server', 'SERVER')
    , new COMMON_CODE('photo', '7', 'Photo')
];

var loginHistorySearchType = [
    new COMMON_CODE(null, 'searchType', '검색구분')
    , new COMMON_CODE('all', '', '검색구분')
    , new COMMON_CODE('mem_no', 'mem_no', '회원번호')
    , new COMMON_CODE('uuid', 'uuid', 'UUID')
    , new COMMON_CODE('token', 'token', '토큰')
    , new COMMON_CODE('ip', 'ip', 'IP')
];

var searchRadioMember = [
    new COMMON_CODE(null, 'searchRadio', '검색구분')
    , new COMMON_CODE('1', '1', '회원')
    , new COMMON_CODE('9', '9', 'IP')
    , new COMMON_CODE('6', '6', '모바일ID')
];

var searchMemoSlct = [
    new COMMON_CODE('','memoSlct','운영자메모구분')
    // ,new COMMON_CODE('-1','-1','메모구분(전체)')
    ,new COMMON_CODE('1','1','회원')
    ,new COMMON_CODE('2','2','방송방')
    ,new COMMON_CODE('3','3','클립')
];

var withdrawalDateSort = [
    new COMMON_CODE('','withdrawalDateSort','탈퇴일시')
    ,new COMMON_CODE('-1','-1','탈퇴일시')
    ,new COMMON_CODE('0','0','오름차순')
    ,new COMMON_CODE('1','1','내림차순')
];

var serviceDateSort = [
    new COMMON_CODE('','serviceDateSort','서비스 유지기간')
    ,new COMMON_CODE('-1','-1','서비스 유지기간')
    ,new COMMON_CODE('0','0','오름차순')
    ,new COMMON_CODE('1','1','내림차순')
];

var dormancyType = [
    new COMMON_CODE('','dormancyType','휴면/해제')
    ,new COMMON_CODE('0','0','휴면/해제 전체')
    ,new COMMON_CODE('1','1','휴면 회원')
    ,new COMMON_CODE('2','2','휴면 해제 회원')
];

// ------------------------- table -----------------------------
var mem_gift_summary = [
    new COMMON_CODE('', 'total_charge_dal', '누적 충전 보낸 달')
    , new COMMON_CODE('', 'total_charge_dal', '누적 충전 받은 달')
    , new COMMON_CODE('', 'total_charge_byeol', '누적 충전 별')
    // , new COMMON_CODE('', 'most_gift_mem', '보낸 선물 최다 회원')
    // , new COMMON_CODE('', 'most_received_mem', '받은 선물 최다 회원')
];
var mem_received_summary = [
    new COMMON_CODE('', 'total_exchange', '누적 교환 수')
    , new COMMON_CODE('', 'dal10', '달 10')
    , new COMMON_CODE('', 'dal30', '달 30')
    , new COMMON_CODE('', 'dal100', '달 100')
    , new COMMON_CODE('', 'dal500', '달 500')
    , new COMMON_CODE('', 'dal1000', '달 1,000')
    , new COMMON_CODE('', 'dal3000', '달 3,000')
];


var mem_wallet_code = [
    new COMMON_CODE('', 'walletType', '달 선물 구분')
    , new COMMON_CODE('all', '0', '이용구분(전체)')
    , new COMMON_CODE('1', '1', '받은내역')
    , new COMMON_CODE('2', '2', '보낸내역')
];

var mem_wallet_dal_code = [
    new COMMON_CODE('', 'slct_type', '달 선물 구분')
    , new COMMON_CODE('all', '0', '구분(전체)')
    , new COMMON_CODE('1', '1', '달 구매')
    , new COMMON_CODE('2', '2', '아이템선물')
    , new COMMON_CODE('3', '3', '부스터사용')
    , new COMMON_CODE('4', '4', '달 선물보내기')
    , new COMMON_CODE('5', '5', '달 선물받기')
    , new COMMON_CODE('6', '6', '달 교환')
    , new COMMON_CODE('7', '7', '이벤트 받기(자동)')
    , new COMMON_CODE('8', '8', '환불차감/결제취소')
    , new COMMON_CODE('9', '9', '퀵 메시지 구매/연장')
    , new COMMON_CODE('10', '10', '레벨업 보상')
    , new COMMON_CODE('11', '11', '출석체크 보상')
    , new COMMON_CODE('12', '12', '소실금액 복구')
    , new COMMON_CODE('13', '13', '테스트지급및회수')
    , new COMMON_CODE('14', '14', '클립선물')
    , new COMMON_CODE('15', '15', '가입보상 달')
    , new COMMON_CODE('16', '16', '랭킹보상')
    , new COMMON_CODE('17', '17', '아이템비밀선물')
    , new COMMON_CODE('18', '18', '룰렛이벤트보상')
    , new COMMON_CODE('19', '19', '게스트선물')
    , new COMMON_CODE('20', '20', '게스트몰래선물')
    /*, new COMMON_CODE('21', '21', '운영출석체크') -> 테이블 정의서엔 있지만 안써서 주석처리 */
    , new COMMON_CODE('22', '22', '스페셜DJ혜택')
    , new COMMON_CODE('23', '23', '이벤트 지급(어드민)')
    , new COMMON_CODE('25', '25', '이벤트 경품 달로 받기')
    , new COMMON_CODE('31', '31', '자동교환')
    , new COMMON_CODE('32', '32', '우체동 선물')
];

var mem_wallet_byeol_code = [
    new COMMON_CODE('', 'slct_type', '별 선물 구분')
    , new COMMON_CODE('all', '0', '구분(전체)')
    , new COMMON_CODE('1', '1', '별 교환')
    , new COMMON_CODE('2', '2', '선물')
    , new COMMON_CODE('3', '3', '환전')
    , new COMMON_CODE('4', '4', '이벤트 받기')
    , new COMMON_CODE('5', '5', '레벨업 보상')
    , new COMMON_CODE('6', '6', '소실금액복구')
    , new COMMON_CODE('7', '7', '테스트지급및회수')
    , new COMMON_CODE('8', '8', '환전취소')
    , new COMMON_CODE('14', '14', '클립선물')
    , new COMMON_CODE('17', '17', '아이템비밀선물')
    , new COMMON_CODE('19', '19', '게스트선물')
    , new COMMON_CODE('20', '20', '게스트몰래선물')
    , new COMMON_CODE('21', '21', '출석체크 보상')
    , new COMMON_CODE('22', '22', '스페셜DJ혜택')
    , new COMMON_CODE('23', '23', '이벤트 지급(어드민)')
    , new COMMON_CODE('31', '31', '자동교환')
    , new COMMON_CODE('32', '32', '우체통 선물')
];

var slctWalletDateType = [
    new COMMON_CODE('', 'slctWalletDateType', '달/별기간선택')
    , new COMMON_CODE('0', '0', '기간선택(전체)')
    , new COMMON_CODE('1', '1', '선물 일시')
];


var slctExchangeStatus = [
    new COMMON_CODE('', 'exchangeStatus', '처리상태')
    , new COMMON_CODE('0', '0', '처리상태(전체)')
    , new COMMON_CODE('1', '1', '승인완료')
    , new COMMON_CODE('2', '2', '승인취소')
    , new COMMON_CODE('3', '3', '미처리')
];
var slctExchangeMemberType = [
    new COMMON_CODE('', 'exchangeMemberType', '회원구분')
    , new COMMON_CODE('0', '0', '회원구분(전체)')
    , new COMMON_CODE('1', '1', '일반회원')
    , new COMMON_CODE('2', '2', '스패셜DJ')
];
var slctExchangeDateType = [
    new COMMON_CODE('', 'slctExchangeDateType', '환전내역 기간선택')
    , new COMMON_CODE('0', '0', '기간(전체)')
    , new COMMON_CODE('1', '1', '기간선택')
];

var member_item_type = [
    new COMMON_CODE('', 'item_type', '회원 아이템코드')
    , new COMMON_CODE('1', '1', '부스터')
];

var member_item_state = [
    new COMMON_CODE('', 'state', '회원 아이템상태코드')
    , new COMMON_CODE('1', '1', '지급')
    , new COMMON_CODE('2', '2', '사용')
    , new COMMON_CODE('3', '3', '차감')
];

var member_saerch_type = [
    new COMMON_CODE('', 'searchType', '회원검색')
    , new COMMON_CODE('-1', '-1', '전체')
    , new COMMON_CODE('1', '1', '회원번호')
    , new COMMON_CODE('2', '2', '회원이름')
    , new COMMON_CODE('3', '3', '회원아이디')
    , new COMMON_CODE('4', '4', '닉네임')
    , new COMMON_CODE('5', '5', '연락처')
]

var member_roulette_coupon_type = [
    new COMMON_CODE('', 'couponType', '쿠폰타입')
    , new COMMON_CODE('1', '1', '방송/청취')
    , new COMMON_CODE('2', '2', '보름달')
    , new COMMON_CODE('3', '3', '구매/결제')
    , new COMMON_CODE('4', '4', '스페셜DJ')
]