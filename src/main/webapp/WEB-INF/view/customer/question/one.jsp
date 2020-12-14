<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="cfn" uri="/WEB-INF/tld/comFunction.tld" %>
<c:set var="dummyData"><%= java.lang.Math.round(java.lang.Math.random() * 1000000) %></c:set>

<c:set var="readYn" value="N" />
<c:set var="insertYn" value="N" />
<c:set var="deleteYn" value="N" />

<c:forEach var="menu" items="${cfn:getMenuList()}" varStatus="status">
    <c:forEach var="twoDepth" items="${menu.twoDepth}">
        <c:if test="${twoDepth.idx eq 52}">
            <c:set var="readYn" value="${twoDepth.is_read eq 0 ? 'N' : 'Y'}" />
            <c:set var="insertYn" value="${twoDepth.is_insert eq 0 ? 'N' : 'Y'}" />
            <c:set var="deleteYn" value="${twoDepth.is_delete eq 0 ? 'N' : 'Y'}" />
        </c:if>
    </c:forEach>
</c:forEach>

<div class="col-md-12 no-padding">
    <label id="one_title"></label>
</div>
<div>
    <form id="question_detailFrm"></form>
</div>

<!-- 이미지 원본 보기 -->
<div id="fullSize_question"></div>

<script type="text/javascript" src="/js/code/customer/questionCodeList.js?${dummyData}"></script>
<script type="text/javascript" src="/js/handlebars/customerHelper.js?${dummyData}"></script>

<script type="text/javascript">
    $(document).ready(function() {

    });
    var memNo;
    var memId;
    var noticeType = 0;
    var email;
    var phone;
    var qnaTitle;
    var qnaContent;
    var fileName;
    var state;

    var tmp_slctMember = 1;

    function quest_detail_success(data, response, params){
        noticeType = 0;
        $('#tab_customerQuestion').addClass("show");

        qnaIdx = params.qnaIdx;
        state = response.data.state;
        if(state != 1){     // 처리중, 미처리 상태일때만
            if(qnaIdx == localStorage.qnaIdx){
                answer = localStorage.answer;
            }else{
                answer = response.data.answer;
            }
        }else{
            answer = response.data.answer;
        }
        memNo = response.data.mem_no;
        memId = response.data.mem_userid;
        phone = response.data.phone;
        email = response.data.email;
        qnaTitle = response.data.question_title;
        op_name = response.data.op_name;

        if(!common.isEmpty(response.data.file_name1)){
            fileName = response.data.file_name1;
        }
        if(!common.isEmpty(response.data.file_name2)){
            if(!common.isEmpty(fileName)){
                fileName = fileName + ", " + response.data.file_name2;
            }else{
                fileName = response.data.file_name2;
            }
        }
        if(!common.isEmpty(response.data.file_name3)){
            if(!common.isEmpty(fileName)){
                fileName = fileName + ", " + response.data.file_name3;
            }else{
                fileName = response.data.file_name3;
            }
        }

        if(!common.isEmpty(response.data.phone)){
            noticeType = 1;
        }
        if(!common.isEmpty(response.data.email)){
            noticeType = 2;
        }
        if(!common.isEmpty(response.data.email) && !common.isEmpty(response.data.phone)){
            noticeType = 3;
        }
        response.data["noticeType"] = noticeType;

        response.data["question_contents"] = response.data.question_contents.replace(/\\n/gi, "\r\n");
        response.data["mem_no"] = memInfo(response.data.mem_no,response.data.mem_no);
        response.data["rowNum"] = params.rowNum;
        response.data["add_file_cnt"] = response.data.fileCnt;
        if(response.data.state == "2" && response.data.op_name == LOGIN_USER_NAME){
            response.data["editAuth"] = "Y";
        }else{
            response.data["editAuth"] = "N";
        }
        if(noticeType == 2 || noticeType == 0){
            response.data["answer"] = answer;
        }else{
            if(!common.isEmpty(answer)){
                response.data["msg_body"] = common.replaceHtml(answer).replace(/<br>/gi, '\n');
            }else{
                response.data["msg_body"] = "[달빛라이브]\n";
            }
        }

        var template = $('#tmp_question_detailFrm').html();
        var templateScript = Handlebars.compile(template);
        var context = response.data;
        var html=templateScript(context);
        $("#question_detailFrm").html(html);

        util.editorInit("question");
        util.getAjaxData("getGroup", "/rest/customer/question/getFaqGroupList", null, fn_getFaqGroup_success);

        $('#bt_operate').click(function() {                   // 1:1 문의 등록
            operate_click();
        });
        // $('#bt_update').click(function() {                   // 1:1 문의 수정
        //     update_click();
        // });

        if(response.data.state == 2 && response.data.op_name != LOGIN_USER_NAME){
            alert("다른 사람이 처리중인 1:1 문의 건 입니다.");
            $("#bt_operate").addClass("hide");
            $("#bt_chatchRelease").addClass("hide");
        }
        //textarea resize
        util.textareaResize(document.getElementById("question_contents"), 200);

        if(noticeType == 1 || noticeType == 3) {
            mobileBtnClick();
        }

        tmpStorage();

        var scrollPosition = $("#div_questionTab").offset();
        util.scrollPostion(scrollPosition.top);
    }
    function fn_getFaqGroup_success(data, response, params) {
        dalbitLog(response);
        var template = $("#tmp_question_faqGroup").html();
        var templateScript = Handlebars.compile(template);
        var context = response.data.faqGroupList;
        var html = templateScript(context);
        $("#_faqGroupArea").html(html);

        if(noticeType == 0 || noticeType == 2){
            $("#faqGroup").val("1").prop("selected", true);
        }else{
            $("#faqGroup").val("97").prop("selected", true);
        }
        faqGroupChange();

        // fn_sublist_success(data, response);
    }
    function faqGroupChange(){
        var faqData = {
            slct_type : $('select[name="faqGroup"]').find('option:selected').val()
        };
        dalbitLog(faqData);
        util.getAjaxData("getSub", "/rest/customer/question/getFaqSubList", faqData, fn_sublist_success);
    }

    function memInfo(memId, memNo){
        return util.memNoLink(memId, memNo);
    }
    function operate_click(){
        var data = {};
        data["qnaIdx"] = qnaIdx;
        data.qnaTitle = qnaTitle;
        if(noticeType == 2 || noticeType == 0){
            data["answer"] = $("#editor").summernote('code');
        }else{
            data["answer"] = $("#smsSend-msg_body").val();
        }
        data.title = $("#smsSend-subject").val();
        data.noticeType = noticeType;
        data.phone = phone;
        data.email = email;
        data.qnaType = $("#question_type").text();
        data.qnaContent = qnaContent;
        data.fileName = fileName;
        data.qnaContent = $("textarea#question_contents").val().replace(/(?:\r\n|\r|\n)/g, '<br/>');

        data.slct_type = $('select[name="question_type"]').find('option:selected').val();
        console.log(data);
        if(confirm("등록하시겠습니까?")){
            util.getAjaxData("insert", "/rest/customer/question/operate", data, fn_insert_success);
        }
    }
    function fn_insert_success(data, response, params){
        dalbitLog(response);
        if(response.code == "-2"){
            alert("이미 등록되어있습니다.");
        }else{
            alert(response.message);
        }

        if(tmp_slctMember == 0){
            dtList_info_detail0.reload();
        }else if(tmp_slctMember == 1){
            dtList_info_detail.reload();
        }else{
            dtList_info_detail2.reload();
        }
        $('#tab_customerQuestion').removeClass("show");
    }

    // function update_click(){
    //     var data = {};
    //     data["qnaIdx"] = qnaIdx;
    //     data["answer"] = $("#editor").summernote('code');
    //     if(confirm("수정하시겠습니까?")){
    //         util.getAjaxData("insert", "/rest/customer/question/update", data, fn_update_success);
    //     }
    // }
    // function fn_update_success(data, response, params){
    //     alert(response.message);
    //     dtList_info_detail.reload();
    //
    //     $("#question_detailFrm").empty();
    // }

    $(document).on('change', '#faqGroup', function() {
        var faqData = {
            slct_type : $('select[name="faqGroup"]').find('option:selected').val()
        };
        dalbitLog(faqData);
        util.getAjaxData("getSub", "/rest/customer/question/getFaqSubList", faqData, fn_sublist_success);
    });

    function fn_sublist_success(data, response, params) {
        var template = $("#tmp_question_faqSub").html();
        var templateScript = Handlebars.compile(template);
        var context = response.data.faqSubList;
        var html = templateScript(context);
        $("#_faqSubArea").html(html);

    }

    $(document).on('click', '#bt_faq', function() {
        $('button.btn-codeview').click();

        if(noticeType == 0 || noticeType == 2){
            $('#editor').summernote('code', $('#editor').summernote('code') + '<p>' + $('select[name="faqSub"]').find('option:selected').data('answer')) + '</p>';
        }else{
            var tmp = $('select[name="faqSub"]').find('option:selected').data('answer').replace(/<br>/gi, '\n');
            tmp = tmp.replace(/<p>/gi, '\n');
            tmp = tmp.replace(/</gi, '').replace(/\//gi, '').replace(/p>/gi, '');
            $("#smsSend-msg_body").val($("#smsSend-msg_body").val() + tmp);
        }
        $('button.btn-codeview').click();
    });

    $(document).on('click', '.bt_baro', function() {
        dalbitLog($(this).text() + ' 바로가기');
        $('button.btn-codeview').click();

        // 버튼 만드는 처리
        var button = '<p><button><a href=' + $(this).data('url') + '>' + $(this).text() + ' 바로가기' + '</a></button><p>';
        $('#editor').summernote('code', $('#editor').summernote('code') + button);
        $('button.btn-codeview').click();
    });

    $(document).on('click', '.bt_chatchRelease', function() {       // 처리중 해제
        var obj = {};
        obj.qnaIdx = qnaIdx;
        util.getAjaxData("qnaCatch", "/rest/customer/question/chatchRelease", obj, fn_chatchRelease_success);
    });
    function fn_chatchRelease_success(data, response, params) {
        dalbitLog(response);
        dtList_info_detail.reload(question_summary_table);
        $('#tab_customerQuestion').removeClass("show");
    }

    $(document).on('click', '#deleteBtn', function(){
        $('.note-editable').empty();
    });
    function mobileBtnClick(){
        if($("#mobileBtn").text() == "모바일 형태보기"){
            $("#mobileBtn").text("PC형태보기");
            $('#div_editor').css({ width: 360});
        }else{
            $("#mobileBtn").text("모바일 형태보기");
            $('#div_editor').css({ width: ''});
        }
    }

    // function resize(obj) {
    //     obj.style.height = "114px";
    //     obj.style.height = (12+obj.scrollHeight)+"px";
    // }

    function adminMemoAdd(){
        console.log($("#txt_qnaAdminMemo").val());
        if (common.isEmpty($("#txt_qnaAdminMemo").val())) {
            alert("등록할 운영자 메모를 입력해 주십시오.");
            return;
        }
        var obj = {};
        obj.qnaIdx = qnaIdx;
        obj.memo = $("#txt_qnaAdminMemo").val();
        obj.mem_no = memNo;
        util.getAjaxData("adminMemoAdd", "/rest/customer/question/adminMemoAdd", obj, update_success);
    }

    function update_success(dst_id, response) {
        dalbitLog(response);
        alert(response.message);

        var obj ={};
        obj.qnaIdx = qnaIdx;
        util.getAjaxData("type", "/rest/customer/question/detail",obj, quest_detail_success);
    }

    function adminMemoList(tmp){
        console.log("--------------------------------");
        console.log(tmp);
        if(!common.isEmpty(tmp)){
            qnaIdx = tmp;
        }
        $('#adminMemoModal').modal('show');
        var dtMemo_List_info;
        var dtList_info_detail_data = function ( data ) {
            data.qnaIdx = qnaIdx;
        };
        dtMemo_List_info = new DalbitDataTable($("#memo_list"), dtList_info_detail_data, questionDataTableSource.adminMemoList);
        dtMemo_List_info.useCheckBox(false);
        dtMemo_List_info.useIndex(true);
        dtMemo_List_info.createDataTable();
    }

    function chatch() {
        var obj = {};
        obj.qnaIdx = qnaIdx;
        util.getAjaxData("qnaCatch", "/rest/customer/question/qnaCatch", obj, fn_getqnaCatch_success);
    }
    function fn_getqnaCatch_success(dst_id, response) {
        dalbitLog(response);
        var obj ={};
        obj.qnaIdx = qnaIdx;
        obj.answer = answer;
        util.getAjaxData("type", "/rest/customer/question/detail",obj, quest_detail_success);
    }
    function fileDel(){
        if(confirm("첨부파일을 삭제하시겠습니까?")){
            var obj ={};
            obj.qnaIdx = qnaIdx;
            util.getAjaxData("fileDel", "/rest/customer/question/file/del",obj, quest_fileDel_success);
        }else false;
    }
    function quest_fileDel_success(dst_id, response) {
        dalbitLog(response);
        alert(response.message);
        quest_reload();
    }

    function quest_reload() {
        getUserInfo();

        var obj ={};
        obj.qnaIdx = qnaIdx;
        obj.answer = answer;
        obj.rowNum = rowNum;
        util.getAjaxData("type", "/rest/customer/question/detail",obj, quest_detail_success);
    }

    function tmpStorage(){
        storageTimer = setInterval(function() {
            if(state != "1"){
                localStorage.qnaIdx = "";
                localStorage.answer = "";
                localStorage.qnaIdx = qnaIdx;
                if(noticeType == 2 || noticeType == 0){
                    localStorage.answer = $("#editor").summernote('code');
                }else{
                    localStorage.answer = $("#smsSend-msg_body").val();
                }
            }
        }, 1000 * 30);
    }

</script>

<script id="tmp_question_detailFrm" type="text/x-handlebars-template">
    <div id="wrapper">
        <div id="page-wrapper">
            <table class="table table-bordered table-dalbit" style="margin: auto">
                <colgroup>
                    <col width="5%"><col width="5%"><col width="5%"><col width="5%"><col width="5%"><col width="5%">
                    <col width="5%"><col width="5%"><col width="5%"><col width="5%"><col width="5%"><col width="5%">
                </colgroup>
                <tbody>
                <tr>
                    <th>No</th>
                    <td>{{rowNum}}</td>

                    <th>문의유형</th>
                    <td>{{{getCommonCodeSelect slct_type 'question_type'}}}</td>

                    <th>Browser</th>
                    <td>{{browser}}</td>

                    <th>회원번호</th>
                    <td>{{{mem_no}}}</td>

                    <th>접수일시</th>
                    <td>{{write_date}}</td>

                    <th>처리상태</th>
                    <td>{{{getCommonCodeLabel state 'question_status'}}}
                        <c:if test="${insertYn eq 'Y'}">
                            {{#equal state '2'}}
                            <button type="button" class="btn-sm btn btn-default bt_chatchRelease">해제</button>
                            {{/equal}}
                            {{#equal state '0'}}
                            <button type="button" class="btn-sm btn btn-default" onclick="chatch();">처리중</button>
                            {{/equal}}
                        </c:if>

                        <c:if test="${insertYn eq 'N'}">
                            {{#equal editAuth 'Y'}}
                            <button type="button" class="btn-sm btn btn-default bt_chatchRelease">해제</button>
                            {{/equal}}
                        </c:if>
                    </td>
                </tr>
                <tr>
                    <th>답변유형</th>
                    <td>
                        {{#dalbit_if noticeType '==' 0}} 보내지 않음 {{/dalbit_if}}
                        {{#dalbit_if noticeType '==' 1}} 문자 {{/dalbit_if}}
                        {{#dalbit_if noticeType '==' 2}} 메일 {{/dalbit_if}}
                        {{#dalbit_if noticeType '==' 3}} 문자/메일 {{/dalbit_if}}
                    </td>

                    <th>플랫폼</th>
                    <td>{{platform}}</td>

                    <th>ip Address</th>
                    <td>{{ip}}</td>

                    <th>문의자<br /></th>
                    <td>
                        {{#dalbit_if mem_userid '!=' ''}}
                            {{mem_userid}}<br/>
                        {{/dalbit_if}}
                        {{mem_level}}/{{mem_grade}}
                    </td>

                    <th>처리일시</th>
                    <td>{{op_date}}</td>

                    <th>처리자명</th>
                    <td>{{op_name}}</td>
                </tr>
                <tr>
                    <th colspan="2">회원에이전트</th>
                    <td colspan="4">
                        <%--<textarea class="form-control" id="mem_info" oninput="util.textareaResize(this, 100)" style="height: 100%">{{{replaceHtml question_contents}}}</textarea>--%>
                    </td>

                    <th rowspan="2">문의자<br />닉네임</th>
                    <td rowspan="2">{{mem_nick}}</td>

                    <th rowspan="2">문의자 이메일</th>
                    <td rowspan="2">{{email}}</td>
                    <th rowspan="2">연락처</th>
                    <td rowspan="2">{{phone}}</td>
                </tr>
                <tr>
                    <th colspan="2">문의제목</th>
                    <td colspan="4"><input type="text" class="form-control fit-table" value="{{question_title}}" /></td>
                </tr>
                <tr>
                    <th colspan="2">문의내용</th>
                    <td colspan="5">
                        <textarea class="form-control" id="question_contents" oninput="util.textareaResize(this, 200)" style="height: 100%;width: 100%">{{{replaceHtml question_contents}}}</textarea>
                    </td>

                    <th>첨부파일 <br /> {{fileCnt}} 건</th>
                    <td colspan="4">
                        {{#equal fileCnt 0}}
                        -
                        {{else}}
                        <div class="col-md-12 no-padding">
                        <form id="profileImg" method="post" enctype="multipart/form-data">
                            {{#dalbit_if ../add_file1 "!=" ""}}<img class="thumbnail fullSize_background col-md-10 no-padding" src="{{renderImage ../add_file1}}" alt="your image" style="width: 150px;height: 150px" />{{/dalbit_if}}
                            {{#dalbit_if ../add_file2 "!=" ""}}<img class="thumbnail fullSize_background col-md-10 no-padding" src="{{renderImage ../add_file2}}" alt="your image" style="width: 150px;height: 150px" />{{/dalbit_if}}
                            {{#dalbit_if ../add_file3 "!=" ""}}<img class="thumbnail fullSize_background col-md-10 no-padding" src="{{renderImage ../add_file3}}" alt="your image" style="width: 150px;height: 150px" />{{/dalbit_if}}
                        </form>
                        </div>
                        <div class="col-md-12 no-padding">
                        <button type="button" id="bt_fileDel" class="btn btn-danger btn-sm" style="" onclick="fileDel();">첨부파일 삭제</button>
                        </div>
                        {{/equal}}
                    </td>
                </tr>

                <tr>
                    <th colspan="2">매크로 답변</th>
                    <td colspan="2" id="_faqGroupArea"></td>
                    <td colspan="2" id="_faqSubArea"></td>

                    <td style="text-align: center">
                        <button type="button" id="bt_faq" class="btn-sm btn btn-default">적용</button>
                    </td>

                    <th rowspan="2">바로가기버튼</th>
                    <td colspan="4" rowspan="2">
                        <button type="button" id="bt_moon" class="btn-sm btn btn-default bt_baro" style="margin-bottom: 3px" data-url=" https://m.dalbitlive.com/store">달결제</button>
                        <button type="button" id="bt_star" class="btn-sm btn btn-default bt_baro" style="margin-bottom: 3px" data-url="https://m.dalbitlive.com/money_exchange">별환전</button>
                        <button type="button" id="bt_wallet" class="btn-sm btn btn-default bt_baro" style="margin-bottom: 3px" data-url="https://m.dalbitlive.com/mypage/{{mem_no}}/wallet">내지갑</button>
                        <button type="button" id="bt_profile" class="btn-sm btn btn-default bt_baro" style="margin-bottom: 3px" data-url="https://m.dalbitlive.com/mypage/setting">사진등록</button>
                        <button type="button" id="bt_broadRoot" class="btn-sm btn btn-default bt_baro" style="margin-bottom: 3px" data-url="https://m.dalbitlive.com/customer/faq">방송방법</button>
                        <button type="button" id="bt_myinfo" class="btn-sm btn btn-default bt_baro" style="margin-bottom: 3px" data-url="https://m.dalbitlive.com/private">내정보관리</button>
                        <button type="button" id="bt_pcSetting" class="btn-sm btn btn-default bt_baro" style="margin-bottom: 3px" data-url="https://www.youtube.com/watch?v=EegzDQ_dZAc target='_blank'">PC 방송 기본장비 설정하기</button>
                        <button type="button" id="bt_pcBroad" class="btn-sm btn btn-default bt_baro" style="margin-bottom: 3px" data-url="https://www.youtube.com/watch?v=-wAeaNZLEws&t=4s target='_blank'">PC방송하기</button>
                        <button type="button" id="bt_mobileBroad" class="btn-sm btn btn-default bt_baro" style="margin-bottom: 3px" data-url="https://www.youtube.com/watch?v=IKo_tNDPpB0&t=1s target='_blank'">모바일 방송하기</button>
                    </td>
                </tr>
                <tr>
                    <th colspan="2">
                        운영자 메모 ({{opMemoCnt}}건)<br>
                        <button type="button" id="bt_adminMemoList" class="btn-sm btn btn-default" onclick="adminMemoList();">자세히</button>
                    </th>
                    <td colspan="4">
                        <input type="text" class="form-control" id="txt_qnaAdminMemo" style="width: 100%">
                    </td>

                    <td style="text-align: center">
                        <button type="button" id="bt_adminMemo" class="btn-sm btn btn-default" onclick="adminMemoAdd();">등록</button>
                    </td>
                </tr>
                </tbody>
            </table>

            <div class="widget mt10" id="div_editor">
                <div class="pull-right">
                    <button class="btn btn-default" type="button" id="mobileBtn" onclick="mobileBtnClick();">모바일 형태보기</button>
                    <button class="btn btn-danger" type="button" id="deleteBtn">내용삭제</button>
                    <%--{{^equal state '2'}}--%>
                    <button type="button" id="bt_operate" class="btn btn-success">완료</button>
                    <%--{{/equal}}--%>
                    <%--{{#equal state '1'}}--%>
                    <%--<button type="button" id="bt_update" class="btn btn-default">수정</button>--%>
                    <%--{{/equal}}--%>
                </div>
                {{#dalbit_if noticeType '==' 2}}
                    <div class="widget-header">
                        <h3><i class="fa fa-user"></i> 메일 답변 </h3>
                    </div>
                    <div class="_editor" id="editor" name="editor">{{{replaceHtml answer}}}</div>
                {{else}}
                    {{#dalbit_if noticeType '==' 0}}
                        <div class="widget-header">
                            <h3><i class="fa fa-user"></i> 답변 </h3>
                        </div>
                        <div class="_editor" id="editor" name="editor">{{{replaceHtml answer}}}</div>
                    {{else}}
                        <div class="widget-header">
                            <h3><i class="fa fa-user"></i> 문자 답변 </h3>
                        </div>
                        <div>
                            <div><span class="font-bold">제목</span></div>
                            <input type="text" class="form-control" name="subject" id="smsSend-subject" placeholder="LMS 발송 제목을 입력해주세요." value="[달빛라이브]{{question_title}}" maxlength="30" disabled>
                            <span style="color: red; font-size:0.9em">* 제목은 수정이 불가능합니다.</span>
                            <br/>
                        </div>
                        <div>
                            <div><span class="font-bold">내용</span></div>
                            <div>
                                <textarea class="form-control" name="msg_body" id="smsSend-msg_body" rows="8" cols="30" placeholder="LMS 발송 문자 내용을 입력해 주세요." style="resize: none;height: 500px">{{{msg_body}}}</textarea>
                                <span style="color: red; font-size:0.9em">* 1000자 이상 시 나눠서 발송 됩니다.</span><br>
                            </div>
                        </div>
                    {{/dalbit_if}}
                {{/dalbit_if}}

            </div>

        </div>
    </div>
</script>

<script id="tmp_question_faqGroup" type="text/x-handlebars-template">
    <select name="faqGroup" id="faqGroup" class="form-control">
        {{#each this as |faq|}}
        <option value="{{faq.slct_type}}">{{questionGroupName faq.slct_type}}</option>
        {{/each}}
    </select>
</script>

<script id="tmp_question_faqSub" type="text/x-handlebars-template">
    <select name="faqSub" id="faqSub" class="form-control">
        {{#each this as |sub|}}
        <option data-answer="{{replaceHtml sub.answer}}">{{sub.question}}</option>
        {{/each}}
    </select>
</script>