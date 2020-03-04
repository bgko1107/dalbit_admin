var BroadcastDataTableSource = {
    'liveList': {
        'url': '/rest/broadcast/live/list'
        , 'columns': [
            {'title': 'Main추천상태', 'data': 'badgeRecomm', 'render': function (data) {
                    if(data == 1){
                        return '<i class="fa fa-circle"></i><br/>' + "추천중";
                    }else{
                        return '<i class="fa fa-circle-o"></i><br/>' + "비추천";
                    }
                }},
            {'title': '레벨/등급', 'data': 'live', 'defaultContent': ''},
            {'title': '프로필이미지', 'data': 'imageProfile', 'defaultContent': '', 'render' : function(data, type, row, meta){
                    return '<img src="'+ IMAGE_SERVER_URL + data+'" width="100px" height="100px" />';
                }},
            {'title': '테그부분', 'data': 'tag', 'render': function (data) {
                    if(data == "ALL"){
                        return '<span class ="label" style="background-color:#d9534f">' + "추천" + '</span><br/>' +
                                '<span class ="label" style="background-color:#3761d9">' + "인기" + '</span><br/>' +
                                '<span class ="label" style="background-color:#d9c811">' + "신입" + '</span>';
                    }else if(data == "repo"){
                        return '<span class ="label" style="background-color:#d9534f">' + "추천" + '</span><br/>' +
                                '<span class ="label" style="background-color:#3761d9">' + "인기" + '</span>';
                    }else if(data == "rene"){
                        return '<span class ="label" style="background-color:#d9534f">' + "추천" + '</span><br/>' +
                                '<span class ="label" style="background-color:#d9c811">' + "신입" + '</span>';
                    }else if(data == "pone"){
                        return '<span class ="label"  style="background-color:#3761d9">' + "인기" + '</span><br/>' +
                                '<span class ="label" style="background-color:#d9c811">' + "신입" + '</span>';
                    }else if(data == "re"){
                        return '<span class ="label" style="background-color:#d9534f">' + "추천" + '</span>';
                    }else if(data == "po"){
                        return '<span class ="label" style="background-color:#3761d9">' + "인기" + '</span>';
                    }else{
                        return '<span class ="label" style="background-color:#d9c811">' + "신입" + '</span>';
                    }
                }},
            {'title': '회원No', 'data': 'memNo', 'defaultContent': ''},
            {'title': 'User ID', 'data': 'memId', 'defaultContent': ''},
            {'title': 'User 닉네임', 'data': 'memNick', 'defaultContent': ''},
            {'title': '방송제목', 'data': 'title', 'defaultContent': ''},
            {'title': '보유 결제금액', 'data': '', 'defaultContent': ''},
            {'title': '누적 받은 선물 수', 'data': '', 'defaultContent': ''},
            {'title': '누적 팬 수', 'data': '', 'defaultContent': ''},
            {'title': '누적 방송 횟수', 'data': '', 'defaultContent': ''},
            {'title': '최초방송 시작일', 'data': 'start_date', 'defaultContent': ''},
        ]
        , 'comments': '실시간 생방송 시작된 방송이 최상위 누적되어 보여집니다.'
    },
    
    'listenDetail': {
        'url': '/rest/member/report/list'
        , 'columns': [
            {'title': '구분', 'data': '', 'defaultContent': ''},
            {'title': '회원번호', 'data': '', 'defaultContent': ''},
            {'title': 'User ID', 'data': '', 'defaultContent': ''},
            {'title': 'User 닉네임', 'data': '', 'defaultContent': ''},
            {'title': '청취 시작 일시', 'data': '', 'defaultContent': ''},
            {'title': '청취 종료시간', 'data': '', 'defaultContent': ''},
            {'title': '권한 시작 일시', 'data': '', 'defaultContent': ''},
            {'title': '권한 종료 일시', 'data': '', 'defaultContent': ''},
            {'title': '청취진행시간', 'data': '', 'defaultContent': ''},
            {'title': '좋아요', 'data': '', 'defaultContent': ''},
            {'title': '부스터', 'data': '', 'defaultContent': ''},
            {'title': '보낸아이템', 'data': '', 'defaultContent': ''},
        ]
        , 'comments': '방송 중 (게스트와 매니저를 포함한)청취자 변동사항을 확인할 수 있습니다.<br> 청취자 리스트는 방송 Live상태 내에서의 데이터로 방송 입퇴장 정보를 포함합니다.'
    },

    'likeDetail': {
        'url': '/rest/member/report/list'
        , 'columns': [
            {'title': '회원번호', 'data': '', 'defaultContent': ''},
            {'title': '보낸 User Id', 'data': '', 'defaultContent': ''},
            {'title': '보낸 User 닉네임', 'data': '', 'defaultContent': ''},
            {'title': '보낸 일시', 'data': '', 'defaultContent': ''},
            {'title': '보낸 좋아요', 'data': '', 'defaultContent': ''},
            {'title': '보낸 부스터', 'data': '', 'defaultContent': ''},
            {'title': '적용완료 일시', 'data': '', 'defaultContent': ''},
        ]
        , 'comments': '방송 중 좋아요와 부스터 적용상태를 확인할 수 있습니다.'
    },

    'giftDetail': {
        'url': '/rest/member/report/list'
        , 'columns': [
            {'title': '회원번호', 'data': '', 'defaultContent': ''},
            {'title': '보낸 User ID', 'data': '', 'defaultContent': ''},
            {'title': '보낸 User 닉네임', 'data': '', 'defaultContent': ''},
            {'title': '보낸 일시', 'data': '', 'defaultContent': ''},
            {'title': '이미지', 'data': '', 'defaultContent': ''},
            {'title': '선물 명', 'data': '', 'defaultContent': ''},
            {'title': '보낸 선물 수', 'data': '', 'defaultContent': ''},
            {'title': '적용완료 일시', 'data': '', 'defaultContent': ''},
        ]
        , 'comments': '방송 중 DJ에게 보낸 회원 및 선물 세부 내역을 확인할 수 있습니다.'
    },
    'storyDetail': {
        'url': '/rest/member/report/list'
        , 'columns': [
            {'title': '회원번호', 'data': '', 'defaultContent': ''},
            {'title': '사연 보낸 청취자 ID', 'data': '', 'defaultContent': ''},
            {'title': '사연 보낸 청취자 닉네임', 'data': '', 'defaultContent': ''},
            {'title': '보낸 일시', 'data': '', 'defaultContent': ''},
            {'title': '사연 내용', 'data': '', 'defaultContent': ''},
        ]
        , 'comments': '방송 중 받은 사연 내역을 확인할 수 있습니다.'
    },
}
