var questDataTableSource = {
    'questList': {
        'url': '/rest/event/quest/list'
        , 'columns': [
            {'title': '이벤트상태', 'data': 'viewYn', 'render': function(data, type, row) {
                    return data == 1 ? '진행중' : '종료';
                }},
            {'title': '이벤트', 'data': 'questDate', 'render': function(data, type, row, meta) {
                    return '<a href="javascript://" onclick="questDetail(' + meta.row + ')">' + data + ' </a>';
                }},
            {'title': '이벤트달성', 'data': 'rewardCnt', 'render': function(data, type, row, meta) {
                    return data;
                }},
            {'title': '등록일', 'data': 'regDate', 'render': function(data, type, row) {
                    return data;
                }},
            {'title': '수정일', 'data': 'lastUpdDate', 'render': function(data, type, row) {
                    return common.substr(data, 0, 19);
                }},
            {'title': '최종 수정자', 'data': 'opName', 'render': function(data, type, row) {
                    return common.substr(data, 0, 19);
                }},
        ]
    },
};