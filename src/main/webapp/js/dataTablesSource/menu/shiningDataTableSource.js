var shiningDataTableSource = {
    'expectedList': {
        'url': '/rest/menu/shining/expectedList'
        , 'columns': [
            {'title': '프로필', 'width': '10%', 'data': 'profileImage', 'render': function(data, type, row) {
                    return '<img class="thumbnail fullSize_background" src="'+ common.profileImage(PHOTO_SERVER_URL, data, row.memSex) +'" width="65px" height="65px" />';
                }}
            , {'title': '회원번호', 'data': 'mem_no', 'width' : '10%', 'render': function(data, type, row) {
                    return '<a href="javascript://" class="_openMemberPop" data-memno="' + row.mem_no + '">' + data + '</a>'
                }}
            , {'title': '닉네임', 'width': '10%', 'data': 'memNick'}
            , {'title': '성별', 'data': 'memSex', 'width':'5%', 'render': function (data, type, row, meta) {
                    return common.sexIcon(data, row.mem_birth_year);
                }}
            , {'title': '가입일', 'data': 'memJoinDate', 'render': function(data, type, row) {
                    return common.convertToDate(data, 'YYYY-MM-DD');
                }}
            , {'title': '30일  내<br />방송 일수', 'data': 'dateCnt', 'width':'10%', 'render': function(data){
                    return common.phoneNumHyphen(data) + ' 일'
                }}
            , {'title': '30일  내<br />방송 횟수', 'data': 'broadcastCnt', 'width':'10%', 'render': function(data){
                    return common.phoneNumHyphen(data) + ' 회'
                }}
            , {'title': '30일 내<br />방송시간', 'data': 'airTime','render': function(data) {
                    return common.timeStampDay(data);
                }}
            , {'title': '30일 내<br />청취자수', 'data': 'sumEntry','render': function(data) {
                    return common.addComma(data)+' 명';
                }}
            , {'title': '30일 내<br />평균 청취자 수', 'data': 'avgEntry', 'render': function(data, type, row) {
                    return common.addComma(data)+' 명';
                }}
            , {'title': '30일 내<br />받은 별', 'data': 'byeolCnt', 'render': function(data, type, row) {
                    return common.addComma(data)+' 별';
                }}
            , {'title': '누적 신고<br />기록', 'data': 'reportedCnt', 'render': function(data, type, row) {
                    return common.addComma(data)+' 회';
                }}
        ]
        // , 'comments': ''
        ,'createdRow' : function( row, data, dataIndex ) {
            if (data.inner == 1) {    // 테스트계정 row 색상 표시
                $(row).addClass("bg-testMember");
            }
        }
    },
};