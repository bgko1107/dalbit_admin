var EventRouletteDataTableSource = {
    'applyList' : {
        'url' : '/rest/content/event/roulette/selectApplyList'
        , 'columns': [
            {'title': '프로필 사진', 'data' : 'image_profile', 'render' : function(data, type, row) {
                    return '<img class="thumbnail fullSize_background" src="' + common.profileImage(PHOTO_SERVER_URL, data, row.mem_sex) + '" width="65px" height="65px" />';
                }},
            {'title': '회원번호', 'data' : 'mem_no', 'render' : function(data, type, row, meta) {
                    return util.memNoLink(data, row.mem_no);
                }},
            {'title': 'UserId', 'data' : 'mem_userid', 'render' : function(data, type, row, meta) {
                    return data;
                }},
            {'title': '닉네임', 'data' : 'mem_nick', 'render' : function(data) {
                    return data;
                }},
            {'title': '성별', 'data' : 'mem_sex', 'render' : function(data) {
                    return common.sexIcon(data);
                }},
            {'title': '참여일시', 'data' : 'apply_date', 'render' : function(data) {
                    return data;
                }},
            {'title': '접수일시', 'data' : 'win_date', 'render' : function(data) {
                if(common.isEmpty(data)){
                    return '-';
                }
                return data;
                }},
            {'title': '받은 달', 'data' : 'item_no', 'render' : function(data) {
                    if(data == 1){
                        return '꽝';
                    }else if(data == 2){
                        return '1 달';
                    }else if(data == 3){
                        return '3 달';
                    }else {
                        return '없음';
                    }
                }},
            {'title': '경험치', 'data' : 'item_no', 'render' : function(data) {
                    if(data == 10001){
                        return '1 exp';
                    }else if(data == 10002){
                        return '3 exp';
                    }else if(data == 10003){
                        return '5 exp';
                    }else if(data == 10004){
                        return '10 exp';
                    }else {
                        return '없음';
                    }
                }},
            {'title': '기프티콘', 'data' : 'item_no', 'render' : function(data) {
                    if(-1 < '|1|2|3|10001|10002|10003|10004|'.indexOf(data)){
                        return '없음';
                    }else if(data.endsWith(4)){
                        return "A";
                    }else if(data.endsWith(5)){
                        return "B";
                    }else if(data.endsWith(6)){
                        return "C";
                    }else if(data.endsWith(7)){
                        return "D";
                    }else if(data.endsWith(8)){
                        return "E";
                    }
                }},
            {'title': '아이템명', 'data' : 'item_name', 'render' : function(data, type, row) {
                    if(!common.isEmpty(row.image_url)){
                        return '<img src="'+row.image_url+'" width="50px;" height="50px;" />' + data;
                    }
                    return data;
                }},
            {'title': '휴대폰 번호', 'data' : 'phone', 'render' : function(data) {
                    return common.phoneNumHyphen(data);
                }},
        ]
    },
}
