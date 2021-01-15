var FaqDataTableSource = {
    'faqInfo': {
        'url': '/rest/administrate/faq/list'
        , 'columns': [
            {'title': 'FAQ구분', 'data': 'slctType', 'name': 'sortSlct', 'render': function (data) {
                    return util.getCommonCodeLabel(data, faq_slctType) ;
                }}
            , {
                'title': 'FAQ 질문', 'data': 'question', 'render': function (data, type, row, meta) {
                    return '<a href="javascript://" class="_getFaqDetail" data-idx="' + row.faqIdx + '" onclick="getFaqDetail('+meta.row+');">' + data + '</a>'
                }
            }
            , {'title': '등록일시', 'data': 'writeDateFormat'}
            , {'title': '수정일시', 'data': 'lastUpdateDateFormat'}
            , {'title': '조회수', 'data': 'viewCnt', 'name': '', 'render' : function(data){
                    return common.addComma(data)
                }}
            , {'title': '사이트 적용', 'data': 'viewOn', 'render': function (data) {
                    return util.renderOnOff(data);
                }}
            , {'title': '처리자명', 'data': 'opName'}
        ]
        // , 'comments': '검색결과 내 질문을 클릭하면 해당 상세정보를 확인할 수 있습니다.'
    },

    'macroFaqInfo': {
        'url': '/rest/administrate/faq/list'
        , 'columns': [
            {'title': '구분', 'data': 'slctType', 'name': 'sortSlct', 'render': function (data) {
                    return util.getCommonCodeLabel(data, faq_slctType) ;
                }}
            , {
                'title': '제목', 'data': 'question', 'render': function (data, type, row, meta) {
                    return '<a href="javascript://" class="_getFaqDetail" data-idx="' + row.faqIdx + '" onclick="getFaqDetail('+meta.row+');">' + data + '</a>'
                }
            }
            , {'title': '등록일시', 'data': 'writeDateFormat'}
            , {'title': '수정일시', 'data': 'lastUpdateDateFormat'}
            , {'title': '적용', 'data': 'viewOn', 'render': function (data) {
                    return util.renderOnOff(data);
                }}
            , {'title': '처리자명', 'data': 'opName'}
        ]
        // , 'comments': '검색결과 내 질문을 클릭하면 해당 상세정보를 확인할 수 있습니다.'
    },
}