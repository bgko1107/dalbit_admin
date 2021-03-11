var recommDataTableSource = {
    'recommList': {
        'url': '/rest/menu/recomm/list'
        , 'columns': [

            {'title': '이미지', 'width': '10%', 'data': 'imageUrl', 'render': function(data, type, row) {
                    if(!common.isEmpty(data)){
                        return '<img class="thumbnail fullSize_background" src="'+ data +'" width="65px" height="65px" />';
                    }else{
                        return '-';
                    }
                }}
            ,
            {'title': '프로필', 'width': '10%', 'data': 'profileImage', 'render': function(data, type, row) {
                    return '<img class="thumbnail fullSize_background" src="'+ common.profileImage(PHOTO_SERVER_URL, data, row.memSex) +'" width="65px" height="65px" />';
                }}
            ,{'title': '회원번호', 'data': 'mem_no', 'width' : '10%', 'render': function(data, type, row) {
                    return '<a href="javascript://" class="_openMemberPop" data-memno="' + data + '">' + data + '</a><br/>' + row.memNick
                }}
            , {'title': '성별', 'data': 'memSex', 'width':'5%', 'render': function (data, type, row, meta) {
                    var tmp="";
                    if(row.specialdjYn == "1"){
                        tmp = '<span class ="label" style="background-color:red">' + "스페셜DJ" + '</span>';
                    }
                    if(row.shiningdjYn == "1"){
                        tmp = '<span class ="label" style="background-color:#aa00ff">' + "샤이닝DJ" + '</span>';
                    }
                    return common.sexIcon(data, row.mem_birth_year) + '<br/>' + row.ageDesc +'<br/>'+ tmp;
                }}
            , {'title': '소개글', 'data': 'title', 'render': function(data, type, row) {
                    return '<a href="javascript://" onclick="choiceMember($(this).data())" data-mem_no="' + row.mem_no + '">' + data + '</a>';
                }}
            , {'title': '게시여부', 'data': 'viewYn', 'width':'5%', 'render': function (data, type, row, meta) {
                    return util.getCommonCodeLabel(data,'content_viewOn','N','view_yn');
                }}
            , {'title': '추천팬등록수', 'data': 'recommendFanCnt', 'width':'5%', 'render': function (data, type, row, meta) {
                    var tmpUrl = "/menu/recomm/popup/recommendFanList?memNo=" + encodeURIComponent(row.mem_no);

                    return '<a href="javascript://" class="_openPop" data-url="' + tmpUrl + '" data-width="600" data-height="400">' + common.addComma(data) + '</a>';
                }}
            , {'title': '최근 방송일시', 'data': 'last_broadcast', 'width':'5%'}
            , {'title': '최근 7일 방송시간', 'data': 'broadcastTime', 'width':'5%', 'render': function(data, type, row) {
                    return common.timeStampDay(data);
                }}
            , {'title': '등록정보', 'data': 'reg_op_name', 'width':'5%', 'render': function(data, type, row) {
                    return data + '<br/>' + row.upd_op_name;
                }}
        ]
        // , 'comments': ''
        ,'createdRow' : function( row, data, dataIndex ) {
            if (data.inner == 1) {    // 테스트계정 row 색상 표시
                $(row).addClass("bg-testMember");
            }
        }
    },

    'recommFanList': {
        'url': '/rest/menu/recomm/fan/list'
        , 'columns': [
            {'title': '회원번호', 'data': 'mem_no_fan', 'width' : '25%', 'render': function(data, type, row) {
                    return '<a href="javascript://" class="_openMemberPop" data-memno="' + data + '">' + data + '</a>';
                }}
            , {'title': '닉네임', 'data': 'memNick', 'width' : '25%'}
            , {'title': '성별', 'data': 'memSex', 'width':'25%', 'render': function (data, type, row, meta) {
                    return common.sexIcon(data, row.mem_birth_year);
                }}
            , {'title': '팬등록일시', 'data': 'reg_date', 'width' : '25%', 'render': function (data, type, row, meta) {
                    return common.substr(data,0,19);
                }}
        ]
        // , 'comments': ''
        ,'createdRow' : function( row, data, dataIndex ) {
            if (data.inner == 1) {    // 테스트계정 row 색상 표시
                $(row).addClass("bg-testMember");
            }
        }
    },


    'newcomerList': {
        'url': '/rest/content/newcomer/list'
        , 'columns': [

            {'title': '프로필', 'width': '70px', 'data': 'profileImage', 'render': function(data, type, row) {
                    return '<img class="thumbnarest/menu/recommil fullSize_background" src="'+ common.profileImage(PHOTO_SERVER_URL, data, row.mem_sex) +'" width="65px" height="65px" />';
                }}
            , {'title': '회원번호', 'data': 'mem_no', 'width' : '100px', 'render': function(data, type, row) {
                    return '<a href="javascript://" class="_openMemberPop" data-memno="' + data + '">' + data + '</a><br/>' + row.mem_nick
                }}
            , {'title': '성별', 'data': 'mem_sex', 'width':'100px', 'render': function (data, type, row, meta) {
                    var tmp="";
                    if(row.specialdj_badge == "1"){
                        tmp += util.getMemberBadge("red", "red", null, "스페셜DJ", "100%", "20px", 10, "15px", "15px");
                    }
                    if(row.specialdj_badge == "2"){
                        tmp += util.getMemberBadge("#632BEB", "#632BEB", null, "베스트DJ", "100%", "20px", 10, "15px", "15px");
                    }
                    if(row.shiningdj_badge == "1"){
                        tmp += util.getMemberBadge("pink", "pink", null, "샤이닝DJ", "100%", "20px", 10, "15px", "15px");
                    }
                    return common.sexIcon(data, row.mem_birth_year) + '<br/>' + tmp;
                }}
            , {'title': '사용여부', 'data': 'viewYn', 'width':'40px', 'render': function (data, type, row, meta) {
                    return util.getCommonCodeLabel(data,'content_viewOn','N','view_yn');
                }}
            , {'title': 'PUSH문구', 'data': 'send_title', 'width':'180px', 'render': function (data, type, row, meta) {
                    return '<a href="javascript://" onclick="pushDetail(' + meta.row + ');">' + data + '</a>';
                }}
            , {'title': 'PUSH 발송건수', 'data': 'send_cnt', 'width':'60px'}
            , {'title': '최근 방송일시', 'data': 'last_broadcast', 'width':'100px', 'render': function(data, type, row) {
                    return data;
                }}
            , {'title': '최근 7일 방송시간', 'data': 'broadcastTime', 'width':'70px', 'render': function(data, type, row) {
                    return common.timeStampDay(data);
                }}
            , {'title': '등록정보', 'data': 'reg_opName', 'width':'100px', 'render': function(data, type, row) {
                    return data + '<br/>' + row.reg_date;
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