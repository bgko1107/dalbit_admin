var PushDataTableSource = {
    'historyList': {
        'url': '/rest/status/push/history/list'

        , 'columns': [
            {'title': '발송일시', 'data' : 'send_date', 'render' : function(data, type, row, meta){
                    return common.convertToDate(data);
                }}
            ,{'title': '플랫폼', 'data' : 'target_platform', 'render' : function(data, type, row, meta){
                    var arrCode = data.toString().split("");
                    if(arrCode.length < 2){
                        return data;
                    }

                    var result = "";
                    if(arrCode[0] == "1"){
                        result += "/ Android "
                    }

                    if(arrCode[1] == "1"){
                        result += "/ IOS "
                    }

                    if(!common.isEmpty(result)){
                        result = result.substring(1);
                    }

                    return result;;
                }}
            ,{'title': '푸시타입', 'data' : 'push_type', 'render' : function(data, type, row, meta){
                    return util.getCommonCodeLabel(data, push_slctPush3);
                }}
            ,{'title': '발송형태', 'data' : 'send_type', 'render' : function(data, type, row, meta){
                    return util.getCommonCodeLabel(data, push_sendType);
                }}
            ,{'title': '수신대상', 'data' : 'target_cnt', 'render' : function(data, type, row, meta){
                    return data + "명";
                }}
            ,{'title': '메시지제목', 'data' : 'send_title', 'render' : function(data, type, row, meta){
                    return '<a href="javascript://" class="_getPushHistoryDetail" data-idx="'+meta.row+'">' + data + '</a>'
                }}
            ,{'title': '회원번호', 'data' : 'mem_no', 'render' : function(data, type, row, meta){
                    if(common.isEmpty(row.mem_no)){
                        return row.mem_nick;
                    }

                    return '<a href="javascript://" class="_openMemberPop" data-memNo="' + row.mem_no + '">' + data + '</a>';
                    // return data;
                }}
            ,{'title': '발송건수', 'data' : 'send_cnt'}
            ,{'title': '성공건수', 'data' : 'succ_cnt'}
            ,{'title': '실패건수', 'data' : 'fail_cnt'}
            ,{'title': '성공율', 'data' : 'succ_rate', 'render' : function(data, type, row, meta){
                    return data + "%";
                }}
            ,{'title': '클릭건수', 'data' : 'click_cnt'}
            ,{'title': '클릭율', 'data' : 'click_rate', 'render' : function(data, type, row, meta){
                    return data + "%";
                }}
            ,{'title': '발송자', 'data' : 'opName'}
        ]
    },
}