var recommDataTableSource = {
    'recommList': {
        'url': '/rest/menu/recomm/list'
        , 'columns': [

            {'title': '프로필', 'width': '10%', 'data': 'profileImage', 'render': function(data, type, row) {
                    return '<img class="thumbnarest/menu/recommil fullSize_background" src="'+ common.profileImage(PHOTO_SERVER_URL, data, row.memSex) +'" width="65px" height="65px" />';
                }}
            , {'title': '회원번호', 'data': 'mem_no', 'width' : '10%', 'render': function(data, type, row) {
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
                    return common.addComma(data);
                }}
            , {'title': '최근 방송일시', 'data': 'last_broadcast'}
            , {'title': '최근 7일 방송시간', 'data': 'broadcastTime', 'render': function(data, type, row) {
                    return common.timeStampDay(data);
                }}
            , {'title': '등록정보', 'data': 'reg_op_name', 'render': function(data, type, row) {
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
};