var ggamggameDataTableSource = {
    'newrecordList': {
        'url': '/rest/content/event/ggamggame/newrecord/list'
        , 'columns': [
            {'title': '이벤트상태', 'data': 'view_yn', 'render': function(data, type, row) {
                    return data == 1 ? '진행중' : '종료';
                }},
            {'title': '이벤트 선택', 'data': 'event_no', 'render': function(data, type, row) {
                    return util.getCommonCodeLabel(data, conEvent);
                }},
            {'title': '기준', 'data': 'type', 'render': function(data, type, row) {
                    return util.getCommonCodeLabel(data, conGubun);
                }},
            {'title': '이벤트 제목', 'data': 'event_name', 'render': function(data, type, row, meta) {
                    return '<a href="javascript://" onclick="newrecordDetail(' + meta.row + ')">' + data + ' </a>';
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