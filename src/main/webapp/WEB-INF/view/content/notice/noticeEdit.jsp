<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="dummyData"><%= java.lang.Math.round(java.lang.Math.random() * 1000000) %></c:set>

<%
    String in_noticeIdx = request.getParameter("noticeIdx");
    String in_rowNum = request.getParameter("rowNum");
%>
<div id="wrapper">
    <div id="page-wrapper">
        <div class="container-fluid">
            <ul class="nav nav-tabs nav-tabs-custom-colored" role="tablist">
                <li class="active"><a href="#" role="tab" data-toggle="tab">공지 내용 수정</a></li>
            </ul>
            <form id="noticeForm"></form>
        </div>
    </div>
</div>

<script type="text/javascript" src="/js/lib/jquery.table2excel.js"></script>
<script type="text/javascript" src="/js/code/content/contentCodeList.js?${dummyData}"></script>
<script>
    $(document).ready(function() {
        getNoticeDetail();

    });

    var noticeIdx = <%=in_noticeIdx%>;
    var rowNum = <%=in_rowNum%>;

    function getNoticeDetail(){
        if(noticeIdx == 0 && rowNum == 0){
            generateForm();
        }else{
            var obj = {};
            obj.noticeIdx = Number(noticeIdx);
            obj.rowNum = Number(rowNum);
            util.getAjaxData("detail", "/rest/content/notice/detail", obj, fn_detail_success);
        }
    }

    function generateForm() {
        var template = $('#tmp_noticeFrm').html();
        var templateScript = Handlebars.compile(template);
        $("#noticeForm").html(templateScript);

        util.editorInit("content-notice");
    }

    function fn_detail_success(dst_id, response, params) {
        response.data["rowNum"] = rowNum;
        var template = $('#tmp_noticeFrm').html();
        var templateScript = Handlebars.compile(template);
        var context = response.data;
        var html = templateScript(context);
        $("#noticeForm").html(html);

        //platform check 추가
        var platformInfo = response.data.platform;
        var platformData = platformInfo.split('');
        platformData.forEach(function(data, index){
            if(data == '1'){
                $("#platform"+ (index + 1)).click();
            }
        });

        // uploadType 추가
        util.editorInit("content-notice");
    }

    function isValid(){

        var slctType = $("#noticeForm #slctType");
        if(common.isEmpty(slctType.val())){
            alert("구분을 선택해주세요.");
            slctType.focus();
            return false;
        }

        var title = $("#noticeForm #title");
        if(common.isEmpty(title.val())){
            alert("제목을 입력해주세요.");
            title.focus();
            return false;
        }

        if($('input[name="platform"]:checked').length == 0){
            alert("플랫폼을 하나 이상 선택해 주세요.");
            return false;
        }

        var editor = $("#editor");
        if(editor.summernote('isEmpty')){
            alert("내용을 입력해주세요.");
            editor.focus();
            return false;
        }

        return true;
    }

    function generateFormData(){
        var data = {};
        var formArray = $("#noticeForm").serializeArray();
        for (var i = 0; i < formArray.length; i++){
            data[formArray[i]['name']] = formArray[i]['value'];
        }
        data["contents"] = $("#editor").summernote('code');
        data["viewOn"] = $("#detail_viewOn").prop('checked') ? 1 : 0;

        var platform_pc = $("#platform1").prop('checked') ? '1' : '0';
        var platform_aos = $("#platform2").prop('checked') ? '1' : '0';
        var platform_ios = $("#platform3").prop('checked') ? '1' : '0';
        data["platform"] = platform_pc + platform_aos + platform_ios;

        data["iosJudgeViewOn"] = $("#detail_iosJudgeViewOn").prop('checked') ? 1 : 0;

        dalbitLog(data);

        return data;
    }

    var tmp_btn;
    $(document).on('click', '#insertBtn', function(){
        if(isValid()){
            if(confirm('등록하시겠습니까?')){
                tmp_btn = "insertBtn";
                util.getAjaxData("insert", "/rest/content/notice/insert", generateFormData(), fn_insert_success);
            }
        }
    });

    $(document).on('click', '#updateBtn', function(){
        if(isValid()){
            if(confirm('수정하시겠습니까?')) {
                tmp_btn = "updateBtn";
                util.getAjaxData("update", "/rest/content/notice/update", generateFormData(), fn_insert_success);
            }
        }
    });

    $(document).on('click', '#listBack', function(){
        location.href = "/content/notice/list";
    });

    $(document).on('click', '#deleteBtn', function(){
        $('.note-editable').empty();
    });

    function fn_insert_success(dst_id, response) {
        alert(response.message);
        if(tmp_btn == "insertBtn"){
            location.href = "/content/notice/list";
        }else{
            location.href = "/content/notice/noticeDetail?noticeIdx="+ noticeIdx + "&rowNum=" + rowNum;
        }
    }

    function mobileBtnClick(tmp){
        if($("#mobileBtn").text() == "모바일형태"){
            $("#mobileBtn").text("PC형태");
            $('#div_editor').css({ width: 360});
        }else{
            $("#mobileBtn").text("모바일형태");
            $('#div_editor').css({ width: ''});
        }
    }

    $(document).on('change', 'input[name="platform"]', function(){
       var me = $(this);
       var index = me.index('input[name="platform"]');
       if(index == 0){
           console.log(me.prop('checked'))
           if(me.prop('checked')){
               $('input[name="platform"]').prop('checked', 'checked');
           }else{
               $('input[name="platform"]').prop('checked', false);
           }
       }else{
           var checkboxLength = $('input[name="platform"]:not("#platform-1")').length;
           var checkedLength = $('input[name="platform"]:not("#platform-1"):checked').length;

           if(me.prop('checked')){
               if(checkboxLength == checkedLength){
                   $("#platform-1").prop('checked', 'checked');
               }
           }else{
               $("#platform-1").prop('checked', false);
           }
       }
    });

</script>

<script id="tmp_noticeFrm" type="text/x-handlebars-template">
    <input type="hidden" name="noticeIdx" value="{{noticeIdx}}" />
    <div class="row col-lg-12 mt15" style="width: 1050px">
        <div class="col-md-12 no-padding">
            <label id="notice_title">ㆍ공지내용 등록 및 수정이 완료된 경우 [등록하기]버튼을 통하여 공지글 등록/수정이 완료됩니다.
                                <br> ㆍ게시상태는 ON 으로 선택한 경우만 서비스 페이지에서 확인이 가능합니다.</label>
            <span class="pull-right">
            <button class="btn btn-default" type="button" id="mobileBtn" onclick="mobileBtnClick();">모바일형태</button>
            <button class="btn btn-danger" type="button" id="deleteBtn">내용삭제</button>
            {{^noticeIdx}}<button class="btn btn-default" type="button" id="insertBtn">등록하기</button>{{/noticeIdx}}
            {{#noticeIdx}}<button class="btn btn-default" type="button" id="updateBtn">수정하기</button>{{/noticeIdx}}
            <button class="btn btn-default" type="button" id="listBack">목록보기</button>
        </span>
        </div>
        <table class="table table-bordered border-black table-dalbit mb0" style="border-color: black">
            <colgroup>
                <col width="4%" />
                <col width="4%" />
                <col width="6%" />
                <col width="4%" />
                <col width="8%" />
                <col width="8%" />
                <col width="8%" />
                <col width="8%" />
                <col width="8%" />
                <col width="8%" />
                <col width="8%" />
                <col width="8%" />
                <col width="8%" />
                <col width="8%" />
            </colgroup>
            <tbody>
                <tr class="align-middle">
                    <th>No</th>
                    <td>{{rowNum}}</td>

                    <th>공지번호</th>
                    <td>{{noticeIdx}}</td>

                    <th>구분</th>
                    <td>{{{getCommonCodeSelect slctType 'notice_slctType' 'Y' ''}}}</td>

                    <th>제목</th>
                    <td colspan="5"><input type="text" name="title" id="title" class="form-control" value="{{{title}}}" maxlen></td>

                    <th>조회수</th>
                    <td>{{addComma viewCnt}}</td>
                </tr>
                <tr>
                    <th rowspan="2" colspan="2">플랫폼</th>
                    <td rowspan="2" colspan="2">{{{getCommonCodeCheck '' 'content_platform2'}}}</td>

                    <th rowspan="2">성별</th>
                    <td rowspan="2">{{{getCommonCodeSelect gender 'gender'}}}</td>

                    <th rowspan="2">등록일시</th>
                    <td rowspan="2">{{writeDate}}</td>

                    <th rowspan="2">게시중지일시</th>
                    <td rowspan="2">
                        {{offDate}}
                        {{#equal offDate ''}}-{{/equal}}
                    </td>

                    <th rowspan="2">처리자</th>
                    <td rowspan="2">{{opName}}</td>
                    <th>게시상태</th>
                    <td>
                        {{{getOnOffSwitch viewOn 'viewOn'}}}
                    </td>
                </tr>
                <tr>
                    <th>IOS심사시<br />비노출</th>
                    <td>{{{getOnOffSwitch iosJudgeViewOn 'iosJudgeViewOn'}}}</td>
                </tr>
            </tbody>
        </table>
    </div>
    <div class="row col-lg-12 form-inline" style="width: 1050px">
        <div class="widget" id="div_editor" style="border-color: black">
            <div class="widget-header" style="border-color: black">
                <h3><i class="fa fa-user"></i> 내용 </h3>
            </div>
            <div class="widget-content no-padding">
                <div class="_editor" id="editor" name="editor">{{{replaceHtml contents}}}</div>
            </div>
        </div>
    </div>
    <div class="row col-md-12" style="width: 1050px">
        <span class="pull-right">
            <button class="btn btn-default" type="button" id="mobileBtn" onclick="mobileBtnClick();">모바일형태</button>
            <button class="btn btn-danger" type="button" id="deleteBtn">내용삭제</button>
            {{^noticeIdx}}<button class="btn btn-default" type="button" id="insertBtn">등록하기</button>{{/noticeIdx}}
            {{#noticeIdx}}<button class="btn btn-default" type="button" id="updateBtn">수정하기</button>{{/noticeIdx}}
            <button class="btn btn-default" type="button" id="listBack">목록보기</button>
        </span>
    </div>

</script>