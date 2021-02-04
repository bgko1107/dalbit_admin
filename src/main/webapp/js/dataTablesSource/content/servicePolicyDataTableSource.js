var servicePolicyDataTableSource = {
    'policyList': {
        'url': '/rest/content/service/policy/list'
        , 'columns': [
            {'title': '반영일시', 'data': 'apply_date', 'render': function (data, type, row, meta) {
                    return common.substr(data, 0, 19);
                }}
            ,{'title': '서비스구분', 'data': 'type_desc'}
            ,{'title': '플랫폼', 'data': 'platform', 'name': 'platform', 'render': function (data) {
                    return util.getPlatformName(data) ;
                }}
            ,{'title': '주요사안 (제목)', 'data': 'title', 'render': function (data, type, row, meta) {
                    return '<a href="javascript://" onclick="policyDetail(' + row.idx + ', ' + 0 + ');">' + data +'</a>';
                }}
            ,{'title': '등록일시', 'data': 'reg_date', 'render': function (data, type, row, meta) {
                    return common.substr(data, 0, 19);
                }}
            ,{'title': '등록자', 'data': 'reg_op_name'}
            ,{'title': '수정일시', 'data': 'upd_date', 'render': function (data, type, row, meta) {
                    return common.substr(data, 0, 19);
                }}
            ,{'title': '수정자', 'data': 'upd_op_name'}
        ]
    },
}