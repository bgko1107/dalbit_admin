var PAGING_INFO = function(totalCnt, pageNo, pageCnt){
    this.totalCnt = common.isEmpty(totalCnt) ? 0 : totalCnt;
    this.pageNo = common.isEmpty(pageNo) ? 1 : pageNo;
    this.pageCnt = common.isEmpty(pageCnt) ? 10 : pageCnt;
};

var INFOREX_MENU = function(id, depth, name, url){
    this.id = id;
    this.depth = depth;
    this.name = name;
    this.url = url;
};

var COMMON_CODE = function(type, value, code){
    this.type = type;
    this.value = value;
    this.code = code;
};

var searchType = [
    new COMMON_CODE(null, 'searchType', '사용자정보구분')
    , new COMMON_CODE('all', '-1', '전체')
    , new COMMON_CODE('memno', '1', '회원번호')
    , new COMMON_CODE('memname', '2', '이름')      //휴대폰 인증 적용후
    , new COMMON_CODE('memid', '3', 'UserID')
    , new COMMON_CODE('memnick', '4', '닉네임')
    , new COMMON_CODE('memphone', '5', '연락처')
];

var search_platform = [
    new COMMON_CODE(null, 'platform', '플랫폼구분')
    , new COMMON_CODE('all', '', '전체')
    , new COMMON_CODE('PC', 'PC', 'PC')
    , new COMMON_CODE('Android', 'Android', 'Android')
    , new COMMON_CODE('IOS', 'IOS', 'IOS')
    , new COMMON_CODE('Web-Mobile', 'Web-Mobile', 'Web-Mobile')
];

var platform = [
    new COMMON_CODE(null, 'platform', '플랫폼구분')
    , new COMMON_CODE('all', '1', '전체')
    , new COMMON_CODE('pc', '2', 'PC')
    , new COMMON_CODE('android', '3', 'Android')
    , new COMMON_CODE('ios', '4', 'IOS')
    , new COMMON_CODE('mobile', '5', 'Web-Mobile')
];

var platformGroup = [
    new COMMON_CODE(null, 'platformGroup', '플랫폼그룹구분')
    , new COMMON_CODE('all', '1', '전체')
    , new COMMON_CODE('pc', '2', 'PC')
    , new COMMON_CODE('mobile', '3', 'Mobile')
    , new COMMON_CODE('pc-mobile', '4', 'PC/Mobile')
];

var os_type = [
    new COMMON_CODE(null, 'os_type', 'OS타입')
    , new COMMON_CODE('1', '1', 'Android')
    , new COMMON_CODE('2', '2', 'IOS')
    , new COMMON_CODE('3', '3', 'PC')
];

var progressStatus = [
    new COMMON_CODE(null, 'progressStatus', '진행여부')
    , new COMMON_CODE('all', '1', '전체')
    , new COMMON_CODE('wait', '2', '대기중')
    , new COMMON_CODE('proceeding', '3', '진행중')
    , new COMMON_CODE('end', '4', '마감')
];

var gender = [
    new COMMON_CODE(null, 'gender', '성별구분')
    , new COMMON_CODE('all', '1', '전체')
    , new COMMON_CODE('man', '2', '<label class="font-bold" style="color: blue">남성</label>')
    , new COMMON_CODE('female', '3', '<label class="font-bold" style="color: red">여성</label>')
    // , new COMMON_CODE('unknown', '-1', '알수없음')
];

var memSex = [
    new COMMON_CODE(null, 'memSex', '성별구분')
    , new COMMON_CODE('man', 'm', '<label class="font-bold" style="color: blue">남성</label>')
    , new COMMON_CODE('female', 'f', '<label class="font-bold" style="color: red">여성</label>')
    , new COMMON_CODE('unknown', 'n', '알수없음')
];

var viewOn = [
    new COMMON_CODE(null, 'viewOn', '게시구분')
    , new COMMON_CODE('all', '-1', '전체')
    , new COMMON_CODE('on', '1', 'ON')
    , new COMMON_CODE('off', '0', 'OFF')
];

var viewType = [
    new COMMON_CODE(null, 'viewType', '링크표시구분')
    , new COMMON_CODE('link', '0', '링크이동')
    , new COMMON_CODE('new', '1', '새 창 열기')
];

var level = [
    new COMMON_CODE(null, 'level', '레벨')
    ,new COMMON_CODE('all', '-1', '전체')
    ,new COMMON_CODE('0', '0', '0레벨')
    ,new COMMON_CODE('1', '1', '1레벨')
    ,new COMMON_CODE('2', '2', '2레벨')
    ,new COMMON_CODE('3', '3', '3레벨')
    ,new COMMON_CODE('4', '4', '4레벨')
    ,new COMMON_CODE('5', '5', '5레벨')
    ,new COMMON_CODE('6', '6', '6레벨')
    ,new COMMON_CODE('7', '7', '7레벨')
    ,new COMMON_CODE('8', '8', '8레벨')
    ,new COMMON_CODE('9', '9', '9레벨')
    ,new COMMON_CODE('10', '10', '10레벨')
    ,new COMMON_CODE('11', '11', '11레벨')
    ,new COMMON_CODE('12', '12', '12레벨')
    ,new COMMON_CODE('13', '13', '13레벨')
    ,new COMMON_CODE('14', '14', '14레벨')
    ,new COMMON_CODE('15', '15', '15레벨')
    ,new COMMON_CODE('16', '16', '16레벨')
    ,new COMMON_CODE('17', '17', '17레벨')
    ,new COMMON_CODE('18', '18', '18레벨')
    ,new COMMON_CODE('19', '19', '19레벨')
    ,new COMMON_CODE('20', '20', '20레벨')
    ,new COMMON_CODE('21', '21', '21레벨')
    ,new COMMON_CODE('22', '22', '22레벨')
    ,new COMMON_CODE('23', '23', '23레벨')
    ,new COMMON_CODE('24', '24', '24레벨')
    ,new COMMON_CODE('25', '25', '25레벨')
    ,new COMMON_CODE('26', '26', '26레벨')
    ,new COMMON_CODE('27', '27', '27레벨')
    ,new COMMON_CODE('28', '28', '28레벨')
    ,new COMMON_CODE('29', '29', '29레벨')
    ,new COMMON_CODE('30', '30', '30레벨')
    ,new COMMON_CODE('31', '31', '31레벨')
    ,new COMMON_CODE('32', '32', '32레벨')
    ,new COMMON_CODE('33', '33', '33레벨')
    ,new COMMON_CODE('34', '34', '34레벨')
    ,new COMMON_CODE('35', '35', '35레벨')
    ,new COMMON_CODE('36', '36', '36레벨')
    ,new COMMON_CODE('37', '37', '37레벨')
    ,new COMMON_CODE('38', '38', '38레벨')
    ,new COMMON_CODE('39', '39', '39레벨')
    ,new COMMON_CODE('40', '40', '40레벨')
    ,new COMMON_CODE('41', '41', '41레벨')
    ,new COMMON_CODE('42', '42', '42레벨')
    ,new COMMON_CODE('43', '43', '43레벨')
    ,new COMMON_CODE('44', '44', '44레벨')
    ,new COMMON_CODE('45', '45', '45레벨')
    ,new COMMON_CODE('46', '46', '46레벨')
    ,new COMMON_CODE('47', '47', '47레벨')
    ,new COMMON_CODE('48', '48', '48레벨')
    ,new COMMON_CODE('49', '49', '49레벨')
    ,new COMMON_CODE('50', '50', '50레벨')
    ,new COMMON_CODE('51', '51', '51레벨')
    ,new COMMON_CODE('52', '52', '52레벨')
    ,new COMMON_CODE('53', '53', '53레벨')
    ,new COMMON_CODE('54', '54', '54레벨')
    ,new COMMON_CODE('55', '55', '55레벨')
    ,new COMMON_CODE('56', '56', '56레벨')
    ,new COMMON_CODE('57', '57', '57레벨')
    ,new COMMON_CODE('58', '58', '58레벨')
    ,new COMMON_CODE('59', '59', '59레벨')
    ,new COMMON_CODE('60', '60', '60레벨')
    ,new COMMON_CODE('61', '61', '61레벨')
    ,new COMMON_CODE('62', '62', '62레벨')
    ,new COMMON_CODE('63', '63', '63레벨')
    ,new COMMON_CODE('64', '64', '64레벨')
    ,new COMMON_CODE('65', '65', '65레벨')
    ,new COMMON_CODE('67', '67', '67레벨')
    ,new COMMON_CODE('68', '68', '68레벨')
    ,new COMMON_CODE('69', '69', '69레벨')
    ,new COMMON_CODE('70', '70', '70레벨')
    ,new COMMON_CODE('71', '71', '71레벨')
    ,new COMMON_CODE('72', '72', '72레벨')
    ,new COMMON_CODE('73', '73', '73레벨')
    ,new COMMON_CODE('74', '74', '74레벨')
    ,new COMMON_CODE('75', '75', '75레벨')
    ,new COMMON_CODE('76', '76', '76레벨')
    ,new COMMON_CODE('77', '77', '77레벨')
    ,new COMMON_CODE('78', '78', '78레벨')
    ,new COMMON_CODE('79', '79', '79레벨')
    ,new COMMON_CODE('80', '80', '80레벨')
    ,new COMMON_CODE('81', '81', '81레벨')
    ,new COMMON_CODE('82', '82', '82레벨')
    ,new COMMON_CODE('83', '83', '83레벨')
    ,new COMMON_CODE('84', '84', '84레벨')
    ,new COMMON_CODE('85', '85', '85레벨')
    ,new COMMON_CODE('86', '86', '86레벨')
    ,new COMMON_CODE('87', '87', '87레벨')
    ,new COMMON_CODE('88', '88', '88레벨')
    ,new COMMON_CODE('89', '89', '89레벨')
    ,new COMMON_CODE('90', '90', '90레벨')
    ,new COMMON_CODE('91', '91', '91레벨')
    ,new COMMON_CODE('92', '92', '92레벨')
    ,new COMMON_CODE('93', '93', '93레벨')
    ,new COMMON_CODE('94', '94', '94레벨')
    ,new COMMON_CODE('95', '95', '95레벨')
    ,new COMMON_CODE('96', '96', '96레벨')
    ,new COMMON_CODE('97', '97', '97레벨')
    ,new COMMON_CODE('98', '98', '98레벨')
    ,new COMMON_CODE('99', '99', '99레벨')
];

var grade = [
    new COMMON_CODE(null, 'grade', '단계')
    ,new COMMON_CODE('0','0','0')
    ,new COMMON_CODE('2','씨앗','씨앗')
    ,new COMMON_CODE('4','새싹','새싹')
    ,new COMMON_CODE('6','풀','풀')
    ,new COMMON_CODE('8','줄기','줄기')
    ,new COMMON_CODE('10','당근','당근')
    ,new COMMON_CODE('12','나무당근','나무당근')
    ,new COMMON_CODE('14','쇠당근','쇠당근')
    ,new COMMON_CODE('16','동당근','동당근')
    ,new COMMON_CODE('18','은당근','은당근')
    ,new COMMON_CODE('20','황금당근','황금당근')
    ,new COMMON_CODE('22','나무메달','나무메달')
    ,new COMMON_CODE('24','쇠메달','쇠메달')
    ,new COMMON_CODE('26','동메달','동메달')
    ,new COMMON_CODE('28','은메달','은메달')
    ,new COMMON_CODE('30','황금데달','황금데달')
    ,new COMMON_CODE('32','나무트로피','나무트로피')
    ,new COMMON_CODE('34','쇠트로피','쇠트로피')
    ,new COMMON_CODE('36','동트로피','동트로피')
    ,new COMMON_CODE('38','은트로피','은트로피')
    ,new COMMON_CODE('40','황금트로피','황금트로피')
    ,new COMMON_CODE('42','나무왕관','나무왕관')
    ,new COMMON_CODE('44','쇠왕관','쇠왕관')
    ,new COMMON_CODE('46','동왕관','동왕관')
    ,new COMMON_CODE('48','은왕관','은왕관')
    ,new COMMON_CODE('50','황금왕관','황금왕관')
];

var browser = [
    new COMMON_CODE(null, 'browser', 'Browser ')
    ,new COMMON_CODE('all',  '-1','전체')
    ,new COMMON_CODE('c',  '0','chrome')
    ,new COMMON_CODE('i', '1','Internet Explorer')
    ,new COMMON_CODE('f', '2','Firefox')
];

var search_browser = [
    new COMMON_CODE(null, 'browser', 'Browser ')
    ,new COMMON_CODE('all',  '','전체')
    ,new COMMON_CODE('c',  'chrome','chrome')
    ,new COMMON_CODE('i', 'Internet Explorer','Internet Explorer')
    ,new COMMON_CODE('f', 'Firefox','Firefox')
];

var question_type = [
    new COMMON_CODE(null, 'question_type', '문의유형')
    ,new COMMON_CODE('all','-1','전체')
    ,new COMMON_CODE('meminfo','1','회원정보')
    ,new COMMON_CODE('broad','2','방송하기')
    ,new COMMON_CODE('listen','3','청취하기')
    ,new COMMON_CODE('pay','4','결제')
    ,new COMMON_CODE('suggestion','5','건의하기')
    ,new COMMON_CODE('error','6','장애/버그')
    ,new COMMON_CODE('gift','7','선물/아이템')
    ,new COMMON_CODE('etc','99','기타')
];

var broadcastSubjectType = [
    new COMMON_CODE(null, 'subject_type', '방송주제')
    , new COMMON_CODE('all', '', '전체')
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

var searchFormRadio = [
    new COMMON_CODE('', 'searchFormRadio', '날짜선택')
    , new COMMON_CODE('0', '0', '한달')
    , new COMMON_CODE('1', '1', '일주일')
    , new COMMON_CODE('2', '2', '날짜선택')
];


// 검색 통합 code --------------------------
var searchMember = [
    new COMMON_CODE('', 'searchMember', '회원 검색')
    , new COMMON_CODE('1', '1', '회원 번호')
    , new COMMON_CODE('2', '2', '회원 닉네임')
    , new COMMON_CODE('3', '3', '이름')
    , new COMMON_CODE('4', '4', '연락처')
    , new COMMON_CODE('5', '5', '아이디')
    , new COMMON_CODE('6', '6', 'IP')
    , new COMMON_CODE('7', '7', '모바일ID')
];

var searchBroad = [
    new COMMON_CODE('', 'searchBroad', '방송 검색')
    , new COMMON_CODE('1', '1', '방송 번호')
    , new COMMON_CODE('2', '2', '방송 제목')
];

var searchMail = [
    new COMMON_CODE('', 'searchMail', '우체통 검색')
    , new COMMON_CODE('1', '1', '우체통 번호')
];

var searchClip = [
    new COMMON_CODE('', 'searchClip', '클립 검색')
    , new COMMON_CODE('1', '1', '클립 제목')
    , new COMMON_CODE('2', '2', '클립 번호')
];

var searchQna = [
    new COMMON_CODE('', 'searchQna', '1:1 문의 검색')
    , new COMMON_CODE('1', '1', '문의 제목')
    , new COMMON_CODE('2', '2', '문의 내용')
];

var searchMarketing = [
    new COMMON_CODE('', 'searchMarketing', '마케팅 게시판 검색')
    , new COMMON_CODE('1', '1', '마케팅 제목')
];

var searchTerms = [
    new COMMON_CODE('', 'searchTerms', '약관 검색')
    , new COMMON_CODE('1', '1', '약관 명')
];

var searchNotice = [
    new COMMON_CODE('', 'searchNotice', '공지사항 검색')
    , new COMMON_CODE('1', '1', '공지 제목')
];

var searchItem = [
    new COMMON_CODE('', 'searchItem', '아이템 관리 검색')
    , new COMMON_CODE('1', '1', '아이템명')
    , new COMMON_CODE('2', '2', '상품코드')
];

var searchBroadTip = [
    new COMMON_CODE('', 'searchBroadTip', '방송 Tip 검색')
    , new COMMON_CODE('1', '1', 'Tip 내용')
    , new COMMON_CODE('2', '2', '수정자명')
];

var searchBroadMsg = [
    new COMMON_CODE('', 'searchBroadMsg', '방송 메시지 검색')
    , new COMMON_CODE('1', '1', '메시지 제목')
];

// -------------------------------------------------------------

var timeHour = getTimeHour();

function getTimeHour() {

    var timeHour = [new COMMON_CODE(null, 'timeHour', '시')];

    for (var i = 0; i < 24; i++) {
        var value = common.fillzero(i, 2);
        timeHour.push(new COMMON_CODE(value, value, value));
    }

    return timeHour;
}

var timeMinute = getTimeMinute();

function getTimeMinute() {

    var timeMinute = [new COMMON_CODE(null, 'timeMinute', '분')];

    for(var i=0; i<60; i++){
        var value = common.fillzero(i, 2);
        timeMinute.push(new COMMON_CODE(value, value, value));
    }

    return timeMinute;
}

