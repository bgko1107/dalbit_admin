var fanrank = {
    'onOffList': {
        'url': '/rest/content/fanrank/onOffList'

        , 'columns': [
            {'title': '회원번호', 'data': 'mem_no', 'render' : function(data, type, row) {
                return util.memNoLink(data, data);
                }}
            , {'title': '닉네임', 'data' : 'mem_nick'}
            , {'title': '성별', 'data': 'mem_sex', 'render' : function(data, type, row) {
                    return common.sexIcon(data, row.mem_birth_year);
                }}
            , {'title': '상태', 'data': 'apply_ranking', 'render' : function(data, type, row) {
                    if(data == 0){
                        return common.setFontColor('미반영', 'red');
                    }else if(data == 1){
                        return common.setFontColor('반영', 'black');
                    }
                    return '';
                }}
            , {'title': '일시', 'data': 'change_date', 'render' : function(data) {
                return data;
                }}
            , {'title': '미 반영 횟수', 'data': 'not_applyCnt', 'render' : function(data) {
                    return data;
                }}
        ]
        , 'comments': ''
    },
};