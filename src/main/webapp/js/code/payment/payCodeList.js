var payStatus = [
    new COMMON_CODE(null, 'searchPayStatus', '결제상태')
    , new COMMON_CODE('all', '-1', '구분(전체)')
    , new COMMON_CODE('pay', '1', '결제완료')
    , new COMMON_CODE('cancel', '2', '취소완료')
    , new COMMON_CODE('block', '3', '취소실패')
];

var payPlatform = [
    new COMMON_CODE(null, 'ostype', '검색구분')
    , new COMMON_CODE('all', '-1', 'OS구분 (전체)')
    , new COMMON_CODE('android', '1', 'AOS')
    , new COMMON_CODE('ios', '2', 'IOS')
    , new COMMON_CODE('web', '3', 'WEB')
];

var innerType = [
    new COMMON_CODE(null, 'innerType', '직원여부')
    , new COMMON_CODE('all', '-1', '회원 (전체)')
    , new COMMON_CODE('N', '0', '회원')
    , new COMMON_CODE('Y', '1', '직원')
];

var payWay = [
    new COMMON_CODE(null, 'payWay', '결제수단')
    , new COMMON_CODE('all', 'all', '결제수단 (전체)')
    , new COMMON_CODE('CN', 'CN', '신용카드')
    , new COMMON_CODE('MC', 'MC', '휴대폰')
    , new COMMON_CODE('VA', 'VA', '가상계좌')
    , new COMMON_CODE('InApp', 'InApp', '인앱(IOS)')
    , new COMMON_CODE('payletter', 'cashbee', '캐시비')
    , new COMMON_CODE('payletter', 'tmoney', '티머니')
    , new COMMON_CODE('payletter', 'payco', '페이코')
    , new COMMON_CODE('payletter', 'kakaopay', '카카오페이')
    , new COMMON_CODE('payletter', 'toss', '토스')
    , new COMMON_CODE('GM', 'GM', '문화상품권')
    , new COMMON_CODE('GG', 'GG', '게임문화상품권')
    , new COMMON_CODE('GC', 'GC', '도서문화상품권')
    , new COMMON_CODE('HM', 'HM', '해피머니상품권')
];

var bankList = [
    new COMMON_CODE('003','003','기업은행')
    , new COMMON_CODE('004','004','국민은행')
    , new COMMON_CODE('020','020','우리은행')
    , new COMMON_CODE('026','026','신한은행')
    , new COMMON_CODE('081','081','하나은행')
    , new COMMON_CODE('011','011','농협')
    , new COMMON_CODE('071','071','우체국')
    , new COMMON_CODE('023','023','SC제일은행')
    , new COMMON_CODE('027','027','한국씨티은행')
    , new COMMON_CODE('007','007','수협은행')
    , new COMMON_CODE('032','032','부산은행')
    , new COMMON_CODE('034','034','광주은행')
    , new COMMON_CODE('039','039','경남은행')
    , new COMMON_CODE('031','031','대구은행')
];

var attempSearchType = [
    new COMMON_CODE(null, 'searchType', '검색구분')
    , new COMMON_CODE('all', '', '검색구분(전체)')
    , new COMMON_CODE('mem_no','mem_no','회원번호')
    , new COMMON_CODE('mem_nick','mem_nick','닉네임')
    , new COMMON_CODE('mem_name','mem_name','이름')
    , new COMMON_CODE('product_nm','product_nm','상품명')
]