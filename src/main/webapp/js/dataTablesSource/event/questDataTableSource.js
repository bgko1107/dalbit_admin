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

    'questMember': {
        'url': '/rest/event/quest/member'
        , 'columns': [
            {'title': '프로필사진', 'data': 'imageProfile', 'render': function(data, type, row) {
                    return '<img class="thumbnail fullSize_background" src="'+ common.profileImage(PHOTO_SERVER_URL,data,row.memSex) +'" width="65px" height="65px" />';
                }},
            {'title': '회원번호', 'data': 'memNo', 'render': function(data, type, row) {
                    return util.memNoLink(data, data);
                }},
            {'title': 'UserID', 'data': 'memUserid', 'render': function(data, type, row) {
                    return data;
                }},
            {'title': '닉네임', 'data': 'memNick', 'render': function(data, type, row) {
                    return data;
                }},
            {'title': '퀘스트', 'data': 'questName', 'render': function(data, type, row) {
                    return data;
                }},
            {'title': '참여자일시', 'data': 'lastUpdDate', 'render': function(data, type, row) {
                    return data;
                }},
            {'title': '달', 'data': 'rewardDal', 'render': function(data, type, row) {
                    return data;
                }},
            {'title': '경험치', 'data': 'rewardExp', 'render': function(data, type, row) {
                    return data;
                }},
        ]
    },
};