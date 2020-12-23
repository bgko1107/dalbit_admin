/** =------ Notice ---------- */
var notice_platform = [
    new COMMON_CODE(null, 'platform', '플랫폼')
    , new COMMON_CODE('all', '111', '전체')
    , new COMMON_CODE('title', '100', 'PC')
    , new COMMON_CODE('content', '010', '안드로이드')
    , new COMMON_CODE('opName', '3', '작성자')
];

var notice_searchType = [
    new COMMON_CODE(null, 'searchType', '검색구분')
    , new COMMON_CODE('all', '-1', '전체')
    , new COMMON_CODE('title', '1', '공지제목')
    , new COMMON_CODE('content', '2', '내용')
    , new COMMON_CODE('opName', '3', '작성자')
];

var notice_slctType = [
    new COMMON_CODE(null, 'slctType', '공지구분')
    , new COMMON_CODE('all', '-1', '전체')
    , new COMMON_CODE('notice', '1', '일반공지')
    , new COMMON_CODE('notice', '', '긴급공지(개발필요)')
    , new COMMON_CODE('event', '2', '이벤트')
    , new COMMON_CODE('check', '3', '정기점검')
    , new COMMON_CODE('update', '4', '업데이트')
    , new COMMON_CODE('news', '5', '언론보도')
];


/** =------ PushMessage ---------- */
var push_searchType = [
    new COMMON_CODE(null, 'searchType', '검색구분')
    , new COMMON_CODE('all', '-1', '검색구분(전체)')
    , new COMMON_CODE('title', '1', '메시지 제목')
    , new COMMON_CODE('content', '2', '메시지 내용')
    , new COMMON_CODE('opname', '3', '발신자')
];

var push_sendType = [
    new COMMON_CODE(null, 'send_type', '발송형태')
    , new COMMON_CODE('all', '-1', '발송형태(전체)')
    , new COMMON_CODE('push/noti', '11', 'PUSH/알림')
    , new COMMON_CODE('push', '10', 'PUSH')
    , new COMMON_CODE('noti', '01', '알림')
];

var push_snedStatus = [
    new COMMON_CODE(null, 'snedStatus', '발송상태')
    , new COMMON_CODE('ready', '0', '발송대기')
    , new COMMON_CODE('send', '1', '발송완료')
    , new COMMON_CODE('error', '2', '발송실패')
];

var push_platform = [
    new COMMON_CODE(null, 'platform', '노출 OS구분')
    , new COMMON_CODE('all', '-1', '전체')
    , new COMMON_CODE('pc', '1', 'PC')
    , new COMMON_CODE('android', '2', 'Android')
    , new COMMON_CODE('ios', '3', 'IOS')
];

var push_messageType = [
    new COMMON_CODE(null, 'messageType', '메시지 구분')
    , new COMMON_CODE('notice', '0', '일반공지')
    , new COMMON_CODE('notice', '1', '긴급공지')
    , new COMMON_CODE('event', '2', '이벤트')
    , new COMMON_CODE('check', '3', '정기점검')
    , new COMMON_CODE('update', '4', '업데이트')
    , new COMMON_CODE('etc', '99', '기타')
];

var push_slctPush = [
    new COMMON_CODE(null, 'slctPush', '푸시타입')
    , new COMMON_CODE('mystar', '0', '마이스타')
    , new COMMON_CODE('receive', '1', '선물 받은 달')
    , new COMMON_CODE('fan', '2', '팬')
    , new COMMON_CODE('comment', '3', '댓글')
    , new COMMON_CODE('dalbit', '4', '달빛 라이브')
    , new COMMON_CODE('event', '5', '이벤트 및 마케팅 정보')
];

var push_slctPush2 = [
    new COMMON_CODE(null, 'slctPush', '푸시타입')
    , new COMMON_CODE('room', '1', '방송방')       								// [room_no]
    , new COMMON_CODE('main', '2', '메인')
//    , new COMMON_CODE('incast', '4', '등록 된 캐스트')
//     , new COMMON_CODE('spdj', '5', '스페셜 DJ 선정 페이지')          // 이상훈과장 요청으로 제거  전유신 2020.07.28
    , new COMMON_CODE('event', '6', '이벤트 페이지')           					// [board_idx]
    , new COMMON_CODE('notice', '7', '공지사항 페이지')                       	// [board_idx]
    , new COMMON_CODE('fan', '31', '팬보드/댓글')								// [mem_no]
    , new COMMON_CODE('wallet', '32', '내지갑(달)')						// [mem_no]
//    , new COMMON_CODE('cast', '33', '마이페이지>캐스트>캐스트 정보 변경 페이지')
    , new COMMON_CODE('noti', '34', '알림')
    , new COMMON_CODE('mypage', '35', '마이페이지')							// [mem_no]
    , new COMMON_CODE('djpage', '36', '대상 프로필')              		// [mem_no]
    , new COMMON_CODE('question', '37', '1:1문의')
    , new COMMON_CODE('broadnoti', '38', '방송공지')
    // , new COMMON_CODE('41', '41', '랭킹 > DJ > 일간')
    // , new COMMON_CODE('42', '42', '랭킹 > DJ > 주간')
    // , new COMMON_CODE('43', '43', '랭킹 > FAN > 일간')
    // , new COMMON_CODE('44', '44', '랭킹 > FAN > 주간')
    , new COMMON_CODE('input', '50', '직접입력')
    , new COMMON_CODE('input', '51', '주간 클립 테이블')
];

var push_slctPush3 = [
    new COMMON_CODE(null, 'slctPush', '푸시타입')
    , new COMMON_CODE('room', '1', '방송방')
    , new COMMON_CODE('main', '2', '메인')
    , new COMMON_CODE('incast', '4', '캐스트')
    , new COMMON_CODE('spdj', '5', '스페셜 DJ')
    , new COMMON_CODE('event', '6', '이벤트')
    , new COMMON_CODE('notice', '7', '공지사항')
    , new COMMON_CODE('fan', '31', '팬보드/댓글')
    , new COMMON_CODE('wallet', '32', '내지갑')
    , new COMMON_CODE('cast', '33', '캐스트 수정')
    , new COMMON_CODE('noti', '34', '알림')
    , new COMMON_CODE('mypage', '35', '마이페이지')
    , new COMMON_CODE('djpage', '36', '레벨업')
    , new COMMON_CODE('question', '37', '1:1문의')
    , new COMMON_CODE('broadnoti', '38', '방송공지')
    , new COMMON_CODE('41', '41', 'DJ랭킹(일간)')
    , new COMMON_CODE('42', '42', 'DJ랭킹(주간)')
    , new COMMON_CODE('43', '43', 'FAN랭킹(일간)')
    , new COMMON_CODE('44', '44', 'FAN랭킹(주간)')
    , new COMMON_CODE('45', '45', '클립플레이')
    , new COMMON_CODE('46', '46', '클립댓글')
    , new COMMON_CODE('input', '50', '직접입력')
];

var push_isDirect = [
    new COMMON_CODE(null, 'sendType', '발송 구분')
    , new COMMON_CODE('instant', '0', '즉시발송')
    , new COMMON_CODE('reservation', '1', '예약발송')
];

var push_targetInfo = [
    new COMMON_CODE(null, 'targetInfo', '발송 닉네임/이름 설정')
    , new COMMON_CODE('1', '1', '닉네임설정')
    , new COMMON_CODE('2', '2', '이름 설정')
    , new COMMON_CODE('0', '0', '미설정')
];


var push_push_slct = [
    new COMMON_CODE(null, 'push_slct', '카테고리')
    ,new COMMON_CODE('all', '-1', '카테고리(전체)')
    ,new COMMON_CODE('11','11','방송 시작')
    ,new COMMON_CODE('12','12','DJ 레벨 업')
    ,new COMMON_CODE('13','13','신규 캐스트 등록, 좋아요')
    ,new COMMON_CODE('14','14','방송 시작 10분 후(팬이 아닌 상태로 방송방에 1회 입장한 사용자에게 수신)')
    ,new COMMON_CODE('15','15','선물 수신')
    ,new COMMON_CODE('16','16','팬 등록(최초 1회만 푸시알림)')
    ,new COMMON_CODE('17','17','팬 보드 신규 글 등록')
    ,new COMMON_CODE('18','18','스타 방송공지 신규 글 등록')
    ,new COMMON_CODE('19','19','생일 축하 알림')
    ,new COMMON_CODE('20','20','DJ/FAN 랭킹 알림')
    ,new COMMON_CODE('21','21','비밀 팬 보드 신규 글 등록')
    ,new COMMON_CODE('22','22','팬 보드 신규 댓글 등록')
    ,new COMMON_CODE('23','23','비밀 팬 보드 신규 댓글 등록 ')
    ,new COMMON_CODE('30','30','마이스타 클립 등록')
    ,new COMMON_CODE('31','31','클립 좋아요')
    ,new COMMON_CODE('32','32','클립 댓글')
    ,new COMMON_CODE('33','33','클립 선물')
    ,new COMMON_CODE('51','51','서비스 공지(가입 후 15일 간, 미접속)')
    ,new COMMON_CODE('52','52','이벤트 알림')
    ,new COMMON_CODE('53','53','운영자 메시지(긴급공지)')
    ,new COMMON_CODE('54','54','운영자 메시지(사용자 경고)')
    ,new COMMON_CODE('55','55','운영자 메시지(경고 해제)')
    ,new COMMON_CODE('56','56','운영자 메시지(이용정지 해제)')
    ,new COMMON_CODE('57','57','운영자 메시지(프로필 이미지 초기화, 닉네임 초기화)')
    ,new COMMON_CODE('58','58','운영자 메시지(클립 정보 수정 및 신고)')
    ,new COMMON_CODE('59','59','스페셜 DJ 선정')
    ,new COMMON_CODE('60','60','1:1 문의 답변')
    ,new COMMON_CODE('61','61','운영자 선물 알림')
    ,new COMMON_CODE('62','62','환전 완료')
    ,new COMMON_CODE('63','63','환전 불가')
    ,new COMMON_CODE('92','92','어드민 운영자 메시지(회원 + 비회원)')
    ,new COMMON_CODE('93','93','어드민 운영자 메시지(회원)')
    ,new COMMON_CODE('94','94','어드민 운영자 메시지(비회원)')
    ,new COMMON_CODE('95','95','어드민 운영자 메시지(테스트계정)')
    ,new COMMON_CODE('96','96','어드민 운영자 메시지(타겟)')
];



var status_simple_push_type = [
    new COMMON_CODE(null, 'status_simple_push_type', '카테고리')
    ,new COMMON_CODE('11','11','마이스타')
    ,new COMMON_CODE('15','15','선물')
    ,new COMMON_CODE('16','16','팬 등록')
    ,new COMMON_CODE('17','17','팬 보드')
    ,new COMMON_CODE('31','31','클립')
    ,new COMMON_CODE('20','20','랭킹')
    ,new COMMON_CODE('19','19','서비스')
    ,new COMMON_CODE('62','62','환전')
    ,new COMMON_CODE('53','53','운영자 (자동)')
    ,new COMMON_CODE('61','61','운영자 (직접)')
];

var status_detail_push_type = [
    new COMMON_CODE(null, 'status_detail_push_type', '카테고리')
    ,new COMMON_CODE('11','11','방송 시작')
    ,new COMMON_CODE('18','18','신규공지 등록')
    ,new COMMON_CODE('30','30','클립 등록')
    ,new COMMON_CODE('15','15','수신')
    ,new COMMON_CODE('16','16','최초 1회')
    ,new COMMON_CODE('17','17','신규 글 등록(일반)')
    ,new COMMON_CODE('21','21','신규 글 등록(비밀)')
    ,new COMMON_CODE('22','22','신규 댓글 등록(일반)')
    ,new COMMON_CODE('23','23','신규 댓글 등록(비밀)')
    ,new COMMON_CODE('24','24','공지댓글')
    ,new COMMON_CODE('31','31','좋아요')
    ,new COMMON_CODE('32','32','댓글')
    ,new COMMON_CODE('33','33','선물')
    ,new COMMON_CODE('20','20','DJ/FAN')
    ,new COMMON_CODE('19','19','생일 축하')
    ,new COMMON_CODE('51','51','공지 가입>15일 간 미접속')
    ,new COMMON_CODE('52','52','이벤트 알림')
    ,new COMMON_CODE('60','60','1:1 문의 답변')
    ,new COMMON_CODE('62','62','완료')
    ,new COMMON_CODE('63','63','취소(불가)')
    ,new COMMON_CODE('53','53','긴급공지')
    ,new COMMON_CODE('50','50','휴면/탈퇴')
    ,new COMMON_CODE('54','54','사용자 경고')
    ,new COMMON_CODE('55','55','경고해제')
    ,new COMMON_CODE('56','56','이용정지해제')
    ,new COMMON_CODE('57','57','프로필 이미지 초기화/닉네임 초기화')
    ,new COMMON_CODE('58','58','클립 정보 수정 및 신고')
    ,new COMMON_CODE('61','61','선물 알림')
    ,new COMMON_CODE('92','92','회원 + 비회원')
    ,new COMMON_CODE('93','93','회원')
    ,new COMMON_CODE('94','94','비회원')
    ,new COMMON_CODE('95','95','테스트계정')
    ,new COMMON_CODE('96','96','타겟')
];







/** =------ Splash ---------- */
var splash_exposureType = [
    new COMMON_CODE(null, 'exposureType', '게시 기간')
    , new COMMON_CODE('immediately', '0', '즉시게시')
    , new COMMON_CODE('reservation', '1', '예약게시')
];


/** =------ Banner ---------- */
var banner_searchType = [
    new COMMON_CODE(null, 'searchType', '검색구분')
    , new COMMON_CODE('all', '-1', '전체')
    , new COMMON_CODE('title', '1', '메시지 제목')
    , new COMMON_CODE('content', '2', '메시지 내용')
];


//배너타입 추가 시 하단에 banner_bannerType_popup이나 banner_bannerType_banner에도 추가해주세요.
var banner_bannerType = [
    new COMMON_CODE(null, 'bannerType', '배너구분')
    , new COMMON_CODE('all', '-1', '전체')
    , new COMMON_CODE('gnb', '0', 'GNB')
    , new COMMON_CODE('top', '1', 'MainTop')
    /*, new COMMON_CODE('thumb', '2', 'Main 썸네일')*/
    , new COMMON_CODE('dj', '3', 'DJ랭킹')
    , new COMMON_CODE('store', '4', '스토어')
    , new COMMON_CODE('center', '5', '고객센터')
    , new COMMON_CODE('popup', '6', '팝업')
    , new COMMON_CODE('startPopup', '7', '시작팝업')
    , new COMMON_CODE('endPopup', '8', '종료팝업')
    , new COMMON_CODE('mainRankBottom', '9', 'Main Center')
    , new COMMON_CODE('clip', '10', '클립 Center')
    , new COMMON_CODE('clipMain', '13', '클립 팝업')
    , new COMMON_CODE('exchangePopup', '11', '환전팝업')
    , new COMMON_CODE('storePopup', '12', '스토어팝업')
    , new COMMON_CODE('rankPopup', '14', '랭킹팝업')
    , new COMMON_CODE('questionTop', '15', '1:1문의 TOP')
];

var banner_bannerType_popup = [
    new COMMON_CODE(null, 'bannerType', '배너구분')
    , new COMMON_CODE('popup', '6', '팝업')
    , new COMMON_CODE('startPopup', '7', '시작팝업')
    , new COMMON_CODE('endPopup', '8', '종료팝업')
    , new COMMON_CODE('clipMain', '13', '클립 팝업')
    , new COMMON_CODE('exchangePopup', '11', '환전팝업')
    , new COMMON_CODE('storePopup', '12', '스토어팝업')
    , new COMMON_CODE('rankPopup', '14', '랭킹팝업')
];

var banner_bannerType_banner = [
    new COMMON_CODE(null, 'bannerType', '배너구분')
    , new COMMON_CODE('all', '-1', '전체')
    , new COMMON_CODE('gnb', '0', 'GNB')
    , new COMMON_CODE('top', '1', 'MainTop')
    , new COMMON_CODE('dj', '3', 'DJ랭킹')
    , new COMMON_CODE('store', '4', '스토어')
    , new COMMON_CODE('center', '5', '고객센터')
    , new COMMON_CODE('mainRankBottom', '9', 'Main Center')
    , new COMMON_CODE('clip', '10', '클립 Center')
    , new COMMON_CODE('questionTop', '15', '1:1문의 TOP')
];

var banner_loginType = [
    new COMMON_CODE(null, 'loginType', '로그인구분')
    , new COMMON_CODE('all', '0', '전체')
    , new COMMON_CODE('login', '1', '로그인')
    , new COMMON_CODE('nonlogin', '2', '비로그인')
];

var banner_frequency = [
    new COMMON_CODE(null, 'frequency', '노출빈도')
    , new COMMON_CODE('10', '10', '10%')
    , new COMMON_CODE('20', '20', '20%')
    , new COMMON_CODE('30', '30', '30%')
    , new COMMON_CODE('40', '40', '40%')
    , new COMMON_CODE('50', '50', '50%')
    , new COMMON_CODE('60', '60', '60%')
    , new COMMON_CODE('70', '70', '70%')
    , new COMMON_CODE('80', '80', '80%')
    , new COMMON_CODE('90', '90', '90%')
    , new COMMON_CODE('100', '100', '100%')
];

var banner_exposureType = [
    new COMMON_CODE(null, 'exposureType', '노출 기간')
    , new COMMON_CODE('always', '0', '상시')
    , new COMMON_CODE('choice', '1', '직접선택')
];

var banner_popupType = [
    new COMMON_CODE(null, 'popup_type', '팝업 구분')
    , new COMMON_CODE('image', '0', '이미지팝업')
    , new COMMON_CODE('text', '1', '텍스트팝업')
];

var banner_cookieYn = [
    new COMMON_CODE(null, 'cookie_yn', '쿠키사용여부')
    , new COMMON_CODE('off', 'N', 'off')
    , new COMMON_CODE('on', 'Y', 'on')
];

/** =------ Event ---------- */
// var event_searchType = [
//     new COMMON_CODE(null, 'searchType', '검색구분')
//     , new COMMON_CODE('all', '-1', '전체')
//     , new COMMON_CODE('title', '1', '제목')
// ];
//
// var event_isReply = [
//     new COMMON_CODE(null, 'is_reply', '댓글사용여부')
//     , new COMMON_CODE('no', '0', '사용안함')
//     , new COMMON_CODE('yes', '1', '사용')
// ];

var event_stateSlct = [
    new COMMON_CODE(null, 'stateSlct', '이벤트 상태 구분')
    , new COMMON_CODE('all', '-1', '이벤트 상태(전체)')
    , new COMMON_CODE('will', '0', '예정')
    , new COMMON_CODE('ing', '1', '진행 중')
    , new COMMON_CODE('end', '2', '종료')
];

var event_alwaysYn = [
    new COMMON_CODE(null, 'alwaysYn', '상시 여부')
    , new COMMON_CODE('no', '0', '날짜 지정')
    , new COMMON_CODE('yes', '1', '상시')
];

var event_viewYn = [
    new COMMON_CODE(null, 'viewYn', '노출 여부')
    , new COMMON_CODE('no', '0', '비노출')
    , new COMMON_CODE('yes', '1', '노출')
];

var event_announceYn = [
    new COMMON_CODE(null, 'announceYn', '당첨자 발표 구분')
    , new COMMON_CODE('all', '-1', '당첨자 발표 여부(전체)')
    , new COMMON_CODE('no', '0', '미발표')
    , new COMMON_CODE('yes', '1', '발표')
];

var event_announceYn_radio = [
    new COMMON_CODE(null, 'announceYn', '당첨자 발표 구분')
    , new COMMON_CODE('no', '0', '미발표')
    , new COMMON_CODE('yes', '1', '발표')
];

var event_winnerYn = [
    new COMMON_CODE(null, 'winnerYn', '당첨자 발표 구분')
    , new COMMON_CODE('no', '0', '미완료')
    , new COMMON_CODE('yes', '1', '완료')
];

var event_addInfoSlct = [
    new COMMON_CODE(null, 'addInfoSlct', '추가 정보 구분')
    , new COMMON_CODE('no', '0', '없음')
    , new COMMON_CODE('image', '1', '이미지')
    , new COMMON_CODE('reply', '2', '댓글')
    , new COMMON_CODE('etc', '9', '기타')
];

var event_prizeSlct = [
    new COMMON_CODE(null, 'prizeSlct', '경품 구분')
    , new COMMON_CODE('rank', '1', '등수구분')
    , new COMMON_CODE('all', '2', '일괄지급')
];

var event_prizeReceive = [
    new COMMON_CODE(null, 'prizeSlct', '경품 수령 구분')
    , new COMMON_CODE('prize', '1', '현물')
    , new COMMON_CODE('dal', '2', '달')
    , new COMMON_CODE('byeol', '3', '별')
];

var event_winnerSortSlct = [
    new COMMON_CODE(null, 'sortSlct', '정렬 구분')
    , new COMMON_CODE('recent', '0', '최근 응모 순')
    , new COMMON_CODE('count', '1', '응모 횟수')
    , new COMMON_CODE('payAmt', '2', '결제 금액')
    , new COMMON_CODE('airTime', '3', '방송 시간')
    , new COMMON_CODE('good', '4', '좋아요')
    , new COMMON_CODE('exp', '5', '경험치')
    , new COMMON_CODE('byeol', '6', '받은 선물')
    , new COMMON_CODE('dal', '7', '보낸 선물')
    , new COMMON_CODE('fan', '8', '팬')
];

var event_winnerWinSlct = [
    new COMMON_CODE(null, 'winSlct', '당첨 구분')
    , new COMMON_CODE('no', '0', '미당첨자')
    , new COMMON_CODE('yes', '1', '당첨자')
    , new COMMON_CODE('all', '2', '당첨자 + 미당첨자')
];

var event_winnerCertificationYn = [
    new COMMON_CODE(null, 'certificationYn', '본인 인증 여부')
    , new COMMON_CODE('no', '0', '미인증')
    , new COMMON_CODE('yes', '1', '인증')
];

var event_minorYn = [
    new COMMON_CODE(null, 'minorYn', '미성년자 여부')
    , new COMMON_CODE('no', '0', '성인')
    , new COMMON_CODE('yes', '1', '미성년')
];

var event_receiveWay = [
    new COMMON_CODE(null, 'receiveWay', '경품 수령 방법')
    , new COMMON_CODE('not yet', '0', '선택 전')
    , new COMMON_CODE('prize', '1', '배송 수령')
    , new COMMON_CODE('dal', '2', '달로 받기')
];

var event_addInfoYn = [
    new COMMON_CODE(null, 'addInfo', '추가 정보 입력 여부')
    , new COMMON_CODE('no', '0', '미입력')
    , new COMMON_CODE('yes', '1', '입력')
];

var event_depositYn = [
    new COMMON_CODE(null, 'depositConfirm', '입금 확인')
    , new COMMON_CODE('no', '0', '미확인')
    , new COMMON_CODE('yes', '1', '확인')
];

var event_winnerState = [
    new COMMON_CODE(null, 'state', '당첨자 상태')
    , new COMMON_CODE('input wait', '0', '입력 대기 중')
    , new COMMON_CODE('deposit wait', '1', '입금 대기 중')
    , new COMMON_CODE('send wait', '2', '발송 대기 중')
    , new COMMON_CODE('complete', '3', '완료')
];

var event_contentType = [
    new COMMON_CODE(null, 'content_type', '이벤트 컨텐츠 타입')
    , new COMMON_CODE('image', 'image', '이미지')
    , new COMMON_CODE('button', 'button', '버튼')
]

var event_content_button_type = [
    new COMMON_CODE(null, 'button_type', '이벤트 컨텐츠 버튼 타입')
    , new COMMON_CODE('link', 'link', '링크이동')
    , new COMMON_CODE('popup', 'popup', '팝업')
    , new COMMON_CODE('popup', 'popup', '팝업')
]

var event_foldYn = [
    new COMMON_CODE(null, 'foldYn', '접기 여부 버튼 타입')
    , new COMMON_CODE('0', '0', '비노출')
    , new COMMON_CODE('1', '1', '노출')
]

/** =------ Item ---------- */
var item_searchType = [
    new COMMON_CODE(null, 'searchType', '검색구분')
    , new COMMON_CODE('all', '-1', '전체')
    , new COMMON_CODE('code', '1', '코드')
    , new COMMON_CODE('itemName', '2', '상품명')
];

var item_discount = [
    new COMMON_CODE(null, 'discount_rate', '할인율')
    , new COMMON_CODE('0', '0', 'OFF')
    , new COMMON_CODE('10', '10', '10%')
    , new COMMON_CODE('20', '20', '20%')
    , new COMMON_CODE('30', '30', '30%')
    , new COMMON_CODE('40', '40', '40%')
    , new COMMON_CODE('50', '50', '50%')
    , new COMMON_CODE('60', '60', '60%')
    , new COMMON_CODE('70', '70', '70%')
    , new COMMON_CODE('80', '80', '80%')
    , new COMMON_CODE('90', '90', '90%')
    , new COMMON_CODE('100', '100', '100%(무료)')
    , new COMMON_CODE('etc', '-1', '기타 <input id="inputDiscountEtc" class="_trim" style="width:40px;" onkeydown="common.inputFilterNumber(event)" maxlength="3">%')
];

var item_itemType = [
    new COMMON_CODE(null, 'item_type', '아이템 타입')
    , new COMMON_CODE('new', '1', '신규')
    , new COMMON_CODE('best', '2', '인기')
    , new COMMON_CODE('limit', '3', '한정')
];

var item_itemSlct = [
    new COMMON_CODE(null, 'item_slct', '아이템 구분')
    , new COMMON_CODE('gift', '1', '방송방선물')
    , new COMMON_CODE('use', '2', '방송방사용')
    , new COMMON_CODE('dal', '3', '달 선물')
];

var item_useArea = [
    new COMMON_CODE(null, 'useArea', '사용영역')
    , new COMMON_CODE('default', '0', '기본')
    , new COMMON_CODE('particle', '1', '1번 영역(파티클)')
    , new COMMON_CODE('combo', '2', '2번 영역(콤보)')
    , new COMMON_CODE('top', '3', '3번 영역(상단)')
    , new COMMON_CODE('right', '4', '4번 영역(우측)')
    , new COMMON_CODE('topAll', '5', '5번 영역(상단전체)')
];

var item_fileField = [
    new COMMON_CODE(null, 'fileField', '파일등록필드')
    , new COMMON_CODE('webp/json', 'webp/json', 'Webp/Json')
    // , new COMMON_CODE('sticker', '2', 'sticker')
];


/** =------ Util ---------- */

var content_viewOn = [
    new COMMON_CODE(null, 'viewYn', '게시구분')
    , new COMMON_CODE('on', '1', 'ON')
    , new COMMON_CODE('off', '0', 'OFF')
];

var content_platform1 = [
    new COMMON_CODE(null, 'platform', '플랫폼구분')
    , new COMMON_CODE('all', '', '전체')
    , new COMMON_CODE('pc', '2', 'PC')
    , new COMMON_CODE('android', '3', 'Android')
    , new COMMON_CODE('ios', '4', 'IOS')
    , new COMMON_CODE('mobile', '5', 'Web-Mobile')
];

var content_platform2 = [
    new COMMON_CODE(null, 'platform', '플랫폼구분')
    , new COMMON_CODE('all', '-1', '전체')
    , new COMMON_CODE('pc', '1', 'PC')
    , new COMMON_CODE('android', '2', 'Android')
    , new COMMON_CODE('ios', '3', 'IOS')
];

var content_platform3 = [
    new COMMON_CODE(null, 'platform', '플랫폼구분')
    , new COMMON_CODE('all', '-1', '전체')
    , new COMMON_CODE('pc', '110', 'PC/Android')
    , new COMMON_CODE('ios', '001', 'IOS')
];

var content_platform4 = [
    new COMMON_CODE(null, 'platform', '플랫폼구분')
    , new COMMON_CODE('all', '0', '전체')
    , new COMMON_CODE('pc', '1', 'PC')
    , new COMMON_CODE('Mobile', '2', 'Mobile')
];

var content_platform5 = [
    new COMMON_CODE(null, 'platform', '플랫폼구분')
    , new COMMON_CODE('all', '0', '플랫폼(전체)')
    , new COMMON_CODE('android/ios', '111', 'Android/IOS')
    , new COMMON_CODE('android', '110', 'Android')
    , new COMMON_CODE('ios', '101', 'IOS')
];

var push_send_user = [
    new COMMON_CODE(null, 'push_send_user', '발송자구분')
    , new COMMON_CODE('0', '0', '발송자구분(전체)')
    , new COMMON_CODE('1', '1', '운영자')
    , new COMMON_CODE('2', '2', '자동')
];


/** =------ App ---------- */
var content_selectApp = [
    new COMMON_CODE(null, 'os', '앱구분')
    , new COMMON_CODE('all', '', '전체')
    , new COMMON_CODE('android', 1, 'AOS')
    , new COMMON_CODE('ios', 2, 'IOS')
];

var content_radioApp = [
    new COMMON_CODE(null, 'content_os', '앱구분')
    , new COMMON_CODE('android', 1, 'AOS')
    , new COMMON_CODE('ios', 2, 'IOS')
];

var content_isUse = [
    new COMMON_CODE(null, 'content_isUse', '사용여부')
    , new COMMON_CODE('no', 0, '사용 안 함')
    , new COMMON_CODE('yes', 1, '사용 함')
];

/** =------ Attendance ---------- */
var attendance_dayType = [
    new COMMON_CODE(null, 'the_day', '참여 구분')
    , new COMMON_CODE('all', '-1', '참여 구분(전체)')
    , new COMMON_CODE('more', '1', '더줘')
    , new COMMON_CODE('yes', '2', '출석')
];

var attendance_searchType = [
    new COMMON_CODE(null, 'searchType', '검색 조건')
    , new COMMON_CODE('all', '-1', '검색 조건(전체)')
    , new COMMON_CODE('crew', '4', '크루표식')
    , new COMMON_CODE('memo', '5', '크루명')
    , new COMMON_CODE('memno', '1', '회원번호')
    , new COMMON_CODE('memid', '2', 'UserID')
    , new COMMON_CODE('memnick', '3', 'User닉네임')
];

/** =------ inssaticon ---------- */
var inssaticon_isUse = [
    new COMMON_CODE(null, 'isUse', '노출여부')
    , new COMMON_CODE('all', '-1', '노출여부(전체)')
    , new COMMON_CODE('0', '0', '비노출')
    , new COMMON_CODE('1', '1', '노출')
];

var inssaticon_category = [
    new COMMON_CODE(null, 'category', '카테고리')
    , new COMMON_CODE('all', '-1', '카테고리(전체)')
];

/** =------ boardAdm ---------- */

var fanBoard_status = [
  new COMMON_CODE(null, 'status', '게시글 상태')
    , new COMMON_CODE('0', 0, '게시글 전체')
    , new COMMON_CODE('1', 1, '정상')
    , new COMMON_CODE('2', 2, '삭제')
];

var searchType_notice = [
    new COMMON_CODE(null, 'searchType_notice', '방송공지')
    , new COMMON_CODE('0', 0, '최근 등록 순으로 보기')
    , new COMMON_CODE('1', 1, '방송공지만 보기')
    , new COMMON_CODE('2', 2, '회원공지만 보기')
    , new COMMON_CODE('3', 3, '오래전 등록 순으로 보기')
];

var searchType_board = [
  new COMMON_CODE(null, 'searchType_board', '게시글 상태')
    , new COMMON_CODE('0', 0, '최근 등록 순으로 보기')
    , new COMMON_CODE('1', 1, '댓글 많은 수 부터 보기')
    , new COMMON_CODE('2', 2, '비밀글만 보기')
    , new COMMON_CODE('3', 3, '삭제글만 보기')
];

var searchType_story = [
  new COMMON_CODE(null, 'searchType_story', '사연')
    , new COMMON_CODE('0', 0, '최근 등록 순으로 보기')
    , new COMMON_CODE('1', 1, '받은 사연 많은 회원부터 보기')
    , new COMMON_CODE('2', 2, '보낸 사연 많은 회원부터 보기')
    , new COMMON_CODE('3', 3, '오래전 등록 순으로 보기')
];

var event_giftcon_type = [
    new COMMON_CODE(null, 'gifticon_type', '품목')
    , new COMMON_CODE('all', '-1', '품목구분')
    , new COMMON_CODE('1', 1, '커피')
    , new COMMON_CODE('2', 2, '치킨')
];

/** =------ crew ---------- */

var crew_searchType = [
    new COMMON_CODE(null, 'crewSearchType', '검색구분')
    , new COMMON_CODE('memno', '1', '회원번호')
    , new COMMON_CODE('memid', '2', 'UserID')
    , new COMMON_CODE('memnick', '3', '닉네임')
];


// 방송관리 tip 관리 --------------
var broadTip_objType = [
    new COMMON_CODE(null, 'broadTip_objType', '검색구분')
    , new COMMON_CODE('-1', '-1', '노출대상 전체')
    , new COMMON_CODE('1', '1', 'DJ')
    , new COMMON_CODE('2', '2', '청취자')
    , new COMMON_CODE('3', '3', 'DJ/청취자')
];

var broadTip_objType_detail = [
    new COMMON_CODE(null, 'broadTip_objType_detail', '노출대상')
    , new COMMON_CODE('-1', '-1', '전체')
    , new COMMON_CODE('1', '1', 'DJ')
    , new COMMON_CODE('2', '2', '청취자')
    , new COMMON_CODE('3', '3', 'DJ/청취자')
];

var broadTip_viewType = [
    new COMMON_CODE(null, 'broadTip_viewType', '검색구분')
    , new COMMON_CODE('-1', '-1', '노출여부 전체')
    , new COMMON_CODE('1', '1', 'On')
    , new COMMON_CODE('0', '0', 'Off')
];

/* 룰렛 이벤트 */
var roulette_searchType = [
    new COMMON_CODE(null, 'searchType', '검색구분')
    , new COMMON_CODE('all', '-1', '전체')
    , new COMMON_CODE('memno', '1', '회원번호')
    , new COMMON_CODE('memid', '2', 'UserID')
    , new COMMON_CODE('memnick', '3', '닉네임')
];

var roulette_winType = [
    new COMMON_CODE(null, 'winType', '검색구분')
    , new COMMON_CODE('all', '-1', '전체')
    , new COMMON_CODE('dal', '1', '달')
    , new COMMON_CODE('gifticon', '2', '기프티콘')
];

var content_scheduleWeek = [
    new COMMON_CODE(null, 'content_scheduleWeek', '요일')
    , new COMMON_CODE('all', '-1', '전체')
    , new COMMON_CODE('1', '1', '월')
    , new COMMON_CODE('2', '2', '화')
    , new COMMON_CODE('3', '3', '수')
    , new COMMON_CODE('4', '4', '목')
    , new COMMON_CODE('5', '5', '금')
    , new COMMON_CODE('6', '6', '토')
    , new COMMON_CODE('7', '7', '일')
];

var content_scheduleWeekTime = [
    new COMMON_CODE(null, 'content_scheduleWeekTime', '시간')
    , new COMMON_CODE('0', '0', '종일')
    , new COMMON_CODE('1', '1', '시간 선택')
];

//타임이벤트
var time_event_event_time = [
    new COMMON_CODE(null, 'event_time', '이벤트 시간')
    , new COMMON_CODE('60', '60', '1시간')
    , new COMMON_CODE('30', '30', '30분')
];

var time_event_rate = [
    new COMMON_CODE(null, 'rate', '지급 비율')
    , new COMMON_CODE('5', '5', '5%')
    , new COMMON_CODE('3', '3', '3%')
];

var time_event_rate = [
    new COMMON_CODE(null, 'rate', '지급 비율')
    , new COMMON_CODE('5', '5', '5%')
    , new COMMON_CODE('3', '3', '3%')
];

var time_event_link_yn = [
    new COMMON_CODE(null, 'rate', '링크적용여부')
    , new COMMON_CODE('1', '1', '링크 적용')
];

//마케팅관리
var marketing_search_type = [
    new COMMON_CODE(null, 'searchType', '검색구분')
    , new COMMON_CODE('all', '-1', '전체')
    , new COMMON_CODE('title', '1', '제목')
    , new COMMON_CODE('content', '2', '내용')
]

var marketing_slct_type = [
    new COMMON_CODE(null, 'searchType', '구분')
    , new COMMON_CODE('title', '1', '위클리픽')
    , new COMMON_CODE('content', '2', '15초 광고 모델')
]

//보름달 관리
var full_moon_condition1_slctType = [
    new COMMON_CODE(null, 'slctType', '구분')
    , new COMMON_CODE('1', '1', '방송시간')
    , new COMMON_CODE('2', '2', '누적청취자')
    , new COMMON_CODE('3', '3', '받은 별')
    , new COMMON_CODE('4', '4', '좋아요<br />(구매 부스터 포함)')
]

var full_moon_condition1_values = [
    new COMMON_CODE(null, 'values', '구분')
    , new COMMON_CODE('1', '1', 'broadTime')
    , new COMMON_CODE('2', '2', 'listenerCnt')
    , new COMMON_CODE('3', '3', 'byeolCnt')
    , new COMMON_CODE('4', '4', 'goodPoint')
]

//보름달 관리
var full_moon_condition1_slctType_unit = [
    new COMMON_CODE(null, 'slctType', '단위')
    , new COMMON_CODE('1', '1', '분')
    , new COMMON_CODE('2', '2', '명')
    , new COMMON_CODE('3', '3', '별')
    , new COMMON_CODE('4', '4', '개')
]

var full_moon_condition2_slctType = [
    new COMMON_CODE(null, 'slctType', '구분')
    , new COMMON_CODE('1', '1', '청취자')
    , new COMMON_CODE('2', '2', 'DJ')
]

var full_moon_condition2_reward = [
    new COMMON_CODE(null, 'reward', '보상')
    , new COMMON_CODE('1', '1', '룰렛응모권')
    , new COMMON_CODE('2', '2', '부스터응모권')
]

var full_moon_condition2_slctType_values = [
    new COMMON_CODE(null, 'slctType', '단위')
    , new COMMON_CODE('1', '1', 'djItemCnt')
    , new COMMON_CODE('2', '2', 'listenerItemCnt')
]

var full_moon_condition3_slctType = [
    new COMMON_CODE(null, 'slctType', '구분')
    , new COMMON_CODE('1', '1', '보낸 달')
    , new COMMON_CODE('2', '2', '좋아요')
    , new COMMON_CODE('3', '3', '보름달 완성 시 청취 중')
]

var full_moon_condition3_slctType_unit = [
    new COMMON_CODE(null, 'slctType', '단위')
    , new COMMON_CODE('1', '1', '달')
    , new COMMON_CODE('2', '2', '개')
    , new COMMON_CODE('3', '3', ' ')
]

var full_moon_condition3_slctType_values = [
    new COMMON_CODE(null, 'slctType', '단위')
    , new COMMON_CODE('1', '1', 'minGiftDal')
    , new COMMON_CODE('2', '2', 'minGoodPoint')
    , new COMMON_CODE('3', '3', 'listenYn')
]

var full_moon_condition5_slctType = [
    new COMMON_CODE(null, 'slctType', '구분')
    , new COMMON_CODE('1', '1', '보름날 노출여부')
]

//보름달 문구관리
var full_moon_text_alert_status = [
    new COMMON_CODE(null, 'status', '보름달 상태')
    , new COMMON_CODE('1', '1', '미완성')
    , new COMMON_CODE('2', '2', '완성')
    , new COMMON_CODE('3', '3', '완성')
    , new COMMON_CODE('4', '4', '완성')
    , new COMMON_CODE('5', '5', '완성')
]

var full_moon_text_alert_type = [
    new COMMON_CODE(null, 'type', '구분')
    , new COMMON_CODE('1', '1', '상태창')
    , new COMMON_CODE('2', '2', '상태창')
    , new COMMON_CODE('3', '3', '상태창')
    , new COMMON_CODE('4', '4', '상태창')
    , new COMMON_CODE('5', '5', '알럿')
]

var full_moon_text_alert_target = [
    new COMMON_CODE(null, 'type', '노출 대상')
    , new COMMON_CODE('1', '1', '공통')
    , new COMMON_CODE('2', '2', 'DJ')
    , new COMMON_CODE('3', '3', '조건 충족 청취자')
    , new COMMON_CODE('4', '4', '조건 미충족 청취자')
    , new COMMON_CODE('5', '5', '공통')
]

var full_moon_text_guide_area = [
    new COMMON_CODE(null, 'area', '영역')
    , new COMMON_CODE('6', '6', '1')
    , new COMMON_CODE('7', '7', '2')
    , new COMMON_CODE('8', '8', '3')
]