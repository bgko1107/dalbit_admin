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

var questionDataTableSource = {
    'questList': {
        'url': '/rest/customer/question/list'
        , 'columns': [
            {'title': '문의유형', 'data': 'slct_type','width':'60px','render': function (data, type, row, meta) {
                    return util.getCommonCodeLabel(data, question_type);
                }},
            {'title': '플랫폼', 'data': 'platform','width':'60px'},
            {'title': 'Browser', 'data': 'browser','width':'60px'},
            {'title': '회원번호', 'data': 'mem_no','width':'150px','render': function (data, type, row, meta) {
                    var tmp = util.memNoLink(data, row.mem_no);
                    if(row.mem_state == 1){
                        tmp = tmp + '<br/>' +  row.mem_level +" / "+ row.mem_grade;
                    }else{
                        tmp = tmp + '<br/>' +  row.mem_grade;
                    }
                    return tmp;
                }},
            {'title': '문의자<br>닉네임', 'data': 'mem_nick','width':'100px','render':function (data,type,row,meta){
                    if(common.isEmpty(data)) {
                       return '탈퇴회원';
                    }else{
                        return data;
                    }            
                }},
            {'title': '성별', 'data': 'mem_sex', 'width':'55px', 'render': function (data, type, row, meta) {
                    return common.sexIcon(data, row.mem_birth_year, true);
                }},
            {'title': '문의', 'data': 'totalQnaCnt','width':'40px','render':function (data,type,row,meta){
                    return common.addComma(data) + " 건";
                }},
            {'title': '처리', 'data': 'totalOpCnt','width':'40px','render':function (data,type,row,meta){
                    return common.addComma(data) + " 건";
                }},

            {'title': '문의제목', 'className':'break-word', 'data': 'question_title',  'render': function (data, type, row, meta) {
                    return '<a href="javascript://" class="getQuestDetail" onclick="javascript:getQuestDetail('+meta.row+');">'+data+'</a>'
                }},
            {'title': '첨부<br>파일', 'data': 'fileCnt','width':'40px', 'render' : function(data, type, row, meta){
                    return data +'건';
                }},
            {'title': '운영자<br>메모', 'data': 'adminMemoCnt','width':'40px', 'render': function (data, type, row, meta) {
                    return '<a href="javascript://" onclick="adminMemoList(' + row.qnaIdx + ');">'+data+'</a>'
                }},
            {'title': '접수일시', 'data': 'writeDateFormat','width':'65px', 'render' : function(data, type, row, meta){
                    if(!common.isEmpty(data)) {
                        return data.replace(" ", "<br>");
                    }
                    return data;
                }},
            {'title': '처리일시', 'data': 'opDateFormat','width':'65px', 'render' : function(data, type, row, meta){
                    if(!common.isEmpty(data)) {
                        return data.replace(" ", "<br>");
                    }
                    return data;
                }},
            {'title': '처리상태', 'data': 'state','width':'60px','render' : function(data){
                    if(data == 3){
                        return '<span style="color: blue;">' + util.getCommonCodeLabel(data, question_status) + '</span>';
                    }else{
                        return util.getCommonCodeLabel(data, question_status);
                    }
                }},
            {'title': '처리자', 'data': 'op_name','width':'90px'},
        ]
        , 'comments': 'ㆍ1:1 문의 처리 및 상세정보 확인 후 해당 정보를 확인 및 답변, 수정할 수 있습니다.'
        ,'createdRow' : function( row, data, dataIndex ) {
            if (data.inner == 1) {    // 테스트계정 row 색상 표시
                $(row).addClass("bg-testMember");
            }
        }
    },

    'questListNonMember': {
        'url': '/rest/customer/question/list'
        , 'columns': [
            {'title': '문의유형', 'data': 'slct_type','width':'60px','render': function (data, type, row, meta) {
                    return util.getCommonCodeLabel(data, question_type);
                }},
            {'title': '답변유형', 'data': '','width':'60px','render': function (data, type, row, meta) {
                    if(common.isEmpty(row.phone) && common.isEmpty(row.email)){
                        return "보내지않음";
                    }else{
                        if(!common.isEmpty(row.phone) && !common.isEmpty(row.email)){
                            return "문자발송";
                        }
                        if(!common.isEmpty(row.phone)){
                            return "문자발송";
                        }
                        if(!common.isEmpty(row.email)){
                            return "메일발송";
                        }
                    }
                }},
            {'title': '플랫폼', 'data': 'platform','width':'60px'},
            {'title': 'Browser', 'data': 'browser','width':'60px'},
            {'title': '회원번호', 'data': 'mem_no','width':'150px','render': function (data, type, row, meta) {
                    var tmp = util.memNoLink(data, row.mem_no);
                    if(row.mem_state == 1){
                        tmp = tmp + '<br/>' +  row.mem_level +" / "+ row.mem_grade;
                    }else{
                        tmp = tmp + '<br/>' +  row.mem_grade;
                    }
                    return tmp;
                }},
            {'title': '문의자<br>닉네임', 'data': 'mem_nick','width':'100px','render':function (data,type,row,meta){
                    if(common.isEmpty(data)) {
                       return '탈퇴회원';
                    }else{
                        return data;
                    }
                }},
            {'title': '문의', 'data': 'totalQnaCnt','width':'40px','render':function (data,type,row,meta){
                    return common.addComma(data) + " 건";
                }},
            {'title': '처리', 'data': 'totalOpCnt','width':'40px','render':function (data,type,row,meta){
                    return common.addComma(data) + " 건";
                }},

            {'title': '문의제목', 'className':'break-word', 'width':'350px', 'data': 'question_title',  'render': function (data, type, row, meta) {
                    return '<a href="javascript://" class="getQuestDetail" onclick="javascript:getQuestDetail('+meta.row+');">'+data+'</a>'
                }},
            {'title': '첨부<br>파일', 'data': 'fileCnt','width':'40px', 'render' : function(data, type, row, meta){
                    return data +'건';
                }},
            {'title': '운영자<br>메모', 'data': 'adminMemoCnt','width':'40px', 'render': function (data, type, row, meta) {
                    return '<a href="javascript://" onclick="adminMemoList(' + row.qnaIdx + ');">'+data+'</a>'
                }},
            {'title': '접수일시', 'data': 'writeDateFormat','width':'65px', 'render' : function(data, type, row, meta){
                    if(!common.isEmpty(data)) {
                        return data.replace(" ", "<br>");
                    }
                    return data;
                }},
            {'title': '처리일시', 'data': 'opDateFormat','width':'65px', 'render' : function(data, type, row, meta){
                    if(!common.isEmpty(data)) {
                        return data.replace(" ", "<br>");
                    }
                    return data;
                }},
            {'title': '처리상태', 'data': 'state','width':'60px','render' : function(data){
                    return util.getCommonCodeLabel(data, question_status);
                }},
            {'title': '처리자', 'data': 'op_name','width':'90px'},
        ]
        , 'comments': 'ㆍ1:1 문의 처리 및 상세정보 확인 후 해당 정보를 확인 및 답변, 수정할 수 있습니다.'
        ,'createdRow' : function( row, data, dataIndex ) {
            if (data.inner == 1) {    // 테스트계정 row 색상 표시
                $(row).addClass("bg-testMember");
            }
        }
    },

    'adminMemoList': {
        'url': '/rest/customer/question/adminMemo/list'
        , 'columns': [
            {'title': '등록일시', 'data': 'regDateFormat','width':'120px'},
            {'title': '등록 관리자', 'data': 'op_name','width':'80px'},
            {'title': '운영자 메모 내용', 'data': 'memo','width':'200px'},
        ]
    },

    'memDetail_questList': {
        'url': '/rest/customer/question/list'
        , 'columns': [
            {'title': '문의<br>유형', 'data': 'slct_type','width':'60px','render': function (data, type, row, meta) {
                    return util.getCommonCodeLabel(data, question_type);
                }},
            {'title': '플랫폼', 'data': 'platform','width':'60px'},
            // {'title': 'Browser', 'data': 'browser','width':'60px'},
            {'title': '회원번호', 'data': 'mem_no','width':'100px','render': function (data, type, row, meta) {
                    var tmp = util.memNoLink(data, row.mem_no);
                    tmp = tmp + '<br/>' +  row.mem_level +" / "+ row.mem_grade;
                    return tmp;
                }},
            {'title': '문의자<br>닉네임', 'data': 'mem_nick','width':'100px','render':function (data,type,row,meta){
                    if(common.isEmpty(data)){
                        return '탈퇴회원';
                    }else{
                        return data;
                    }
                }},
            {'title': '성별', 'data': 'mem_sex', 'width':'60px', 'render': function (data, type, row, meta) {
                    return common.sexIcon(data, row.mem_birth_year, true);
                }},
            {'title': '문의', 'data': 'totalQnaCnt','width':'45px','render':function (data,type,row,meta){
                    return common.addComma(data) + " 건";
                }},
            {'title': '처리', 'data': 'totalOpCnt','width':'45px','render':function (data,type,row,meta){
                    return common.addComma(data) + " 건";
                }},

            {'title': '문의제목', 'className':'break-word', 'width':'200px', 'data': 'question_title',  'render': function (data, type, row, meta) {
                    return '<a href="javascript://" class="getQuestDetail" onclick="javascript:getQuestDetail('+meta.row+');">'+data+'</a>'
                }},
            {'title': '메모', 'data': 'adminMemoCnt','width':'45px'},
            {'title': '접수일시', 'data': 'writeDateFormat','width':'65px', 'render' : function(data, type, row, meta){
                    if(!common.isEmpty(data)) {
                        return data.replace(" ", "<br>");
                    }
                    return data;
                }},
            {'title': '처리일시', 'data': 'opDateFormat','width':'65px', 'render' : function(data, type, row, meta){
                    if(!common.isEmpty(data)) {
                        return data.replace(" ", "<br>");
                    }
                    return data;
                }},
            {'title': '첨부<br>파일', 'data': 'add_file','width':'40px', 'render' : function(data, type, row, meta){
                    var fileCnt = common.isEmpty(data) ? 0 : data.split(",").length;
                    return fileCnt +'건';
                }},
            {'title': '처리상태', 'data': 'state','width':'60px','render' : function(data){
                    return util.getCommonCodeLabel(data, question_status);
                }},
            {'title': '처리자', 'className':'break-word', 'width':'45px', 'data': 'op_name'},
        ]
        , 'comments': 'ㆍ1:1 문의 처리 및 상세정보 확인 후 해당 정보를 확인 및 답변, 수정할 수 있습니다.'
    },


    'macroList': {
        'url': '/rest/customer/question/macro/list'
        , 'columns': [
            {'title': '구분', 'data': '','render': function (data, type, row, meta) {
                    return '자동 답변';
                }},
            {'title': '문의제목', 'className':'break-word', 'data': 'title',  'render': function (data, type, row, meta) {
                    return '<a href="javascript://" class="getMacroDetail" onclick="getMacroDetail('+row.idx+', '+ row.rowNum +');">'+data+'</a>'
                }},
            {'title': '시간설정', 'data': 'timeValue','render': function (data, type, row, meta) {
                    return data + ' 분 후';
                }},
            {'title': '등록일시', 'data': 'regDate','render': function (data, type, row, meta) {
                    return data.substr(0,19);
                }},
            {'title': '수정일시', 'data': 'updDate','render': function (data, type, row, meta) {
                    return data.substr(0,19);
                }},
            {'title': '자동 답변', 'data': 'viewYn','render': function (data, type, row, meta) {
                    return util.renderOnOff(data);
                }},
            {'title': '등록자명', 'data': 'opName'},
        ]
    },
}


