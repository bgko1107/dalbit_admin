class COMMON_CODE{
    constructor(type, value, code){
        this.type = type;
        this.value = value;
        this.code = code;
    }
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
    , new COMMON_CODE('pc', '2', 'PC')
    , new COMMON_CODE('android', '3', 'Android')
    , new COMMON_CODE('ios', '4', 'IOS')
    , new COMMON_CODE('mobile', '5', 'Web-Mobile')
];

var platform = [
    new COMMON_CODE(null, 'platform', '플랫폼구분')
    , new COMMON_CODE('all', '1', '전체')
    , new COMMON_CODE('pc', '2', 'PC')
    , new COMMON_CODE('android', '3', 'Android')
    , new COMMON_CODE('ios', '4', 'IOS')
    , new COMMON_CODE('mobile', '5', 'Web-Mobile')
];

var gender = [
    new COMMON_CODE(null, 'gender', '성별구분')
    , new COMMON_CODE('all', '1', '전체')
    , new COMMON_CODE('man', '2', '남자')
    , new COMMON_CODE('female', '3', '여자')
    , new COMMON_CODE('unknown', '4', '알수없음')
];

var viewOn = [
    new COMMON_CODE(null, 'viewOn', '게시구분')
    , new COMMON_CODE('all', '-1', '전체')
    , new COMMON_CODE('on', '1', 'ON')
    , new COMMON_CODE('off', '0', 'OFF')
];

var viewType = [
    new COMMON_CODE(null, 'viewType', '링크표시구분')
    , new COMMON_CODE('new', '1', '새 창 열기')
    , new COMMON_CODE('link', '2', '링크이동')
];
var level = [
    new COMMON_CODE('0', '0', '0레벨')
    ,new COMMON_CODE('1', '1', '1레벨')
    ,new COMMON_CODE('2', '2', '2레벨')
    ,new COMMON_CODE('3', '3', '3레벨')
    ,new COMMON_CODE('4', '4', '4레벨')
    ,new COMMON_CODE('5', '5', '5레벨')
    ,new COMMON_CODE('6', '6', '6레벨')
    ,new COMMON_CODE('7', '7', '7레벨')
    ,new COMMON_CODE('8', '8', '8레벨')
    ,new COMMON_CODE('9', '9', '9레벨')
];
var grade = [
    new COMMON_CODE('0',  '0',        '0 단계')
    ,new COMMON_CODE('6',  '51',      '1 단계')
    ,new COMMON_CODE('11', '1298',    '2 단계')
    ,new COMMON_CODE('15', '2869',    '3 단계')
];


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
