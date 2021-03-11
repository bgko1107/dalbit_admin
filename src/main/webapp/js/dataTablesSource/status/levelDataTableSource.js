var levelDataTableSource = {
    'memLevelList': {
        'url': '/rest/status/level/list'

        , 'columns': [
            {'title': '순위', 'data' : 'ranking', 'width':'40px'}
            ,{'title': '레벨', 'data' : 'level', 'width':'40px'}
            ,{'title': '명칭', 'data' : 'grade', 'width':'80px'}
            ,{'title': '경험치(비율)', 'data' : 'memExp', 'width':'80px', 'render': function (data, type, row, meta) {
                    return data + "(" + Number(row.expPro).toFixed(2) + "%)";
                }}
            ,{'title': '누적 경험치', 'data' : 'exp', 'width':'80px'}
            ,{'title': '회원번호', 'data' : 'mem_no', 'width':'80px', 'render': function (data, type, row, meta) {
                    return util.memNoLink(data, row.mem_no);
                }}
            ,{'title': '닉네임', 'data' : 'mem_nick', 'width':'80px'}
            ,{'title': '성별(나이)', 'data' : 'mem_sex', 'width':'80px','render' : function(data, type, row, meta) {
                    return common.sexIcon(data) + "(" + row.age.split('.')[0] + "세)";
                }}
            ,{'title': '태그', 'data' : '', 'width':'80px', 'render': function (data, type, row, meta) {
                    var tmp = "";
                    if(row.newdj_badge == "1"){
                        tmp = tmp + '<div class="mb5"><span class ="label" style="background-color:#d9c811">' + "신입" + '</span></div>';
                    }
                    if(row.specialdj_badge == "1"){
                        tmp = tmp + '<div class="mb5"><span class ="label" style="background-color:red">' + "스페셜DJ" + '</span></div>';
                    }
                    if(row.specialdj_badge == "2"){
                        tmp = tmp + '<div class="mb5"><span class ="label" style="background-color:#632BEB">' + "베스트DJ" + '</span></div>';
                    }
                    if(row.badge_value != "" && row.badge_value != null){
                        if(row.badge_value == 1){
                            tmp = tmp + '<div class="mb5"><span class ="label" style="background-color:#006ad9">' + "회장" + '</span></div>';
                        }else if(row.badge_value == 2){
                            tmp = tmp + '<div class="mb5"><span class ="label" style="background-color:#d97c07">' + "부회장" + '</span></div>';
                        }else if(row.badge_value == 3){
                            tmp = tmp + '<div class="mb5"><span class ="label" style="background-color:#0ed900">' + "사장" + '</span></div>';
                        }
                    }
                    return tmp;
                }}
            ,{'title': '최근방송일시', 'data' : 'broadDate', 'width':'80px'}
            ,{'title': '최근청취일시', 'data' : 'listenDate', 'width':'80px'}
            ,{'title': '최근레벨업일시<br/>(며칠 전)', 'data' : 'levelUpDate', 'width':'90px','render' : function(data, type, row, meta) {
                    return data + '<br/>(' + row.levelUpDay + '일 전)';
                }}
            ,{'title': '최근 접속 기록', 'data' : 'lastLoginDate', 'width':'90px','render' : function(data, type, row, meta) {
                    return data + '<br/>(' + row.loginDay + '일 전)';
                }}
            ,{'title': '1위팬 닉네임<br/>(선물 수)', 'data' : 'top1Fan', 'width':'100px','render' : function(data, type, row, meta) {
                    // if(row.totRcvRubyCnt > 0){
                        return data;
                    // }
                    // return '';
                }}
            ,{'title': '보유달', 'data' : 'ruby', 'width':'80px','render' : function(data){
                    return common.addComma(data);
                }}
            ,{'title': '보유별', 'data' : 'gold', 'width':'80px','render' : function(data){
                    return common.addComma(data);
                }}
            ,{'title': '선물 한<br/>달/별', 'data' : 'present', 'width':'80px','render' : function(data){
                    return common.addComma(data);
                }}
            ,{'title': '선물 받은<br/>달/별', 'data' : 'receive', 'width':'80px','render' : function(data){
                    return common.addComma(data);
                }}
        ]
    },
}