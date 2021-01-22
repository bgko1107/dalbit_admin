
/** =------ Declaration ---------- */
var declaration_searchType = [
    new COMMON_CODE(null, 'searchType', '검색 조건')
    , new COMMON_CODE('all', '-1', '검색 조건(전체)')
    , new COMMON_CODE('memno', '1', '회원번호')
    , new COMMON_CODE('memid', '2', 'UserID')
    , new COMMON_CODE('memnick', '3', 'User닉네임')
    , new COMMON_CODE('phone', '4', '연락처')
];

var declaration_slctType = [
    new COMMON_CODE(null, 'slctType', '제재 조치')
    , new COMMON_CODE('all', '-1', '제재 조치(전체)')
    , new COMMON_CODE('not', '0', '미처리')
    , new COMMON_CODE('continue', '1', '확인완료')
    , new COMMON_CODE('warning', '2', '경고')
    , new COMMON_CODE('stop1', '3', '1일정지')
    , new COMMON_CODE('stop3', '4', '3일정지')
    , new COMMON_CODE('stop7', '5', '7일정지')
    , new COMMON_CODE('withdrawal', '6', '영구정지')
    , new COMMON_CODE('forcedOut', '7', '강제탈퇴')
    , new COMMON_CODE('pause', '8', '임시정지')
];

var declaration_opCode = [
    new COMMON_CODE(null, 'slctType', '제재 조치')
    , new COMMON_CODE('all', '-1', '제재 조치(전체)')
    , new COMMON_CODE('not', '0', '미처리')
    , new COMMON_CODE('continue', '1', '확인완료')
    , new COMMON_CODE('warning', '2', '경고')
    , new COMMON_CODE('stop1', '3', '1일정지')
    , new COMMON_CODE('stop3', '4', '3일정지')
    , new COMMON_CODE('stop7', '5', '7일정지')
    , new COMMON_CODE('withdrawal', '6', '영구정지')
    //, new COMMON_CODE('forcedOut', '7', '강제탈퇴')
    , new COMMON_CODE('pause', '8', '임시정지')     //mem_state는 영구정지와 같게하고 block_type을 1로 한다.
];

var declaration_reason = [
    new COMMON_CODE(null, 'slctReason', '신고 구분')
    , new COMMON_CODE('all', '-1', '신고 구분(전체)')
    , new COMMON_CODE('profile', '1', '이미지')
    , new COMMON_CODE('obs', '2', '음란성')
    , new COMMON_CODE('adv', '3', '광고 및 상업성')
    , new COMMON_CODE('abuse', '4', '욕설 및 비방성')
    , new COMMON_CODE('nick', '6', '닉네임')
    , new COMMON_CODE('etc', '5', '기타')
    , new COMMON_CODE('admin', '98', '관리자신고')
];

var reportImageSlctType = [
    new COMMON_CODE(null, 'slctType', '이미지 신고 구분')
    , new COMMON_CODE('-1', '-1', '이미지선택(전체)')
    , new COMMON_CODE('0', '0', '우체통')
    , new COMMON_CODE('1', '1', '방송방')
    , new COMMON_CODE('2', '2', '프로필 사진')
];

var block_scope = [
    new COMMON_CODE(null, 'blockScope_', '조치 범위')
    , new COMMON_CODE('mem_no', '3', '아이디(변경x)')
    , new COMMON_CODE('deviceUuid', '1', '디바이스 아이디')
    , new COMMON_CODE('ip', '2', 'ip')
]

var declaration_status = [
    new COMMON_CODE(null, 'status', '처리구분')
    , new COMMON_CODE('all', '-1', '전체')
    , new COMMON_CODE('off', '0', '미처리')
    , new COMMON_CODE('on', '1', '처리완료')
];

var declaration_Message = [
  new COMMON_CODE(null, 'declaration_Message', '조치메시지')
    ,new COMMON_CODE('msg1', '1', '음란, 미풍양속 위배 행위')
    ,new COMMON_CODE('msg2', '2', '지나치게 과도한 욕설과 부적절한 언어를 사용하는 행위')
    ,new COMMON_CODE('msg3', '3', '지나치게 과도한 폭력, 위협, 혐오, 잔혹한 행위 또는 묘사')
    ,new COMMON_CODE('msg4', '4', '불법성 행위 또는 조장')
    ,new COMMON_CODE('msg5', '5', '청소년 유해 활동')
    ,new COMMON_CODE('msg6', '6', '동일한 내용을 반복적으로 등록 (도배)')
    ,new COMMON_CODE('msg7', '7', '상업적 또는 홍보/광고, 악의적인 목적으로 서비스 가입/활동')
    ,new COMMON_CODE('msg8', '8', '차별/갈등 조장 활동 (성별,종교,장애,연령,인종,지역,직업 등)')
    ,new COMMON_CODE('msg9', '9', '서비스 명칭 또는 운영진을 사칭하여 타인을 속이거나 피해와 혼란을 주는 행위')
    ,new COMMON_CODE('msg10', '10', '타인의 개인정보 및 계정, 기기를 도용/탈취하여 서비스를 이용 하는 행위')
    ,new COMMON_CODE('msg11', '11', '타인의 권리침해 및 명예훼손')
    ,new COMMON_CODE('msg12', '12', '다수의 계정을 이용한 어뷰징 활동')
    ,new COMMON_CODE('msg13', '13', '서비스 내 현금 거래')
    ,new COMMON_CODE('msg14', '14', '고의적인 서비스 운영 방해')
    ,new COMMON_CODE('msg15', '15', '연령제한으로 인한 한시적 제재조치')
    ,new COMMON_CODE('msg99', '99', '서비스 자체 기준 위반')
];

var declaration_send = [
    new COMMON_CODE(null, 'declaration_sendNoti', '보내기 구분')
    , new COMMON_CODE('yes', '1', '알림 ON')
    , new COMMON_CODE('no', '0', '알림 OFF')
];

/** =------ Sms ---------- */

var sms_code = [
  new COMMON_CODE(null, 'vxml_file', 'sms구분')
  , new COMMON_CODE('all', '-1', 'SMS구분(전체)')
  , new COMMON_CODE('join', '0', '회원가입')
  , new COMMON_CODE('change', '1', '비밀번호 변경')
  , new COMMON_CODE('exchange_ok', '2', '환전완료')
  , new COMMON_CODE('exchange_cancel', '3', '환전취소')
  , new COMMON_CODE('VA', '4', '가상계좌')
  , new COMMON_CODE('question', '5', '고객센터')
  , new COMMON_CODE('exchange_cancel', '7', '어드민')
  , new COMMON_CODE('etc', '', '기타')
];

var sms_isDirect = [
    new COMMON_CODE(null, 'sendType', '발송 구분')
    , new COMMON_CODE('instant', '0', '즉시발송')
    , new COMMON_CODE('reservation', '1', '예약발송')
];

var sms_msgType = [
    new COMMON_CODE(null, 'msg_type', '발송형태')
    , new COMMON_CODE('sms', '0', 'SMS')
    , new COMMON_CODE('lms', '5', 'LMS')
];

var sms_slctType = [
    new COMMON_CODE(null, 'slctType', '검색 조건')
    , new COMMON_CODE('time', '0', '시간대별')
    , new COMMON_CODE('day', '1', '일자별')
    , new COMMON_CODE('month', '2', '월간별')
];

var sms_status = [
    new COMMON_CODE(null, 'status', '발송상태')
    , new COMMON_CODE('0', '0', '요청')
    , new COMMON_CODE('1', '1', '대기')
    , new COMMON_CODE('2', '2', '완료')
    , new COMMON_CODE('3', '3', '예약')
];


/** =------ Image ---------- */
var declaration_image_searchType = [
    new COMMON_CODE(null, 'searchType', '검색 조건')
    , new COMMON_CODE('all', '-1', '전체')
    , new COMMON_CODE('memno', '1', '회원번호')
    , new COMMON_CODE('memid', '3', 'UserID')
    , new COMMON_CODE('memnick', '4', '닉네임')
    , new COMMON_CODE('memphone', '5', '연락처')
    , new COMMON_CODE('roomNm', '6', '방송제목')
];

var declaration_image_Message = [
    new COMMON_CODE(null, 'declaration_Message', '조치메시지')
    , new COMMON_CODE('msg1','1','상대방에게 불쾌감을 유발하는 성적 표현 및 음란성 이미지')
    , new COMMON_CODE('msg2','2','게임물 내 도박/프리서버/유료 대리랭크를 하거나 이를 홍보하는 이미지')
    , new COMMON_CODE('msg3','3','타인의 개인정보를 유포하는 행위')
    , new COMMON_CODE('msg4','4','저작권침해 (게시물 복제*전송에 대한 신고의 건)')
    , new COMMON_CODE('msg5','5','방송방 내 음란물 게시')
    , new COMMON_CODE('msg6','6','청소년 보호정책에 위배되는 이미지')
    , new COMMON_CODE('msg7','7','의도적이고 선정적인 이미지')
    , new COMMON_CODE('msg99','99','기타')
];