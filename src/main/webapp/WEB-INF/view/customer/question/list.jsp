<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="dummyData"><%= java.lang.Math.round(java.lang.Math.random() * 1000000) %></c:set>
<%
    String in_tabType = request.getParameter("tabType");
%>

<div id="wrapper">
    <div id="page-wrapper">
        <div class="container-fluid no-padding">
            <!-- serachBox -->
            <div class="col-md-7 no-padding">
                <form id="searchForm">
                    <div class="row col-lg-10 form-inline">
                        <div class="widget widget-table searchBoxArea">
                            <table>
                                <tr>
                                    <th rowspan="2" style="background-color:#4472c4;color:#e9ee17;width: 70px">
                                        <i class="fa fa-search"></i><br/>검색
                                    </th>
                                </tr>
                                <tr>
                                    <td style="text-align: left">
                                        <span name="question_searchType" id="question_searchType" style="display: none"></span>
                                        <span name="question_selbox_type" id="question_selbox_type" style="display: none"></span>
                                        <span name="slctDateType" id="slctDateType" onchange="seldateType_change();"></span>

                                        <div class="input-group date" id="rangeDatepicker" style="display: none">
                                            <label for="displayDate" class="input-group-addon">
                                                <span><i class="fa fa-calendar"></i></span>
                                            </label>
                                            <input type="text" name="displayDate" id="displayDate" class="form-control" />
                                        </div>

                                        <input type="hidden" name="startDate" id="startDate" />
                                        <input type="hidden" name="endDate" id="endDate" />
                                        <%--<input name="startDate" id="startDate" />--%>
                                        <%--<input name="endDate" id="endDate" />--%>

                                        <label><input type="text" class="form-control" id="txt_search" style="width: 130px"></label>
                                        <button type="button" class="btn btn-success" id="bt_search">검색</button>
                                        <a href="javascript://" class="_prevSearch" style="display: none">[이전]</a>
                                        <a href="javascript://" class="_todaySearch" style="display: none">[오늘]</a>
                                        <a href="javascript://" class="_nextSearch" style="display: none">[다음]</a>
                                    </td>
                                </tr>
                            </table>
                        </div>
                    </div>
                </form>
            </div>
            <div class="col-md-4 no-padding pull-right" style="margin-right: 30px">
                <span id="question_summaryArea0"></span>
                <span id="question_summaryArea"></span>
                <span id="question_summaryArea2"></span>
            </div>
            <!-- //serachBox -->
            <div class="row col-lg-12 form-inline" style="padding-top: 2px; padding-bottom: 15px;">
                <div class="widget-content">
                    <ul class="nav nav-tabs nav-tabs-custom-colored" role="tablist" id="tablist_con">
                        <li><a href="/status/question/info?tabType=1" id="tab_totalDetail">총계</a></li>
                        <li><a href="/status/question/info?tabType=2" id="tab_typeDetail">유형별</a></li>
                        <li><a href="/status/question/info?tabType=3" id="tab_platformDetail">플랫폼별</a></li>
                        <li><a href="/status/question/info?tabType=4" id="tab_untreatedDetail">미처리</a></li>
                        <li><a href="" role="tab" data-toggle="tab" onclick="tab_questionClick(0)" >전체 문의</a></li>
                        <%--<li><a href="" role="tab" data-toggle="tab" onclick="tab_questionClick(1)" >회원 문의</a></li>--%>
                        <%--<li><a href="" role="tab" data-toggle="tab" onclick="tab_questionClick(2)">비회원 문의</a></li>--%>
                        <li><a href="/customer/question/macro?tabType=0" title="매크로 관리 페이지로 이동합니다.">매크로 관리</a></li>
                    </ul>
                </div>
            </div>
            <!-- DATA TABLE -->
            <div class="row col-lg-12 form-inline">
                <div class="widget widget-table">
                    <div class="widget-header">
                        <h3><i class="fa fa-desktop"></i> 1:1 문의</h3>
                    </div>

                    <div class="col-md-12 no-padding">
                        <div class="col-md-6">
                            <br/>
                            <span name="question_status" id="question_status" onchange="question_status_change()"></span>
                            <span name="question_mem_state" id="question_mem_state" onchange="question_status_change()"></span>
                            <span name="question_platform" id="question_platform" onchange="question_status_change()"></span>
                        </div>
                    </div>
                    <div class="col-md-12 no-padding" id="div_table">
                        <div class="widget-content" id="main_table0">
                            <table id="list_info0" class="table table-sorting table-hover table-bordered ">
                                <thead>
                                </thead>
                                <tbody id="tableBody">
                                </tbody>
                            </table>
                        </div>
                        <div class="widget-content" id="main_table">
                            <table id="list_info" class="table table-sorting table-hover table-bordered ">
                                <thead>
                                </thead>
                                <tbody id="tableBody">
                                </tbody>
                            </table>
                        </div>
                        <div class="widget-content" id="main_table2">
                            <table id="list_info2" class="table table-sorting table-hover table-bordered ">
                                <thead>
                                </thead>
                                <tbody id="tableBody2">
                                </tbody>
                            </table>
                        </div>
                        <div id="buttonList"></div>
                    </div>
                </div>
            </div>
            <!-- DATA TABLE END -->
            <!-- TAB -->
            <div class="no-padding mb15" id="tab_qna">
                <jsp:include page="questionTab.jsp"></jsp:include>
            </div>
            <!-- TAB END -->
        </div>
    </div>
</div>


<!-- 운영자메모 Modal -->
<div class="modal fade" id="adminMemoModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog" style="width: 800px;display: table;">
        <div class="modal-content">
            <div class="modal-header">
                <lable>운영자메모</lable>
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
            </div>
            <div class="modal-body">
                <div class="widget-content">
                    <table id="memo_list" class="table table-sorting table-hover table-bordered">
                        <thead>
                        </thead>
                        <tbody id="tableBody">
                        </tbody>
                    </table>
                </div>
            </div>
            <div class="modal-footer">
            </div>
        </div>
    </div>
</div>
<!-- Modal 끝 -->

<script type="text/javascript" src="/js/code/customer/customerCodeList.js?${dummyData}"></script>
<script type="text/javascript" src="/js/code/customer/questionCodeList.js?${dummyData}"></script>

<script>
    var tabType = <%=in_tabType%>;
    var dateTime = new Date();
    dateTime = moment(dateTime).format("YYYY.MM.DD");
    var week = ['일', '월', '화', '수', '목', '금', '토'];
    var toDay = week[moment(new Date()).day()];
    setTimeDate(dateTime);

    var storageTimer;

    var dtList_info_detail0;     // 전체회원
    var dtList_info_detail;     // 회원
    var dtList_info_detail2;    // 비회원

    $(document).ready(function() {

        $("#displayDate").statsDaterangepicker(
            function(start, end, t1) {
                $("#startDate").val(start.format('YYYY.MM.DD'));
                $("#endDate").val(end.format('YYYY.MM.DD'));
            }
        );

        // ui.checkBoxInit('list_info');

        $('input[id="txt_search"]').keydown(function(e) {
            if (e.keyCode === 13) {
                getUserInfo();
            };
        });
        <!-- 버튼 -->
        $('#bt_search').click( function() {       //검색
            getUserInfo();
        });
        <!-- 버튼 끝 -->


        $("#question_summaryArea0").hide();
        $("#question_summaryArea").hide();
        $("#question_summaryArea2").hide();
        if(!common.isEmpty(tabType)){
            if(tabType == 0){
                $('.nav-tabs li:eq(4) a').tab('show');
                $("#question_summaryArea0").show();
            }else if(tabType == 1){
                $('.nav-tabs li:eq(5) a').tab('show');
                $("#question_summaryArea").show();
            }else if(tabType == 2){
                $('.nav-tabs li:eq(6) a').tab('show');
                $("#question_summaryArea2").show();
            }
        }else{
            $('.nav-tabs li:eq(4) a').tab('show');
            $("#question_summaryArea0").show();
        }

        $("#question_status").html(util.getCommonCodeSelect(-1, question_status));
        $("#question_platform").html(util.getCommonCodeSelect(-1, question_platform));
        tab_questionClick(0);
    });
    $("#question_searchType").html(util.getCommonCodeSelect(-1, question_searchType));
    $("#question_selbox_type").html(util.getCommonCodeSelect(-1, question_selbox_type));
    $("#slctDateType").html(util.getCommonCodeSelect(-1, slctDateType));

    $('#one_title').html("ㆍ회원의 1:1문의 내용을 확인하고, 답변 및 처리할 수 있습니다. 신중히 확인 한 후 답변바랍니다.");

    var tmp_searchText;
    var tmp_searchType= -1;
    var tmp_slctState =-1;
    var tmp_slctPlatform = null;

    if(!common.isEmpty(tabType)){
        tmp_slctMember = tabType;
    }

    function setTimeDate(dateTime){
        $("#startDate").val(dateTime);
        $("#endDate").val(dateTime);
    }

    $(document).on('click', '._prevSearch', function(){
        searchDate('prev');
    });

    $(document).on('click', '._nextSearch', function(){
        searchDate('next');
    });
    $(document).on('click', '._todaySearch', function(){
        searchDate();
    });

    function searchDate(dateType){
        if(common.isEmpty(dateType)){
            $("#startDate").val(moment(new Date()).format('YYYY.MM.DD'));
            $("#endDate").val(moment(new Date()).format('YYYY.MM.DD'));
            $("#displayDate").val($("#startDate").val() + ' - ' + $("#endDate").val());
            getUserInfo();
        }else if(dateType == 'prev'){
            setDay(-1);
        }else if(dateType == 'next'){
            setDay(1);
        }
    }

    function setDay(days){
        $("#startDate").val(moment($("#startDate").val()).add('days', days).format('YYYY.MM.DD'));
        $("#endDate").val(moment($("#endDate").val()).add('days', days).format('YYYY.MM.DD'));
        $("#displayDate").val($("#startDate").val() + " - " + $("#endDate").val());
        getUserInfo();
    }

    function seldateType_change(){
        if($("#slctDateType").find("select").val() == 0){
            $("#rangeDatepicker").hide();
            $("._prevSearch").hide();
            $("._todaySearch").hide();
            $("._nextSearch").hide();
        }else{
            $("#rangeDatepicker").show();
            $("._prevSearch").show();
            $("._todaySearch").show();
            $("._nextSearch").show();
        }
    }

    // function setMonth(months){
    //     $("#startDate").val(moment($("#startDate").val()).add('months', months).format('YYYY.MM.01'));
    //     $("#endDate").val(moment($("#startDate").val()).add('months', 1).add('days', -1).format('YYYY.MM.DD'));
    //     $("#displayDate").val($("#startDate").val() + " - " + $("#endDate").val());
    //     getUserInfo();
    // }

    // getUserInfo();
    function getUserInfo(){                 // 검색
        /* 엑셀저장을 위해 조회조건 임시저장 */
        tmp_searchText = $('#txt_search').val();
        if(tmp_slctMember == 0){
            dtList_info_detail0.reload(question_summary_table);
        }else if(tmp_slctMember == 1){
            dtList_info_detail.reload(question_summary_table);
        }else{
            dtList_info_detail2.reload(question_summary_table);
        }

        /*검색결과 영역이 접혀 있을 시 열기*/
        ui.toggleSearchList();

        $('#tab_customerQuestion').removeClass("show");
    }

    function question_summary_table(json){
        var template = $("#question_tableSummary0").html();
        var templateScript = Handlebars.compile(template);
        var data = {
            content : json.summary
            , length : json.recordsTotal
        }
        var html = templateScript(data);
        $("#question_summaryArea0").html(html);

        var template = $("#question_tableSummary").html();
        var templateScript = Handlebars.compile(template);
        var data = {
            content : json.summary
            , length : json.recordsTotal
        }
        var html = templateScript(data);
        $("#question_summaryArea").html(html);

        var template = $("#question_tableSummary2").html();
        var templateScript = Handlebars.compile(template);
        var data = {
            content : json.summary
            , length : json.recordsTotal
        }
        var html = templateScript(data);
        $("#question_summaryArea2").html(html);

        clearInterval(storageTimer);
        ui.paintColor();

    }

    function question_status_change(){
        // tmp_slctMember = $("#question_mem_state").find("#question_mem_state option:selected").val();
        tmp_slctState = $("#question_status").find("#question_status option:selected").val();
        tmp_slctPlatform = $('#platform').val();
        if(tmp_slctMember == 0) {
            dtList_info_detail0.reload(question_summary_table);
        }if(tmp_slctMember == 1) {
            dtList_info_detail.reload(question_summary_table);
        }else{
            dtList_info_detail2.reload(question_summary_table);
        }
    }

    $("#question_searchType").find("select").change( function() {
        $("#question_selbox_type").find("select").val(-1);
        tmp_searchType = $("#question_searchType").find("select").val();
    });

    $("#question_selbox_type").find("select").change( function() {
        $("#question_searchType").find("select").val(-1);
        tmp_searchType = $("#question_selbox_type").find("select").val();
    });

    var qnaIdx;
    var answer;
    var rowNum;
    function getQuestDetail(index){
        clearInterval(storageTimer);
        $("#tab_qna").removeClass("hide");

        if(tmp_slctMember == 0){
            var data = dtList_info_detail0.getDataRow(index);
        }else if(tmp_slctMember == 1){
            var data = dtList_info_detail.getDataRow(index);
        }else{
            var data = dtList_info_detail2.getDataRow(index);
        }
        var obj ={};
        obj.qnaIdx = data.qnaIdx;
        obj.answer = data.answer;
        obj.rowNum = data.rowNum;

        qnaIdx = data.qnaIdx;
        answer = data.answer;
        rowNum = data.rowNum;

        util.getAjaxData("type", "/rest/customer/question/detail",obj, quest_detail_success);
    }

    function fn_success_excel(){
        console.log("fn_success_excel");
    }
    function fn_fail_excel(){
        console.log("fn_fail_excel");
    }

    // $(document).on('click', '#list_info .dt-body-center input[type="checkbox"]', function(){
    //     if($(this).prop('checked')){
    //         $(this).parent().parent().find('.getQuestDetail').click();
    //     }else{
    //         $('#tab_customerQuestion').removeClass("show");
    //     }
    // });

    function questionDelData(){
        if(tmp_slctMember == 0) {
            var checkDatas = dtList_info_detail0.getCheckedData();
        }else if(tmp_slctMember == 1) {
            var checkDatas = dtList_info_detail.getCheckedData();
        }else{
            var checkDatas = dtList_info_detail2.getCheckedData();
        }
        if(checkDatas.length <= 0){
            alert("삭제할 사연을 선택해 주십시오");
            return;
        }
        var tmp_sw = true;
        // 1:1 문의 삭제 상태 체크

        for(var i=0;i<checkDatas.length;i++){
            if(checkDatas[i].state == 1){
                tmp_sw = false;
                break;
            }
        }
        if(!tmp_sw){
            if (confirm("처리완료 건이 있습니다. 삭제 하시겠습니까?")) {
                tmp_sw = true;
            }
        }
        if(tmp_sw){
            var data = new Object();
            data.delList = checkDatas;
            util.getAjaxData("delete", "/rest/customer/question/delete",data, questionDel_success);
        }else{
            return;
        }
    }

    function questionDel_success(dst_id, response) {
        if(tmp_slctMember == 0) {
            dtList_info_detail0.reload();
        }else if(tmp_slctMember == 1) {
            dtList_info_detail.reload();
        }else{
            dtList_info_detail2.reload();
        }

        $("#tab_qna").addClass("hide");
    }

    function tab_questionClick(tmp) {
        tmp_slctMember = tmp;
        if(tmp == 0){
            $("#question_summaryArea0").show();
            $("#main_table0").show();
            $("#question_summaryArea").hide();
            $("#main_table").hide();
            $("#question_summaryArea2").hide();
            $("#main_table2").hide();
        }else if(tmp == 1){
            $("#question_summaryArea0").hide();
            $("#main_table0").hide();
            $("#question_summaryArea").show();
            $("#main_table").show();
            $("#question_summaryArea2").hide();
            $("#main_table2").hide();
        }else if(tmp == 2){
            $("#question_summaryArea0").hide();
            $("#main_table0").hide();
            $("#question_summaryArea").hide();
            $("#main_table").hide();
            $("#question_summaryArea2").show();
            $("#main_table2").show();
        }
        if(tmp == 0){
            allMembers();
        }else if(tmp == 1){
            members();
        }else if(tmp == 2){
            nonMembers();
        }

        $("#buttonList").empty();
        var questionDelBtn = '<input type="button" value="선택삭제" class="btn btn-danger btn-sm ml10" id="btn_questionDelBtn" style="margin-right: 3px;"/>';
        var excel = '<button class="btn btn-default btn-sm print-btn pull-right mr10" type="button" id="excelDownBtn"><i class="fa fa-print"></i>Excel Down</button>';
        $("#buttonList").append(questionDelBtn);
        $("#buttonList").append(excel);
        // $("#main_table").find(".footer-right").append(excel);
        // $("#main_table2").find(".footer-right").append(excel);

        questionDelEventInit();
        questionExcelEventInit();

        $("#tab_qna").addClass("hide");
    }
    function allMembers(){
        console.log("--------------------");
        var dtList_info_detail_data0 = function ( data ) {
            data.searchText = $('#txt_search').val();
            data.searchType = tmp_searchType;
            data.slctState = tmp_slctState;
            data.slctPlatform = tmp_slctPlatform;
            data.slctMember = tmp_slctMember;
            data.startDate = $("#startDate").val();
            data.endDate = $("#endDate").val();
            data.slctDateType = $("#slctDateType").find("select").val();
        };

        dtList_info_detail0 = new DalbitDataTable($("#list_info0"), dtList_info_detail_data0, questionDataTableSource.questList);
        dtList_info_detail0.useCheckBox(true);
        dtList_info_detail0.useIndex(true);
        dtList_info_detail0.createDataTable(question_summary_table);
    }

    function members(){
        var dtList_info_detail_data = function ( data ) {
            data.searchText = $('#txt_search').val();
            data.searchType = tmp_searchType;
            data.slctState = tmp_slctState;
            data.slctPlatform = tmp_slctPlatform;
            data.slctMember = tmp_slctMember;
            data.startDate = $("#startDate").val();
            data.endDate = $("#endDate").val();
            data.slctDateType = $("#slctDateType").find("select").val();
        };

        dtList_info_detail = new DalbitDataTable($("#list_info"), dtList_info_detail_data, questionDataTableSource.questList);
        dtList_info_detail.useCheckBox(true);
        dtList_info_detail.useIndex(true);
        dtList_info_detail.createDataTable(question_summary_table);
    }

    function nonMembers(){
        var dtList_info_detail_data2 = function ( data ) {
            data.searchText = $('#txt_search').val();
            data.searchType = tmp_searchType;
            data.slctState = tmp_slctState;
            data.slctPlatform = tmp_slctPlatform;
            data.slctMember = tmp_slctMember;
            data.startDate = $("#startDate").val();
            data.endDate = $("#endDate").val();
            data.slctDateType = $("#slctDateType").find("select").val();
        };

        dtList_info_detail2 = new DalbitDataTable($("#list_info2"), dtList_info_detail_data2, questionDataTableSource.questListNonMember);
        dtList_info_detail2.useCheckBox(true);
        dtList_info_detail2.useIndex(true);
        dtList_info_detail2.createDataTable(question_summary_table);

    }


    function questionDelEventInit(){
        $("#btn_questionDelBtn").on("click", function () { //선택삭제
            if (confirm("선택한 1:1문의를 삭제하시겠습니까?")) {
                questionDelData();
            }
        });
    }

    function questionExcelEventInit() {
        /*=============엑셀==================*/
        $('#excelDownBtn').on('click', function () {
            var formElement = document.querySelector("form");
            var formData = new FormData(formElement);
            formData.append("slctState", -1);
            util.excelDownload($(this), "/rest/customer/question/listExcel", formData, fn_success_excel, fn_fail_excel);

        });
    }

    /*==================================*/
</script>

<script id="question_tableSummary0" type="text/x-handlebars-template">
    <table class="table table-bordered table-summary pull-right no-margin" style="width: 820px;">
        <colgroup>
            <col width="10%"/><col width="10%"/><col width="10%"/><col width="10%"/><col width="8%"/>
            <col width="10%"/><col width="10%"/><col width="12%"/><col width="10%"/><col width="10%"/>
        </colgroup>
        <tr>
            <th class="_bgColor" data-bgcolor="#d9d9d9"></th>
            <th class="_bgColor" data-bgcolor="#b4c7e7">회원정보</th>
            <th class="_bgColor" data-bgcolor="#b4c7e7">방송정보</th>
            <th class="_bgColor" data-bgcolor="#b4c7e7">청취하기</th>
            <th class="_bgColor" data-bgcolor="#b4c7e7">결제</th>
            <th class="_bgColor" data-bgcolor="#b4c7e7">건의하기</th>
            <th class="_bgColor" data-bgcolor="#b4c7e7">장애/버그</th>
            <th class="_bgColor" data-bgcolor="#b4c7e7">선물/아이템</th>
            <th class="_bgColor" data-bgcolor="#b4c7e7">기타</th>
            <th class="_bgColor" data-bgcolor="#d9d9d9">총합</th>
        </tr>
        <tr>
            <td class="_bgColor font-bold" data-bgcolor="#dae3f3">회원 / 비회원</td>
            <td>
                {{#equal length '0'}}0{{/equal}}{{#dalbit_if content.type1Cnt '!=' content.type1OpCnt}} <span class="font-bold" style="color: red;">{{content.type1Cnt}}</span>{{else}} {{content.type1Cnt}} {{/dalbit_if}} /
                {{#equal length '0'}}0{{/equal}}{{#dalbit_if content.no_type1Cnt '!=' content.no_type1OpCnt}} <span class="font-bold" style="color: red;">{{content.no_type1Cnt}}</span>{{else}} {{content.no_type1Cnt}} {{/dalbit_if}}건
            </td>
            <td>
                {{#equal length '0'}}0{{/equal}}{{#dalbit_if content.type2Cnt '!=' content.type2OpCnt}} <span class="font-bold" style="color: red;">{{content.type2Cnt}}</span>{{else}} {{content.type2Cnt}} {{/dalbit_if}} /
                {{#equal length '0'}}0{{/equal}}{{#dalbit_if content.no_type2Cnt '!=' content.no_type2OpCnt}} <span class="font-bold" style="color: red;">{{content.no_type2Cnt}}</span>{{else}} {{content.no_type2Cnt}} {{/dalbit_if}}건
            </td>
            <td>
                {{#equal length '0'}}0{{/equal}}{{#dalbit_if content.type3Cnt '!=' content.type3OpCnt}} <span class="font-bold" style="color: red;">{{content.type3Cnt}}</span>{{else}} {{content.type3Cnt}} {{/dalbit_if}} /
                {{#equal length '0'}}0{{/equal}}{{#dalbit_if content.no_type3Cnt '!=' content.no_type3OpCnt}} <span class="font-bold" style="color: red;">{{content.no_type3Cnt}}</span>{{else}} {{content.no_type3Cnt}} {{/dalbit_if}}건
            </td>
            <td>
                {{#equal length '0'}}0{{/equal}}{{#dalbit_if content.type4Cnt '!=' content.type4OpCnt}} <span class="font-bold" style="color: red;">{{content.type4Cnt}}</span>{{else}} {{content.type4Cnt}} {{/dalbit_if}} /
                {{#equal length '0'}}0{{/equal}}{{#dalbit_if content.no_type4Cnt '!=' content.no_type4OpCnt}} <span class="font-bold" style="color: red;">{{content.no_type4Cnt}}</span>{{else}} {{content.no_type4Cnt}} {{/dalbit_if}}건
            </td>
            <td>
                {{#equal length '0'}}0{{/equal}}{{#dalbit_if content.type5Cnt '!=' content.type5OpCnt}} <span class="font-bold" style="color: red;">{{content.type5Cnt}}</span>{{else}} {{content.type5Cnt}} {{/dalbit_if}} /
                {{#equal length '0'}}0{{/equal}}{{#dalbit_if content.no_type5Cnt '!=' content.no_type5OpCnt}} <span class="font-bold" style="color: red;">{{content.no_type5Cnt}}</span>{{else}} {{content.no_type5Cnt}} {{/dalbit_if}}건
            </td>
            <td>
                {{#equal length '0'}}0{{/equal}}{{#dalbit_if content.type6Cnt '!=' content.type6OpCnt}} <span class="font-bold" style="color: red;">{{content.type6Cnt}}</span>{{else}} {{content.type6Cnt}} {{/dalbit_if}} /
                {{#equal length '0'}}0{{/equal}}{{#dalbit_if content.no_type6Cnt '!=' content.no_type6OpCnt}} <span class="font-bold" style="color: red;">{{content.no_type6Cnt}}</span>{{else}} {{content.no_type6Cnt}} {{/dalbit_if}}건
            </td>
            <td>
                {{#equal length '0'}}0{{/equal}}{{#dalbit_if content.type7Cnt '!=' content.type7OpCnt}} <span class="font-bold" style="color: red;">{{content.type7Cnt}}</span>{{else}} {{content.type7Cnt}} {{/dalbit_if}} /
                {{#equal length '0'}}0{{/equal}}{{#dalbit_if content.no_type7Cnt '!=' content.no_type7OpCnt}} <span class="font-bold" style="color: red;">{{content.no_type7Cnt}}</span>{{else}} {{content.no_type7Cnt}} {{/dalbit_if}}건
            </td>
            <td>
                {{#equal length '0'}}0{{/equal}}{{#dalbit_if content.type99Cnt '!=' content.type99OpCnt}} <span class="font-bold" style="color: red;">{{content.type99Cnt}}</span>{{else}} {{content.type99Cnt}} {{/dalbit_if}} /
                {{#equal length '0'}}0{{/equal}}{{#dalbit_if content.no_type99Cnt '!=' content.no_type99OpCnt}} <span class="font-bold" style="color: red;">{{content.no_type99Cnt}}</span>{{else}} {{content.no_type99Cnt}} {{/dalbit_if}}건
            </td>
            <td class="_bgColor font-bold" data-bgcolor="#f2f2f2">
                {{#equal length '0'}}0{{/equal}}{{#equal length '0'}}0{{/equal}}{{#dalbit_if content.totalQna '!=' content.totalOpQna}} <span class="font-bold" style="color: red;">{{content.totalQna}}</span>{{else}} {{content.totalQna}} {{/dalbit_if}} /
                {{#equal length '0'}}0{{/equal}}{{#equal length '0'}}0{{/equal}}{{#dalbit_if content.no_totalQna '!=' content.no_totalOpQna}} <span class="font-bold" style="color: red;">{{content.no_totalQna}}</span>{{else}} {{content.no_totalQna}} {{/dalbit_if}}건
            </td>
        </tr>
        <tr>
            <td class="_bgColor font-bold" data-bgcolor="#dae3f3">운영자 처리</td>
            <td>
                {{#equal length '0'}}0{{/equal}}{{#dalbit_if content.type1OpCnt '!=' content.type1Cnt}} <span class="font-bold" style="color: red;">{{content.type1OpCnt}}</span>{{else}} {{content.type1OpCnt}} {{/dalbit_if}} /
                {{#equal length '0'}}0{{/equal}}{{#dalbit_if content.no_type1OpCnt '!=' content.no_type1Cnt}} <span class="font-bold" style="color: red;">{{content.no_type1OpCnt}}</span>{{else}} {{content.no_type1OpCnt}} {{/dalbit_if}}건
            </td>
            <td>
                {{#equal length '0'}}0{{/equal}}{{#dalbit_if content.type2OpCnt '!=' content.type2Cnt}} <span class="font-bold" style="color: red;">{{content.type2OpCnt}}</span>{{else}} {{content.type2OpCnt}} {{/dalbit_if}} /
                {{#equal length '0'}}0{{/equal}}{{#dalbit_if content.no_type2OpCnt '!=' content.no_type2Cnt}} <span class="font-bold" style="color: red;">{{content.no_type2OpCnt}}</span>{{else}} {{content.no_type2OpCnt}} {{/dalbit_if}}건
            </td>
            <td>
                {{#equal length '0'}}0{{/equal}}{{#dalbit_if content.type3OpCnt '!=' content.type3Cnt}} <span class="font-bold" style="color: red;">{{content.type3OpCnt}}</span>{{else}} {{content.type3OpCnt}} {{/dalbit_if}} /
                {{#equal length '0'}}0{{/equal}}{{#dalbit_if content.no_type3OpCnt '!=' content.no_type3Cnt}} <span class="font-bold" style="color: red;">{{content.no_type3OpCnt}}</span>{{else}} {{content.no_type3OpCnt}} {{/dalbit_if}}건
            </td>
            <td>
                {{#equal length '0'}}0{{/equal}}{{#dalbit_if content.type4OpCnt '!=' content.type4Cnt}} <span class="font-bold" style="color: red;">{{content.type4OpCnt}}</span>{{else}} {{content.type4OpCnt}} {{/dalbit_if}} /
                {{#equal length '0'}}0{{/equal}}{{#dalbit_if content.no_type4OpCnt '!=' content.no_type4Cnt}} <span class="font-bold" style="color: red;">{{content.no_type4OpCnt}}</span>{{else}} {{content.no_type4OpCnt}} {{/dalbit_if}}건
            </td>
            <td>
                {{#equal length '0'}}0{{/equal}}{{#dalbit_if content.type5OpCnt '!=' content.type5Cnt}} <span class="font-bold" style="color: red;">{{content.type5OpCnt}}</span>{{else}} {{content.type5OpCnt}} {{/dalbit_if}} /
                {{#equal length '0'}}0{{/equal}}{{#dalbit_if content.no_type5OpCnt '!=' content.no_type5Cnt}} <span class="font-bold" style="color: red;">{{content.no_type5OpCnt}}</span>{{else}} {{content.no_type5OpCnt}} {{/dalbit_if}}건
            </td>
            <td>
                {{#equal length '0'}}0{{/equal}}{{#dalbit_if content.type6OpCnt '!=' content.type6Cnt}} <span class="font-bold" style="color: red;">{{content.type6OpCnt}}</span>{{else}} {{content.type6OpCnt}} {{/dalbit_if}} /
                {{#equal length '0'}}0{{/equal}}{{#dalbit_if content.no_type6OpCnt '!=' content.no_type6Cnt}} <span class="font-bold" style="color: red;">{{content.no_type6OpCnt}}</span>{{else}} {{content.no_type6OpCnt}} {{/dalbit_if}}건
            </td>
            <td>
                {{#equal length '0'}}0{{/equal}}{{#dalbit_if content.type7OpCnt '!=' content.type7Cnt}} <span class="font-bold" style="color: red;">{{content.type7OpCnt}}</span>{{else}} {{content.type7OpCnt}} {{/dalbit_if}} /
                {{#equal length '0'}}0{{/equal}}{{#dalbit_if content.no_type7OpCnt '!=' content.no_type7Cnt}} <span class="font-bold" style="color: red;">{{content.no_type7OpCnt}}</span>{{else}} {{content.no_type7OpCnt}} {{/dalbit_if}}건
            </td>
            <td>
                {{#equal length '0'}}0{{/equal}}{{#dalbit_if content.type99OpCnt '!=' content.type99Cnt}} <span class="font-bold" style="color: red;">{{content.type99OpCnt}}</span>{{else}} {{content.type99OpCnt}} {{/dalbit_if}} /
                {{#equal length '0'}}0{{/equal}}{{#dalbit_if content.no_type99OpCnt '!=' content.no_type99Cnt}} <span class="font-bold" style="color: red;">{{content.no_type99OpCnt}}</span>{{else}} {{content.no_type99OpCnt}} {{/dalbit_if}}건
            </td>
            <td class="_bgColor font-bold" data-bgcolor="#f2f2f2">
                {{#equal length '0'}}0{{/equal}}{{#equal length '0'}}0{{/equal}}{{#dalbit_if content.totalOpQna '!=' content.totalQna}} <span class="font-bold" style="color: red;">{{content.totalOpQna}}</span>{{else}} {{content.totalOpQna}} {{/dalbit_if}} /
                {{#equal length '0'}}0{{/equal}}{{#equal length '0'}}0{{/equal}}{{#dalbit_if content.no_totalOpQna '!=' content.no_totalQna}} <span class="font-bold" style="color: red;">{{content.no_totalOpQna}}</span>{{else}} {{content.no_totalOpQna}} {{/dalbit_if}}건
            </td>
        </tr>
    </table>
</script>

<script id="question_tableSummary" type="text/x-handlebars-template">
    <table class="table table-bordered table-summary pull-right no-margin" style="width: 820px;">
        <colgroup>
            <col width="10%"/><col width="10%"/><col width="10%"/><col width="10%"/><col width="8%"/>
            <col width="10%"/><col width="10%"/><col width="12%"/><col width="10%"/><col width="10%"/>
        </colgroup>
        <tr>
            <th class="_bgColor" data-bgcolor="#d9d9d9"></th>
            <th class="_bgColor" data-bgcolor="#b4c7e7">회원정보</th>
            <th class="_bgColor" data-bgcolor="#b4c7e7">방송정보</th>
            <th class="_bgColor" data-bgcolor="#b4c7e7">청취하기</th>
            <th class="_bgColor" data-bgcolor="#b4c7e7">결제</th>
            <th class="_bgColor" data-bgcolor="#b4c7e7">건의하기</th>
            <th class="_bgColor" data-bgcolor="#b4c7e7">장애/버그</th>
            <th class="_bgColor" data-bgcolor="#b4c7e7">선물/아이템</th>
            <th class="_bgColor" data-bgcolor="#b4c7e7">기타</th>
            <th class="_bgColor" data-bgcolor="#d9d9d9">총합</th>
        </tr>
        <tr>
            <td class="_bgColor font-bold" data-bgcolor="#dae3f3">회원</td>
            <td>{{#equal length '0'}}0{{/equal}}{{#dalbit_if content.type1Cnt '!=' content.type1OpCnt}} <span class="font-bold" style="color: red;">{{content.type1Cnt}}건</span>{{else}} {{content.type1Cnt}}건 {{/dalbit_if}}</td>
            <td>{{#equal length '0'}}0{{/equal}}{{#dalbit_if content.type2Cnt '!=' content.type2OpCnt}} <span class="font-bold" style="color: red;">{{content.type2Cnt}}건</span>{{else}} {{content.type2Cnt}}건 {{/dalbit_if}}</td>
            <td>{{#equal length '0'}}0{{/equal}}{{#dalbit_if content.type3Cnt '!=' content.type3OpCnt}} <span class="font-bold" style="color: red;">{{content.type3Cnt}}건</span>{{else}} {{content.type3Cnt}}건 {{/dalbit_if}}</td>
            <td>{{#equal length '0'}}0{{/equal}}{{#dalbit_if content.type4Cnt '!=' content.type4OpCnt}} <span class="font-bold" style="color: red;">{{content.type4Cnt}}건</span>{{else}} {{content.type4Cnt}}건 {{/dalbit_if}}</td>
            <td>{{#equal length '0'}}0{{/equal}}{{#dalbit_if content.type5Cnt '!=' content.type5OpCnt}} <span class="font-bold" style="color: red;">{{content.type5Cnt}}건</span>{{else}} {{content.type5Cnt}}건 {{/dalbit_if}}</td>
            <td>{{#equal length '0'}}0{{/equal}}{{#dalbit_if content.type6Cnt '!=' content.type6OpCnt}} <span class="font-bold" style="color: red;">{{content.type6Cnt}}건</span>{{else}} {{content.type6Cnt}}건 {{/dalbit_if}}</td>
            <td>{{#equal length '0'}}0{{/equal}}{{#dalbit_if content.type7Cnt '!=' content.type7OpCnt}} <span class="font-bold" style="color: red;">{{content.type7Cnt}}건</span>{{else}} {{content.type7Cnt}}건 {{/dalbit_if}}</td>
            <td>{{#equal length '0'}}0{{/equal}}{{#dalbit_if content.type99Cnt '!=' content.type99OpCnt}} <span class="font-bold" style="color: red;">{{content.type99Cnt}}건</span>{{else}} {{content.type99Cnt}}건 {{/dalbit_if}}</td>
            <td class="_bgColor font-bold" data-bgcolor="#f2f2f2">{{#equal length '0'}}0{{/equal}}{{#equal length '0'}}0{{/equal}}{{#dalbit_if content.totalQna '!=' content.totalOpQna}} <span class="font-bold" style="color: red;">{{content.totalQna}}건</span>{{else}} {{content.totalQna}}건 {{/dalbit_if}}</td>
        </tr>
        <tr>
            <td class="_bgColor font-bold" data-bgcolor="#dae3f3">운영자 처리</td>
            <td>{{#equal length '0'}}0{{/equal}}{{#dalbit_if content.type1OpCnt '!=' content.type1Cnt}} <span class="font-bold" style="color: red;">{{content.type1OpCnt}}건</span>{{else}} {{content.type1OpCnt}}건 {{/dalbit_if}}</td>
            <td>{{#equal length '0'}}0{{/equal}}{{#dalbit_if content.type2OpCnt '!=' content.type2Cnt}} <span class="font-bold" style="color: red;">{{content.type2OpCnt}}건</span>{{else}} {{content.type2OpCnt}}건 {{/dalbit_if}}</td>
            <td>{{#equal length '0'}}0{{/equal}}{{#dalbit_if content.type3OpCnt '!=' content.type3Cnt}} <span class="font-bold" style="color: red;">{{content.type3OpCnt}}건</span>{{else}} {{content.type3OpCnt}}건 {{/dalbit_if}}</td>
            <td>{{#equal length '0'}}0{{/equal}}{{#dalbit_if content.type4OpCnt '!=' content.type4Cnt}} <span class="font-bold" style="color: red;">{{content.type4OpCnt}}건</span>{{else}} {{content.type4OpCnt}}건 {{/dalbit_if}}</td>
            <td>{{#equal length '0'}}0{{/equal}}{{#dalbit_if content.type5OpCnt '!=' content.type5Cnt}} <span class="font-bold" style="color: red;">{{content.type5OpCnt}}건</span>{{else}} {{content.type5OpCnt}}건 {{/dalbit_if}}</td>
            <td>{{#equal length '0'}}0{{/equal}}{{#dalbit_if content.type6OpCnt '!=' content.type6Cnt}} <span class="font-bold" style="color: red;">{{content.type6OpCnt}}건</span>{{else}} {{content.type6OpCnt}}건 {{/dalbit_if}}</td>
            <td>{{#equal length '0'}}0{{/equal}}{{#dalbit_if content.type7OpCnt '!=' content.type7Cnt}} <span class="font-bold" style="color: red;">{{content.type7OpCnt}}건</span>{{else}} {{content.type7OpCnt}}건 {{/dalbit_if}}</td>
            <td>{{#equal length '0'}}0{{/equal}}{{#dalbit_if content.type99OpCnt '!=' content.type99Cnt}} <span class="font-bold" style="color: red;">{{content.type99OpCnt}}건</span>{{else}} {{content.type99OpCnt}}건 {{/dalbit_if}}</td>
            <td class="_bgColor font-bold" data-bgcolor="#f2f2f2">{{#equal length '0'}}0{{/equal}}{{#equal length '0'}}0{{/equal}}{{#dalbit_if content.totalOpQna '!=' content.totalQna}} <span class="font-bold" style="color: red;">{{content.totalOpQna}}건</span>{{else}} {{content.totalOpQna}}건 {{/dalbit_if}}</td>
        </tr>
    </table>
</script>

<script id="question_tableSummary2" type="text/x-handlebars-template">
    <table class="table table-bordered table-summary pull-right no-margin" style="width: 820px;">
        <colgroup>
            <col width="10%"/><col width="10%"/><col width="10%"/><col width="10%"/><col width="8%"/>
            <col width="10%"/><col width="10%"/><col width="12%"/><col width="10%"/><col width="10%"/>
        </colgroup>
        <tr>
            <th class="_bgColor" data-bgcolor="#d9d9d9"></th>
            <th class="_bgColor" data-bgcolor="#b4c7e7">회원정보</th>
            <th class="_bgColor" data-bgcolor="#b4c7e7">방송정보</th>
            <th class="_bgColor" data-bgcolor="#b4c7e7">청취하기</th>
            <th class="_bgColor" data-bgcolor="#b4c7e7">결제</th>
            <th class="_bgColor" data-bgcolor="#b4c7e7">건의하기</th>
            <th class="_bgColor" data-bgcolor="#b4c7e7">장애/버그</th>
            <th class="_bgColor" data-bgcolor="#b4c7e7">선물/아이템</th>
            <th class="_bgColor" data-bgcolor="#b4c7e7">기타</th>
            <th class="_bgColor" data-bgcolor="#d9d9d9">총합</th>
        </tr>

        <tr>
            <td class="_bgColor font-bold" data-bgcolor="#dae3f3">비회원</td>
            <td>{{#equal length '0'}}0{{/equal}}{{#dalbit_if content.no_type1Cnt '!=' content.no_type1OpCnt}} <span class="font-bold" style="color: red;">{{content.no_type1Cnt}}건</span>{{else}} {{content.no_type1Cnt}}건 {{/dalbit_if}}</td>
            <td>{{#equal length '0'}}0{{/equal}}{{#dalbit_if content.no_type2Cnt '!=' content.no_type2OpCnt}} <span class="font-bold" style="color: red;">{{content.no_type2Cnt}}건</span>{{else}} {{content.no_type2Cnt}}건 {{/dalbit_if}}</td>
            <td>{{#equal length '0'}}0{{/equal}}{{#dalbit_if content.no_type3Cnt '!=' content.no_type3OpCnt}} <span class="font-bold" style="color: red;">{{content.no_type3Cnt}}건</span>{{else}} {{content.no_type3Cnt}}건 {{/dalbit_if}}</td>
            <td>{{#equal length '0'}}0{{/equal}}{{#dalbit_if content.no_type4Cnt '!=' content.no_type4OpCnt}} <span class="font-bold" style="color: red;">{{content.no_type4Cnt}}건</span>{{else}} {{content.no_type4Cnt}}건 {{/dalbit_if}}</td>
            <td>{{#equal length '0'}}0{{/equal}}{{#dalbit_if content.no_type5Cnt '!=' content.no_type5OpCnt}} <span class="font-bold" style="color: red;">{{content.no_type5Cnt}}건</span>{{else}} {{content.no_type5Cnt}}건 {{/dalbit_if}}</td>
            <td>{{#equal length '0'}}0{{/equal}}{{#dalbit_if content.no_type6Cnt '!=' content.no_type6OpCnt}} <span class="font-bold" style="color: red;">{{content.no_type6Cnt}}건</span>{{else}} {{content.no_type6Cnt}}건 {{/dalbit_if}}</td>
            <td>{{#equal length '0'}}0{{/equal}}{{#dalbit_if content.no_type7Cnt '!=' content.no_type7OpCnt}} <span class="font-bold" style="color: red;">{{content.no_type7Cnt}}건</span>{{else}} {{content.no_type7Cnt}}건 {{/dalbit_if}}</td>
            <td>{{#equal length '0'}}0{{/equal}}{{#dalbit_if content.no_type99Cnt '!=' content.no_type99OpCnt}} <span class="font-bold" style="color: red;">{{content.no_type99Cnt}}건</span>{{else}} {{content.no_type99Cnt}}건 {{/dalbit_if}}</td>
            <td class="_bgColor font-bold" data-bgcolor="#f2f2f2">{{#equal length '0'}}0{{/equal}}{{#equal length '0'}}0{{/equal}}{{#dalbit_if content.no_totalQna '!=' content.no_totalOpQna}} <span class="font-bold" style="color: red;">{{content.no_totalQna}}건</span>{{else}} {{content.no_totalQna}}건 {{/dalbit_if}}</td>
        </tr>
        <tr>
            <td class="_bgColor font-bold" data-bgcolor="#dae3f3">운영자 처리</td>
            <td>{{#equal length '0'}}0{{/equal}}{{#dalbit_if content.no_type1OpCnt '!=' content.no_type1Cnt}} <span class="font-bold" style="color: red;">{{content.no_type1OpCnt}}건</span>{{else}} {{content.no_type1OpCnt}}건 {{/dalbit_if}}</td>
            <td>{{#equal length '0'}}0{{/equal}}{{#dalbit_if content.no_type2OpCnt '!=' content.no_type2Cnt}} <span class="font-bold" style="color: red;">{{content.no_type2OpCnt}}건</span>{{else}} {{content.no_type2OpCnt}}건 {{/dalbit_if}}</td>
            <td>{{#equal length '0'}}0{{/equal}}{{#dalbit_if content.no_type3OpCnt '!=' content.no_type3Cnt}} <span class="font-bold" style="color: red;">{{content.no_type3OpCnt}}건</span>{{else}} {{content.no_type3OpCnt}}건 {{/dalbit_if}}</td>
            <td>{{#equal length '0'}}0{{/equal}}{{#dalbit_if content.no_type4OpCnt '!=' content.no_type4Cnt}} <span class="font-bold" style="color: red;">{{content.no_type4OpCnt}}건</span>{{else}} {{content.no_type4OpCnt}}건 {{/dalbit_if}}</td>
            <td>{{#equal length '0'}}0{{/equal}}{{#dalbit_if content.no_type5OpCnt '!=' content.no_type5Cnt}} <span class="font-bold" style="color: red;">{{content.no_type5OpCnt}}건</span>{{else}} {{content.no_type5OpCnt}}건 {{/dalbit_if}}</td>
            <td>{{#equal length '0'}}0{{/equal}}{{#dalbit_if content.no_type6OpCnt '!=' content.no_type6Cnt}} <span class="font-bold" style="color: red;">{{content.no_type6OpCnt}}건</span>{{else}} {{content.no_type6OpCnt}}건 {{/dalbit_if}}</td>
            <td>{{#equal length '0'}}0{{/equal}}{{#dalbit_if content.no_type7OpCnt '!=' content.no_type7Cnt}} <span class="font-bold" style="color: red;">{{content.no_type7OpCnt}}건</span>{{else}} {{content.no_type7OpCnt}}건 {{/dalbit_if}}</td>
            <td>{{#equal length '0'}}0{{/equal}}{{#dalbit_if content.no_type99OpCnt '!=' content.no_type99Cnt}} <span class="font-bold" style="color: red;">{{content.no_type99OpCnt}}건</span>{{else}} {{content.no_type99OpCnt}}건 {{/dalbit_if}}</td>
            <td class="_bgColor font-bold" data-bgcolor="#f2f2f2">{{#equal length '0'}}0{{/equal}}{{#equal length '0'}}0{{/equal}}{{#dalbit_if content.no_totalOpQna '!=' content.no_totalQna}} <span class="font-bold" style="color: red;">{{content.no_totalOpQna}}건</span>{{else}} {{content.no_totalOpQna}}건 {{/dalbit_if}}</td>
        </tr>

    </table>
</script>