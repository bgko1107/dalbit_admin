var subject_type = [
    new COMMON_CODE(null, 'subject_type', '방송 주제')
    , new COMMON_CODE('00', '00', '일상')
    , new COMMON_CODE('01', '01', '수다/챗')
    , new COMMON_CODE('02', '02', '노래/연주')
    , new COMMON_CODE('03', '03', '노래방')
    , new COMMON_CODE('04', '04', '책/스토리')
    , new COMMON_CODE('05', '05', '여행')
    , new COMMON_CODE('06', '06', '힐링')
    , new COMMON_CODE('07', '07', '고민/사연')
    , new COMMON_CODE('08', '08', '사랑/우정')
    , new COMMON_CODE('09', '09', 'ASMR')
    , new COMMON_CODE('10', '10', '유머')
    , new COMMON_CODE('11', '11', '스터디')
    , new COMMON_CODE('13', '13', '성우')
    , new COMMON_CODE('14', '14', '연애/오락')
    , new COMMON_CODE('15', '15', '먹방/요리')
    , new COMMON_CODE('16', '16', '건강/스포츠')
    , new COMMON_CODE('17', '17', '게임')
    , new COMMON_CODE('19', '19', '드라마/영화')
    , new COMMON_CODE('20', '20', '외국어')
    , new COMMON_CODE('21', '21', '판매/영업')
    , new COMMON_CODE('99', '99', '기타')
];

var entryType = [
    new COMMON_CODE(null, 'entryType', '입장제한')
    , new COMMON_CODE('all', '0', '전체')
    , new COMMON_CODE('fan', '1', '팬만입장')
    , new COMMON_CODE('entry', '2', '20세이상')
];

var searchRadio = [
    new COMMON_CODE(null, 'searchRadio', '검색Radio')
    , new COMMON_CODE('member', '1', '회원')
    , new COMMON_CODE('broad', '2', '방송')
];

var freezing = [
    new COMMON_CODE(null, 'freezing', '얼리기')
    , new COMMON_CODE('freezing', '2', '얼리기')
    , new COMMON_CODE('release', '0', '해제')
];

var forcedExit = [
    new COMMON_CODE(null, 'forcedExit', '방강제종료')
    , new COMMON_CODE('maintain', '0', '유지')
    , new COMMON_CODE('forcedExit', '1', '강제종료')
];

var searchType_broad = [
    new COMMON_CODE(null, 'searchType_broad', '사용자정보구분')
    , new COMMON_CODE('all', '0', '전체')
    , new COMMON_CODE('memno', '1', '회원번호')
    , new COMMON_CODE('memid', '2', 'UserID')
    , new COMMON_CODE('memnick', '3', '닉네임')
    , new COMMON_CODE('memphone', '4', '연락처')
    , new COMMON_CODE('memname', '5', '이름')
];

var searchBroad_broad = [
    new COMMON_CODE(null, 'searchBroad_broad', '방송정보검색')
    , new COMMON_CODE('all', '0', '전체')
    , new COMMON_CODE('broadTitle', '1', '방송제목')
    , new COMMON_CODE('welcomMsg', '2', '인사말')
    , new COMMON_CODE('broadNotie', '3', '방송중공지')
    , new COMMON_CODE('roomNo', '4', '방송방번호')
];

var state = [
    new COMMON_CODE(null, 'state', '상태')
    , new COMMON_CODE('all', '-1', '전체')
    , new COMMON_CODE('0', '0', '청취중')
    , new COMMON_CODE('1', '1', '퇴장')
    , new COMMON_CODE('2', '2', '강제퇴장')
    , new COMMON_CODE('3', '3', '접속이상')
];

var djOs = [
    new COMMON_CODE(null, 'djOs', 'djOs')
    , new COMMON_CODE('0', '1', 'android')
    , new COMMON_CODE('1', '2', 'ios')
    , new COMMON_CODE('2', '3', 'PC')
];

var room_state = [
    new COMMON_CODE(null, 'room_state', '방송상태')
    , new COMMON_CODE('0', '0', 'Ant끊김')
    , new COMMON_CODE('1', '1', '방송중(Mic On)')
    , new COMMON_CODE('2', '2', '방송준비중(Mic Off)')
    , new COMMON_CODE('3', '3', '통화중')
    , new COMMON_CODE('4', '4', '방송종료')
    , new COMMON_CODE('5', '5', 'DJ비정상종료')
    , new COMMON_CODE('6', '6', '방송준비중(미디어서버 접속 전)')
];

var searchRoom_state = [
    new COMMON_CODE(null, 'searchRoom_state', '방송상태')
    , new COMMON_CODE('-1', '-1', '전체')
    , new COMMON_CODE('0', '1', '진행중')
    , new COMMON_CODE('4', '2', '종료')
];

var liveSort = [
    new COMMON_CODE(null, 'liveSort', '실시간방송정렬')
    , new COMMON_CODE('0', '0', '현재 실시간방송 순으로')
    , new COMMON_CODE('7', '7', '보름달 완료 방송')
    , new COMMON_CODE('1', '1', '최근 방송시작 순으로')
    , new COMMON_CODE('2', '2', '진행시간 오래된 순으로')
    , new COMMON_CODE('3', '3', '청취자 많은 순으로')
    , new COMMON_CODE('4', '4', '청취자 적은 순으로')
    , new COMMON_CODE('5', '5', '선물 건 수 많이 받은 순으로')
    , new COMMON_CODE('6', '6', '선물 별 수 많이 받은 순으로')
];

var endSort = [
    new COMMON_CODE(null, 'endSort', '실시간방송정렬')
    , new COMMON_CODE('0', '0', '최근 방송 종료 순으로')
    , new COMMON_CODE('7', '7', '보름달 완료 방송')
    , new COMMON_CODE('2', '2', '진행시간 오래된 순으로')
    , new COMMON_CODE('3', '3', '청취자 많은 순으로')
    , new COMMON_CODE('4', '4', '청취자 적은 순으로')
    , new COMMON_CODE('5', '5', '선물 건 수 많이 받은 순으로')
    , new COMMON_CODE('6', '6', '선물 별 수 많이 받은 순으로')
];


var liveListenSort = [
    new COMMON_CODE(null, 'liveListenSort', '실시간청취자')
    , new COMMON_CODE('0', '0', '최근 청취자 순으로')
    , new COMMON_CODE('1', '1', '청취시간 많은 순으로')
    , new COMMON_CODE('2', '2', '청취시작 오래된 순으로')
    , new COMMON_CODE('3', '3', '좋아요 수가 많은 순으로')
    , new COMMON_CODE('4', '4', '선물 수가 많은 순으로')
    , new COMMON_CODE('5', '5', '청취자만')
    , new COMMON_CODE('6', '6', '매니저만')
    , new COMMON_CODE('7', '7', '게스트만')
];

var liveGuest = [
    new COMMON_CODE(null, 'liveGuest', '실시간/종료게스트')
    , new COMMON_CODE('0', '0', '최근 게스트 참여 순')
    , new COMMON_CODE('1', '1', '연결시간 많은 순')
    , new COMMON_CODE('2', '2', '게스트 참여 오래된 순')
    , new COMMON_CODE('3', '3', '선물 수 많은 순')
    , new COMMON_CODE('4', '4', '선물 별 많은 순')
];

// ------------------------- table -----------------------------
var listen_summary = [
    new COMMON_CODE('','listenerCnt','청취자 수')
    // ,new COMMON_CODE('','noMemCnt','비회원 참여 수')
    ,new COMMON_CODE('','totalGuestCnt','게스트 수')
    ,new COMMON_CODE('','managerCnt','매니저 수')
    ,new COMMON_CODE('','forcedCnt','강제퇴장 수')
    ,new COMMON_CODE('','totalGoodCnt','좋아요 수')
    ,new COMMON_CODE('','totalBoosterCnt','부스터 수')
    ,new COMMON_CODE('','totalGiftCnt','선물 수')
    ,new COMMON_CODE('','totalCompleteMoonCnt','보름달 공헌 인원')
];

var guest_summary = [
    new COMMON_CODE('','totalCnt','연결횟수')
    ,new COMMON_CODE('','totalSexM','연결인원')
    ,new COMMON_CODE('','totalAirTime','게스트 방송시간')
    ,new COMMON_CODE('','totalGiftCnt','받은 선물')
];

var like_summary = [
    new COMMON_CODE('','goodCnt','좋아요')
    ,new COMMON_CODE('','boosterCnt','청취자 부스터')
];

var chat_summary = [
    new COMMON_CODE('','chatCnt','채팅참여자')
    ,new COMMON_CODE('','djCnt','달D')
    ,new COMMON_CODE('','listenerCnt',': 청취자')
    ,new COMMON_CODE('','guest',': 게스트')
    ,new COMMON_CODE('','managerCnt',': 매니저')
    ,new COMMON_CODE('','forcedCnt','강제퇴장자')
];

var broadcast_state = [
    new COMMON_CODE('','state','방송방상태')
    ,new COMMON_CODE('0','0','미디어서버비정상')
    ,new COMMON_CODE('1','1','방송중')
    ,new COMMON_CODE('2','2','mic off')
    ,new COMMON_CODE('3','3','통화중')
    ,new COMMON_CODE('4','4','방송종료')
    ,new COMMON_CODE('5','5','DJ비정상종료')
    ,new COMMON_CODE('6','6','방송준비중')
]

var broadcast_state_icon = [
    new COMMON_CODE('','state','방송방상태')
    ,new COMMON_CODE('1','1','<i class="fa fa-play-circle fa-2x"></i>')
    ,new COMMON_CODE('2','2','<i class="fa fa-microphone-slash fa-2x"></i>')
    ,new COMMON_CODE('3','3','<i class="fa fa-phone-volume fa-2x"></i>')
    ,new COMMON_CODE('4','4','<i class="fa fa-stop-circle fa-2x"></i>')
    ,new COMMON_CODE('5','5','<i class="fa fa-exclamation-triangle fa-2x"></i>')
]

//----------------massage---------------------

var entryType_Message = [
    new COMMON_CODE(null, 'entry_message', '조치메시지')
    , new COMMON_CODE('msg1', '1', '회원에 의한 요청 시')
    , new COMMON_CODE('msg2', '2', '연령에 맞지 않은 방송방 처리 시')
    , new COMMON_CODE('msg3', '3', '방송DJ의 컨트롤 불가 사항 시')
    , new COMMON_CODE('msg99', '99', '기타 운영자 직접작성')
];

var freezeMsg_Message = [
    new COMMON_CODE(null, 'entry_message', '조치메시지')
    , new COMMON_CODE('msg1', '1', '회원에 의한 요청 시')
    , new COMMON_CODE('msg2', '2', '도배성 글에 대한 처리 시')
    , new COMMON_CODE('msg3', '3', '방송DJ의 컨트롤 불가 사항 시')
    , new COMMON_CODE('msg99', '99', '기타 운영자 직접작성')
];

var forceExit_Message = [
    new COMMON_CODE(null, 'entry_message', '조치메시지')
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

var guestProposeState = [
    new COMMON_CODE(null, 'guestProposeState', '게스트 신청 상태')
    ,new COMMON_CODE('0', '0', '게스트 신청 취소')
    ,new COMMON_CODE('1', '1', '게스트 신청')
    ,new COMMON_CODE('2', '2', '게스트 초대')
    ,new COMMON_CODE('3', '3', '게스트 초대 취소')
    ,new COMMON_CODE('4', '4', '게스트 지정')
    ,new COMMON_CODE('5', '5', '게스트 지정 취소')
];

var inAppItem = [
    new COMMON_CODE(null, 'payItem', '아이템구분')
    , new COMMON_CODE(-1, '-1', '아이템 ▽')
    , new COMMON_CODE('com.dalbitlive.inapp.dal.9', 'com.dalbitlive.inapp.dal.9', '달 9')
    , new COMMON_CODE('com.dalbitlive.inapp.dal.45', 'com.dalbitlive.inapp.dal.45', '달 45')
    , new COMMON_CODE('com.dalbitlive.inapp.dal.92', 'com.dalbitlive.inapp.dal.92', '달 92')
    , new COMMON_CODE('com.dalbitlive.inapp.dal.100', 'com.dalbitlive.inapp.dal.100', '달 200')
    , new COMMON_CODE('com.dalbitlive.inapp.dal.420', 'com.dalbitlive.inapp.dal.420', '달 500')
    , new COMMON_CODE('com.dalbitlive.inapp.dal.838', 'com.dalbitlive.inapp.dal.838', '달 838')
    , new COMMON_CODE('com.dalbitlive.inapp.dal.1531', 'com.dalbitlive.inapp.dal.1531', '달 1530')
    , new COMMON_CODE('com.dalbitlive.inapp.dal.2300', 'com.dalbitlive.inapp.dal.2300', '달 2300')
    , new COMMON_CODE('com.dalbitlive.inapp.dal.3770', 'com.dalbitlive.inapp.dal.3770', '달 3770')
];

var elseItem = [
    new COMMON_CODE(null, 'payItem', '아이템구분')
    , new COMMON_CODE(-1, '-1', '아이템 ▽')
    , new COMMON_CODE('A1070', 'A1070', '달 10')
    , new COMMON_CODE('A1865', 'A1865', '달 50')
    , new COMMON_CODE('A1335', 'A1335', '달 100')
    , new COMMON_CODE('A1555', 'A1555', '달 300')
    , new COMMON_CODE('A1227', 'A1227', '달 500')
    , new COMMON_CODE('A1738', 'A1738', '달 1000')
    , new COMMON_CODE('A1233', 'A1233', '달 3000')
    , new COMMON_CODE('A1999', 'A1999', '달 5000')
    , new COMMON_CODE('A1342', 'A1342', '달 10000')
];

var behavior_target = [
    new COMMON_CODE(null, 'target', '노출대상')
    , new COMMON_CODE('1', '1', '청취자')
    // 추후에 추가 될 수 있음
];

var behavior_type = [
    new COMMON_CODE(null, 'type', '타입')
    , new COMMON_CODE('1', '1', '선물함')
    , new COMMON_CODE('2', '2', '사연')
    , new COMMON_CODE('3', '3', '팬등록')
    , new COMMON_CODE('4', '4', '좋아요')
];

var behavior_viewYn = [
    new COMMON_CODE(null, 'viewYn', '노출여부')
    , new COMMON_CODE('off', '0', 'Off')
    , new COMMON_CODE('on', '1', 'On')
];

var behavior_target_search = [
    new COMMON_CODE(null, 'target', '노출대상')
    , new COMMON_CODE('all', -1, '노출대상(전체)')
    , new COMMON_CODE('1', 1, '청취자')
    // 추후에 추가 될 수 있음
];

var behavior_viewYn_search = [
    new COMMON_CODE(null, 'viewYn', '노출여부')
    , new COMMON_CODE('all', -1, '노출여부(전체)')
    , new COMMON_CODE('off', 2, 'Off')
    , new COMMON_CODE('on', 1, 'On')
];