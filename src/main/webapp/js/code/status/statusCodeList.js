var zoneDate = [
    new COMMON_CODE(null, 'zoneDate', '시간대별')
    , new COMMON_CODE('time', '0', '시간대 별')
    , new COMMON_CODE('day', '1', '일자 별')
    , new COMMON_CODE('month', '2', '월 별')
];
var levelFilter = [
    new COMMON_CODE(null, 'levelFilter', '레벨filter')
    , new COMMON_CODE('level', '0', '레벨 순위로 보기')
    , new COMMON_CODE('service', '1', '서비스 순위로 보기')
];

var giftSort = [
    new COMMON_CODE(null, 'giftSort', '방송현황 선물내역정렬')
    , new COMMON_CODE('0', '0', '최근 구매 순으로')
    , new COMMON_CODE('1', '1', '아이템 구매달 많은 순으로')
];

/*================ 앱버전현황 ===================*/
var appVersion_platform = [
    new COMMON_CODE(null, 'platform', '플랫폼')
    , new COMMON_CODE('all', 0, '전체')
    , new COMMON_CODE('aos', 1, 'AOS')
    , new COMMON_CODE('ios', 2, 'IOS')
];