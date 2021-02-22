var specialDataTableSource = {
    'reqSpecialList': {
        'url': '/rest/menu/special/reqDalList'
        , 'columns': [
            {'title': '스디횟수', 'data': 'specialCnt', 'width' : '5%', 'render': function(data, type, row) {
                    return common.addComma(data) + ' 회';
                }}
            ,
            {'title': '회원번호', 'data': 'mem_no', 'width' : '10%', 'render': function(data, type, row) {
                    return '<a href="javascript://" class="_openMemberPop" data-memno="' + row.mem_no + '">' + data + '</a>'
                }}
            , {'title': '닉네임', 'width': '10%', 'data': 'mem_nick'}
            , {'title': '성별', 'data': 'mem_sex', 'width':'5%', 'render': function (data, type, row, meta) {
                    return common.sexIcon(data, row.mem_birth_year);
                }}
            , {'title': '신청일', 'data': 'reg_date', 'render': function(data, type, row) {
                    return common.convertToDate(data, 'YYYY-MM-DD HH:mm:ss');
                }}
            , {'title': '이름', 'width': '10%', 'data': 'mem_name', 'render': function(data, type, row){
                   return '<a href="javascript://" class="_reqDalDetail" data-idx="' + row.idx + '">' + data + '</a>'
                }}
            , {'title': '연락처', 'data': 'mem_phone', 'width':'10%', 'render': function(data){
                    return common.phoneNumHyphen(data)
                }}
            , {'title': '누적<br />방송시간', 'data': 'airTime','render': function(data) {
                    return common.addComma(data)+' 분';
                }}
            , {'title': '90분 이상<br />방송 횟수', 'data': 'broadcastCnt','render': function(data) {
                    return common.addComma(data)+' 회';
                }}
            , {'title': '좋아요', 'data': 'goodCnt', 'render': function(data, type, row) {
                    return common.addComma(data + row.boostGoodCnt)+' 회';
                }}
            /*, {'title': '팬', 'data': 'fanCnt', 'render': function(data) {
                    return common.addComma(data)+' 명';
                }}*/
            , {'title': '누적<br />청취자 수', 'data': 'allListenCnt', 'render': function(data, type, row) {
                    return common.addComma(data)+' 명';
                }}
            , {'title': '순수<br />청취자 수', 'data': 'listenCnt', 'render': function(data, type, row) {
                    return common.addComma(data)+' 명';
                }}
            , {'title': '신고횟수', 'data': 'reportCnt', 'render': function(data, type, row) {
                    return common.addComma(data)+' 번';
                }}
            , {'title': '받은 별', 'data': 'receiveStar', 'render': function(data, type, row) {
                    return common.addComma(data)+' 별';
                }}
            /*, {'title': '채팅<br />횟수', 'data': 'chatCnt', 'render': function(data, type, row) {
                    return common.addComma(data)+' 번';
                }}*/
            , {'title': '방송<br />횟수', 'data': 'broadCnt', 'render': function(data, type, row) {
                    return common.addComma(data)+' 번';
                }}
            , {'title': '30분 이상<br />청취자 수', 'data': 'listenCnt30', 'render': function(data, type, row) {
                    return common.addComma(data)+' 명';
                }}
        ]
        // , 'comments': ''
        ,'createdRow' : function( row, data, dataIndex ) {
            if (data.inner == 1) {    // 테스트계정 row 색상 표시
                $(row).addClass("bg-testMember");
            }
        }
    },

    'reqAbleSpecialList': {
        'url': '/rest/menu/special/reqAbleList'
        , 'columns': [
            {'title': '회원번호', 'data': 'mem_no', 'width' : '10%', 'render': function(data, type, row) {
                    return '<a href="javascript://" class="_openMemberPop" data-memno="' + row.mem_no + '">' + data + '</a>'
                }}
            , {'title': '닉네임', 'width': '10%', 'data': 'mem_nick'}
            , {'title': '성별', 'data': 'mem_sex', 'width':'5%', 'render': function (data, type, row, meta) {
                    return common.sexIcon(data, row.mem_birth_year);
                }}
            , {'title': '누적<br />방송시간', 'data': 'airTime','render': function(data) {
                    return common.addComma(data)+' 분';
                }}
            , {'title': '90분 이상<br />방송 횟수', 'data': 'broadcastCnt','render': function(data) {
                    return common.addComma(data)+' 회';
                }}
            , {'title': '좋아요', 'data': 'goodCnt', 'render': function(data, type, row) {
                    return common.addComma(data + row.boostGoodCnt)+' 회';
                }}
            , {'title': '누적<br />청취자 수', 'data': 'allListenCnt', 'render': function(data, type, row) {
                    return common.addComma(data)+' 명';
                }}
            , {'title': '순수<br />청취자 수', 'data': 'listenCnt', 'render': function(data, type, row) {
                    return common.addComma(data)+' 명';
                }}
            , {'title': '신고횟수', 'data': 'reportCnt', 'render': function(data, type, row) {
                    return common.addComma(data)+' 번';
                }}
            , {'title': '받은 별', 'data': 'receiveStar', 'render': function(data, type, row) {
                    return common.addComma(data)+' 별';
                }}
            , {'title': '방송<br />횟수', 'data': 'broadCnt', 'render': function(data, type, row) {
                    return common.addComma(data)+' 번';
                }}
            , {'title': '30분 이상<br />청취자 수', 'data': 'listenCnt30', 'render': function(data, type, row) {
                    return common.addComma(data)+' 명';
                }}
        ]
        // , 'comments': ''
        ,'createdRow' : function( row, data, dataIndex ) {
            if (data.inner == 1) {    // 테스트계정 row 색상 표시
                $(row).addClass("bg-testMember");
            }
        }
    },

    'specialList': {
        'url': '/rest/menu/special/dalList'
        , 'columns': [
            {'title': '회원번호', 'data': 'mem_no', 'render': function(data, type, row) {
                return '<a href="javascript://" class="_openMemberPop" data-memno="' + row.mem_no + '">' + data + '</a>' +
                    '<a href="javascript://" style="display:none;" class="_dalDetail" data-reqidx="' + row.req_idx + '"></a>'
                }}
            , {'title': '등록일', 'data': 'reg_date', 'render': function(data, type, row) {
                    return common.convertToDate(data, 'YYYY-MM-DD HH:mm:ss');
                }}
            , {'title': '관리자 등록여부', 'data': 'is_force', 'render': function(data, type, row) {
                    return util.getCommonCodeLabel(data, special_isForce);
                }}
            , {'title': '순서', 'data': 'order'}
            , {'title': '등록자', 'data': 'op_name'}
        ]
        // , 'comments': ''
    },

    'modalSpecialList': {
        'url': '/rest/member/member/list'
        , 'columns': [
            {'title': 'memNo', 'data': 'mem_no' , 'visible' : false},
            {'title': 'UserID', 'data': 'mem_userid','width':'50px'},
            {'title': '닉네임', 'data': 'mem_nick','width':'100px'},
            {'title': '연락처', 'data': 'mem_phone','width':'50px'},
            {'title': '등록하기', 'data': '','defaultContent': '', 'render': function (data, type, row, meta) {
                    return '<a onclick="javascript:setModalMemeberData('+meta.row+')" data-dismiss="modal">' + "[등록하기]" + '</a>'
                },'width':'60px'},
        ]
    },

    'reqManageList' : {
        'url': '/rest/menu/special/selectManageList'
        , 'columns': [
            {'title': '년', 'data': 'select_year','width':'70px'},
            {'title': '월', 'data': 'select_month','width':'70px'},
            {'title': '기수', 'data': 'round_no','width':'70px'},
            {'title': '제목', 'data': 'title','width':'200px', 'render' : function(data, type, row, meta){
                    return '<a href="javascript://" class="_detail" data-year="'+row.select_year+'" data-month="'+row.select_month+'">' + data + '</a>'
                }},
            {'title': '신청기간', 'data': 'mem_phone', 'render' : function(data, type, row, meta){
                    return moment(row.req_start_date).format('YYYY.MM.DD') + ' ~<br />' + moment(row.req_end_date).format('YYYY.MM.DD')
                },'width':'100px'},
            {'title': '데이터<br />수집기간', 'data': '', 'render': function (data, type, row, meta) {
                    return moment(row.condition_start_date).format('YYYY.MM.DD') + ' ~<br />' + moment(row.condition_end_date).format('YYYY.MM.DD')
                },'width':'100px'},
            {'title': '지원요건 1', 'data': '', 'render': function (data, type, row, meta) {
                    return row.condition_codeName1 + '<br />' + specialDjUtil.getConditionData(row.condition_code1, row.condition_data1)
                },'width':'200px'},
            {'title': '지원요건 2', 'data': '', 'render': function (data, type, row, meta) {
                    return row.condition_codeName2 + '<br />' + specialDjUtil.getConditionData(row.condition_code2, row.condition_data2)
                },'width':'200px'},
            {'title': '지원요건 3', 'data': '', 'render': function (data, type, row, meta) {
                    return row.condition_codeName3 + '<br />' + specialDjUtil.getConditionData(row.condition_code3, row.condition_data3)
                },'width':'200px'},
            {'title': '지원요건 4', 'data': '', 'render': function (data, type, row, meta) {
                    return row.condition_codeName4 + '<br />' + specialDjUtil.getConditionData(row.condition_code4, row.condition_data4)
                },'width':'200px'},
            {'title': '베스트요건', 'data': '', 'render': function (data, type, row, meta) {
                    return row.best_codeName + '<br />' + specialDjUtil.getConditionData(row.best_code, row.best_data)
                },'width':'200px'},
            {'title': '등록일', 'data': 'reg_date', 'render': function (data, type, row, meta) {
                    return moment(row.reg_date).format('YYYY.MM.DD HH:mm:ss')
                },'width':'100px'},
            {'title': '등록자', 'data': 'op_name','width':'100px'},
            {'title': '수정일', 'data': 'last_upd_date', 'render': function (data, type, row, meta) {
                    if(common.isEmpty(data)){
                        return '-'
                    }
                    return moment(data).format('YYYY.MM.DD HH:mm:ss')
                },'width':'100px'},
            {'title': '수정자', 'data': 'last_op_name', 'render': function (data, type, row, meta) {
                    if(common.isEmpty(data)){
                        return '-'
                    }
                    return data
                },'width':'100px'},
        ]
    },

    'bestAbleSpecialList' : {
        'url': '/rest/menu/special/bestAbleList'
        , 'columns': [
            {'title': '유저구분', 'data': 'specialdj_badge','width':'70px', 'render' : function(data, type, row, meta){
                    return (data == 0 ? '일반' : data == 1 ? '스페셜' : '베스트');
                }},
            {'title': '스디 횟수', 'data': 'specialdj_cnt','width':'70px'},
            {'title': '베스트<br >횟수', 'data': 'bestdj_cnt','width':'70px'},
            {'title': '회원번호', 'data': 'mem_no','width':'200px', 'render' : function(data, type, row, meta){
                    return util.memNoLink(data, data);
                }},
            {'title': '닉네임', 'data': 'mem_nick','width':'300px'},
            {'title': '성별', 'data': 'mem_sex', 'render': function (data, type, row, meta) {
                    return common.sexIcon(data, row.mem_birth_year, true);
                },'width':'100px'},
            {'title': '누적 방송시간<br />(팬방송 제외)', 'data': 'air_time', 'render': function (data, type, row, meta) {
                    return common.timeStampDay(data-row.fan_air_time);
                },'width':'200px'},
            {'title': '누적<br />팬 방송시간', 'data': 'fan_air_time', 'render': function (data, type, row, meta) {
                    return common.timeStampDay(data);
                },'width':'200px'},
            {'title': '일반 조건<br />신청 유무', 'data': 'is_req','width':'200px'},
            {'title': '베스트<br />가능여부', 'data': '', 'render': function (data, type, row, meta) {

                    if(row.specialdj_badge == 2 && row.best_data <= Math.floor(row.air_time / 3600)){
                        return common.setFontColor('가능', 'blue');
                    }

                    if(row.specialdj_badge == 1 && 5 < row.specialdj_cnt && row.best_data <= Math.floor(row.air_time / 3600)){
                        return common.setFontColor('가능', 'blue');
                    }

                    if(row.specialdj_badge < 2 && row.is_req == 'Y'){
                        return common.setFontColor('심사필요', 'green');
                    }

                    return common.setFontColor('불가능', 'red');
                },'width':'200px'},
        ]
    },
};