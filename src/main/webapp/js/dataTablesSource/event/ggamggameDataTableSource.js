var ggamggameDataTableSource = {
    'newrecordList': {
        'url': '/rest/event/ggamggame/newrecord/list'
        , 'columns': [
            {'title': '이벤트 제목', 'data': 'event_name', 'render': function(data, type, row, meta) {
                    return '<a href="javascript://" onclick="newrecordDetail(' + meta.row + ')">' + data + ' </a>';
                }},
            {'title': '노출 여부', 'data': 'view_yn', 'render': function(data, type, row) {
                    return util.getCommonCodeLabel(data, content_viewOn);
                }},
            {'title': '최종 수정일', 'data': 'upd_date', 'render': function(data, type, row) {
                    return data;
                }},
            {'title': '최종 수정자', 'data': 'upd_op_name', 'render': function(data, type, row) {
                    return data;
                }},
        ]
    },
};