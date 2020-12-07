/**
 * ========= DataTable Source =============
 * key:{
 *      'url': ajax호출 URL (필수)
 *      ','columns': [       (필수)
 *          {'title': 필드헤더명, 'data': 출력데이터변수명, 'defaultContent': 값이 없을 경우 Default값}
 *      ]
 * }
 *
 **/

var UtilDataTableSource = {
    'modalMemberList': {
        'url': '/rest/member/member/list'
        , 'columns': [
            {'title': 'memNo', 'data': 'mem_no' , 'visible' : false},
            {'title': 'UserID', 'data': 'mem_userid','width':'50px'},
            {'title': '닉네임', 'data': 'mem_nick','width':'100px'},
            {'title': '연락처', 'data': 'mem_phone','width':'50px'},
            {'title': '수신대상등록하기', 'data': '','defaultContent': '', 'render': function (data, type, row, meta) {
                    return '<a href="javascript://" onclick="javascript:setModalMemberData('+meta.row+')">' + "[등록하기]" + '</a>'
                },'width':'60px'},
        ]
    },

    'modalBroadcastLiveList': {
        'url': '/rest/broadcast/broadcast/list'
        , 'columns': [
            {
                'title': '플랫폼', 'data': 'osType', 'width': '65px', 'render': function (data) {
                    return util.getCommonCodeLabel(data, os_type);
                }
            },
            {'title': '주제', 'data': 'subject_name', 'width': '65px'},
            {
                'title': '제목', 'data': 'title', 'width': '150px', 'render': function (data, type, row, meta) {
                    var tmp = "<div style='display: inline-flex; align-items: center'>";

                    tmp += "<div class='pr10 pull-left'>"
                    if (row.recommBadge == "1") {
                        tmp = tmp + '<span class ="label" style="background-color:#d9534f">' + "추천" + '</span><br/>';
                    }
                    if (row.popularBadge == "1") {
                        tmp = tmp + '<span class ="label" style="background-color:#3761d9">' + "인기" + '</span><br/>';
                    }
                    if (row.newjdBadge == "1") {
                        tmp = tmp + '<span class ="label" style="background-color:#d9c811">' + "신입" + '</span>';
                    }
                    tmp += "</div>"
                    tmp += util.roomNoLink(data, row.room_no);

                    tmp += "</div>";
                    return tmp;

                    // return util.roomNoLink(data, row.room_no);
                }
            },
            {
                'title': 'DJ ID', 'data': 'dj_userid', 'width': '65px', 'render': function (data, type, row, meta) {
                    var tmp = util.memNoLink(data, row.dj_mem_no);
                    tmp = tmp + '<br/>' + row.dj_level + " / " + row.dj_grade;
                    return tmp;
                }
            },
            {'title': 'User 닉네임', 'data': 'dj_nickname', 'width': '75px'},
            {'title': '시작일시', 'data': 'start_date', 'width': '120px'},
            {
                'title': '진행시간', 'data': 'airTime', 'width': '65px', 'render': function (data) {
                    return common.timeStamp(data);
                }
            },
            {'title': '등록', 'data': '','defaultContent': '', 'render': function (data, type, row, meta) {
                    return '<a onclick="javascript:setModalBroadcastLiveData('+meta.row+')" data-dismiss="modal">' + "[등록하기]" + '</a>'
                },'width':'60px'
            }
        ]
    },

    'modalMemberBoosterList': {
        'url': '/rest/member/member/boost/list'
        , 'columns': [
            {'title': 'memNo', 'data': 'mem_no' , 'visible' : false},
            {'title': 'UserID', 'data': 'mem_userid','width':'100px', 'render': function (data, type, row, meta) {
                    return '<a href="javascript://" class="_openMemberPop" data-memNo="'+row.mem_no+'">' + data + '</a>'
                }},
            {'title': '닉네임', 'data': 'mem_nick','width':'150px'},
            {'title': '연락처', 'data': 'mem_phone','width':'150px', 'render': function (data, type, row, meta) {
                    return common.phoneNumHyphen(data)
                }},
            {'title': '보유수량 및 지급/차감', 'data': 'item_cnt', 'render': function (data, type, row, meta) {
                    return data +'개 '
                        + '<select id="boostPlusMinus" name="boostPlusMinus" class="form-control searchType ml15 boostPlusMinus">'
                        + '     <option value="1">+</option>'
                        + '     <option value="3">-</option>'
                        + '</select>'
                        + '<input type="text" class="form-control ml10 txt_boostAddCnt" id="txt_boostAddCnt" style="width:50px" maxLength="4">'
                        + '<button type="button" id="bt_boostAdd" class="btn btn-default btn-sm ml10"'
                        + '     data-memno="' + row.mem_no + '" data-boostcnt="'+data+'">변경'
                        + '</button>'
                }},
        ]
    },
};