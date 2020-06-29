var MemberDataTableSource = {

    'joinList': {
        'url': '/rest/member/join/list'
        , 'columns': [
            {'title': '가입일시', 'data': 'memJoinDateFormat', 'width':'100px'},
            {'title': '가입플랫폼', 'data': 'mem_slct', 'width':'100px', 'render': function (data) {
                    return util.renderSlct(data,"30");
                }},
            {'title': 'OS', 'data': 'os_type', 'width':'100px', 'render': function (data) {
                    return util.getCommonCodeLabel(data, os_type);
                }},
            {'title': '회원번호', 'data': 'mem_no', 'width':'100px'},
            {'title': '로그인ID', 'data': 'mem_id', 'width':'100px', 'render': function (data, type, row, meta) {
                    return util.memNoLink(data, row.mem_no);
                }},
            {'title': 'UserID', 'data': 'mem_userid', 'width':'100px', 'render': function (data, type, row, meta) {
                    if(row.testId == "" || row.testId == null){
                        return util.memNoLink(data, row.mem_no);
                    }else{
                        return util.memNoLink(data +"_"+ row.testId, row.mem_no);
                    }
                }},
            {'title': '닉네임', 'data': 'mem_nick', 'width':'100px'},
            {'title': '성별', 'data': 'mem_sex', 'width':'70px', 'render': function (data, type, row, meta) {
                    return common.sexIcon(data);
                }},
            {'title': '이름', 'data': 'mem_name', 'width':'100px'},
            {'title': '연락처', 'data': 'mem_phone', 'width':'100px'},
            {'title': 'IP', 'data': 'ip', 'width':'100px'},
            {'title': '광고유입여부', 'data': 'join_path', 'width':'100px', 'render' : function(data, type, row, meta){
                    return common.isEmpty(data) ? 'N' : 'Y'
                }},
            {'title': '방생성수', 'data': 'broadcastCnt', 'width':'100px', 'render' : function(data){
                    return common.fontColor(common.addComma(data), 0, 'red') + ' 회';
                }},
            {'title': '청취수', 'data': 'listenCnt', 'width':'100px', 'render' : function(data){
                    return common.fontColor(common.addComma(data), 0, 'red') + ' 회';
                }},
            {'title': '결제수', 'data': 'payCnt', 'width':'100px', 'render' : function(data){
                    return common.fontColor(common.addComma(data), 0, 'red') + ' 회';
                }},
        ]
        , 'comments': 'ㆍ최근 가입 정보가 상위로 누적되어 보여지는 리스트입니다.<br/>' +
                      'ㆍ회원에 대한 상세정보를 확인하시려면 UserID를 클릭 해주세요.'
    },

    'withdrawalList': {
        'url': '/rest/member/join/withdrawalList'
        , 'columns': [
            {'title': '가입일시', 'data': 'lastUpdDateFormat', 'width':'100px'},
            {'title': '가입플랫폼', 'data': 'mem_slct', 'width':'100px', 'render': function (data) {
                    return util.renderSlct(data,"30");
                }},
            {'title': 'OS', 'data': 'os_type', 'width':'100px', 'render': function (data) {
                    return util.getCommonCodeLabel(data, os_type);
                }},
            {'title': '회원번호', 'data': 'mem_no', 'width':'100px'},
            {'title': '로그인ID', 'data': 'mem_id', 'width':'100px', 'render': function (data, type, row, meta) {
                    return util.memNoLink(data, row.mem_no);
                }},
            {'title': 'UserID', 'data': 'mem_userid', 'width':'100px', 'render': function (data, type, row, meta) {
                    return util.memNoLink(data, row.mem_no);
                }},
            {'title': '닉네임', 'data': 'mem_nick', 'width':'100px'},
            {'title': '성별', 'data': 'mem_sex', 'width':'70px', 'render': function (data, type, row, meta) {
                    return common.sexIcon(data);
                }},
            {'title': '이름', 'data': 'mem_name', 'width':'100px'},
            {'title': '연락처', 'data': 'mem_phone', 'width':'100px'},
            {'title': 'IP', 'data': 'ip', 'width':'100px'},
            {'title': '광고유입여부', 'data': 'join_path', 'width':'100px', 'render' : function(data, type, row, meta){
                    return common.isEmpty(data) ? 'N' : 'Y'
                }},
            {'title': '방생성수', 'data': 'broadcastCnt', 'width':'100px', 'render' : function(data){
                    return common.fontColor(common.addComma(data), 0, 'red') + ' 회';
                }},
            {'title': '청취수', 'data': 'listenCnt', 'width':'100px', 'render' : function(data){
                    return common.fontColor(common.addComma(data), 0, 'red') + ' 회';
                }},
            {'title': '결제수', 'data': 'payCnt', 'width':'100px', 'render' : function(data){
                    return common.fontColor(common.addComma(data), 0, 'red') + ' 회';
                }},
        ]
        , 'comments': 'ㆍ 최근 탈퇴 회원 정보가 상위로 누적되어 보여지는 리스트입니다.<br/>' +
                      'ㆍ 탈퇴 회원에 대한 상세정보를 확인하시려면 UserID를 클릭 해주세요. <br/>' +
                      '&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;단, 탈퇴 회원에 대한 정보 수정은 불가합니다.'
    },



    'userInfo': {
        'url': '/rest/member/member/list'
        , 'columns': [
            {'title': '회원번호', 'data': 'mem_no', 'width':'100px'},
             {'title': 'UserID', 'data': 'mem_userid', 'width':'100px', 'render': function (data, type, row, meta) {
                    return '<a href="javascript://" class="getMemberDetail" onclick="javascript:getMemNo_info('+meta.row+');">' + data + '</a>'
                }},
             {'title': '닉네임', 'data': 'mem_nick', 'width':'80px'},
             {'title': '성별', 'data': 'mem_sex', 'width':'70px', 'render': function (data, type, row, meta) {
                    return common.sexIcon(data);
                }},
             {'title': '연락처', 'data': 'mem_phone', 'width':'80px'},
             {'title': '가입플랫폼', 'data': 'mem_slct', 'width':'80px', 'render': function (data) {
                    return util.renderSlct(data,"30");
                 }},
             {'title': '가입일시', 'data': 'joinDateFormat', 'width':'120px'},
             {'title': '최근 접속 일시', 'data': 'last_connect_DateFormat', 'width':'120px'},
             {'title': '누적 접속 수', 'data': 'connectCnt', 'width':'80px', 'render': function (data) {
                     return common.addComma(data);
                 }},
             {'title': '결제 건 수/금액', 'data': 'payCntAmount', 'width':'90px'},
             {'title': '회원상태', 'data': 'mem_state',  'width':'60px', 'render': function (data) {
                     return util.getCommonCodeLabel(data, mem_state);
                 }},
             {'title': '접속상태', 'data': 'connectState', 'width':'80px'},
             {'title': '방송상태', 'data': 'liveBroad', 'width':'80px'},
        ]
        , 'comments': 'ㆍ회원 아이디를 클릭하시면 상세정보를 확인할 수 있습니다.'
    },

    'broadDetail': {
        'url': '/rest/member/broadcast/list'
        , 'columns': [
            {'title': 'roomNo', 'data': 'room_no', 'visible' : false},
            {'title': '플랫폼', 'data': 'os_type','width' : '65px', 'render': function (data) {
                    return util.getCommonCodeLabel(data, os_type);
                }},
            {'title': '주제', 'data': 'subject_type', 'width':'100px','render' : function(data){
                    return util.getCommonCodeLabel(data, subject_type);
                }},
            {'title': '제목', 'data': 'title', 'width':'250px', 'render': function (data, type, row, meta) {
                    return util.roomNoLink(data, row.room_no);
                }},
            {'title': '시작시간', 'data': 'startDateFormat', 'width':'120px'},
            {'title': '종료시간', 'data': 'endDateFormat', 'width':'120px'},
            {'title': '진행시간', 'data': 'airtime', 'width':'100px','render' : function(data){
                    return common.timeStamp(data);
                }},
            {'title': '청취자', 'data': 'listenerCnt', 'width':'80px', 'render': function (data) {
                    return common.addComma(data) + "명";
                }},
            {'title': '방송 중<br/>매니저', 'data': 'managerCnt', 'width':'80px', 'render': function (data) {
                    return common.addComma(data) + "명";
                }},
            {'title': '선물<br/>주고/받음', 'data': 'giftCnt', 'width':'80px', 'render': function (data) {
                    return common.addComma(data) + "건";
                }},
            {'title': '받은 별', 'data': 'byeolCnt', 'width':'80px', 'render': function (data) {
                    return common.addComma(data) + "건";
                }},
            {'title': '받은 좋아요', 'data': 'goodCnt', 'width':'80px', 'render': function (data) {
                    return common.addComma(data) + "건";
                }},
            {'title': '받은 부스터', 'data': 'boosterCnt', 'width':'80px', 'render': function (data) {
                    return common.addComma(data) + "건";
                }},
        ]
        ,'comments': 'ㆍ회원이 방송을 진행하고, 청취한 기록을 확인할 수 있습니다.'
    },
    'listenDetail': {
        'url': '/rest/member/listen/list'
        , 'columns': [
            {'title': 'roomNo', 'data': 'room_no' , 'visible' : false},
            {'title': 'DJID', 'data': 'dj_userId', 'width':'100px', 'render': function (data, type, row, meta) {
                    return util.memNoLink(data, row.dj_mem_no);
                }},
            {'title': 'DJ닉네임', 'data': 'dj_nickName', 'width':'100px'},
            {'title': '성별', 'data': 'dj_mem_sex', 'width':'70px', 'render': function (data, type, row, meta) {
                    return common.sexIcon(data);
                }},
            {'title': '청취방주제', 'data': 'subject_type', 'width':'100px','render' : function(data){
                    return util.getCommonCodeLabel(data, subject_type);
                }},
            {'title': '방송제목', 'data': 'title', 'width':'250px', 'render': function (data, type, row, meta) {
                    return util.roomNoLink(data, row.room_no);
                }},
            {'title': '청취시작시간', 'data': 'startDateFormat', 'width':'120px'},
            {'title': '청취종료시간', 'data': 'endDateFormat', 'width':'120px'},
            {'title': '청취진행시간', 'data': 'listentime', 'width':'120px', 'render': function (data) {
                    return common.timeStamp(data);
                }},
            {'title': '강제퇴장', 'data': 'forcedLeave', 'width':'80px'},
            {'title': '보낸 별', 'data': 'giftByeol', 'width':'80px', 'render': function (data) {
                    return common.addComma(data) + "건";
                }},
            {'title': '보낸 좋아요', 'data': 'goodCnt', 'width':'80px', 'render': function (data) {
                    return common.addComma(data) + "건";
                }},
            {'title': '보낸 부스터', 'data': 'boosterCnt', 'width':'80px', 'render': function (data) {
                    return common.addComma(data) + "건";
                }},
        ]
        ,'comments': 'ㆍ회원이 청취한 방송기록을 확인할 수 있습니다.'
    },

    'payDetail': {
        'url': '/rest/member/pay/list'
        , 'columns': [
            {'title': '구분', 'data': 'type'},
            {'title': '아이템명', 'data': 'type'},
            {'title': '수량', 'data': 'type'},
            {'title': '요청 금액', 'data': 'type'},
            {'title': '결제취소 수단', 'data': 'type'},
            {'title': '결제취소 일시', 'data': 'type'},
            {'title': '가능여부', 'data': 'type'},
            {'title': '취소처리 일시', 'data': 'type'},
            {'title': '처리상태', 'data': 'type'},
            {'title': '처리자명', 'data': 'type'},
        ]
        , 'comments': 'ㆍ회원의 결제취소 정보를 확인하고, 결제 건에 한해 구분>”결제 : 결제 완료, 불가>결제 취소를 요청하였으나<br/>' +
                      '&nbsp;&nbsp;&nbsp;&nbsp;이미 아이템을 사용한 경우, 취소 : 결제 취소가 완료된 경우”로 구분됩니다. <br/>' +
                      'ㆍ결제를 클릭 가능여부 Y인경우만 취소처리가 가능하고, 클릭 시 결제 취소처리를 할 수 있습니다.'
    },



    'exchangeDetail': {
        'url': ''
        , 'columns': [
            {'title': '회원번호', 'data': 'type'},
            {'title': 'UserID', 'data': 'type'},
            {'title': '닉네임', 'data': 'type'},
            {'title': '환전요청금액', 'data': 'type'},
            {'title': '처리일시', 'data': 'type'},
            {'title': '신청 골드 금액', 'data': 'type'},
            {'title': '누적환전건수', 'data': 'type'},
            {'title': '누적완료건수', 'data': 'type'},
            {'title': '처리상태', 'data': 'type'},
            {'title': '상세보기', 'data': 'type', 'render': function (data, type, row, meta) {
                    return '<a onclick="javascript:exchangeStatus('+meta.row+')" data-toggle="modal" data-target="#myModal">' + data + '</a>'
                }},
            {'title': '처리자명', 'data': 'type'},
        ]
        , 'comments': 'ㆍ회원의 과거에서 현재까지의 환전 내역을 모두 확인하고, 증빙서류를 통한 본인확인 여부를 확인 하여 처리할 수 있습니다.<br/>ㆍ해당 처리는 CS가 아닌 별도 담당자에 의해 처리됩니다.'
    },

    'giftDetail': {
        'url': '/rest/member/gift/list'
        , 'columns': [
            {'title': '회원번호', 'data': 'mem_no'},
            {'title': 'UserID', 'data': 'userId', 'render': function (data, type, row, meta) {
                    return util.memNoLink(data, row.mem_no);
                }},
            {'title': 'User닉네임', 'data': 'nickName'},
            {'title': '성별', 'data': 'mem_sex', 'width':'70px', 'render': function (data, type, row, meta) {
                    return common.sexIcon(data);
                }},
            {'title': '구분', 'data': 'gubun'},
            {'title': '비공개', 'data': 'secret', 'render': function (data, type, row, meta) {
                    return data == '' ? "X" : data == 1 ? "O" : common.addComma(data);
                }},
            {'title': '이미지', 'data': 'item_thumbnail','width':'50px','render' : function (data, type, row, meta) {
                    return '<img class="" src="'+ data +'" width="50px" height="50px"/>';
                }},
            {'title': '아이템명', 'data': 'itemName'},
            {'title': '선물 수', 'data': 'itemCnt', 'render': function (data) {
                    return common.addComma(data) + " 개"
                }},
            {'title': '선물 달', 'data': 'ruby', 'render': function (data) {
                    return common.addComma(data) + " 달"
                }},
            {'title': '선물 일시', 'data': 'giftDateFormat'},
        ]
    },

    'chargeDetail': {
        'url': '/rest/member/gift/charge/list'
        , 'columns': [
            {'title': '회원번호', 'data': 'mem_no'},
            {'title': 'User ID', 'data': 'mem_userid', 'render': function (data, type, row, meta) {
                    if(row.mem_no == "운영자") {
                        if (data == "운영자") {
                            return data;
                        } else {
                            var tmp = "/member/member/popup/memberTestid?name=" + encodeURIComponent(data);
                            return util.popupLink(data, tmp, "1400", "700");
                        }
                    }
                    return data;
                }},
            {'title': 'User 닉네임', 'data': 'mem_nick', 'render': function (data, type, row, meta) {
                if(row.mem_no == "운영자"){
                    if(data == "운영자"){
                        return data;
                    }else{
                        var tmp = "/member/member/popup/memberTestid?name=" + encodeURIComponent(data);
                        return util.popupLink(data,tmp,"1400","700");
                    }
                }else{
                    return util.memNoLink(data, row.mem_no);
                }
            }},
            {'title': '성별', 'data': 'mem_sex', 'width':'70px', 'render': function (data, type, row, meta) {
                    return common.sexIcon(data);
                }},
            {'title': '구분', 'data': 'use_contents'},
            {'title': '이미지', 'data': 'image','width':'50px','render' : function (data, type, row, meta) {
                    return '<img class="" src="'+ data +'" width="50px" height="50px"/>';
                }},
            {'title': '아이템명', 'data': 'itemNm'},
            {'title': '선물 달 수', 'data': 'cnt','render' : function (data, type, row, meta) {
                    return common.addComma(data);
                }},
            {'title': '선물 일시', 'data': 'lastUpdDateFormat'},
        ]
    },

    'exchangeDetail': {
        'url': '/rest/member/gift/exchange/list'
        , 'columns': [
            {'title': '이미지', 'data': 'giftDateFormat'},
            {'title': '보유 별', 'data': 'giftDateFormat'},
            {'title': '교환 수', 'data': 'giftDateFormat','render' : function (data, type, row, meta) {
                    return common.addComma(data);
                }},
            {'title': '남은 별', 'data': 'giftDateFormat','render' : function (data, type, row, meta) {
                    return common.addComma(data);
                }},
            {'title': '교환 후 보유 달', 'data': 'giftDateFormat','render' : function (data, type, row, meta) {
                    return common.addComma(data);
                }},
            {'title': '교환 시도 횟수', 'data': 'giftDateFormat','render' : function (data, type, row, meta) {
                    return common.addComma(data);
                }},
            {'title': '플랫폼', 'data': 'giftDateFormat'},
            {'title': '선물 일시', 'data': 'giftDateFormat'},
        ]
    },

    'mystar': {
        'url': '/rest/member/mystar/mystarlist'
        , 'columns': [
            {'title': 'MyStar ID', 'data': 'mem_no_start_id', 'render': function (data, type, row, meta) {
                    return util.memNoLink(data, row.mem_no_star);
                }},
            {'title': 'MyStar 닉네임', 'data': 'mem_no_start_nick'},
            {'title': '성별', 'data': 'star_sex', 'width':'70px', 'render': function (data, type, row, meta) {
                    return common.sexIcon(data);
                }},
            {'title': '아이템보낸 건 수', 'data': 'accumCnt', 'width':'120px', 'render': function (data) {
                    return common.addComma(data) + "건";
                }},
            {'title': '보낸 달 수', 'data': 'totalItemCnt', 'width':'120px', 'render': function (data) {
                    return common.addComma(data) + "건";
                }},
            {'title': 'Mystar등록일', 'data': 'regDateFormat'},
        ]
    },

    'myfan': {
        'url': '/rest/member/mystar/myfanlist'
        , 'columns': [
            {'title': 'Fan ID', 'data': 'mem_no_fan_id', 'render': function (data, type, row, meta) {
                    return util.memNoLink(data, row.mem_no_fan);
                }},
            {'title': 'Fan 닉네임', 'data': 'mem_no_fan_nick'},
            {'title': '성별', 'data': 'fan_sex', 'width':'70px', 'render': function (data, type, row, meta) {
                    return common.sexIcon(data);
                }},
            {'title': '아이템보낸 건 수', 'data': 'accumCnt', 'width':'120px', 'render': function (data) {
                    return common.addComma(data) + "건";
                }},
            {'title': '보낸 달 수', 'data': 'totalItemCnt', 'width':'120px', 'render': function (data) {
                    return common.addComma(data) + "건";
                }},
            {'title': 'Fan 등록일', 'data': 'regDateFormat'},
        ]
    },

    'noticeDetail': {
        'url': '/rest/member/notice/list'
        , 'columns': [
            {'title': '구분', 'data': 'type','width':'100px','render' : function(data){
                    if(data == "1"){
                        return "회원공지";
                    }else{
                        return "방송공지";
                    }
                }},
            {'title': '공지내용', 'data': 'contents','width':'200px','render':function(data){
                    return data.replace(/\\n/gi,"<br/>");
                }},
            {'title': '등록일시', 'data': 'lastUpdDateFormat','width':'100px'},
        ]
        , 'comments': 'ㆍ각 회원의 방송중 공지와 팬보드 내 연동된 공지 및 팬보드에서의 개인공지를 확인하고, 관리할 수 있습니다.'
    },

    'fanboardDetail': {
        'url': '/rest/member/fanboard/list'
        , 'columns': [
            {'title': '프로필이미지', 'data': 'profileImage', 'render' : function(data, type, row){
                    return '<img class="thumbnail fullSize_background" src="'+ common.profileImage(PHOTO_SERVER_URL,data,row.memSex) +'" width="50px" height="50px" />';
                }},
            {'title': '회원번호', 'data': 'writer_mem_no'},
            {'title': '팬ID', 'data': 'userId', 'render': function (data, type, row, meta) {
                    return util.memNoLink(data, row.writer_mem_no);
                }},
            {'title': '팬닉네임', 'data': 'nickName'},
            {'title': '성별', 'data': 'memSex', 'width':'70px', 'render': function (data, type, row, meta) {
                    return common.sexIcon(data);
                }},
            {'title': '등록일시', 'data': 'writeDateFormat'},
            {'title': '작성내용', 'data': 'contents','width' : '400px'},
            {'title': '상태', 'data': 'STATUS', 'render':function(data){
                    if(data == "1"){
                        return "정상";
                    }else{
                        return "삭제";
                    }
                }},
            {'title': '총 댓글 수', 'data': 'replyCnt', 'render': function (data, type, row, meta) {
                    return data + '<br/><a href="javascript://" onclick="javascript:Fanboard(' + meta.row + ');">' + "[댓글]" + '</a>'
                }},
        ]
        , 'comments': 'ㆍ회원의 팬보드 내 작성 된 팬보드에서의 작성 글 및 댓글정보를 확인할 수 있습니다.'
    },

    'declarationDetail': {
        'url': '/rest/customer/declaration/list'

        ,'columns': [
            {'title': '플랫폼', 'data': 'platform', 'name': 'sortPlatform'}
            ,{'title': '신고 구분', 'data' : 'reason', 'name' : 'sortReport', 'render': function(data) {
                    return util.getCommonCodeLabel(data, declaration_reason);
                }}
            ,{'title': '신고자 UserID', 'data': 'mem_userid', 'render': function (data, type, row) {
                    return '<a href="javascript://" class="_getDeclarationDetail" data-idx="' + row.reportIdx + '">' + data + '</a>'}}
            ,{'title': '신고자 User닉네임', 'data': 'mem_nick'}
            ,{'title': '성별', 'data': 'mem_sex', 'width':'70px', 'render': function (data, type, row, meta) {
                    return common.sexIcon(data);
                }}
            ,{'title': '신고 대상 UserID', 'data': 'reported_userid', 'render': function (data, type, row) {
                    return '<a href="javascript://" class="_getDeclarationDetail" data-idx="' + row.reportIdx + '">' + data + '</a>'}
                , 'defaultContent': '-'}
            ,{'title': '신고 대상 User닉네임', 'data': 'reported_nick'}
            ,{'title': '성별', 'data': 'reported_mem_sex', 'width':'70px', 'render': function (data, type, row, meta) {
                    return common.sexIcon(data);
                }}
            ,{'title': '접수 일시', 'data': 'regDateFormat'}
            ,{'title': '처리 일시', 'data': 'opDateFormat', 'defaultContent':'-'}
            ,{'title': '처리 상태', 'data': 'op_code', 'name': 'slctType', 'render' : function(data) {
                    return util.getCommonCodeLabel(data, declaration_slctType);
                }}
            ,{'title': '처리자', 'data': 'opName', 'defaultContent':'-'}
        ]
        , 'comments' : ' • 최신 신고자를 기준으로 상위 구성하고, 확인하고자 하는 회원 정보 내 선택을 클릭하면 상세정보 및 회원 신고조치를 처리할 수 있습니다.'
    },

    'banwordDetail': {
        'url': '/rest/member/banword/list'
        , 'columns': [
            {'title': '금지어', 'data': 'ban_word'},
        ]
        , 'comments': 'ㆍ회원이 직접 100개까지 관리를 할 수 있고, 관리자에 의해 등록/수정/삭제도 할 수 없습니다.'
    },

    'adminMemoList': {
        'url': '/rest/member/member/adminMemolist'
        , 'columns': [
            {'title': '등록 일시', 'data': 'regDate','width':'180px'},
            {'title': '등록 관리자', 'data': 'opName','width':'100px'},
            {'title': '운영자 메모 내용', 'data': 'memo','render': function (data) {
                return common.replaceTag(data);
            }},
        ]
    },

    'connectState': {
        'url': '/rest/member/member/connect'
        , 'columns': [
            {'title': '접속일시', 'data': 'connectDateFormat'},
            {'title': '접속구분', 'data': 'connectType', 'render': function (data) {
                    if(data == 1){
                        return "Login";
                    }else{
                        return "Logout";
                    }
                }},
            {'title': 'App Ver', 'data': 'appVersion'},
            {'title': 'Browser', 'data': 'Browser'},
            {'title': 'Device', 'data': 'Device', 'render': function (data) {
                    return util.getCommonCodeLabel(data, os_type);
                }},
            {'title': 'DeviceToken', 'data': 'device_token','render' : function(data){
                    return '<label class="word-break">' + data +'</label>';
                }},
            {'title': 'Mobile Device ID', 'data': 'deviceUUID'},
            {'title': 'Mobile AD ID', 'data': 'adID'},
            {'title': 'IP 주소', 'data': 'ip'},
        ]
        , 'comments': 'ㆍ회원의 가입일부터 현재까지의 접속 기록을 확인할 수 있습니다.'
    },

    'manager': {
        'url': '/rest/member/member/managerList'
        , 'columns': [
            {'title': '회원번호', 'data': 'mem_no'},
            {'title': 'User ID', 'data': 'mem_userid'},
            {'title': 'User 닉네임', 'data': 'mem_nick'},
            {'title': '권한부여 일시', 'data': 'regDate'},
            {'title': '선물', 'data': 'gift'},
        ]
        , 'comments': 'ㆍ마이페이지 내 매니저 임명 변동사항을 확인할 수 있습니다. <br>ㆍ아래 정보는 현재 권한을 갖은 매니저 리스트이고, 매니저 권한은 최대 10명까지 가능합니다.'
    },
    'meManager': {
        'url': '/rest/member/member/managerList'
        , 'columns': [
            {'title': '회원번호', 'data': 'mem_no'},
            {'title': 'User ID', 'data': 'mem_userid'},
            {'title': 'User 닉네임', 'data': 'mem_nick'},
            {'title': '권한부여 일시', 'data': 'regDate'},
            {'title': '선물', 'data': 'gift'},
        ]
        , 'comments': 'ㆍ나를 매니저로 등록한 DJ정보 입니다.'
    },

    'black': {
        'url': '/rest/member/member/blackList'
        , 'columns': [
            {'title': '회원번호', 'data': 'mem_no'},
            {'title': 'User ID', 'data': 'mem_userid'},
            {'title': 'User 닉네임', 'data': 'mem_nick'},
            {'title': '권한부여 일시', 'data': 'regDate'},
            {'title': '선물', 'data': 'gift'},
        ]
        , 'comments': 'ㆍ마이페이지 내 블랙리스트로 등록한 회원 정보를 확인할 수 있습니다.'
    },
    'meBlack': {
        'url': '/rest/member/member/blackList'
        , 'columns': [
            {'title': '회원번호', 'data': 'mem_no'},
            {'title': 'User ID', 'data': 'mem_userid'},
            {'title': 'User 닉네임', 'data': 'mem_nick'},
            {'title': '권한부여 일시', 'data': 'regDate'},
            {'title': '선물', 'data': 'gift'},
        ]
        , 'comments': 'ㆍ나를 블랙리스트로 등록한 DJ정보 입니다. <br/>ㆍ해당 정보는 운영관리를 위한 정보입니다. 따라서, 회원에게 보이거나 알려주어서는 안됩니다.'
    },

    'editHistory': {
        'url': '/rest/member/member/editHist'
        , 'columns': [
            {'title': '수정일자', 'data': 'editDateFormat','width':'120px'},
            {'title': '수정 내용', 'data': 'editContents','width':'900px','className':'al' ,'render' : function(data){
                    return memberUtil.convertEditHistory(data);
                }},
            {'title': '처리자명', 'data': 'opName','width':'100px'},
        ]
        , 'comments': 'ㆍ회원 또는 운영자에 의해 정보가 수정된 일시를 확인할 수 있습니다.'
    },

    'pointHistory': {
        'url': '/rest/member/member/pointHist'
        , 'columns': [
            {'title': '수정일자', 'data': 'editDateFormat','width':'120px'},
            {'title': '수정 내용', 'data': 'editContents','width':'900px'},
            {'title': '처리자명', 'data': 'opName','width':'100px'},
        ]
        , 'comments': 'ㆍ운영자에 의해 정보가 수정된 일시를 확인할 수 있습니다.'
    },


    'exchangeList': {
        'url': '/rest/member/exchange/list'
        , 'columns': [
            {'title': '상태', 'data': 'mem_state','render' : function (data, type, row) {
                    return common.getMemStateName(data);
                }},
            {'title': '미성년자여부', 'data': 'birth','render' : function (data, type, row) {
                    if(data < 19){
                        return '<span style="color:red">미성년자</span>';
                    }
                    return "-";
                }},
            {'title': '예금주', 'data': 'account_name'},
            {'title': '신청금액', 'data': 'cash_basic', 'render': function(data) {
                    return common.addComma(data) + "원";
                }},
            {'title': '스페셜DJ<br/>혜택', 'data': 'benefit', 'render': function(data) {
                    return common.addComma(data) + "원";
                }},
            {'title': '실수령액', 'data': 'cash_real', 'render': function(data) {
                    return common.addComma(data) + "원";
                }},
            {'title': '신청 별 수', 'data': 'byeol', 'render': function(data) {
                    return common.addComma(data) + "별";
                }},
            {'title': '현재 별 수', 'data': 'gold', 'render': function(data) {
                    return common.addComma(data) + "별";
                }},
            {'title': '환전횟수', 'data': 'exchangeCnt', 'render': function(data) {
                    return common.addComma(data) + "번";
                }},
            {'title': '신청일자', 'data': 'reg_date', 'render': function(data) {
                    return common.convertToDate(data);
                }},
            {'title': '처리일자', 'data': 'op_date', 'render': function(data) {
                    return common.convertToDate(data);
                }},
            {'title': '처리현황', 'data': 'state', 'render': function(data) {
                    if(common.isEmpty(data)){
                        return '-';
                    }else if(data == 0){
                        return '미처리';
                    }else if(data == 1){
                        return '<span style=color:blue;>완료</span>';
                    }else if(data == 2){
                        return '<span style=color:red;>불가</span>';
                    }
                }},
            {'title': '처리자', 'data': 'op_name'},
            {'title': '상세보기', 'data': '','render' : function (data, type, row) {
                return '<button type="button" class="btn btn-primary btn-sm _layerOpen" data-exchangeidx=' + row.idx + '>보기</button>';
            }},
        ]
    },




    'walletDalDetail': {
        'url': '/rest/member/wallet/dal/list'
        , 'columns': [
            {'title': '회원번호', 'data': 'mem_no'},
            {'title': 'UserID', 'data': 'userId', 'render': function (data, type, row, meta) {
                    return util.memNoLink(data, row.mem_no);
                }},
            {'title': 'User닉네임', 'data': 'nickName'},
            {'title': '성별', 'data': 'mem_sex', 'width':'70px', 'render': function (data, type, row, meta) {
                    return common.sexIcon(data);
                }},
            {'title': '구분', 'data': 'gubun', 'render': function (data, type, row, meta) {
                    return util.getCommonCodeLabel(data, mem_wallet_dal_code);
                }},
            {'title': '비공개', 'data': 'secret', 'render': function (data, type, row, meta) {
                    return data == '' ? "X" : data == 1 ? "O" : common.addComma(data);
                }},
            {'title': '이미지', 'data': 'item_thumbnail','width':'50px','render' : function (data, type, row, meta) {
                    var imgurl = common.isEmpty(data) ? "https://image.dalbitlive.com/ani/thumbs/moon_thumb.jpg" : data;
                    return '<img class="" src="'+ imgurl +'" width="50px" height="50px"/>';
                }},
            {'title': '아이템명', 'data': 'itemName'},
            {'title': '선물 수', 'data': 'itemCnt', 'render': function (data) {
                    return common.addComma(data) + " 개"
                }},
            {'title': '선물 달', 'data': 'ruby', 'render': function (data) {
                    return common.addComma(data) + " 달"
                }},
            {'title': '선물 일시', 'data': 'giftDateFormat'},
        ]
    },

    'walletByeolDetail': {
        'url': '/rest/member/wallet/byeol/list'
        , 'columns': [
            {'title': '회원번호', 'data': 'mem_no'},
            {'title': 'UserID', 'data': 'userId', 'render': function (data, type, row, meta) {
                    return util.memNoLink(data, row.mem_no);
                }},
            {'title': 'User닉네임', 'data': 'nickName'},
            {'title': '성별', 'data': 'mem_sex', 'width':'70px', 'render': function (data, type, row, meta) {
                    return common.sexIcon(data);
                }},
            {'title': '구분', 'data': 'gubun'},
            {'title': '비공개', 'data': 'secret', 'render': function (data, type, row, meta) {
                    return data == '' ? "X" : data == 1 ? "O" : common.addComma(data);
                }},
            {'title': '이미지', 'data': 'item_thumbnail','width':'50px','render' : function (data, type, row, meta) {
                    var imgurl = common.isEmpty(data) ? "https://image.dalbitlive.com/ani/thumbs/star_thumb.jpg" : data;
                    return '<img class="" src="'+ imgurl +'" width="50px" height="50px"/>';
                }},
            {'title': '아이템명', 'data': 'itemName'},
            {'title': '선물 수', 'data': 'itemCnt', 'render': function (data) {
                    return common.addComma(data) + " 개"
                }},
            {'title': '선물 별', 'data': 'gold', 'render': function (data) {
                    return common.addComma(data) + " 별"
                }},
            {'title': '선물 일시', 'data': 'giftDateFormat'},
        ]
    },
}
