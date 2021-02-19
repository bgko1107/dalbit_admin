var NoticeDataTableSource = {
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
        , 'comments': ''
    },

    'editHistory': {
        'url': '/rest/content/boardAdm/edit/list'
        , 'columns': [
            {'title': '수정일자', 'data': 'editDateFormat','width':'120px'},
            {'title': '수정 내용', 'data': 'editContents','width':'900px','className':'al' },
            {'title': '처리자명', 'data': 'opName','width':'100px'},
        ]
        , 'comments': 'ㆍ회원 또는 운영자에 의해 정보가 수정된 일시를 확인할 수 있습니다.'
    },
}