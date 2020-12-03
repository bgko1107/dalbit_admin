var MarketingDataTableSource = {
    'noticeInfo': {
        'url': '/rest/content/notice/list'

        , 'columns': [
            {'title': '플랫폼', 'data': 'platform', 'name': 'sortPlat', 'render': function (data) {
                    return util.getPlatformName(data) ;
                }}
            , {'title': '구분', 'data': 'slctType', 'name': 'sortSlct', 'render': function (data) {
                    return util.getCommonCodeLabel(data, notice_slctType) ;
                }}
            , {'title': '성별', 'data' : 'gender', 'name': 'sortGender', 'render': function (data) {
                    return util.getCommonCodeLabel(data, gender) ;
                }}
            , {
                'title': '제목', 'data': 'title', 'render': function (data, type, row, meta) {
                    return '<a href="/content/notice/noticeDetail?noticeIdx=' + row.noticeIdx + '&rowNum = ' +row.rowNum+ '" class="_getNoticeDetail"  data-idx ="' + row.noticeIdx+ '">' + data + '</a>'
                }
            }
            , {'title': '등록일시', 'data': 'writeDateFormat'}
            , {'title': '조회수', 'data': 'viewCnt', 'render' : function(data){
                    return common.addComma(data);
                }}
            , {'title': '게시상태', 'data': 'viewOn', 'render': function (data) {
                    return util.renderOnOff(data);
                }}
            , {'title': '바로알림', 'data': '', 'render': function (data) {
                    return '<a href="javascript://" class="_notice">'+'[바로알림]'+'</a>';
                }}
            , {'title': '처리자명', 'data': 'opName'}
            , {'title': 'IOS 심사 중<br />노출여부', 'data': 'iosJudgeViewOn', 'render': function (data) {
                    return util.renderOnOff(data);
                }}
        ]
        , 'comments': ' • 달빛라이브 사이트 내 공지를 등록/수정/삭제할 수 있습니다.'
    },

    'marketingList': {
        'url': '/rest/content/marketing/weekly/list'

        , 'columns': [
            {'title': 'No', 'data': 'rowNum', 'name': 'rowNum', 'render': function (data) {
                    return data;
                }}
            , {'title': '회차', 'data': 'round', 'name': 'round', 'render': function (data) {
                    return data;
                }}
            , {'title': '구분', 'data' : 'slctType', 'name': 'sortGender', 'render': function (data) {
                    return util.getCommonCodeLabel(data, marketing_slct_type) ;
                }}
            , {
                'title': '제목', 'data': 'title', 'render': function (data, type, row, meta) {
                    return '<a href="/content/notice/noticeDetail?noticeIdx=' + row.noticeIdx + '&rowNum = ' +row.rowNum+ '" class="_getNoticeDetail"  data-idx ="' + row.noticeIdx+ '">' + data + '</a>'
                }
            }
            , {'title': '대상1', 'data': 'mem_no1', 'render' : function(data){
                    return data;
                }}
            , {'title': '대상2', 'data': 'mem_no2', 'render' : function(data){
                    return data;
                }}
            , {'title': '등록일시', 'data': 'writeDate', 'render': function (data) {
                    return data;
                }}
            , {'title': '조회수', 'data': 'viewCnt', 'render': function (data) {
                    return common.addComma(data);
                }}
            , {'title': '게시상태', 'data': 'viewOn', 'render': function (data) {
                    return data;
                }}
            , {'title': '처리자명', 'data': 'opName', 'render': function (data) {
                    return data;
                }}
        ]
    },
}