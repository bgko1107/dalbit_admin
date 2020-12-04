var ClipHistoryDataTableSource = {
    'list': {
        'url': '/rest/clip/history/list'

        , 'columns': [
			{'title': '플랫폼', 'width':'40px', 'data': 'osType', 'render': function (data, type, row, meta) {
                    return util.getCommonCodeLabel(data, clip_platformType);
                }},
			{'title': '주제', 'width':'60px', 'data': 'subjectName', 'render': function (data, type, row, meta) {
                    return data;
                }},
			{'title': '클립', 'width':'180px', 'data': 'title', 'render': function (data, type, row, meta) {
                    return '<a href="javascript://" class="_openClipInfoPop" data-clipNo="' + row.castNo + '">' + data + '</a>';
                }},
			{'title': '이미지', 'width':'50px', 'data': 'imageBackground', 'render': function (data, type, row, meta) {
                    if(common.isEmpty(data)){
                        return "";
                    }
                    return '<img class="thumbnail fullSize_background" src="'+ PHOTO_SERVER_URL + data +'" width="50px" max-height="50px" />';

                    // return data;
                }},
			{'title': '[듣기]<br>녹음시간', 'width':'50px', 'data': 'filePath', 'render': function (data, type, row, meta) {

                    return row.filePlay + '<br /><a class="_openClipPlayerPop" id="' + "play_" + row.castNo + '" data-clipNo="' + row.castNo + '" data-clipPath="' + data + '" href="javascript:;" >[ <i class="fa fa-play"></i> 듣기]</a>';
                    // return '<audio class="clipPlayer" id="player_' + row.castNo + '" onended="playEnd(' + row.castNo + ')"><source src="'+ PHOTO_SERVER_URL + row.filePath +'"></audio><a id="' + "play_" + row.castNo + '" data-castNo="' + row.castNo + '" href="javascript:;" onclick="eventPlay($(this))">[ <i class="fa fa-play"></i> ]</a><br>' + row.filePlay;
                }},
            {'title': '등록회원', 'width':'70px', 'data': 'memNo', 'render': function (data, type, row, meta) {
                    return row.memNick + '<br /><a href="javascript://" class="_openMemberPop" data-memno="' + data + '">' + data + '</a>';
                }},
			{'title': '성별(나이)', 'width':'70px', 'data': 'memSex', 'render': function (data, type, row, meta) {
                    return common.sexIcon(data,row.memBirthYear,true);
                }},
			{'title': '등록일시', 'width':'70px', 'data': 'startDate', 'render': function (data, type, row, meta) {
                    return data;
                }},
			{'title': '공개<br>여부', 'width':'25px', 'data': 'typeOpen', 'render': function (data, type, row, meta) {
                    return util.getCommonCodeLabel(data, clip_typeOpen);
                }},
            {'title': '인증<br>여부', 'width':'35px', 'data': 'clipConfirm', 'render': function (data, type, row, meta) {
                    return util.getCommonCodeLabel(data, clip_confirmType_yn) + '<br>' + '<a href="javascript:;" onclick="editClipConfirm('+ row.castNo + ',' + data + ')">[' + util.getCommonCodeLabel(data, clip_confirmType_update) + ']</a>';
                }},
            {'title': '운영자<br>메모', 'width':'40px', 'data': 'opMemoCnt', 'render': function (data, type, row, meta) {
                    return '<a href="javascript://" class="_openClipInfoPop" data-clipNo="' + row.castNo + '" data-tabid="bt_detail_memo">' + common.addComma(data) + '</a>';
                }},
            {'title': '청취자', 'width':'50px', 'data': 'countPlayMemberCnt', 'render': function (data, type, row, meta) {
                    return '<a href="javascript://" class="_openClipInfoPop" data-clipNo="' + row.castNo + '" data-tabid="tab_listen">' + common.addComma(data) + '</a>';
                }},
			{'title': '청취수', 'width':'50px', 'data': 'countPlay', 'render': function (data, type, row, meta) {
                    return '<a href="javascript://" class="_openClipInfoPop" data-clipNo="' + row.castNo + '" data-tabid="tab_listen">' + common.addComma(data) + '</a>';
                }},
			{'title': '최다<br>청취수', 'width':'50px', 'data': 'countMaxPlay', 'render': function (data, type, row, meta) {
                    return '<a href="javascript://" class="_openClipInfoPop" data-clipNo="' + row.castNo + '" data-tabid="tab_listen" data-orderby="3">' + common.addComma(data) + '</a>';
                }},
			{'title': '좋아요', 'width':'50px', 'data': 'countGood', 'render': function (data, type, row, meta) {
                    return '<a href="javascript://" class="_openClipInfoPop" data-clipNo="' + row.castNo + '" data-tabid="tab_good">' + common.addComma(data) + '</a>';
                }},
			{'title': '선물 건', 'width':'50px', 'data': 'countGift', 'render': function (data, type, row, meta) {
                    return '<a href="javascript://" class="_openClipInfoPop" data-clipNo="' + row.castNo + '" data-tabid="tab_gift">' + common.addComma(data) + '</a>';
                }},
			{'title': '선물 별', 'width':'55px', 'data': 'countByeol', 'render': function (data, type, row, meta) {
                    return '<a href="javascript://" class="_openClipInfoPop" data-clipNo="' + row.castNo + '" data-tabid="tab_gift">' + common.addComma(data) + '</a>';
                }},
			{'title': '댓글', 'width':'45px', 'data': 'replyCnt', 'render': function (data, type, row, meta) {
                    return '<a href="javascript://" class="_selectReply" data-reply="' + data +  '" data-cast_no="' + row.castNo +'">' + data + '</a>';
                }},
			{'title': '숨기기', 'width':'45px', 'data': 'hide', 'render': function (data, type, row, meta) {
                    if(row.state == 4 || row.state == 5){
                        return "-";
                    }

                    if(data == 0){
                        return '<a href="javascript:;" onclick="updateClipHide(' + row.castNo + ', '+ data +')">[숨기기]</a>';
                    }else{
                        return '<a href="javascript:;" onclick="updateClipHide(' + row.castNo + ', '+ data +')">[해제]</a>';
                    }
                }},
            {'title': '삭제', 'width':'70px', 'data': 'state', 'render': function (data, type, row, meta) {
                    if(data == 4 || row.state == 5){
                        return "-";
                    }else{
                        return '<p class="mb5"><a href="javascript:;" onclick="reportDeleteClip(' + row.castNo + ')">[경고/삭제]</a></p><a href="javascript:;" onclick="deleteClip(' + row.castNo + ', ' + row.memNo + ')">[삭제]</a>';
                    }
                }},
			{'title': '상태', 'width':'45px', 'data': 'state', 'render': function (data, type, row, meta) {
                    if(data == 4 || data == 5){
                        return '<span style="color:red;font-weight:bold">삭제</span>' + (common.isEmpty(row.delName) ? '' : '<br>(' + row.delName + ')');
                    }

                    if(row.hide == 1){
                        return util.getCommonCodeLabel(data, clip_hide) + (common.isEmpty(row.hideName) ? '' : '<br>(' + row.hideName + ')');
                    }

                    return util.getCommonCodeLabel(data, clip_stateType);
                }},
        ],

        'createdRow' : function( row, data, dataIndex ) {
            if(data.inner == 1){    // 테스트계정 row 색상 표시
                $(row).addClass("bg-testMember");
            }
        }
    },




    'listenList': {
        'url': '/rest/clip/history/listen/list'

        , 'columns': [
            {'title': '청취일시', 'width':'70px', 'data': 'listenDate', 'render': function (data, type, row, meta) {
                    return data;
                }},
            {'title': '청취회원', 'width':'70px', 'data': 'listenMemNo', 'render': function (data, type, row, meta) {
                    return '<a href="javascript://" class="_openMemberPop" data-memno="' + data + '">' + data + '</a><br>' + row.listenMemNick;
                }},
            {'title': '성별(나이)', 'width':'70px', 'data': 'listenMemSex', 'render': function (data, type, row, meta) {
                    return common.sexIcon(data,row.listenMemBirthYear);
                }},
            {'title': '청취회원IP', 'width':'70px', 'data': 'listenMemIp', 'render': function (data, type, row, meta) {
                    return data;
                }},
            {'title': '', 'width':'2px', 'className': 'no-padding', 'data': '', 'render': function (data, type, row, meta) {
                    return "";
                }},
            {'title': '플랫폼', 'width':'45px', 'data': 'osType', 'render': function (data, type, row, meta) {
                    return util.getCommonCodeLabel(data, clip_platformType);
                }},
            {'title': '주제', 'width':'60px', 'data': 'subjectName', 'render': function (data, type, row, meta) {
                    return data;
                }},
            {'title': '클립', 'width':'170px', 'data': 'title', 'render': function (data, type, row, meta) {
                    return '<a href="javascript://" class="_openClipInfoPop" data-clipNo="' + row.castNo + '">' + row.castNo + '</a><br>' + data;
                }},
            {'title': '이미지', 'width':'50px', 'data': 'imageBackground', 'render': function (data, type, row, meta) {
                    if(common.isEmpty(data)){
                        return "";
                    }
                    return '<img class="thumbnail fullSize_background" src="'+ PHOTO_SERVER_URL + data +'" width="50px" max-height="50px" />';

                    // return data;
                }},
            {'title': '[듣기]<br>녹음시간', 'width':'50px', 'data': 'filePath', 'render': function (data, type, row, meta) {

                    return '<a class="_openClipPlayerPop" id="' + "play_" + row.castNo + '" data-clipNo="' + row.castNo + '" data-clipPath="' + data + '" href="javascript:;" >[ <i class="fa fa-play"></i> 듣기]</a><br>' + row.filePlay;
                    // return '<audio class="clipPlayer" id="player_' + row.castNo + '" onended="playEnd(' + row.castNo + ')"><source src="'+ PHOTO_SERVER_URL + row.filePath +'"></audio><a id="' + "play_" + row.castNo + '" data-castNo="' + row.castNo + '" href="javascript:;" onclick="eventPlay($(this))">[ <i class="fa fa-play"></i> ]</a><br>' + row.filePlay;
                }},
            {'title': '등록회원', 'width':'70px', 'data': 'memNo', 'render': function (data, type, row, meta) {
                    return '<a href="javascript://" class="_openMemberPop" data-memno="' + data + '">' + data + '</a><br>' + row.memNick;
                }},
            {'title': '성별(나이)', 'width':'70px', 'data': 'memSex', 'render': function (data, type, row, meta) {
                    return common.sexIcon(data,row.memBirthYear);
                }},
            {'title': '등록일시', 'width':'70px', 'data': 'startDate', 'render': function (data, type, row, meta) {
                    return data;
                }},
            {'title': '보유달 수', 'width':'50px', 'data': 'dal', 'render': function (data, type, row, meta) {
                    return common.addComma(data);
                }},
            {'title': '청취수', 'width':'50px', 'data': 'countPlay', 'render': function (data, type, row, meta) {
                    return '<a href="javascript://" class="_openClipInfoPop" data-clipNo="' + row.castNo + '" data-tabid="tab_listen">' + common.addComma(data) + '</a>';
                }},
            {'title': '좋아요 수', 'width':'50px', 'data': 'countGood', 'render': function (data, type, row, meta) {
                    return '<a href="javascript://" class="_openClipInfoPop" data-clipNo="' + row.castNo + '" data-tabid="tab_good">' + common.addComma(data) + '</a>';
                }},
        ],

        'createdRow' : function( row, data, dataIndex ) {
            if(data.inner == 1){    // 테스트계정 row 색상 표시
                $(row).addClass("bg-testMember");
            }
        }
    },


    'giftList': {
        'url': '/rest/clip/history/gift/list'

        ,  'columns': [
            {'title': '선물보낸회원', 'width':'70px', 'data': 'memNo', 'render': function (data, type, row, meta) {
                    return '<a href="javascript://" class="_openMemberPop" data-memno="' + data + '">' + data + '</a><br>' + row.memNick;
                }},
            {'title': '성별(나이)', 'width':'70px', 'data': 'memSex', 'render': function (data, type, row, meta) {
                    return common.sexIcon(data,row.memBirthYear);
                }},
            {'title': '선물받은일시', 'width':'70px', 'data': 'giftDate', 'render': function (data, type, row, meta) {
                    return data;
                }},
            {'title': '주제', 'width':'60px', 'data': 'subjectName', 'render': function (data, type, row, meta) {
                    return data;
                }},
            {'title': '클립', 'width':'180px', 'data': 'title', 'render': function (data, type, row, meta) {
                    return '<a href="javascript://" class="_openClipInfoPop" data-clipNo="' + row.castNo + '">' + row.castNo + '</a><br>' + data;
                }},
            {'title': '선물받은회원', 'width':'70px', 'data': 'giftedMemNo', 'render': function (data, type, row, meta) {
                    return '<a href="javascript://" class="_openMemberPop" data-memno="' + data + '">' + data + '</a><br>' + row.giftedMemNick;
                }},
            {'title': '성별(나이)', 'width':'70px', 'data': 'giftedMemSex', 'render': function (data, type, row, meta) {
                    return common.sexIcon(data,row.giftedMemBirthYear);
                }},
            {'title': '이미지', 'width':'50px', 'data': 'itemThumbnail', 'render': function (data, type, row, meta) {
                    if(common.isEmpty(data)){
                        return "";
                    }
                    return '<img class="fullSize_background _webpImage" src="'+ data +'" width="50px" max-height="50px" data-webpImage="' + row.itemWebpImage+ '"/>';

                    // return data;
                }},
            {'title': '선물명', 'width':'70px', 'data': 'itemName', 'render': function (data, type, row, meta) {
                    return data;
                }},
            {'title': '받은선물<br>개수', 'width':'50px', 'data': 'itemCnt', 'render': function (data, type, row, meta) {
                    return common.addComma(data);
                }},
            {'title': '받은선물<br>별 수', 'width':'50px', 'data': 'gold', 'render': function (data, type, row, meta) {
                    return common.addComma(data);
                }},
            {'title': '누적<br>받은선물<br>개수', 'width':'50px', 'data': 'itemTotalCnt', 'render': function (data, type, row, meta) {
                    return common.addComma(data);
                }},
            {'title': '누적<br>받은선물<br>별 수', 'width':'50px', 'data': 'goldTotalCnt', 'render': function (data, type, row, meta) {
                    return common.addComma(data);
                }},
        ],

        'createdRow' : function( row, data, dataIndex ) {
            if(data.inner == 1){    // 테스트계정 row 색상 표시
               $(row).addClass("bg-testMember");
            }
        }
    },


    'removeList': {
        'url': '/rest/clip/history/remove/list'

        , 'columns': [
            {'title': '공개<br>여부', 'width':'25px', 'data': 'typeOpen', 'render': function (data, type, row, meta) {
                    return util.getCommonCodeLabel(data, clip_typeOpen);
                }},
            {'title': '인증<br>여부', 'width':'25px', 'data': 'clipConfirm', 'render': function (data, type, row, meta) {
                    return util.getCommonCodeLabel(data, clip_confirmType_yn);
                }},
            {'title': '플랫폼', 'width':'45px', 'data': 'osType', 'render': function (data, type, row, meta) {
                    return util.getCommonCodeLabel(data, clip_platformType);
                }},
            {'title': '주제', 'width':'60px', 'data': 'subjectName', 'render': function (data, type, row, meta) {
                    return data;
                }},
            {'title': '클립', 'width':'180px', 'data': 'title', 'render': function (data, type, row, meta) {
                    return '<a href="javascript://" class="_openClipInfoPop" data-clipNo="' + row.castNo + '">' + row.castNo + '</a><br>' + data;
                }},
            {'title': '이미지', 'width':'50px', 'data': 'imageBackground', 'render': function (data, type, row, meta) {
                    if(common.isEmpty(data)){
                        return "";
                    }
                    return '<img class="thumbnail fullSize_background" src="'+ PHOTO_SERVER_URL + data +'" width="50px" max-height="50px" />';

                    // return data;
                }},
            {'title': '[듣기]<br>녹음시간', 'width':'50px', 'data': 'filePath', 'render': function (data, type, row, meta) {

                    return '<a class="_openClipPlayerPop" id="' + "play_" + row.castNo + '" data-clipNo="' + row.castNo + '" data-clipPath="' + data + '" href="javascript:;" >[ <i class="fa fa-play"></i> 듣기]</a><br>' + row.filePlay;
                    // return '<audio class="clipPlayer" id="player_' + row.castNo + '" onended="playEnd(' + row.castNo + ')"><source src="'+ PHOTO_SERVER_URL + row.filePath +'"></audio><a id="' + "play_" + row.castNo + '" data-castNo="' + row.castNo + '" href="javascript:;" onclick="eventPlay($(this))">[ <i class="fa fa-play"></i> ]</a><br>' + row.filePlay;
                }},
            {'title': '등록회원', 'width':'70px', 'data': 'memNo', 'render': function (data, type, row, meta) {
                    return '<a href="javascript://" class="_openMemberPop" data-memno="' + data + '">' + data + '</a><br>' + row.memNick;
                }},
            {'title': '성별(나이)', 'width':'70px', 'data': 'memSex', 'render': function (data, type, row, meta) {
                    return common.sexIcon(data,row.memBirthYear);
                }},
            {'title': '삭제일시', 'width':'70px', 'data': 'endDate', 'render': function (data, type, row, meta) {
                    return data;
                }},
            {'title': '보유달 수', 'width':'50px', 'data': 'dal', 'render': function (data, type, row, meta) {
                    return common.addComma(data);
                }},
            {'title': '청취수', 'width':'50px', 'data': 'countPlay', 'render': function (data, type, row, meta) {
                    return '<a href="javascript://" class="_openClipInfoPop" data-clipNo="' + row.castNo + '" data-tabid="tab_listen">' + common.addComma(data) + '</a>';
                }},
            {'title': '좋아요 수', 'width':'50px', 'data': 'countGood', 'render': function (data, type, row, meta) {
                    return '<a href="javascript://" class="_openClipInfoPop" data-clipNo="' + row.castNo + '" data-tabid="tab_good">' + common.addComma(data) + '</a>';
                }},
            {'title': '삭제구분', 'width':'50px', 'data': 'delName', 'render': function (data, type, row, meta) {
                    return common.isEmpty(data) ? "" : data;
                }},
        ],

        'createdRow' : function( row, data, dataIndex ) {
            if(data.inner == 1){    // 테스트계정 row 색상 표시
               $(row).addClass("bg-testMember");
            }
        }
    },


    'memberList': {
        'url': '/rest/clip/history/member/list'
        , 'columns': [
            {'title': '등록<br>건수', 'width':'35px', 'data': 'insertCnt', 'render': function (data, type, row, meta) {
                    return common.addComma(data);
                }},
            {'title': '출력<br>건수', 'width':'35px', 'data': 'viewCnt', 'render': function (data, type, row, meta) {
                    return common.addComma(data);
                }},
            {'title': '숨김<br>건수', 'width':'35px', 'data': 'hideCnt', 'render': function (data, type, row, meta) {
                    return common.addComma(data);
                }},
            {'title': '삭제<br>건수', 'width':'35px', 'data': 'deleteCnt', 'render': function (data, type, row, meta) {
                    return common.addComma(data);
                }},
            {'title': '', 'width':'2px', 'className': 'no-padding', 'data': '', 'render': function (data, type, row, meta) {
                    return "";
                }},
            {"title": "No.", "data": "rowNum", "width": "20px", "defaultContent": "-", 'render' : function(data, type, row, meta, a, b){
                    return data;
                }
            },
            {'title': '공개<br>여부', 'width':'25px', 'data': 'typeOpen', 'render': function (data, type, row, meta) {
                    return util.getCommonCodeLabel(data, clip_typeOpen);
                }},
            {'title': '플랫폼', 'width':'45px', 'data': 'osType', 'render': function (data, type, row, meta) {
                    return util.getCommonCodeLabel(data, clip_platformType);
                }},
            {'title': '주제', 'width':'60px', 'data': 'subjectName', 'render': function (data, type, row, meta) {
                    return data;
                }},
            {'title': '클립', 'width':'180px', 'data': 'title', 'render': function (data, type, row, meta) {
                    return '<a href="javascript://" class="_openClipInfoPop" data-clipNo="' + row.castNo + '">' + row.castNo + '</a><br>' + data;
                }},
            {'title': '이미지', 'width':'50px', 'data': 'imageBackground', 'render': function (data, type, row, meta) {
                    if(common.isEmpty(data)){
                        return "";
                    }
                    return '<img class="thumbnail fullSize_background" src="'+ PHOTO_SERVER_URL + data +'" width="50px" max-height="50px" />';

                    // return data;
                }},
            {'title': '[듣기]<br>녹음시간', 'width':'50px', 'data': 'filePath', 'render': function (data, type, row, meta) {

                    return '<a class="_openClipPlayerPop" id="' + "play_" + row.castNo + '" data-clipNo="' + row.castNo + '" data-clipPath="' + data + '" href="javascript:;" >[ <i class="fa fa-play"></i> 듣기]</a><br>' + row.filePlay;
                    // return '<audio class="clipPlayer" id="player_' + row.castNo + '" onended="playEnd(' + row.castNo + ')"><source src="'+ PHOTO_SERVER_URL + row.filePath +'"></audio><a id="' + "play_" + row.castNo + '" data-castNo="' + row.castNo + '" href="javascript:;" onclick="eventPlay($(this))">[ <i class="fa fa-play"></i> ]</a><br>' + row.filePlay;
                }},
            {'title': '등록회원', 'width':'70px', 'data': 'memNo', 'render': function (data, type, row, meta) {
                    return '<a href="javascript://" class="_openMemberPop" data-memno="' + data + '">' + data + '</a><br>' + row.memNick;
                }},
            {'title': '성별(나이)', 'width':'70px', 'data': 'memSex', 'render': function (data, type, row, meta) {
                    return common.sexIcon(data,row.memBirthYear);
                }},
            {'title': '삭제일시', 'width':'70px', 'data': 'endDate', 'render': function (data, type, row, meta) {
                    return data;
                }},
            {'title': '보유달 수', 'width':'50px', 'data': 'dal', 'render': function (data, type, row, meta) {
                    return common.addComma(data);
                }},
            {'title': '청취수', 'width':'50px', 'data': 'countPlay', 'render': function (data, type, row, meta) {
                    return '<a href="javascript://" class="_openClipInfoPop" data-clipNo="' + row.castNo + '" data-tabid="tab_listen">' + common.addComma(data) + '</a>';
                }},
            {'title': '좋아요수', 'width':'50px', 'data': 'countGood', 'render': function (data, type, row, meta) {
                    return '<a href="javascript://" class="_openClipInfoPop" data-clipNo="' + row.castNo + '" data-tabid="tab_good">' + common.addComma(data) + '</a>';
                }},
            {'title': '클립목록', 'width':'55px', 'data': 'memNo', 'render': function (data, type, row, meta) {
                    return '<a href="javascript://" class="_openMemberPop" data-memno="' + data + '" data-tabid="tab_clip">[목록확인]</a>';
                }},
        ],

        'createdRow' : function( row, data, dataIndex ) {
            if(data.inner == 1){    // 테스트계정 row 색상 표시
               $(row).addClass("bg-testMember");
            }
        }
    },


    'recommendClip': {
        'url': '/rest/clip/history/list'

        , 'columns': [
            {'title': '플랫폼', 'width':'40px', 'data': 'osType', 'render': function (data, type, row, meta) {
                    return util.getCommonCodeLabel(data, clip_platformType);
                }},
            {'title': '주제', 'width':'60px', 'data': 'subjectName', 'render': function (data, type, row, meta) {
                    return data;
                }},
            {'title': '클립', 'width':'180px', 'data': 'title', 'render': function (data, type, row, meta) {
                    return '<a href="javascript://" class="_openClipInfoPop" data-clipNo="' + row.castNo + '">' + data + '</a>';
                }},
            {'title': '이미지', 'width':'25px', 'data': 'imageBackground', 'render': function (data, type, row, meta) {
                    if(common.isEmpty(data)){
                        return "";
                    }
                    return '<img class="thumbnail fullSize_background" src="'+ PHOTO_SERVER_URL + data +'" width="25px" max-height="25px" />';

                    // return data;
                }},
            {'title': '[듣기]<br>녹음시간', 'width':'50px', 'data': 'filePath', 'render': function (data, type, row, meta) {

                    return row.filePlay + '&nbsp;<a class="_openClipPlayerPop" id="' + "play_" + row.castNo + '" data-clipNo="' + row.castNo + '" data-clipPath="' + data + '" href="javascript:;" >[ <i class="fa fa-play"></i> 듣기]</a>';
                    // return '<audio class="clipPlayer" id="player_' + row.castNo + '" onended="playEnd(' + row.castNo + ')"><source src="'+ PHOTO_SERVER_URL + row.filePath +'"></audio><a id="' + "play_" + row.castNo + '" data-castNo="' + row.castNo + '" href="javascript:;" onclick="eventPlay($(this))">[ <i class="fa fa-play"></i> ]</a><br>' + row.filePlay;
                }},
            {'title': '등록회원', 'width':'70px', 'data': 'memNo', 'render': function (data, type, row, meta) {
                    return row.memNick + ' [<a href="javascript://" class="_openMemberPop" data-memno="' + data + '">' + data + '</a>]';
                }},
            {'title': '성별(나이)', 'width':'70px', 'data': 'memSex', 'render': function (data, type, row, meta) {
                    return common.sexIcon(data,row.memBirthYear);
                }},
            {'title': '등록일시', 'width':'70px', 'data': 'startDate', 'render': function (data, type, row, meta) {
                    return common.substr(data,0,19);
                }},
            {'title': '공개<br>여부', 'width':'25px', 'data': 'typeOpen', 'render': function (data, type, row, meta) {
                    return util.getCommonCodeLabel(data, clip_typeOpen);
                }},
            {'title': '인증<br>여부', 'width':'35px', 'data': 'clipConfirm', 'render': function (data, type, row, meta) {
                    return util.getCommonCodeLabel(data, clip_confirmType_yn) + '&nbsp;<a href="javascript:;" onclick="editClipConfirm('+ row.castNo + ',' + data + ')">[' + util.getCommonCodeLabel(data, clip_confirmType_update) + ']</a>';
                }},
            // {'title': '운영자<br>메모', 'width':'40px', 'data': 'opMemoCnt', 'render': function (data, type, row, meta) {
            //         return '<a href="javascript://" class="_openClipInfoPop" data-clipNo="' + row.castNo + '" data-tabid="bt_detail_memo">' + common.addComma(data) + '</a>';
            //     }},
            // {'title': '청취자', 'width':'50px', 'data': 'countPlayMemberCnt', 'render': function (data, type, row, meta) {
            //         return '<a href="javascript://" class="_openClipInfoPop" data-clipNo="' + row.castNo + '" data-tabid="tab_listen">' + common.addComma(data) + '</a>';
            //     }},
            {'title': '청취수', 'width':'50px', 'data': 'countPlay', 'render': function (data, type, row, meta) {
                    return '<a href="javascript://" class="_openClipInfoPop" data-clipNo="' + row.castNo + '" data-tabid="tab_listen">' + common.addComma(data) + '</a>';
                }},
            // {'title': '최다<br>청취수', 'width':'50px', 'data': 'countMaxPlay', 'render': function (data, type, row, meta) {
            //         return '<a href="javascript://" class="_openClipInfoPop" data-clipNo="' + row.castNo + '" data-tabid="tab_listen" data-orderby="3">' + common.addComma(data) + '</a>';
            //     }},
            {'title': '좋아요', 'width':'50px', 'data': 'countGood', 'render': function (data, type, row, meta) {
                    return '<a href="javascript://" class="_openClipInfoPop" data-clipNo="' + row.castNo + '" data-tabid="tab_good">' + common.addComma(data) + '</a>';
                }},
            // {'title': '선물 건', 'width':'50px', 'data': 'countGift', 'render': function (data, type, row, meta) {
            //         return '<a href="javascript://" class="_openClipInfoPop" data-clipNo="' + row.castNo + '" data-tabid="tab_gift">' + common.addComma(data) + '</a>';
            //     }},
            // {'title': '선물 별', 'width':'55px', 'data': 'countByeol', 'render': function (data, type, row, meta) {
            //         return '<a href="javascript://" class="_openClipInfoPop" data-clipNo="' + row.castNo + '" data-tabid="tab_gift">' + common.addComma(data) + '</a>';
            //     }},
            // {'title': '댓글', 'width':'45px', 'data': 'replyCnt', 'render': function (data, type, row, meta) {
            //         return '<a href="javascript://" class="_selectReply" data-reply="' + data +  '" data-cast_no="' + row.castNo +'">' + data + '</a>';
            //     }},
            // {'title': '숨기기', 'width':'45px', 'data': 'hide', 'render': function (data, type, row, meta) {
            //         if(row.state == 4 || row.state == 5){
            //             return "-";
            //         }
            //
            //         if(data == 0){
            //             return '<a href="javascript:;" onclick="updateClipHide(' + row.castNo + ', '+ data +')">[숨기기]</a>';
            //         }else{
            //             return '<a href="javascript:;" onclick="updateClipHide(' + row.castNo + ', '+ data +')">[해제]</a>';
            //         }
            //     }},
            // {'title': '삭제', 'width':'70px', 'data': 'state', 'render': function (data, type, row, meta) {
            //         if(data == 4 || row.state == 5){
            //             return "-";
            //         }else{
            //             return '<p class="mb5"><a href="javascript:;" onclick="reportDeleteClip(' + row.castNo + ')">[경고/삭제]</a></p><a href="javascript:;" onclick="deleteClip(' + row.castNo + ', ' + row.memNo + ')">[삭제]</a>';
            //         }
            //     }},
            {'title': '상태', 'width':'45px', 'data': 'state', 'render': function (data, type, row, meta) {
                    if(data == 4 || data == 5){
                        return '<span style="color:red;font-weight:bold">삭제</span>' + (common.isEmpty(row.delName) ? '' : '<br>(' + row.delName + ')');
                    }

                    if(row.hide == 1){
                        return util.getCommonCodeLabel(data, clip_hide) + (common.isEmpty(row.hideName) ? '' : '<br>(' + row.hideName + ')');
                    }

                    return util.getCommonCodeLabel(data, clip_stateType);
                }},
        ],

        'createdRow' : function( row, data, dataIndex ) {
            if(data.inner == 1){    // 테스트계정 row 색상 표시
                $(row).addClass("bg-testMember");
            }
        }
    },
}
