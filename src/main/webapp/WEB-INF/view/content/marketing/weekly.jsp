<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="dummyData"><%= java.lang.Math.round(java.lang.Math.random() * 1000000) %></c:set>

<!-- DATA TABLE -->
<div class="dataTables_paginate paging_full_numbers" id="weeklyList_info_paginate_top"></div>
<div>
    <table id="weeklyList" class="table table-sorting table-hover table-bordered">
        <thead>
        <tr>
            <th>No</th>
            <th>회차</th>
            <th>구분</th>
            <th>제목</th>
            <th>대상1</th>
            <th>대상2</th>
            <th>등록일시</th>
            <th>조회수</th>
            <th>게시상태</th>
            <th>처리자명</th>
        </tr>
        </thead>
        <tbody id="weeklyList_tableBody"></tbody>
    </table>
</div>
<div class="dataTables_paginate paging_full_numbers" id="weeklyList_info_paginate"></div>
<!-- DATA TABLE END -->
<input type="button" value="선택 삭제" class="btn btn-danger btn-sm" id="btn_delete"/>

<div id="wrapper">
    <form id="weeklyForm"></form>
</div>

<jsp:include page="/WEB-INF/view/common/util/select_memeberList.jsp"></jsp:include>


<script type="text/javascript" src="/js/code/menu/menuCodeList.js?${dummyData}"></script>
<script type="text/javascript">
    var weeklyPagingInfo = new PAGING_INFO(0,1,100);

    $(function (){
        getWeeklyList();

        $("#btn_selectMember").on("click", function () {
            showPopMemberList(choiceMember);
        });

    });

    function getWeeklyList(){

        console.log("----------------------");

        var template = $('#tmp_weeklyList').html();
        var templateScript = Handlebars.compile(template);
        var html = templateScript();
        $("#weeklyList_tableBody").html(html);


        var template = $('#tmp_weeklyForm').html();
        var templateScript = Handlebars.compile(template);
        var html = templateScript();
        $("#weeklyForm").html(html);
        util.editorInit("content-notice");
        // console.log(dataSet());
        // util.getAjaxData("weeklyList", "/rest/menu/weekly/list", dataSet(), fn_succ_weeklyList);


    }


    function fn_succ_weeklyList(data, response, params) {
        dalbitLog(response);

        var template = $('#tmp_weeklyList').html();
        var templateScript = Handlebars.compile(template);
        var context = response.data;
        // var html = templateScript(context);
        var html = templateScript();
        $("#weeklyList_tableBody").html(html);

        var pagingInfo = response.pagingVo;
        weeklyPagingInfo.totalCnt = pagingInfo.totalCnt;
        util.renderPagingNavigation("weeklyList_info_paginate_top", weeklyPagingInfo);
        util.renderPagingNavigation("weeklyList_info_paginate", weeklyPagingInfo);
    }

    function handlebarsPaging(targetId, pagingInfo){
        console.log("---------------------------- targetId");
        console.log(targetId);
        weeklyPagingInfo = pagingInfo;
    }

    // // [수신대상 선택 - 지정회원] 회원 추가
    function choiceMember(data) {
        console.log(data);
        var html = '<span id="' + data.mem_no + '">' + data.mem_nick + '(' +data.mem_userid+ ') <a style="cursor: pointer;" onclick="delMember($(this))">[X]</a></span>&nbsp;&nbsp;&nbsp;&nbsp;';

        if($("#div_selectTarget").find("span").length >= 2){
            alert("최대 2명까지 지정 가능합니다.");
            return false;
        }

        $("#div_selectTarget").append(html);
    }

    // [수신대상 선택 - 지정회원] 회원 삭제
    function delMember(dom) {
        dom.parent("span").remove();
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
    $(document).on('click', '#deleteBtn', function(){
        $('.note-editable').empty();
    });

    $(document).on('click', '#insertBtn', function(){
        if(confirm("등록하시겠습니까?")){
            // util.getAjaxData("insert", "/rest/administrate/faq/insert", generateData(), fn_insert_success);
        }
    });

</script>

<script type="text/x-handlebars-template" id="tmp_weeklyList">
    {{#each this as |user|}}
    <tr>
        <td>{{rowNum}}</td>
        <td>-</td>
        <td>-</td>
        <td>-</td>
        <td>-</td>
        <td>-</td>
        <td>-</td>
        <td>-</td>
        <td>-</td>
        <td>-</td>
        <td>-</td>
    </tr>
    {{else}}
    <tr>
        <td colspan="11">{{isEmptyData}}</td>
    </tr>
    {{/each}}
</script>



<script id="tmp_weeklyForm" type="text/x-handlebars-template">
    <div class="col-md-12 no-padding">
        <span class="pull-right">
                <button class="btn btn-default" type="button" id="mobileBtn" onclick="mobileBtnClick();">모바일형태</button>
                <button class="btn btn-danger" type="button" id="deleteBtn">내용삭제</button>
                <button class="btn btn-default" type="button" id="insertBtn">등록하기</button>
            </span>
    </div>
    <table class="table table-bordered table-dalbit">
        <colgroup>
        </colgroup>
        <tbody>
        <tr class="align-middle">
            <th>No</th>
            <td>0</td>
            <th>구분</th>
            <td>위클리픽</td>
            <th>제목</th>
            <td>
                <input class="form-control" type="text" id="title"/>
            </td>
            <th>조회수</th>
            <td>0</td>
        </tr>
        <tr>
            <th>회차</th>
            <td>
                <input class="form-control" type="text" id="sequence"/>
            </td>
            <th>등록일시</th>
            <td></td>
            <th>처리자</th>
            <td></td>
            <th>게시상태</th>
            <td>{{{getOnOffSwitch 1 'viewOn'}}}</td>
        </tr>
        <tr>
            <th>회원검색</th>
            <td colspan="7">
                <input type="button" value="회원검색" class="btn btn-success btn-xs" id="btn_selectMember"/>
                <div id="div_selectTarget" style="padding-left: 30px;"></div>
            </td>
        </tr>
        <tr>
            <th>내용</th>
            <td colspan="7">
                <div id="div_editor">
                    <div class="_editor" id="editor" name="editor"></div>
                </div>
            </td>
        </tr>
        </tbody>
    </table>
</script>