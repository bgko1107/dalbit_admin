var BroadcastDataTableSource = {
    'liveList': {
        'url': '/rest/broadcast/broadcast/list'
        , 'columns': [
            {'title': '플랫폼', 'data': 'osType','width' : '30px', 'render': function (data) {
                    if(data == 3){
                        var tmp = '<img src="https://cdn.zeplin.io/5e841bd8a790d06f2465dd87/assets/4bb20760-4afb-46a1-8bdf-35106f1a4e46.svg"> <br/>' ;
                    }else{
                        var tmp = '<img src="https://cdn.zeplin.io/5e841bd8a790d06f2465dd87/assets/dca7b592-edb6-4080-b763-7e535529661f.svg"> <br/>' ;
                    }
                    return tmp + util.getCommonCodeLabel(data, os_type);
                }},
            {'title': '게스트<br />여부', 'data': 'guestCnt','width' : '35px','render': function (data, type, row, meta) {
                    var tmp = 0 < data ? 'Y' : 'N';
                    return '<a href="javascript://" onclick="broadCastLivePopUp( ' + row.room_no + ', ' + 2 + ');">' + tmp + '</a>';
                }},
            {'title': '주제<br/>제목', 'data': 'title','width' : '150px', 'render': function (data, type, row, meta) {
                    var tmp_mediaType = "";
                    if(!common.isEmpty(row.mediaType)){
                        if(row.mediaType == "a"){
                            tmp_mediaType += '<img class="mediaType" id="mediaType" name="mediaType" data-mediaType="' + row.mediaType + '" src="https://image.dalbitlive.com/svg/ico_live_audio.svg" alt="your image" style="width: 33px;height: 33px" />';
                        }else{
                            tmp_mediaType += '<img class="mediaType" id="mediaType" name="mediaType" data-mediaType="' + row.mediaType + '" src="https://image.dalbitlive.com/svg/ico_live_video_b.svg" alt="your image" style="width: 33px;height: 33px" />';
                        }
                        return tmp_mediaType + ' ' + row.subject_name + '<br/>' + util.roomNoLink(data, row.room_no);
                    }else{
                        return "";
                    }
                }},
            {'title': '방송방', 'data': 'backgroundImage', 'width' : '50px', 'render' : function(data, type, row){
                    return '<img class="thumbnail fullSize_background" src="'+ PHOTO_SERVER_URL + data +'" width="65px" height="65px" />';
                }},
            {'title': '프로필', 'data': 'dj_profileImage', 'width' : '50px', 'render' : function(data, type, row){
                    return '<img class="thumbnail fullSize_background" src="'+ common.profileImage(PHOTO_SERVER_URL,data,row.dj_memSex) +'" width="65px" height="65px" />';
                }},
            {'title': '보유뱃지', 'data': 'tag','width' : '45px', 'render': function (data, type, row, meta) {
                    var tmp = "";
                    /*for(var i=0;i<row.fanBadgeList.length;i++){
                        tmp = tmp + util.getMemberBadge(row.fanBadgeList[i].startColor, row.fanBadgeList[i].endColor, null, row.fanBadgeList[i].text , "100%", "20px", 10, "15px", "15px" );
                    }*/
                    // for(var i=0;i<row.liveBadgeList.length;i++) {
                    //     tmp = tmp + util.getMemberBadge(row.liveBadgeList[i].startColor, row.liveBadgeList[i].endColor, null, row.liveBadgeList[i].text, "100%", "20px", 10, "15px", "15px");
                    // }

                    // if(row.recommBadge == "1"){
                    //     tmp = tmp + util.getMemberBadge("#d943c1", "#d943c1", null, "추천", "100%", "20px", 10, "15px", "15px");
                    // }
                    // if(row.popularBadge == "1"){
                    //     tmp = tmp + util.getMemberBadge("#d943c1", "#3761d9", null, "인기", "100%", "20px", 10, "15px", "15px");
                    // }
                    // if(row.newdj_badge == "1"){
                    //     tmp = tmp + util.getMemberBadge("#d943c1", "#d9c811", null, "신입", "100%", "20px", 10, "15px", "15px");
                    // }
                    if(row.specialdj_badge == "1"){
                        tmp = tmp + util.getMemberBadge("red", "red", null, "스페셜DJ", "100%", "20px", 10, "15px", "15px");
                    }
                    if(row.specialdj_badge == "2"){
                        tmp = tmp + util.getMemberBadge("#632BEB", "#632BEB", null, "베스트DJ", "100%", "20px", 10, "15px", "15px");
                    }
                    if(row.shiningdj_badge == "1"){
                        tmp = tmp + util.getMemberBadge("pink", "pink", null, "샤이닝DJ", "100%", "20px", 10, "15px", "15px");
                    }
                    return tmp;
                }},
            {'title': '회원번호<br/>닉네임', 'data': 'dj_nickname','width' : '75px','render': function (data, type, row, meta) {
                    var tmp = util.memNoLink(row.dj_mem_no, row.dj_mem_no);
                    return tmp + '<br/>' + data + '<br/>' + common.sexIcon(row.dj_memSex, row.dj_birth_year);
                }},
            // {'title': '성별', 'data': 'dj_memSex', 'width':'35px', 'render': function (data, type, row, meta) {
            //         return ;
            //     }},
            {'title': '방송<br/>개설', 'data': 'broadCastCnt','width' : '30px', 'render': function (data, type, row, meta) {
                    return common.addComma(data);
                }},
            {'title': '상태(Mic)<br/>/숨김', 'data': 'state', 'width':'35px', 'render': function (data, type, row, meta) {

                    if(row.freezeMsg == 1){
                        return "채팅 얼리기<br/>/ " + (row.hide == 0 ? 'N' : 'Y');
                    }else{
                        return util.getCommonCodeLabel(data,room_state) + '<br/>/ ' + (row.hide == 0 ? ' N' : 'Y');
                    }
                }},
            {'title': '보름달', 'data': 'complete_moon','width' : '50px', 'render': function (data, type, row, meta) {
                    var moonName = '';
                    if(data == 2){
                        moonName = '(슈퍼문)<br />'
                    }
                    return 0 < data ? moonName + common.convertToDate(row.complete_date, 'YYYY-MM-DD HH:mm:ss') : row.step + "단계";
                }},
            {'title': '시작일시', 'data': 'start_date','width' : '50px'},
            {'title': '진행시간', 'data': 'airTime','width' : '45px','render': function (data){
                    return common.timeStamp(data);
                }},
            {'title': '받은 별<br/>(부스터제외)', 'data': 'byeolCnt','width' : '40px','render': function (data, type, row, meta) {
                    var tmp = common.addComma(data);
                    var totalByeolCnt = data + (row.boosterCnt * 10);
                    return '<a href="javascript://" onclick="broadCastLivePopUp( ' + row.room_no + ', ' + 5 + ');" style="color:#555555">' + common.addComma(totalByeolCnt) + '개' + '<br/>(' + tmp + '개)</a>';
                }},
            {'title': '랭킹점수', 'data': 'total','width' : '45px','render': function (data){
                    return common.addComma(data) + "점";
                }},
            {'title': '누적 청취<br />(신규 팬)', 'data': 'totalListener','width' : '55px','render': function (data, type, row, meta) {
                    return common.addComma(row.memTotalListener) + '명<br />' + '( '+ common.addComma(row.count_fan) +'명 )';
                }},
            {'title': '<lable style="color:red">청취자</lable>', 'data': 'liveListener','color': 'red','width' : '40px','render': function (data, type, row, meta) {
                    return '<a href="javascript://" onclick="broadCastLivePopUp( ' + row.room_no + ', ' + 1 + ');" style="color:red">' + common.addComma(row.memLiveListener) + '명' + '</a>';
                }},
            {'title': '좋아요<br/>(부스터제외)', 'data': 'goodCnt','width' : '35px','render': function (data,type,row,meta){
                    var totalGoodCnt = data + (row.boosterCnt * 10);
                    return totalGoodCnt + "건<br/>(" + common.addComma(data) + "건)";
                }},
            {'title': '부스터<br/>(만료/진행)', 'data': 'boosterCnt','width' : '50px','render': function (data, type, row, meta) {
                    var liveboostCnt;
                    if((data - row.liveBoostCnt) < 0){
                        liveboostCnt = 0;
                    }else{
                        liveboostCnt = data - row.liveBoostCnt;
                    }
                    var tmp = common.addComma(data) + '건<br/>(' + common.addComma(liveboostCnt ) +"건 / " + common.addComma(row.liveBoostCnt) + '건)';
                    return tmp;
                }},
            // {'title': '선물', 'data': 'giftCnt','width' : '30px','render': function (data, type, row, meta) {
            //         var tmp = common.addComma(data);
            //         return '<a href="javascript://" onclick="broadCastLivePopUp( ' + row.room_no + ', ' + 4 + ');" style="color:#555555">' + tmp + '건</a>';
            //     }},

            // {'title': '팬 수', 'data': 'fanCnt','width' : '40px','render': function (data){
            //         var tmp = common.addComma(data);
            //         return tmp + "명";
            //     }},
            // {'title': '강제퇴장', 'data': 'forcedCnt','width' : '50px','render': function (data){
            //         var tmp = common.addComma(data);
            //         return tmp + "명";
            //     }},
            {'title': '사연', 'data': 'storyCnt','width' : '30px','render': function (data, type, row, meta) {
                    var url = "/broadcast/live/popup/storyPopup?roomNo=" + encodeURIComponent(row.room_no);
                    // var tmp = '<a href="javascript://" class="_openPop" data-url="' + url + '" data-width="'+ 1250 +'" data-height="'+ 700 +'">' + 0 + '</a>';
                    var tmp = '<a href="javascript://" class="_openPop" data-url="' + url + '" data-width="'+ 1250 +'" data-height="'+ 700 +'" style="color:#555555">' + common.addComma(data) + '건</a>';
                    return tmp;
                }},

            {'title': '입장/<br/>강제종료', 'data': '','width' : '55px','render': function (data, type, row, meta) {
                    var tmp = '';
                    if(!common.isEmpty(row.mediaType)){
                        if(row.mediaType == "a"){
                            tmp += '<button type="button" id="bt_broadcastGo" class="btn btn-default btn-xs _openPlayerPop" style="width: 60px;margin-bottom: 1px" data-roomno="' + row.room_no + '" >입장</button><br/>';
                        }else{
                            tmp += '<button type="button" id="bt_broadcastGoVideo" class="btn btn-default btn-xs _openVideoPlayerPop" style="width: 60px;margin-bottom: 1px" data-roomno="' + row.room_no + '" >입장</button><br/>';
                        }
                        tmp += '<button type="button" class="btn btn-danger btn-xs" onclick="forcedEnd($(this).data());" data-memno= "' + row.dj_mem_no + '" data-roomno="' + row.room_no + '" >강제종료</button>';
                    }
                    return tmp;
                }},
            {'title': '방송<br/>연장', 'data': 'extend_time_count','width' : '25px','render': function (data){
                    return common.fontColor(data, 0, 'blue') +'번';
                }},
            {'title': '이어하기', 'data': 'continue_room','width' : '25px','render': function (data){
                    return common.fontColor(data, 0, 'blue') +'번';
                }},
            // {'title': '숨김<br/>상태', 'data': 'hide', 'width':'30px', 'render': function (data, type, row, meta) {
            //         if(data == 0) return "N";
            //         else return "Y";
            //     }},
        ]
        ,'createdRow' : function( row, data, dataIndex ) {
            if (data.inner == 1) {    // 테스트계정 row 색상 표시
                $(row).addClass("bg-testMember");
            }
        }
    },

    'endLiveList': {
        'url': '/rest/broadcast/broadcast/list'
        , 'columns': [
            {'title': '플랫폼', 'data': 'osType','width' : '65px', 'render': function (data) {
                    if(data == 3){
                        var tmp = '<img src="https://cdn.zeplin.io/5e841bd8a790d06f2465dd87/assets/4bb20760-4afb-46a1-8bdf-35106f1a4e46.svg"> <br/>' ;
                    }else{
                        var tmp = '<img src="https://cdn.zeplin.io/5e841bd8a790d06f2465dd87/assets/dca7b592-edb6-4080-b763-7e535529661f.svg"> <br/>' ;
                    }
                    return tmp + util.getCommonCodeLabel(data, os_type);
                }},
            {'title': '주제', 'data': 'subject_name','width' : '65px'},
            {'title': '제목', 'data': 'title','width' : '150px', 'render': function (data, type, row, meta) {
                    var tmp_mediaType = "";
                    if(!common.isEmpty(row.mediaType)) {
                        if (row.mediaType == "a") {
                            tmp_mediaType += '<img class="mediaType" id="mediaType" name="mediaType" data-mediaType="' + row.mediaType + '" src="https://image.dalbitlive.com/svg/ico_live_audio.svg" alt="your image" style="width: 33px;height: 33px" />';
                        } else {
                            tmp_mediaType += '<img class="mediaType" id="mediaType" name="mediaType" data-mediaType="' + row.mediaType + '" src="https://image.dalbitlive.com/svg/ico_live_video_b.svg" alt="your image" style="width: 33px;height: 33px" />';
                        }
                        return tmp_mediaType + ' ' + util.roomNoLink(data, row.room_no);
                    }else{
                        return "";
                    }
                }},
            {'title': '배경', 'data': 'backgroundImage', 'width' : '50px', 'render' : function(data, type, row){
                    return '<img class="thumbnail fullSize_background" src="'+ PHOTO_SERVER_URL + data +'" width="65px" height="65px" />';
                }},
            {'title': '프로필', 'data': 'dj_profileImage', 'width' : '50px', 'render' : function(data, type, row){
                    return '<img class="thumbnail fullSize_background" src="'+ common.profileImage(PHOTO_SERVER_URL,data,row.dj_memSex) +'" width="65px" height="65px" />';
                }},
            /*{'title': '보유뱃지', 'data': 'tag','width' : '80px', 'render': function (data, type, row, meta) {
                    var tmp = "";
                    /!*for(var i=0;i<row.fanBadgeList.length;i++){
                        tmp = tmp + util.getMemberBadge(row.fanBadgeList[i].startColor, row.fanBadgeList[i].endColor, null, row.fanBadgeList[i].text , "100%", "20px", 10, "15px", "15px" );
                    }*!/
                    for(var i=0;i<row.liveBadgeList.length;i++) {
                        tmp = tmp + util.getMemberBadge(row.liveBadgeList[i].startColor, row.liveBadgeList[i].endColor, null, row.liveBadgeList[i].text, "100%", "20px", 10, "15px", "15px");
                    }

                    if(row.recommBadge == "1"){
                        tmp = tmp + util.getMemberBadge("#d943c1", "#d943c1", null, "추천", "100%", "20px", 10, "15px", "15px");
                    }
                    if(row.popularBadge == "1"){
                        tmp = tmp + util.getMemberBadge("#d943c1", "#3761d9", null, "인기", "100%", "20px", 10, "15px", "15px");
                    }
                    if(row.newdj_badge == "1"){
                        tmp = tmp + util.getMemberBadge("#d943c1", "#d9c811", null, "신입", "100%", "20px", 10, "15px", "15px");
                    }
                    if(row.specialdj_badge == "1"){
                        tmp = tmp + util.getMemberBadge("red", "red", null, "스페셜DJ", "100%", "20px", 10, "15px", "15px");
                    }
                    return tmp;
                }},*/
            {'title': '회원번호<br/>닉네임', 'data': 'dj_nickname','width' : '75px','render': function (data, type, row, meta) {
                    var tmp = util.memNoLink(row.dj_mem_no, row.dj_mem_no);
                    return tmp + '<br/>' + data;
                }},
            {'title': '성별', 'data': 'dj_memSex', 'width':'55px', 'render': function (data, type, row, meta) {
                    return common.sexIcon(data, row.dj_birth_year, true);
                }},
            {'title': '방송 개설', 'data': 'broadCastCnt','width' : '70px', 'render': function (data, type, row, meta) {
                    return common.addComma(data);
                }},

            {'title': '상태', 'data': 'state', 'width':'50px', 'render': function (data, type, row, meta) {
                    if(row.freezeMsg == 1){
                        return util.getCommonCodeLabel(data,room_state) + " (채팅 얼리기)";
                    }else{
                        return util.getCommonCodeLabel(data,room_state);
                    }
                }},
            {'title': '보름달', 'data': 'complete_moon','width' : '50px', 'render': function (data, type, row, meta) {
                    var moonName = '';
                    if(data == 2){
                        moonName = '(슈퍼문)<br />'
                    }
                    return 0 < data ? moonName + common.convertToDate(row.complete_date, 'YYYY-MM-DD HH:mm:ss') : row.step + "단계";
                }},
            {'title': '시작일시', 'data': 'start_date','width' : '60px'},
            {'title': '종료일시', 'data': 'end_date','width' : '60px'},
            {'title': '진행시간', 'data': 'airTime','width' : '65px','render': function (data){
                    return common.timeStamp(data);
                }},
            {'title': '<lable style="color:red">누적청취</lable><br />(신규 팬)', 'data': 'totalListener','width' : '60px','render': function (data, type, row){
                    return '<lable style="color:red">' + common.addComma(data) + ' 명</lable><br />'+ '( '+ common.addComma(row.count_fan) +'명 )';
                }},
            {'title': '좋아요', 'data': 'goodCnt','width' : '40px','render': function (data){
                    var tmp = common.addComma(data);
                    return tmp + "건";
                }},
            {'title': '부스터', 'data': 'boosterCnt','width' : '40px','render': function (data){
                    var tmp = common.addComma(data);
                    return tmp + "건";
                }},
            {'title': '선물', 'data': 'giftCnt','width' : '40px','render': function (data){
                    var tmp = common.addComma(data);
                    return tmp + "건";
                }},
            {'title': '받은 별', 'data': 'byeolCnt','width' : '50px','render': function (data){
                    var tmp = common.addComma(data);
                    return tmp + "개";
                }},
            // {'title': '팬 수', 'data': 'fanCnt','width' : '40px','render': function (data){
            //         var tmp = common.addComma(data);
            //         return tmp + "명";
            //     }},
            // {'title': '강제퇴장', 'data': 'forcedCnt','width' : '50px','render': function (data){
            //         var tmp = common.addComma(data);
            //         return tmp + "명";
            //     }},
            {'title': '사연', 'data': 'storyCnt','width' : '40px','render': function (data, type, row, meta) {
                    var url = "/broadcast/live/popup/storyPopup?roomNo=" + encodeURIComponent(row.room_no);
                    // var tmp = '<a href="javascript://" class="_openPop" data-url="' + url + '" data-width="'+ 1250 +'" data-height="'+ 700 +'">' + 0 + '</a>';
                    var tmp = '<a href="javascript://" class="_openPop" data-url="' + url + '" data-width="'+ 1250 +'" data-height="'+ 700 +'">' + common.addComma(data) + '건</a>';
                    return tmp;
                }},
            {'title': '나가기<br/>시도', 'data': 'exit_try_count','width' : '55px','render': function (data){
                    return common.fontColor(data, 1, 'red') +'번';
                }},
            {'title': '방송<br/>연장', 'data': 'extend_time_count','width' : '35px','render': function (data){
                    return common.fontColor(data, 0, 'blue') +'번';
                }},
            {'title': '이어하기', 'data': 'continue_room','width' : '25px','render': function (data){
                    return common.fontColor(data, 0, 'blue') +'번';
                }},
            {'title': '숨김<br/>상태', 'data': 'hide', 'width':'30px', 'render': function (data, type, row, meta) {
                    if(data == 0) return "N";
                    else return "Y";
                }},
        ]
        ,'createdRow' : function( row, data, dataIndex ) {
            if (data.inner == 1) {    // 테스트계정 row 색상 표시
                $(row).addClass("bg-testMember");
            }
        }
    },

    'broadcastList': {
        'url': '/rest/broadcast/broadcast/list'
        , 'columns': [
            {'title': '상태', 'data': 'state','render': function (data, type, row, meta) {
                    return util.getCommonCodeLabel(data, room_state);
                }},
            {'title': '주제', 'data': 'subject_name'},
            {'title': '제목', 'data': 'title', 'render': function (data, type, row, meta) {
                    return '<a href="javascript://" class="getBroadCast_info" onclick="javascript:getBroadCast_info('+meta.row+');">'+data+'</a>'
                }},
            {'title': '시작일시', 'data': 'start_date'},
            {'title': '종료일시', 'data': 'end_date'},
            {'title': '진행시간', 'data': 'airTime','render':function(data){
                    return common.timeStamp(data);
                }},
            {'title': 'DJ 회원번호', 'data': 'dj_mem_no','render': function (data, type, row, meta) {
                    var tmp = util.memNoLink(data, row.dj_mem_no);
                    tmp = tmp + '<br/>' +  row.dj_level +" / "+ row.dj_grade;
                    return tmp;
                }},
            {'title': 'DJ 닉네임', 'data': 'dj_nickname'},
            {'title': '성별', 'data': 'dj_memSex', 'width':'100px', 'render': function (data, type, row, meta) {
                    return common.sexIcon(data) + "(" +row.dj_korean_age + "세)";
                }},
            {'title': '누적청취자', 'data': 'totalListener','render': function (data){
                    var tmp = common.addComma(data);
                    return tmp + "명";
                }},
            {'title': '<lable style="color:red">청취자</lable>', 'data': 'liveListener','render': function (data){
                    return '<lable style="color:red">' + common.addComma(data) + ' 명</lable>';
                }},
            {'title': '좋아요', 'data': 'goodCnt','render': function (data){
                    var tmp = common.addComma(data);
                    return tmp + "건";
                }},
            {'title': '선물', 'data': 'giftCnt','render': function (data){
                    var tmp = common.addComma(data);
                    return tmp + "건";
                }},
            {'title': '사연수', 'data': 'storyCnt','render': function (data){
                    var tmp = common.addComma(data);
                    return tmp + "건";
                }},
            {'title': '나가기<br />시도', 'data': 'exit_try_count','width' : '70px','render': function (data){
                    return common.fontColor(data, 1, 'red')+'번';
                }},
            {'title': '연장 횟수', 'data': 'extend_time_count','width' : '70px','render': function (data){
                    return common.fontColor(data, 0, 'blue')+'번';
                }},
            {'title': '이어하기', 'data': 'continue_room','width' : '70px','render': function (data){
                    return common.fontColor(data, 0, 'blue') +'번';
                }},
            {'title': '숨김상태', 'data': 'hide', 'render': function (data, type, row, meta) {
                    if(data == 0) return "N";
                    else return "Y";

                }},
        ]
        , 'comments': 'ㆍ방송제목을 클릭하시면 현재 방송중인 정보를 확인 할 수 있습니다.'
    },

    'listenDetail': {
        'url': '/rest/broadcast/listener/list'
        , 'columns': [
            {'title': '구분', 'data': 'state', 'width':'80px', 'render': function (data, type, row, meta) {
                    var tmp = "";

                    if(row.recomm_badge == "1"){
                        tmp = '<span class ="label" style="background-color:#d943c1">' + "추천" + '</span><br/>';
                    }
                    if(row.newdj_badge == "1"){
                        tmp = tmp + '<span class ="label" style="background-color:#632beb">' + "신입DJ" + '</span><br/>';
                    }
                    if(row.specialdj_badge == "1"){
                        tmp = tmp + '<span class ="label" style="background-color:red">' + "스페셜DJ" + '</span>';
                    }
                    if(row.specialdj_badge == "2"){
                        tmp = tmp + '<span class ="label" style="background-color:#632BEB">' + "베스트DJ" + '</span>';
                    }
                    if(row.new_badge == "1"){
                        tmp = tmp + '<span class ="label" style="background-color:#ffc000">' + "신입" + '</span><br/>';
                    }
                    if(data == "1") {
                        return '<lable style="color:#d98000">퇴장</lable><br/>' + tmp;
                    }else if(data == "2"){
                        return '<lable style="color:#ff1600">강제퇴장자</lable><br/>' + tmp;
                    }else if(data == "0"){
                        if(row.shadow == "0"){
                            if(row.auth == "0"){
                                return '<lable style="color:#080004">청취자</lable><br/>' + tmp;
                            }else if(row.auth == "1"){
                                return '<lable style="color:#00ff32">매니저</lable><br/>' + tmp;
                            }else if(row.auth == "2"){
                                return '<lable style="color:#0036ff">게스트</lable><br/>' + tmp;
                            }
                        }else{
                            return '<lable class="font-bold" style="color:#9900ff">관리자</lable><br/>' + tmp;
                        }
                    }
                }},

            {'title': '회원번호', 'data': 'mem_no', 'width':'100px', 'render': function (data, type, row, meta) {
                    var tmp = util.memNoLink(data, row.mem_no);
                    tmp = tmp + '<br/>' +  row.level +" / "+ row.grade;
                    return tmp;
                }},
            {'title': 'User 닉네임', 'data': 'nickName', 'width':'80px'},
            {'title': '성별', 'data': 'mem_sex', 'width':'70px', 'render': function (data, type, row, meta) {
                    return common.sexIcon(data, row.mem_birth_year, true);
                }},
            {'title': '최근 청취 시작 일시', 'data': 'startDateFormat', 'width':'100px'},
            {'title': '청취 종료시간', 'data': 'endDateFormat', 'width':'100px'},
            {'title': '권한 시작 일시', 'data': 'authStartDateFormat', 'width':'100px'},
            {'title': '권한 종료 일시', 'data': 'authEndDateFormat', 'width':'100px'},
            {'title': '누적 청취시간', 'data': 'listenTime', 'width':'100px','render' : function (data, type, row){
                    if(row.shadow == 1){
                        if(common.isEmpty(row.endDateFormat)){
                            return '';
                        }else{
                            var startDate = moment(row.startDateFormat);
                            var endDate = moment(row.endDateFormat);
                            return common.timeStamp(endDate.diff(startDate, 'seconds'));
                        }
                    }
                    return common.timeStamp(data);
                }},
            {'title': '입장수', 'data': 'joinCnt', 'width':'60px'},
            {'title': '좋아요', 'data': 'goodCnt', 'width':'60px'},
            {'title': '부스터', 'data': 'boosterCnt', 'width':'60px', 'render': function (data) {
                    return data + " 개"
                }},
            {'title': '보낸아이템', 'data': 'giftCnt', 'width':'80px', 'render': function (data) {
                    return data + " 개"
                }},
            {'title': '보름달', 'data' : 'complete_moon', 'width':'50px', 'render': function (data, type, row, meta) {
                    var moonName = '';
                    if(data == 2){
                        moonName = '<br />(슈퍼문)';
                    }
                    return 0 < data ? "Y" + moonName : "N";
                }},
            {'title': '디바이스 정보', 'data' : 'osType', 'width':'150px', 'render': function (data, type, row, meta) {
                    var html = '';
                    html += 'osType : ' + row.osType + '<br />';
                    html += '제조사명 : ' + row.deviceManufacturer + '<br />';
                    html += '모델명 : ' + row.deviceModel + '<br />';
                    html += 'appVersion : ' + row.appVersion + '<br />';
                    html += 'buildVersion : ' + row.buildVersion;

                    return html;
                }},
        ]
        , 'comments' : 'ㆍ방송 중 (게스트와 매니저를 포함한) 청취자 변동사항을 확인할 수 있습니다.<br/>' +
                       'ㆍ청취자 리스트는 방송 Live상태 내에서의 데이터로 방송 입퇴장 정보를 포함합니다.'
        ,'createdRow' : function( row, data, dataIndex ) {
            if (data.inner == 1) {    // 테스트계정 row 색상 표시
                $(row).addClass("bg-testMember");
            }
            if (data.shadow == 1) {
                $(row).addClass("font-shadow");
            }
        }
    },

    'guestDetail': {
        'url': '/rest/broadcast/guest/list'
        , 'columns': [
            {'title': '상태', 'data': 'state', 'width':'80px', 'render': function (data, type, row, meta) {
                    if(data == 0){
                        return "게스트 연결종료";
                    }else{
                        return "게스트 연결 중";
                    }
                }},
            {'title': '회원번호', 'data': 'mem_no', 'width':'110px', 'render': function (data, type, row, meta) {
                    var tmp = util.memNoLink(data, row.mem_no);
                    tmp = tmp + '<br/>' +  row.level +" / "+ row.grade;
                    return tmp;
                }},
            {'title': 'User 닉네임', 'data': 'mem_nick', 'width':'140px'},
            {'title': '성별', 'data': 'mem_sex', 'width':'70px', 'render': function (data, type, row, meta) {
                    return common.sexIcon(data, row.mem_birth_year);
                }},
            {'title': '게스트 연결일시', 'data': 'start_date', 'width':'120px'},
            {'title': '게스트 종료일시', 'data': 'end_date', 'width':'120px','render' : function(data, type, row, meta){
                    if(row.state == 1){
                        tmp = '<button type="button" class="btn btn-danger btn-xs" onclick="guestOut( ' + meta.row + ' );" style="width: 75px;margin-bottom: 1px" >게스트 종료</button>';
                        return tmp;
                    }else{
                        return data;
                    }
                }},
            {'title': '게스트 연결시간', 'data': 'air_time', 'width':'120px','render' : function (data){
                    return common.timeStamp(data);
                }},
            {'title': '받은 선물', 'data': 'giftCnt', 'width':'80px', 'render': function (data, type, row) {
                    return common.addComma(data) + " 개<br />" + common.addComma(row.giftGold) +" 별";
                }},
            // {'title': '게스트 신청', 'data': 'proCnt', 'width':'80px', 'render': function (data, type, row, meta) {
            //         return data;
            //     }},
            // {'title': '게스트 신청 취소', 'data': 'proCancelCnt', 'width':'80px', 'render': function (data, type, row, meta) {
            //         return data;
            //     }},
            // {'title': '초대 수', 'data': 'inviteCnt', 'width':'80px', 'render': function (data, type, row, meta) {
            //         return data;
            //     }},
            // {'title': '초대 취소', 'data': 'inviteCancelCnt', 'width':'80px', 'render': function (data, type, row, meta) {
            //         return data;
            //     }},
            // {'title': '게스트 수락', 'data': 'inviteOkCnt', 'width':'80px', 'render': function (data, type, row, meta) {
            //         return data;
            //     }},
            // {'title': '게스트 거절', 'data': 'inviteNoCnt', 'width':'80px', 'render': function (data, type, row, meta) {
            //         return data;
            //     }},
            {'title': '상세내역', 'data': 'inviteNoCnt', 'width':'80px', 'render': function (data, type, row, meta) {
                    return '<a href="javascript://" onclick="guestDetail(' + meta.row + ')">' + "상세내역 보기" + '</a>';
                }},

        ]
        , 'comments' : 'ㆍ방송 중 게스트 신청 및 연결내역을 확인할 수 있습니다.'
    },

    'chatList': {
        'url': '/rest/member/report/list'
        , 'columns': [
            {'title': '채팅 장성 시간', 'data': ''},
            {'title': '채팅 내용', 'data': ''},
        ]
    },


    'likeDetail': {
        'url': '/rest/broadcast/like/list'
        , 'columns': [
            {'title': '회원번호', 'data': 'mem_no', 'width':'100px', 'render': function (data, type, row, meta) {
                    var tmp = util.memNoLink(data, row.mem_no);
                    tmp = tmp + '<br/>' +  row.level +" / "+ row.grade;
                    return tmp;
                }},
            {'title': '보낸 User 닉네임', 'data': 'mem_nick','width' : '150px'},
            {'title': '성별', 'data': 'mem_sex', 'width':'70px', 'render': function (data, type, row, meta) {
                    return common.sexIcon(data, row.mem_birth_year);
                }},
            {'title': '좋아요 보낸 일시', 'data': 'goodDate','width' : '150px'},
            {'title': '누적 부스터', 'data': 'accumCnt','width' : '150px', 'render': function (data) {
                    var tmp = common.addComma(data);
                    return tmp + "건";
                }},
            {'title': '부스터 적용 일시', 'data': 'boosterDateFormat','width' : '150px'},
            {'title': '실시간 순위', 'data': 'rank','width' : '100px', 'render': function (data) {
                    var tmp = common.addComma(data);
                    return tmp + "위";
                }},
        ]
        , 'comments': 'ㆍ방송 중 좋아요와 부스터 적용상태를 확인할 수 있습니다.'
        ,'createdRow' : function( row, data, dataIndex ) {
            if (data.inner == 1) {    // 테스트계정 row 색상 표시
                $(row).addClass("bg-testMember");
            }
        }
    },

    'giftDetail': {
        'url': '/rest/broadcast/gift/list'
        , 'columns': [
            {'title': '회원번호', 'data': 'mem_no', 'render': function (data, type, row, meta) {
                    var tmp = util.memNoLink(data, row.mem_no);
                    tmp = tmp + '<br/>' +  row.level +" / "+ row.grade;
                    return tmp;
                }},
            {'title': '보낸 User 닉네임', 'data': 'nickName'},
            {'title': '성별', 'data': 'mem_sex', 'width':'70px', 'render': function (data, type, row, meta) {
                    return common.sexIcon(data, row.mem_birth_year);
                }},
            {'title': '게스트선물', 'data': 'item_type', 'render': function (data, type, row, meta) {
                    if(data == 8){
                        var tmp = "게스트 선물";
                    }else{
                        var tmp = "DJ선물";
                    }
                    return tmp;
                }},
            {'title': '보낸 일시', 'data': 'giftDateFormat'},
            {'title': '몰래보낸선물', 'data': 'secret', 'render': function (data, type, row, meta) {
                    if(data == 1) var tmp = "O";
                    else var tmp = "X";
                    return tmp;
                }},
            {'title': '이미지', 'data': 'item_thumbnail', 'render' : function(data, type, row, meta){
                    return '<img class="thumbnail" src="'+ data+'" width="50px" height="50px"/>';
                }},
            {'title': '선물 명', 'data': 'itemName'},
            {'title': '선물 수', 'data': 'itemCnt', 'render': function (data) {
                    return data + " 개"
                }},
            // {'title': '누적 선물', 'data': 'accumCnt', 'render': function (data) {
            //         return data + " 개"
            //     }},
            {'title': '받은 별 수', 'data': 'byeolCnt', 'render': function (data) {
                    return data + " 개"
                }},
            // {'title': '누적 받은 별 수', 'data': 'accumByeolCnt', 'render': function (data) {
            //         return data + " 개"
            //     }},
        ]
        , 'comments': 'ㆍ방송 중 DJ에게 보낸 회원 및 선물 세부 내역을 확인할 수 있습니다.'
        ,'createdRow' : function( row, data, dataIndex ) {
            if (data.inner == 1) {    // 테스트계정 row 색상 표시
                $(row).addClass("bg-testMember");
            }
        }
    },

    'storyDetail': {
        'url': '/rest/broadcast/story/list'
        , 'columns': [
            {'title': '회원번호','data':'mem_no', 'render': function (data, type, row, meta) {
                    var tmp = util.memNoLink(data, row.mem_no);
                    tmp = tmp + '<br/>' +  row.level +" / "+ row.grade;
                    return tmp;
                }},
            {'title': '사연 보낸 청취자 닉네임', 'data': 'nickName'},
            {'title': '성별', 'data': 'mem_sex', 'width':'70px', 'render': function (data, type, row, meta) {
                    return common.sexIcon(data, row.mem_birth_year);
                }},
            {'title': '보낸 일시', 'data': 'writeDateFormat'},
            {'title': '사연 내용', 'data': 'contents', 'render': function (data, type, row, meta) {
                    return data.replace(/\\n/gi,"<br/>");
                }},
        ]
        , 'comments': 'ㆍ방송 중 받은 사연 내역을 확인할 수 있습니다.'
        ,'createdRow' : function( row, data, dataIndex ) {
            if (data.inner == 1) {    // 테스트계정 row 색상 표시
                $(row).addClass("bg-testMember");
            }
        }
    },

    'chatDetail': {
        'url': '/rest/broadcast/chat/list'
        , 'columns': [
            {'title': '채팅 시작 일시', 'data': 'writeDateFormat', 'width':'140px'},
            {'title': '채팅 내용', 'data': 'nickname','className': 'al','render': function (data, type, row, meta) {
                var tmp_auth;
                if(row.auth == "0"){             //일반
                    tmp_auth = '<i class="fa fa-volume-up" style="color: #080004"></i>';
                }else if(row.auth == "1"){      //매니저
                    tmp_auth = '<i class="fa fa-street-view" style="color: #00ff32"></i>';
                }else if(row.auth == "2"){      //게스트
                    tmp_auth = '<i class="fa fa-star" style="color: #0036ff"></i>';
                }else if(row.auth == "3"){      //dj
                    tmp_auth = '<i class="fa fa-microphone" style="color: #8556F6"></i>';
                }
                var tmp = tmp_auth + '<a href="javascript://" onclick="targetChat(' + meta.row + ')">' + data + '</a>' + " :" +row.msg;
                return tmp;
            }},
        ]
        ,'createdRow' : function( row, data, dataIndex ) {
            if (data.inner == 1) {    // 테스트계정 row 색상 표시
                $(row).addClass("bg-testMember");
            }
        }
    },

    'targetchat': {
        'url': '/rest/broadcast/chat/targetList'
        , 'columns': [
            {'title': '채팅 시작 일시', 'data': 'writeDateFormat', 'width':'140px'},
            {'title': '채팅 내용', 'data': 'nickname','className': 'al','render': function (data, type, row, meta) {
                var tmp_auth;
                if(row.auth == "0"){             //일반
                    tmp_auth = '<i class="fa fa-volume-up" style="color: #080004"></i>';
                }else if(row.auth == "1"){      //매니저
                    tmp_auth = '<i class="fa fa-street-view" style="color: #00ff32"></i>';
                }else if(row.auth == "2"){      //게스트
                    tmp_auth = '<i class="fa fa-star" style="color: #0036ff"></i>';
                }else if(row.auth == "3"){      //dj
                    tmp_auth = '<i class="fa fa-microphone" style="color: #8556F6"></i>';
                }
                var tmp = tmp_auth + util.memNoLink(data, row.mem_no) + " :" +row.msg;
                return tmp;
            }},
        ]
        ,'createdRow' : function( row, data, dataIndex ) {
            if (data.inner == 1) {    // 테스트계정 row 색상 표시
                $(row).addClass("bg-testMember");
            }
        }
    },

    'editHistory': {
        'url': '/rest/broadcast/broadcast/editHist'
        , 'columns': [
            {'title': '수정일자', 'data': 'editDateFormat','width':'120px'},
            {'title': '수정 내용', 'data': 'editContents','width':'900px','className':'al','render' : function(data){
                    return memberUtil.convertEditHistory(data);
                }},
            {'title': '처리자명', 'data': 'opName','width':'100px'},
        ]
        , 'comments': 'ㆍ회원 또는 운영자에 의해 정보가 수정된 일시를 확인할 수 있습니다.'
    },

    'adminMemoList': {
        'url': '/rest/member/member/adminMemolist'
        , 'columns': [
            {'title': '등록 일시', 'data': 'regDate','width':'180px'},
            {'title': '등록 관리자', 'data': 'opName','width':'100px'},
            {'title': '운영자 메모 내용', 'data': 'memo'},
        ]
    },

    'liveListenerList': {
        'url': '/rest/broadcast/broadcast/live/listener/list'
        , 'columns': [
            {'title': '청취 방송제목', 'data': 'title', 'render': function (data, type, row, meta) {
                    return util.roomNoLink(data, row.roomNo);
                }},
            {'title': 'DJ 회원번호<br/>DJ 닉네임', 'data': 'djMemNo', 'render': function (data, type, row, meta) {
                    return util.memNoLink(data, data) + '<br/>' + row.djNickNm;
                }},
            {'title': '구분', 'data': 'auth', 'render': function (data, type, row, meta) {
                    if(data == "0"){
                        return '<lable style="color:#080004">청취자</lable><br/>';
                    }else if(data == "1"){
                        return '<lable style="color:#00ff32">매니저</lable><br/>';
                    }else if(data == "2"){
                        return '<lable style="color:#0036ff">게스트</lable><br/>';
                    }
                }},
            {'title': '청취플랫폼', 'data': 'os_type', 'render': function (data, type, row, meta) {
                    if(data == 3){
                        var tmp = '<img src="https://cdn.zeplin.io/5e841bd8a790d06f2465dd87/assets/4bb20760-4afb-46a1-8bdf-35106f1a4e46.svg"> <br/>' ;
                    }else{
                        var tmp = '<img src="https://cdn.zeplin.io/5e841bd8a790d06f2465dd87/assets/dca7b592-edb6-4080-b763-7e535529661f.svg"> <br/>' ;
                    }
                    return tmp + util.getCommonCodeLabel(data, os_type);
                }},
            {'title': '청취자<br/>프로필', 'data': 'profImg', 'render': function (data, type, row, meta) {
                    return '<img class="thumbnail fullSize_background" src="'+ common.profileImage(PHOTO_SERVER_URL,data,row.gender) +'" width="65px" height="65px" />';
                }},
            /*{'title': '보유뱃지', 'data': 'tag','width' : '80px', 'render': function (data, type, row, meta) {
                    var tmp = "";
                    /!*for(var i=0;i<row.fanBadgeList.length;i++){
                        tmp = tmp + util.getMemberBadge(row.fanBadgeList[i].startColor, row.fanBadgeList[i].endColor, null, row.fanBadgeList[i].text , "100%", "20px", 10, "15px", "15px" );
                    }*!/
                    for(var i=0;i<row.liveBadgeList.length;i++) {
                        tmp = tmp + util.getMemberBadge(row.liveBadgeList[i].startColor, row.liveBadgeList[i].endColor, null, row.liveBadgeList[i].text, "100%", "20px", 10, "15px", "15px");
                    }

                    if(row.recommBadge == "1"){
                        tmp = tmp + util.getMemberBadge("#d943c1", "#d943c1", null, "추천", "100%", "20px", 10, "15px", "15px");
                    }
                    if(row.popularBadge == "1"){
                        tmp = tmp + util.getMemberBadge("#d943c1", "#3761d9", null, "인기", "100%", "20px", 10, "15px", "15px");
                    }
                    if(row.newdj_badge == "1"){
                        tmp = tmp + util.getMemberBadge("#d943c1", "#d9c811", null, "신입", "100%", "20px", 10, "15px", "15px");
                    }
                    if(row.specialdj_badge == "1"){
                        tmp = tmp + util.getMemberBadge("red", "red", null, "스페셜DJ", "100%", "20px", 10, "15px", "15px");
                    }
                    return tmp;
                }},*/
            {'title': '청취자 회원번호<br/>닉네임', 'data': 'memNo', 'render': function (data, type, row, meta) {
                    if(data.substr(0,1) == "8"){
                        return "비회원";
                    }else{
                        return util.memNoLink(data, data) + "<br/>" + row.nickNm;
                    }
                }},
            {'title': '성별(나이)', 'data': 'gender', 'render': function (data, type, row, meta) {
                    return common.sexIcon(data) + "(" + row.age +")";
                }},
            {'title': '청취시작 시간', 'data': 'joinDt'},
            {'title': '청취 시간', 'data': 'listenTime','render' : function(data){
                    return common.timeStamp(data);
                }},
            {'title': '당일 청취 수', 'data': 'listenCnt', 'render': function (data, type, row, meta) {
                    return data + " 번";
                }},
            {'title': '좋아요(부스트) 수', 'data': 'goodCnt', 'render': function (data, type, row, meta) {
                    return data + " (" + row.boosterCnt +")";
                }},
            {'title': '선물 수', 'data': 'giftCnt', 'render': function (data, type, row, meta) {
                    return common.addComma(data) + " 개";
                }},
            {'title': '강제 퇴장<br/>운영자 알림', 'data': 'mem_no', 'render': function (data, type, row, meta) {
                    var tmp;
                    tmp = '<button type="button" class="btn btn-danger btn-xs" onclick="liveListenForced( ' + meta.row + ' );" style="width: 75px;margin-bottom: 1px" >강제퇴장</button><br/>';
                    if(row.memNo.substr(0,1) != "8") {
                        tmp = tmp + '<button type="button" class="btn btn-default btn-xs" style="width: 75px" onclick="liveListenNotice( ' + meta.row + ' );">운영자알림</button>';
                    }
                    return tmp;
                }},
        ]
        ,'createdRow' : function( row, data, dataIndex ) {
            if (data.inner == 1) {    // 테스트계정 row 색상 표시
                $(row).addClass("bg-testMember");
            }
        }
    },


    'loginUser': {
        'url': '/rest/connect/user/info/current'
        , 'columns': [
            {'title': '가입일시', 'data': 'memJoinDateFormat'},
            {'title': '접속일시', 'data': 'connectDateFormat'},
            {'title': 'OS', 'data': 'os_type', 'render': function (data, type, row, meta) {
                    if(common.isEmpty(data)){
                        data = 3;
                    }
                    if(data == 3){
                        var tmp = '<img src="https://cdn.zeplin.io/5e841bd8a790d06f2465dd87/assets/4bb20760-4afb-46a1-8bdf-35106f1a4e46.svg"> <br/>' ;
                    }else{
                        var tmp = '<img src="https://cdn.zeplin.io/5e841bd8a790d06f2465dd87/assets/dca7b592-edb6-4080-b763-7e535529661f.svg"> <br/>' ;
                    }
                    return tmp + util.getCommonCodeLabel(data, os_type);
                }},
            {'title': '프로필', 'data': 'profile', 'render': function (data, type, row, meta) {
                    return '<img class="thumbnail fullSize_background" src="'+ common.profileImage(PHOTO_SERVER_URL,data,row.mem_sex) +'" width="65px" height="65px" />';
                }},
            /*{'title': '보유뱃지', 'data': 'tag','width' : '80px', 'render': function (data, type, row, meta) {
                    var tmp = "";
                    /!*for(var i=0;i<row.fanBadgeList.length;i++){
                        tmp = tmp + util.getMemberBadge(row.fanBadgeList[i].startColor, row.fanBadgeList[i].endColor, null, row.fanBadgeList[i].text , "100%", "20px", 10, "15px", "15px" );
                    }*!/
                    for(var i=0;i<row.liveBadgeList.length;i++) {
                        tmp = tmp + util.getMemberBadge(row.liveBadgeList[i].startColor, row.liveBadgeList[i].endColor, null, row.liveBadgeList[i].text, "100%", "20px", 10, "15px", "15px");
                    }

                    if(row.recommBadge == "1"){
                        tmp = tmp + util.getMemberBadge("#d943c1", "#d943c1", null, "추천", "100%", "20px", 10, "15px", "15px");
                    }
                    if(row.popularBadge == "1"){
                        tmp = tmp + util.getMemberBadge("#d943c1", "#3761d9", null, "인기", "100%", "20px", 10, "15px", "15px");
                    }
                    if(row.newdj_badge == "1"){
                        tmp = tmp + util.getMemberBadge("#d943c1", "#d9c811", null, "신입", "100%", "20px", 10, "15px", "15px");
                    }
                    if(row.specialdj_badge == "1"){
                        tmp = tmp + util.getMemberBadge("red", "red", null, "스페셜DJ", "100%", "20px", 10, "15px", "15px");
                    }
                    return tmp;
                }},*/
            {'title': '회원번호', 'data': 'mem_no', 'render': function (data, type, row, meta) {
                    return util.memNoLink(data, row.mem_no) + "<br/>" + row.mem_nick;
                }},
            {'title': '성별(나이)', 'data': 'mem_sex', 'width':'120px', 'render': function (data, type, row, meta) {
                    return common.sexIcon(data, row.mem_birth_year);
                }},
            {'title': 'IP', 'data': 'ip'},
            {'title': '방생성수', 'data': 'broadcastingCnt', 'render': function (data, type, row, meta) {
                    return common.addComma(data);
                }},
            {'title': '청취일수', 'data': 'listenTime', 'render': function (data, type, row, meta) {
                    return common.timeStampDay(data);
                }},
            {'title': '당일 청취 수', 'data': 'listenCnt'},
            {'title': '결제 건 수/금액', 'data': 'payCnt', 'render': function (data, type, row, meta) {
                    return data + " / " + common.addComma(row.payAmount);
                }},
            {'title': '보유 달', 'data': 'dal', 'render': function (data, type, row, meta) {
                    return common.addComma(data) + " 달";
                }},
        ]
        ,'createdRow' : function( row, data, dataIndex ) {
            if (data.inner == 1) {    // 테스트계정 row 색상 표시
                $(row).addClass("bg-testMember");
            }
        }
    },



    'liveGuestList': {
        'url': '/rest/broadcast/broadcast/live/guest/list'
        , 'columns': [
            {'title': '상태', 'data': 'now_state'},
            {'title': '참여 방송', 'data': 'room_title', 'render': function (data, type, row, meta) {
                    return util.roomNoLink(data, row.room_no);
                }},
            {'title': '프로필', 'data': 'image_profile', 'width' : '50px', 'render' : function(data, type, row){
                    return '<img class="thumbnail fullSize_background" src="'+ common.profileImage(PHOTO_SERVER_URL,data,row.mem_sex) +'" width="65px" height="65px" />';
                }},
            {'title': '회원번호<br/>닉네임', 'data': 'mem_nick','width' : '75px','render': function (data, type, row, meta) {
                    var tmp = util.memNoLink(row.mem_no, row.mem_no);
                    return tmp + '<br/>' + data;
                }},
            {'title': '성별', 'data': 'mem_sex', 'width':'55px', 'render': function (data, type, row, meta) {
                    return common.sexIcon(data, row.mem_birth_year, true);
                }},
            {'title': '연결시작', 'data': 'start_date', 'render': function (data, type, row, meta) {
                    return common.substr(data,0,19);
                }},
            {'title': '종료 시간', 'data': 'end_date', 'render': function (data, type, row, meta) {
                    return common.substr(data,0,19);
                }},
            {'title': '연결 시간', 'data': 'connect_time', 'render': function (data, type, row, meta) {
                    return common.timeStampDay(data,0,8);
                }},
            {'title': '참여형태', 'data': 'join_form', 'render': function (data, type, row, meta) {
                    return data;
                }},
            {'title': '방송참여', 'data': 'total_cnt', 'render': function (data, type, row, meta) {
                    return data + ' 번';
                }},
            {'title': '중복참여', 'data': 'duplicate_cnt', 'render': function (data, type, row, meta) {
                    return data + ' 번';
                }},
            {'title': '선물 수', 'data': 'gift_cnt', 'render': function (data, type, row, meta) {
                    return '<a href="javascript://" class="_openMemberPop" data-memNo=' + row.mem_no + ' data-tabid="tab_walletDetail">' + data + ' 개</a>';
                }},
            {'title': '선물 별', 'data': 'byeol_cnt', 'render': function (data, type, row, meta) {
                    return '<a href="javascript://" class="_openMemberPop" data-memNo=' + row.mem_no + ' data-tabid="tab_walletDetail">' + data + ' 별</a>';
                }},
            {'title': '[강제 종료]<br/>[경고/정지]', 'data': 'mem_no', 'render': function (data, type, row, meta) {
                    if(row.now_state == "종료"){
                        var tmp = '<button type="button" class="btn btn-default btn-xs" onclick="reportPopup( ' + meta.row + ' );">경고/정지</button>';
                    }else{
                        var tmp =  '<button type="button" class="btn btn-danger btn-xs" onclick="guestOut( ' + meta.row + ' );" style="width: 75px;margin-bottom: 1px" >강제 종료</button><br/>';
                        tmp = tmp + '<button type="button" class="btn btn-default btn-xs" onclick="reportPopup( ' + meta.row + ' );">경고/정지</button>';
                    }
                    return tmp;
                }},
        ]
        ,'createdRow' : function( row, data, dataIndex ) {
            if (data.inner == 1) {    // 테스트계정 row 색상 표시
                $(row).addClass("bg-testMember");
            }
        }
    },

    'minigameMemberList': {
        'url': '/rest/content/boardAdm/mini/game/member/list'
        , 'columns': [
            {'title': '회원번호', 'data': 'mem_no', 'width':'100px', 'render': function (data, type, row, meta) {
                    return util.memNoLink(data, row.mem_no);
                }},
            {'title': '닉네임', 'data': 'mem_nick', 'width':'100px'},
            {'title': '참여 게임', 'data': 'gameName', 'width':'100px', 'render': function (data, type, row, meta) {
                    return '룰렛';
                }},
            {'title': '참여일시', 'data': 'last_upd_date', 'width':'100px'},
            {'title': '게임 차감 달', 'data': 'pay_amt', 'width':'100px'},
            {'title': '당첨/선택 옵션', 'data': 'opt', 'width':'100px'},
        ]
        ,'createdRow' : function( row, data, dataIndex ) {
            if (data.inner == 1) {    // 테스트계정 row 색상 표시
                $(row).addClass("bg-testMember");
            }
        }
    },

    'minigameEditHistory': {
        'url': '/rest/content/boardAdm/mini/game/edit/history'
        , 'columns': [
            {'title': '수정일시', 'data': 'edit_date', 'width':'100px'},
            {'title': '개설 게임', 'data': '', 'width':'100px', 'render': function (data, type, row, meta) {
                    return '룰렛';
                }},
            {'title': '수정내역', 'data': 'edit_contents', 'width':'100px'},
            {'title': '처리자명', 'data': 'op_name', 'width':'100px'},
        ]
        ,'createdRow' : function( row, data, dataIndex ) {
            if (data.inner == 1) {    // 테스트계정 row 색상 표시
                $(row).addClass("bg-testMember");
            }
        }
    },

}
