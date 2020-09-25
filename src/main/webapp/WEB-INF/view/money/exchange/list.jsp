<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="cfn" uri="/WEB-INF/tld/comFunction.tld" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<sec:authentication var="principal" property="principal" />
<c:set var="dummyData"><%= java.lang.Math.round(java.lang.Math.random() * 1000000) %></c:set>
<%
    String in_tabType = request.getParameter("tabType");
%>
<div id="wrapper">
    <div id="page-wrapper">
        <div class="container-fluid">
            <!-- serachBox -->
            <form id="searchForm">
                <div class="row col-lg-12 form-inline no-padding">
                    <%--<input type="hidden" name="pageStart" id="pageStart">
                    <input type="hidden" name="pageCnt" id="pageCnt">--%>
                    <div class="widget widget-table searchBoxArea">
                        <div class="widget-header searchBoxRow">
                            <h3 class="title"><i class="fa fa-search"></i> 환전 검색</h3>
                            <div>
                                <span id="searchYearArea"></span>
                                <span id="searchMonthArea"></span>

                                <span id="searchTypeArea" class="ml10"></span>
                                <label><input type="text" class="form-control" id="search_value" name="search_value"></label>
                                <button type="button" class="btn btn-success" id="bt_search">검색</button>

                                <%--<button type="button" class="btn btn-primary" id="bt_search_special">600달 이상 보유 회원</button>--%>
                                <label class="control-inline fancy-checkbox custom-color-green">
                                    <input type="checkbox" name="search_testId" id="search_testId" value="1" checked="true">
                                    <span>테스트 아이디 제외</span>
                                </label>

                                <label class="control-inline fancy-checkbox custom-color-green" id="exchangeCheckArea">
                                    <input type="checkbox" name="search_exchangeYn" id="search_exchangeYn" value="1">
                                    <span>1회 이상 환전 회원</span>
                                </label>
                            </div>
                        </div>
                    </div>
                </div>
            </form>
            <!-- //serachBox -->

            <div class="row widget-content">
                <ul class="nav nav-tabs nav-tabs-custom-colored" role="tablist">
                    <li><a href="/money/resource/info?tabType=0">시간대별</a></li>
                    <li><a href="/money/resource/info?tabType=1">월간별</a></li>
                    <li><a href="/money/resource/info?tabType=2">연간별</a></li>
                    <li><a href="/money/resource/info?tabType=3">회원Data</a></li>
                    <li><a href="/money/resource/info?tabType=4">달 구매내역</a></li>
                    <li><a href="/money/resource/info?tabType=5">달 사용내역</a></li>
                    <li><a href="/money/item/list" id="tab_changeList">교환내역</a></li>
                    <li class="active"><a href="#exchange" id="tab_exchangeList" title="환전내역으로 이동합니다.">환전내역</a></li>
                </ul>
            </div>
            <div class="tab-content">
                <div class="tab-pane fade in active" id="exchange" >
                    <!-- DATA TABLE -->
                    <div class="row col-lg-12 form-inline block no-padding" id="topBotton">
                        <ul class="nav nav-tabs nav-tabs-custom-colored" role="tablist">
                            <li class="_tab">
                                <a href="/status/exchange/info">총계</a>
                            </li>
                            <li class="_tab active">
                                <a href="#recommend" id="tab_specialDj" name="tab_specialDj" role="tab" data-toggle="tab" data-specialDj="1">스페셜DJ</a>
                            </li>
                            <li class="_tab">
                                <a href="#recommend" id="tab_user" name="tab_user" role="tab" data-toggle="tab" data-specialDj="0">일반회원</a>
                            </li>

                            <c:if test="${fn:contains('|이재은|이형원|전유신|강다인|고병권|이재호|양효진|최계석|손우걸|', principal.getUserInfo().getName())}">
                                <li class="_tab ml15">
                                    <a href="javascript://" id="rejectList" name="rejectList" role="tab" data-toggle="tab">불가내역</a>
                                </li>
                            </c:if>

                            <li class="_tab">
                                <a href="javascript://" id="enableList" name="enableList" role="tab" data-toggle="tab">환전신청 가능회원</a>
                            </li>
                        </ul>

                        <div>
                            <div class="row col-lg-12 no-padding" style="margin-left: 0px">
                                <div id="summaryTable"></div>
                                <div class="col-md-2 no-padding pull-right">
                                    <table class="table table-sorting table-hover table-bordered mt5" style="margin-bottom: 0px">
                                        <colgroup>
                                            <col width="15%"/><col width="65%"/>
                                        </colgroup>
                                        <tr>
                                            <td style="background-color: #dae3f3"></td><td>테스트 아이디</td>
                                        </tr>
                                    </table>
                                </div>

                                <div class="col-md-12 no-padding">
                                    <div class="dataTables_paginate paging_full_numbers mt15" id="list_info_paginate_top"></div>
                                    <div class="col-lg-12 no-padding" id="listTable"></div>
                                    <div class="dataTables_paginate paging_full_numbers" id="list_info_paginate"></div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!-- DATA TABLE END -->
                </div>
            </div>
        </div>
    </div>
</div>

<button class="btn btn-primary btn-lg" data-toggle="modal" data-target="#detailView" id="showModal" style="display:none;">레이어팝업오픈버튼</button>

<div class="modal fade" id="detailView" tabindex="-1" role="dialog" aria-labelledby="detailViewLabel" aria-hidden="true"></div>

<form name="excelForm" id="excelForm"></form>

<script type="text/javascript" src="/js/lib/jquery.table2excel.js"></script>
<script type="text/javascript" src="/js/code/money/exchangeCodeList.js?${dummyData}"></script>
<script type="text/javascript" src="/js/code/member/memberCodeList.js?${dummyData}"></script>
<script type="text/javascript" src="/js/handlebars/moneyHelper.js?${dummyData}"></script>
<script type="text/javascript">
    var exchangePagingInfo = new PAGING_INFO(0,1,50);
    var limitDay = moment(new Date()).format('YYYYMMDD');

    var tabType = <%=in_tabType%>;

    $(function(){

        $("#searchYearArea").html(util.getCommonCodeSelect(moment(new Date()).format('YYYY'), search_exchange_years));
        $("#searchMonthArea").html(util.getCommonCodeSelect(moment(new Date()).format('MM'), search_exchange_months));
        $("#searchTypeArea").html(util.getCommonCodeSelect('', search_exchange_type));

        $('#searchTestIdArea').html(util.getCommonCodeRadio(-1, testId));

        if(!common.isEmpty(tabType)){
            $('#topBotton li:eq(' + tabType + ') a').tab('show');
        }
        getList();
    });

    function getParameter(viewName){
        return data = {
            isSpecial : $('._tab.active a').data('specialdj')
            , search_year : $("#search_year").val()
            , search_month : $("#search_month").val()
            , search_state : $("#search_state").val()
            , exchange_sort : $("#exchange_sort").val()
            , gender : $("#gender").val()
            , search_type : $("#search_type").val()
            , search_value : $("#search_value").val()
            , search_testId : $('input[name="search_testId"]').prop('checked') ? 1 : 0
            , search_exchangeYn : $('input[name="search_exchangeYn"]').prop('checked') ? 'Y' : 'N'
            , pageStart : exchangePagingInfo.pageNo
            , pageCnt : exchangePagingInfo.pageCnt
            , limitDay : limitDay
            , slctType : 1
            , viewName : viewName
        };
    }

    function getSummary(){
        util.getAjaxData("select", "/rest/money/exchange/summary", getParameter(), fn_succ_summary);
    }

    function fn_succ_summary(dst_id, response){

        var special_total_cnt = 0;
        var special_total_amount = 0;
        var special_total_star = 0;

        response.data.specialSummaryList.forEach(function(data, i){
            $('._summary_special_'+i).html(common.addComma(data));
            if(i == 0 || i == 3 ){
                special_total_cnt += data;
            }
            if(i == 1 || i == 4){
                special_total_amount += data;
            }
            if(i == 2 || i == 5){
                special_total_star += data;
            }
        });

        $('._summary_total_special_cnt').html(common.addComma(special_total_cnt));
        $('._summary_total_special_amount').html(common.addComma(special_total_amount));
        $('._summary_total_special_star').html(common.addComma(special_total_star));


        var general_total_cnt = 0;
        var general_total_amount = 0;
        var general_total_star = 0;

        response.data.generalSummaryList.forEach(function(data, i){
            $('._summary_user_'+i).html(common.addComma(data));

            if(i == 0 || i == 3){
                general_total_cnt += data;
            }
            if(i == 1 || i == 4){
                general_total_amount += data;
            }
            if(i == 2 || i == 5){
                general_total_star += data;
            }
        });

        $('._summary_total_user_cnt').html(common.addComma(general_total_cnt));
        $('._summary_total_user_amount').html(common.addComma(general_total_amount));
        $('._summary_total_user_star').html(common.addComma(general_total_star));

    }

    function getList(tmp){

        var targetAnchor = $('._tab.active').find('a');

        if(targetAnchor.data('specialdj') != null){

            $("#exchangeCheckArea").attr('style', 'display:none !important;');
            $("#searchYearArea").show();
            $("#searchMonthArea").show();
            $("#searchStateArea").show();

            exchangeList(tmp);
        }else if(targetAnchor.prop('id') == 'rejectList'){

            $("#exchangeCheckArea").attr('style', 'display:none !important;');
            $("#searchYearArea").show();
            $("#searchMonthArea").show();
            $("#searchStateArea").show();

            rejectList();

        }else if(targetAnchor.prop('id') == 'enableList') {

            $("#exchangeCheckArea").show();
            $("#searchYearArea").hide();
            $("#searchMonthArea").hide();
            $("#searchStateArea").hide();

            enableList();
        }
    }

    function exchangeList(tmp){
        if(common.isEmpty(tmp) || tmp != "button"){
            var template = $('#tmp_exchangeSummary').html();
            var templateScript = Handlebars.compile(template);
            var html = templateScript();
            $("#summaryTable").html(html);

            $("#searchStateArea").html(util.getCommonCodeSelect('', search_exchange_state));
            $("#exchangeSort").html(util.getCommonCodeSelect('', exchange_sort));
            $("#selGender").html(util.getCommonCodeSelect('', gender));
        }

        var template = $('#tmp_exchangeTable').html();
        var templateScript = Handlebars.compile(template);
        var html = templateScript();
        $("#listTable").html(html);

        ui.paintColor();

        $("#allChk").removeAttr('checked');
        getSummary();
        util.getAjaxData("select", "/rest/money/exchange/list", getParameter(), fn_succ_list);
    }

    function enableList(){
        var template = $('#tmp_enableSummary').html();
        var templateScript = Handlebars.compile(template);
        var html = templateScript();
        $("#summaryTable").html(html);

        var template = $('#tmp_enableTable').html();
        var templateScript = Handlebars.compile(template);
        var html = templateScript();
        $("#listTable").html(html);

        util.getAjaxData("select", "/rest/money/exchange/list", getParameter('enableList'), fn_succ_enable_list);

    }

    function rejectList(){

        $('#summaryTable').empty();

        var template = $('#tmp_rejectTable').html();
        var templateScript = Handlebars.compile(template);
        var html = templateScript();
        $("#listTable").html(html);

        util.getAjaxData("select", "/rest/money/exchange/list", getParameter('rejectList'), fn_succ_reject_list);
    }

    $('#bt_search').on('click', function(){
        exchangePagingInfo.pageNo = 1;
        getList("button");
    });

    $('input[id="search_value"]').on('keydown', function(e) {    // textBox 처리
        if(e.keyCode == 13) {
            exchangePagingInfo.pageNo = 1;
            getList();
        };
    });

    $('._tab').on('click', function(){
        $('._tab').removeClass('active');
        $(this).addClass('active');

        exchangePagingInfo.pageNo = 1;
        getList();

    });

    $('input[name="search_testId"], input[name="search_exchangeYn"]').on('change', function(){
        exchangePagingInfo.pageNo = 1;
        getList();
    });

    function fn_succ_list(dst_id, response) {
        /*
            2020.09.21 양효진과장 요청
            환전 정책 변경으로 일반도 스페셜DJ와 같이 다음날부터 환전가능
        */
        /*if(getParameter().isSpecial == 0){
            var curDay = moment().day();
            var prevDay = 0;
            if(curDay == 0){
                prevDay = -3
            }else if(curDay == 3 || curDay == 6){
                prevDay = -2
            }else if(curDay == 2 || curDay ==5){
                prevDay = -1
            }
            limitDay = moment(new Date()).add('days', prevDay).format('YYYYMMDD');
        }else{*/
            limitDay = moment(new Date()).format('YYYYMMDD');
        /*}*/

        response.data.limitDay = limitDay;

        var template = $('#tmp_exchangeList').html();
        var templateScript = Handlebars.compile(template);
        var context = response.data;
        var html = templateScript(context);
        $("#tableBody").html(html);

        exchangePagingInfo.totalCnt = response.data.exchangeCnt;
        util.renderPagingNavigation("list_info_paginate_top", exchangePagingInfo);
        util.renderPagingNavigation("list_info_paginate", exchangePagingInfo);


    }

    function handlebarsPaging(targetId, pagingInfo){
        exchangePagingInfo = pagingInfo;
        getList();
    }

    function fn_succ_enable_list(dst_id, response) {
        var template = $('#tmp_enableList').html();
        var templateScript = Handlebars.compile(template);
        var context = response.data;
        var html = templateScript(context);
        $("#tableBody").html(html);

        exchangePagingInfo.totalCnt = response.data.enableCnt;
        util.renderPagingNavigation("list_info_paginate_top", exchangePagingInfo);
        util.renderPagingNavigation("list_info_paginate", exchangePagingInfo);

        var exchangeAmt = common.exchangeAmt(response.data.totalGold,response.data.specialCnt).replace(/,/gi,"");
        var totalSuccAmt = common.vatMinus(response.data.totalSuccAmt).replace(/,/gi,"");
        response.data.netProfit = Number(totalSuccAmt)-(Number(exchangeAmt) + Number(response.data.totalExchangeAmt));

        var template = $("#tmp_enableSummary").html();
        var templateScript = Handlebars.compile(template);
        var data = {
            content : response.data
        };
        var html = templateScript(data);
        $("#summaryTable").html(html);

    }

    function fn_succ_reject_list(dst_id, response){
        var template = $('#tmp_rejectList').html();
        var templateScript = Handlebars.compile(template);
        var context = response.data;
        var html = templateScript(context);
        $("#tableBody").html(html);

        exchangePagingInfo.totalCnt = response.data.rejectCnt;
        util.renderPagingNavigation("list_info_paginate_top", exchangePagingInfo);
        util.renderPagingNavigation("list_info_paginate", exchangePagingInfo);
    }

    $(document).on('click', '#excelDownBtn', function(){
        var hidden = '<input type="hidden" name="{name}" value="{value}">';

        var hiddenData = '';
        hiddenData += hidden.replace('{name}', 'isSpecial').replace('{value}', getParameter().isSpecial);
        hiddenData += hidden.replace('{name}', 'search_year').replace('{value}', getParameter().search_year);
        hiddenData += hidden.replace('{name}', 'search_month').replace('{value}', getParameter().search_month);
        hiddenData += hidden.replace('{name}', 'search_state').replace('{value}', 0);
        hiddenData += hidden.replace('{name}', 'exchange_sort').replace('{value}', 0);
        hiddenData += hidden.replace('{name}', 'search_testId').replace('{value}', getParameter().search_testId);
        hiddenData += hidden.replace('{name}', 'search_type').replace('{value}', getParameter().search_type);
        hiddenData += hidden.replace('{name}', 'search_value').replace('{value}', getParameter().search_value);
        hiddenData += hidden.replace('{name}', 'limitDay').replace('{value}', getParameter().limitDay);

        $("#excelForm").html(hiddenData).attr({
            method : 'post'
            , action : '/money/exchange/listExcel'
            , target : 'iframe_excel_download'
        }).submit();
    });

    $(document).on('click', '#completeListBtn', function(){
        $("#rangeDatepicker, #completeExcelDownBtn").show();
        setRangeDatepicker();
    });

    $(document).on('click', '#completeExcelDownBtn', function(){
        if($("#startDate").val() == '' || $("#endDate").val() == ''){
            alert('날짜를 선택해주세요.');
            return false;
        }

        var hidden = '<input type="hidden" name="{name}" value="{value}">';

        var hiddenData = '';
        hiddenData += hidden.replace('{name}', 'startDate').replace('{value}', $("#startDate").val());
        hiddenData += hidden.replace('{name}', 'endDate').replace('{value}', $("#endDate").val());

        $("#excelForm").html(hiddenData).attr({
            method : 'post'
            , action : '/money/exchange/completeListExcel'
            , target : 'iframe_excel_download'
        }).submit();


    });




    function fn_success_excel(response) {
        console.log(response);
    }

    function fn_fail_excel(response){
        alert('현재 환전 처리일이 아니거나, 처리되지 않은 신청 건이 없습니다.');
    }

    $(document).on('click', '._layerOpen', function(title, content){

        var detailData = getParameter();
        detailData.idx = $(this).data('exchangeidx');

        util.getAjaxData("select", "/rest/money/exchange/detail", detailData, fn_succ_detail);
    });

    function fn_succ_detail(dist_id, response){
        var template = $('#tmp_layer_detail').html();
        var templateScript = Handlebars.compile(template);
        var context = response.data;
        var html = templateScript(context);
        $("#detailView").html(html);

        showModal();

    }

    function showModal(){
        $("#showModal").click();
    }

    function closeModal(){
        $("#layerCloseBtn").click();
    }

    $(document).on('click', '._updateBtn', function(){

        if(confirm('수정하시겠습니까?')){

            var account_name = $("#account_name");
            if(common.isEmpty(account_name)){
                alert('예금주명을 입력해주세요.');
                account_name.focus();
                return
            }
            var data = $("#exchangeForm").serialize();
            util.getAjaxData("update", "/rest/money/exchange/update", $("#exchangeForm").serialize(), fn_succ_update);
        }
    });

    function fn_succ_update(dist_id, response){
        alert(response.message);
        closeModal();
        getList();
    }

    $(document).on('click', '._completeBtn', function(){
        if(confirm('완료처리하시겠습니까?')){
            var data = $("#exchangeForm").serialize();
            data += '&state=1';
            util.getAjaxData("complete", "/rest/money/exchange/complete", data, fn_succ_complete);
        }
    });

    $(document).on('click', '._rejectBtn', function(){
        if(confirm('불가처리 하시겠습니까?\n불가처리 시 환전 신청한 별 수가 반환됩니다.')){
            var data = $("#exchangeForm").serialize();
            data += '&state=2';
            util.getAjaxData("reject", "/rest/money/exchange/complete", data, fn_succ_complete);
        }
    });

    function fn_succ_complete(dist_id, response){
        if(dist_id == 'complete'){
            alert('완료처리 되었습니다.');
        }else if(dist_id == 'reject'){
            alert(response.message);
        }
        closeModal();
        getList();
    }

    $(document).on('click', '#allChk', function(){

        if(0 == $('._chk:enabled').length){
            alert('선택할 회원이 없습니다.');
            return false;
        }

        if($(this).prop('checked')){
            $('._chk:enabled').prop('checked', 'checked');
        }else{
            $('._chk').removeAttr('checked');
        }

    });

    $(document).on('click', '#completeBtn', function(){
        var checks = $('._chk:checked');
        if(0 == checks.length){
            alert('선택된 회원이 없습니다.');
            return false;
        }

        if(confirm(checks.length + '건을 완료처리 하시겠습니까?')){
            var idxs = '';
            $('._chk:checked').each(function(){
                idxs += $(this).data('exchangeidx')+ '@';
            });

            var data = {
                idxs : idxs
            }
            util.getAjaxData("complete", "/rest/money/exchange/multiComplete", data, fn_succ_complete);
        }
    });

    // 미처리 사유 change 이벤트
    $(document).on('change', '#send_type', function(){
        var type = $(this).val();

        if(type == 1){
            $("#tr_send_cont").show();

            var title = "(증빙서류 화질문제)환전신청이 승인되지 않았습니다.";
            $("#send_title").val(title);
            $("#label_send_title").text(title);

            var text = "환전신청 시 첨부하여주신 파일이 명확하게 확인되지 않아 승인이 거부되었습니다.\n" +
                        "회원님의 정보 또는 통장사본의 정보가 정확하게 확인될 수 있도록 다시(캡쳐 또는 사진을 찍어) 첨부한 후 신청해주시기 바랍니다.";
            $("#send_cont").val(text);
            util.textareaResize(document.getElementById("send_cont"), 90)
        }
        else if(type == 2) {
            $("#tr_send_cont").show();

            var title = "(미비한 증빙서류)환전신청이 승인되지 않았습니다.";
            $("#send_title").val(title);
            $("#label_send_title").text(title);

            var text = "주민등록증, 주민등록등본 사본과 통장정보를 확인할 수 있는 명확한 파일을 다시 첨부하여 신청해주시기 바랍니다.";
            $("#send_cont").val(text);
            util.textareaResize(document.getElementById("send_cont"), 90)
        }
        else if(type == 3){
            $("#tr_send_cont").show();

            var title = "(입력정보 불일치)환전신청이 승인되지 않았습니다.";
            $("#send_title").val(title);
            $("#label_send_title").text(title);

            var text = "환전신청 시 입력하신 정보와 첨부파일 정보가 일치하지 않습니다.\n" +
                        "회원님의 정보 또는 통장사본의 정보가 정확하게 확인될 수 있도록 다시 캡쳐 또는 사진을 찍어 첨부하여 신청해주시기 바랍니다.";
            $("#send_cont").val(text);
            util.textareaResize(document.getElementById("send_cont"), 90)
        }
        else if(type == 4){
            $("#tr_send_cont").show();

            var title = "환전신청이 승인되지 않았습니다.";
            $("#send_title").val(title);
            $("#label_send_title").text(title);

            var text = "";
            $("#send_cont").val(text);
            util.textareaResize(document.getElementById("send_cont"), 90)
        }
        else{
            $("#tr_send_cont").hide();

            var title = "";
            $("#send_title").val(title);
            $("#label_send_title").text(title);

            var text = "";
            $("#send_cont").val(text);
            util.textareaResize(document.getElementById("send_cont"), 90)
        }
    });

    /* 파일 업로드 */
    function photoSubmit(me) {

        var formData = new FormData();
        formData.append('uploadType', 'exchange');

        var files = $('#'+ $(me).attr('id'))[0].files;
        for (var i = 0; i < files.length; ++i) {
            console.log(files[i]);
            formData.append('file', files[i]);
        }
        $.ajax({
            url: PHOTO_SERVER_URL + "/upload",
            method: 'POST',
            processData: false,
            contentType: false,
            data: formData,
            success: function (response) {
                console.log(response);
                console.log(JSON.parse(response));
                response = JSON.parse(response);
                alert(response.message);
                if (response.result == "success") {
                    me.parent().find('img.thumbnail').attr('src', response.data.url);
                    me.parent().find('input._hidden_filename').val(response.data.path);
                    pathChange();
                }
            },
            error: function (e) {
                console.log(e);
                alert("error : " + e);
            }
        });
    }

    /* 파일 경로를 바꿀 done */
    function pathChange() {
        // file1 upload -> done
        if($("#add_file1").val().indexOf('_1/') >= 0) {
            var data = {
                'tempFileURI': $("#add_file1").val()
            };
            util.getAjaxData("add_file1", PHOTO_SERVER_URL + "/done", data, fn_pathChange_success);
        }
        // file2 upload -> done
        if($("#add_file2").val().indexOf('_1/') >= 0) {
            var data = {
                'tempFileURI': $("#add_file2").val()
            };
            util.getAjaxData("add_file2", PHOTO_SERVER_URL + "/done", data, fn_pathChange_success);
        }
    }

    function fn_pathChange_success(dst_id, response) {
        console.log(response.data);
        $("#"+dst_id).val(response.data.path);
        $("#"+dst_id).parent().find('img.thumbnail').attr('src', response.data.url);
    }

    function searchStateArea_click(){
        exchangeList("button");
    }
    function exchangeSort_click(){
        exchangeList("button");
    }
    function gender_click(){
        exchangeList("button");
    }


    function setRangeDatepicker(startDate, endDate){

        startDate = common.isEmpty(startDate) ? moment(new Date()).format("YYYY.MM.01") : startDate;
        endDate = common.isEmpty(endDate) ? moment(new Date()).format("YYYY.MM.DD") : endDate;

        $("#startDate").val(startDate);
        $("#endDate").val(endDate);

        $('#rangeDate').daterangepicker({
            startDate: startDate,
            endDate: endDate
        }, function(startDate,endDate){
            $("#startDate").val(moment(startDate).format("YYYY.MM.DD"));
            $("#endDate").val(moment(endDate).format("YYYY.MM.DD"));
            $("#displayDate").val($("#startDate").val() + ' - ' + $("#endDate").val());
        });
    }

</script>


<script type="text/x-handlebars-template" id="tmp_exchangeSummary">
    <div class="col-md-12 no-padding">
        <div class="col-md-12 no-padding">
            <div class="col-lg-6 no-padding">
                <table class="table table-bordered table-summary pull-left">
                    <colgroup>
                        <col width="80px"/>
                        <col width="80px"/>
                        <col width="80px"/>
                        <col width="80px"/>
                    </colgroup>
                    <thead>
                    <tr>
                        <th colspan="4" class="_bgColor _fontColor" data-bgcolor="#ffa100" data-fontcolor="white">스페셜DJ</th>
                    </tr>
                    <tr>
                        <th>상태</th>
                        <th>건 수</th>
                        <th>금액</th>
                        <th>요청 별</th>
                    </tr>
                    </thead>
                    <tbody id="tb_special_summary">
                    <tr>
                        <th>미처리</th>
                        <td><span class="_summary_special_0">0</span>건</td>
                        <td><span class="_summary_special_1">0</span>원</td>
                        <td><span class="_summary_special_2">0</span>별</td>
                    </tr>
                    <tr>
                        <th>처리완료</th>
                        <td><span class="_summary_special_3">0</span>건</td>
                        <td><span class="_summary_special_4">0</span>원</td>
                        <td><span class="_summary_special_5">0</span>별</td>
                    </tr>
                    <tr class="_fontColor" data-fontcolor="#ff5600">
                        <th>총계</th>
                        <th><span class="_summary_total_special_cnt">0</span>건</th>
                        <th><span class="_summary_total_special_amount">0</span>원</th>
                        <th><span class="_summary_total_special_star">0</span>별</th>
                    </tr>
                    <tr style="border-left: hidden;border-right: hidden; height: 5px;">
                        <td colspan="4" style="height: 5px;"></td>
                    </tr>
                    <tr>
                        <th>처리불가</th>
                        <td><span class="_summary_special_6">0</span>건</td>
                        <!-- 양과장님 요청으로 수치 표현 안함 -->
                        <!--<td><span class="_summary_special_7">0</span>원</td>
                        <td><span class="_summary_special_8">0</span>별</td>-->
                        <td>-</td>
                        <td>-</td>
                    </tr>
                    </tbody>
                </table>
                <table class="table table-bordered table-summary pull-left" style="margin-right: 0px">
                    <colgroup>
                        <col width="80px"/>
                        <col width="80px"/>
                        <col width="80px"/>
                        <col width="80px"/>
                    </colgroup>
                    <thead>
                    <tr>
                        <th colspan="4" class="_bgColor _fontColor" data-bgcolor="#66a449" data-fontcolor="white">일반회원</th>
                    </tr>
                    <tr>
                        <th>상태</th>
                        <th>건 수</th>
                        <th>금액</th>
                        <th>요청 별</th>
                    </tr>
                    </thead>
                    <tbody id="tb_user_summary">
                    <tr>
                        <th>미처리</th>
                        <td><span class="_summary_user_0">0</span>건</td>
                        <td><span class="_summary_user_1">0</span>원</td>
                        <td><span class="_summary_user_2">0</span>별</td>
                    </tr>
                    <tr>
                        <th>처리완료</th>
                        <td><span class="_summary_user_3">0</span>건</td>
                        <td><span class="_summary_user_4">0</span>원</td>
                        <td><span class="_summary_user_5">0</span>별</td>
                    </tr>
                    <tr class="_fontColor" data-fontcolor="#ff5600">
                        <th>총계</th>
                        <th><span class="_summary_total_user_cnt">0</span>건</th>
                        <th><span class="_summary_total_user_amount">0</span>원</th>
                        <th><span class="_summary_total_user_star">0</span>별</th>
                    </tr>
                    <tr style="border-left: hidden;border-right: hidden; height: 5px;">
                        <td colspan="4" style="height: 5px;"></td>
                    </tr>
                    <tr>
                        <th>처리불가</th>
                        <td><span class="_summary_user_6">0</span>건</td>
                        <!-- 양과장님 요청으로 수치 표현 안함 -->
                        <!--<td><span class="_summary_special_7">0</span>원</td>
                        <td><span class="_summary_special_8">0</span>별</td>-->
                        <td>-</td>
                        <td>-</td>
                    </tr>
                    </tbody>
                </table>
            </div>
            <div class="col-lg-6 no-padding">
                <label>ㆍ환전완료 정보를 확인하고, 처리 불가 회원에 대한 응대를 할 수 있습니다.</label><br/>
                <label>ㆍ경영지원부에서 환전 처리를 완료한 후, 운영 담당자가 최종 확인하여 [SMS 발송]으로 회원에게 환전결과를 알립니다.</label><br/>
                <label>ㆍ[SMS발송] 후 [최종완료] 처리를 하면 더 이상 변경이 불가합니다.</label><br/>
                <label>ㆍ환전 불가처리 시 신청한 환전별은 환불처리 됩니다.</label>
            </div>
        </div>
        <div class="col-md-12">
            <div>
                <button class="btn btn-sm btn-primary print-btn pull-right ml5 mr5" type="button" id="completeBtn"><i class="fa fa-check-square"></i> 선택 완료처리</button>
                <button class="btn btn-sm btn-success print-btn pull-right ml5 mr5" type="button" id="excelDownBtn"><i class="fa fa-print"></i> Excel Down</button>
            </div>
        </div>
        <div class="col-md-12">
            <div class="pull-right">
                <button class="btn btn-sm btn-success print-btn" type="button" id="completeListBtn"><i class="fa fa-print"></i>완료내역 받기</button>

                <div class="input-group date" id="rangeDatepicker" style="display:none;">
                    <label for="rangeDate" class="input-group-addon">
                        <span><i class="fa fa-calendar"></i></span>
                    </label>
                    <input id="rangeDate" type="text" class="form-control"/>
                </div>

                <input type="hidden" name="startDate" id="startDate">
                <input type="hidden" name="endDate" id="endDate" />

                <button class="btn btn-sm btn-success print-btn" type="button" id="completeExcelDownBtn" style="display:none;"><i class="fa fa-print"></i>Down</button>
            </div>
        </div>
        <div class="col-md-6 no-padding">
            <span id="searchStateArea" onchange="searchStateArea_click();"></span>
            <span id="exchangeSort" onchange="exchangeSort_click();"></span>
            <c:if test="${fn:contains('|고병권|', principal.getUserInfo().getName())}">
                <span id="selGender" onchange="gender_click();"></span>
            </c:if>
        </div>
    </div>
</script>

<script type="text/x-handlebars-template" id="tmp_exchangeTable">
    <table id="list_info" class="table table-sorting table-hover table-bordered">
        <colgroup>
            <col width="3%"/>
            <col width="3%"/>
            <col width="3%"/>
            <col width="3%"/>
            <col width="5%"/>
            <col width="5%"/>
            <col width="6%"/>
            <col width="5%"/>
            <col width="5%"/>
            <col width="5%"/>
            <col width="5%"/>
            <col width="5%"/>
            <col width="5%"/>
            <col width="5%"/>
            <col width="3%"/>
            <col width="3%"/>
            <col width="5%"/>
            <col width="5%"/>
            <col width="5%"/>
            <col width="5%"/>
            <col width="5%"/>
            <col width="4%"/>
            <col width="4%"/>
            <col width="5%"/>
        </colgroup>

        <thead id="tableTop">
        <tr>
            <th>No</th>
            <th>상태</th>
            <th><input type="checkbox" id="allChk"></th>
            <th>프로필</th>
            <c:if test="${fn:contains('|고병권|', principal.getUserInfo().getName())}">
                <th>신분증</th>
            </c:if>
            <th>회원번호</th>
            <th>닉네임</th>
            <th>성별</th>
            <th>가입시<br />생년월일</th>
            <th>미성년자<br />여부</th>
            <th>회원이름</th>
            <th>예금주</th>
            <th>신청금액</th>
            <th>스페셜DJ<br />혜택</th>
            <th>실수령액</th>
            <th>신청 별 수</th>
            <th>현재 별 수</th>
            <th>테스트ID<br />등록이력</th>
            <th>환전횟수</th>
            <th>환전<br />누적금액</th>
            <th>신청일자</th>
            <th>처리일자</th>
            <th>처리현황</th>
            <th>처리자</th>
            <th>상세</th>
        </tr>
        </thead>
        <tbody id="tableBody"></tbody>
    </table>
</script>

<script type="text/x-handlebars-template" id="tmp_exchangeList">
    {{#each this.exchangeList as |data|}}
    <tr {{#dalbit_if inner '==' 1}} style="background-color: #dae3f3" {{/dalbit_if}}>
        <td>
            {{indexDesc ../exchangeCnt data.rowNum}}
        </td>
        <td>
            {{{getMemStateName data.mem_state}}}
        </td>
        <td>
            {{#adultStatusCheck data.birth data.recant_yn}}
                {{#workdayCheck ../limitDay data.reg_date}}
                    <input type="checkbox" class="_chk"
                           data-exchangeidx='{{data.idx}}'
                           data-regdate="{{convertToDate data.reg_date 'YYYYMMDD'}}"
                           {{^equal data.state '0'}}disabled{{/equal}} />
                {{else}}
                    {{{fontColor '대기' 1 'gray'}}}
                {{/workdayCheck}}
            {{else}}
                {{{fontColor '철회' 1 'red'}}}
            {{/adultStatusCheck}}
        </td>
        <td >
            <form id="profileImg" method="post" enctype="multipart/form-data">
                <img id="image_section" class="thumbnail fullSize_background no-padding" src="{{renderProfileImage data.image_profile data.mem_sex}}" alt="your image"
                     style="width: 50px;height: 50px;margin-bottom: 0px;" />
            </form>
        </td>
        <c:if test="${fn:contains('|고병권|', principal.getUserInfo().getName())}">
        <td >
            <img src="{{renderImage data.add_file1}}" style="max-width:50px;max-height:50px;" class="thumbnail fullSize_background no-padding no-margin" />
        </td>
        </c:if>
        <td><a href="javascript://" class="_openMemberPop" data-memno="{{data.mem_no}}">{{data.mem_no}}</a></td>
        <td>{{data.mem_nick}}</td>
        <td>{{{sexIcon data.mem_sex data.mem_birth_year}}}</td>

        <td>{{data.birth}}</td>
        <td>{{{calcAge data.birth}}}{{#equal data.recant_yn 'y'}}<br /><span style='font-weight:bold'>[철회됨]</span>{{/equal}}</td>

        <td>{{data.mem_name}}</td>
        <td>{{data.account_name}}</td>
        <td>{{addComma data.cash_basic}}원</td>
        <td>{{addComma data.benefit}}원</td>
        <td>{{addComma data.cash_real}}원</td>
        <td>{{addComma data.byeol}}별</td>
        <td>{{addComma data.gold}}별</td>
        <td>{{data.testid_history}}</td>
        <td>{{addComma data.exchangeCnt}}번</td>
        <td>{{addComma data.totalCashReal}}원</td>
        <td>{{convertToDate data.reg_date 'YYYY-MM-DD HH:mm:ss'}}</td>
        <td>{{convertToDate data.op_date 'YYYY-MM-DD HH:mm:ss'}}</td>
        <td>{{{stateName data.state}}}</td>
        <td>{{data.op_name}}</td>
        <td><button type="button" class="btn btn-primary btn-sm _layerOpen" data-exchangeidx='{{data.idx}}'>보기</button></td>
    </tr>

    {{else}}
    <tr>
        <td colspan="24">{{isEmptyData}}</td>
    </tr>
    {{/each}}
</script>

<script type="text/x-handlebars-template" id="tmp_layer_detail">
    <form id="exchangeForm">
        <input type="hidden" name="idx" value="{{detail.idx}}" />
        <div class="modal-dialog" style="{{#if parentInfo.parents_name}}{{/if}}width:900px{{^if parentInfo.parents_name}}width:600px{{/if}}">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true" id="layerCloseBtn">&times;</button>
                    <h4 class="modal-title" id="_layerTitle">상세보기</h4>
                </div>
                <div class="modal-body">
                    <div class="col-lg-12 form-inline block _modalLayer">
                        <div class="{{#if parentInfo.parents_name}}col-lg-8{{/if}}{{^if parentInfo.parents_name}}col-lg-12{{/if}}">
                        <%--<div class="col-lg-12">--%>
                            <table id="list_info" class="table table-sorting table-hover table-bordered">
                                <tbody id="tableBody">
                                    <tr>
                                        <th>신청금액</th>
                                        <td colspan="3" style="font-weight:bold; color: #ff5600">
                                            {{addComma detail.cash_basic}}원
                                        </td>
                                    </tr>
                                    <tr>
                                        <th>은행명</th>
                                        <td>
                                            {{{getCommonCodeSelect detail.bank_code 'inforex_bank_code' 'Y' ''}}}
                                        </td>

                                        <th>계좌번호</th>
                                        <td>
                                            <input type="text" class="form-control" id="account_no" name="account_no" maxlength="25" value="{{detail.account_no}}" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <th>예금주</th>
                                        <td>
                                            <input type="text" class="form-control" id="account_name" name="account_name" maxlength="25" value="{{detail.account_name}}" />
                                            <br />
                                            {{detail.mem_name}}
                                        </td>
                                        <th>주민번호</th>
                                        <td>
                                            <input type="text" class="form-control" id="social_no" name="social_no" maxlength="13" value="{{detail.social_no}}" />
                                            <br />
                                            [{{convertJumin detail.social_no}}]
                                        </td>
                                    </tr>

                                    <tr>
                                        <th>가입시<br />생년월일</th>
                                        <td>
                                            {{detail.birth}}
                                        </td>
                                        <th>미성년자<br />여부</th>
                                        <td>
                                            {{{calcAge detail.birth}}}
                                            {{#isChild detail.birth}}
                                                {{^if parentInfo.parents_name}}
                                                    <br />
                                                    <span style="font-weight:bold;">법정대리인 보호자 동의 정보가 없습니다.</span>
                                                {{/if}}
                                            {{/isChild}}
                                        </td>
                                    </tr>

                                    <tr>
                                        <th>주소</th>
                                        <td colspan="3">
                                            <input type="text" class="form-control _fullWidth" id="address_1" name="address_1" value="{{detail.address_1}}" />
                                        </td>
                                    </tr>

                                    <tr>
                                        <th>상세주소</th>
                                        <td colspan="3">
                                            <input type="text" class="form-control _fullWidth" id="address_2" name="address_2" value="{{detail.address_2}}" />
                                        </td>
                                    </tr>

                                    <tr>
                                        <th>전화번호</th>
                                        <td colspan="3">
                                            <input type="hidden" name="phone_no" value="{{phoneNumHyphen detail.phone_no}}" />
                                            {{phoneNumHyphen detail.phone_no}}
                                            / {{phoneNumHyphen detail.mem_phone}}
                                        </td>
                                    </tr>

                                    <tr>
                                        <th>접수서류</th>
                                        <td colspan="3">
                                            <div class="col-lg-6" style="border:solid 1px black">
                                                <a href="javascript://">
                                                    <img src="{{renderImage detail.add_file1}}" style="max-width:100px;max-height:150px;" class="_fullWidth _openImagePop thumbnail" />
                                                </a>
                                                {{#equal detail.state '0'}}<input id="files1" type="file" onchange="photoSubmit($(this))">{{/equal}}
                                                <input type="hidden" class="_hidden_filename" name="add_file1" id="add_file1" value="{{detail.add_file1}}" />
                                            </div>
                                            <div class="col-lg-6" style="border:solid 1px black">
                                                <a href="javascript://">
                                                    <img src="{{renderImage detail.add_file2}}" style="max-width:100px;max-height:150px;" class="_fullWidth _openImagePop thumbnail" />
                                                </a>
                                                {{#equal detail.state '0'}}<input id="files2" type="file" onchange="photoSubmit($(this))"/>{{/equal}}
                                                <input type="hidden" class="_hidden_filename" name="add_file2" id="add_file2" value="{{detail.add_file2}}" />
                                            </div>
                                        </td>
                                    </tr>

                                    <tr>
                                        <th>신청일자</th>
                                        <td>
                                            {{convertToDate detail.reg_date 'YYYY-MM-DD HH:mm:ss'}}
                                        </td>

                                        <th>완료일자</th>
                                        <td>
                                            {{#equal detail.op_date ''}}
                                            -
                                            {{else}}
                                            {{convertToDate ../detail.op_date 'YYYY-MM-DD HH:mm:ss'}}
                                            {{/equal}}
                                        </td>
                                    </tr>

                                    <tr>
                                        <th>
                                            미처리 사유
                                        </th>
                                        <td colspan="3">
                                            <input type="hidden" id="send_title" name="send_title">
                                            {{{getCommonCodeSelect detail.send_type 'exchange_cancel_type'}}} <label id="label_send_title">{{detail.send_title}}</label>
                                            <p class="no-margin no-padding" style="font-size:0.9em; color:red;">* 사유 선택 후 불가 처리 시 회원에게 푸시 메시지, SMS로 발송됩니다</p>
                                        </td>
                                    </tr>

                                    {{#dalbit_if detail.send_type "==" "0"}}
                                    <tr id="tr_send_cont" style="display:none;">
                                        {{else}}
                                    <tr id="tr_send_cont">
                                        {{/dalbit_if}}
                                        <th>
                                            미처리 사유<br>내용
                                        </th>
                                        <td colspan="3">
                                            <textarea class="form-control" name="send_cont" id="send_cont" oninput="util.textareaResize(this)" placeholder="" style="width:100%; height:90px; resize: none">{{replaceHtml detail.send_cont}}</textarea>
                                        </td>
                                    </tr>

                                    <tr>
                                        <th>메모</th>
                                        <td colspan="3">
                                            <input type="text" class="form-control _fullWidth" id="op_msg" name="op_msg" maxlength="1000" value="{{detail.op_msg}}" />
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>

                        {{#if parentInfo.parents_name}}
                        <div class="col-lg-4">
                            <div class="mb10">법정대리인 (보호자) 동의 정보</div>
                            <table id="parentTable" class="table table-sorting table-hover table-bordered">
                                <tbody>
                                    <tr>
                                        <th>
                                           보호자 이름
                                        </th>
                                        <td>
                                            {{parentInfo.parents_name}}
                                        </td>
                                    </tr>
                                    <tr>
                                        <th>
                                           성별
                                        </th>
                                        <td>
                                            {{{sexIcon parentInfo.parents_sex parentInfo.mem_birth_year}}}
                                        </td>
                                    </tr>
                                    <tr>
                                        <th>
                                           생년월일
                                        </th>
                                        <td>
                                            {{parentInfo.parents_birth_year}}{{parentInfo.parents_birth_month}}{{parentInfo.parents_birth_day}}
                                        </td>
                                    </tr>
                                    <tr>
                                        <th>
                                           통신사
                                        </th>
                                        <td>
                                            {{parentInfo.parents_comm_company}}
                                        </td>
                                    </tr>
                                    <tr>
                                        <th>
                                           휴대폰번호
                                        </th>
                                        <td>
                                            {{parentInfo.parents_phone}}
                                        </td>
                                    </tr>
                                    <tr>
                                        <th>
                                           내/외국인
                                        </th>
                                        <td>
                                            {{parentInfo.parents_foreign_yn}}
                                        </td>
                                    </tr>
                                    <tr>
                                        <th>철회 여부</th>
                                        <td>
                                            {{#equal parentInfo.recant_yn 'n'}}
                                                <label style="font-weight: bold">No</label>
                                            {{else}}
                                                <label style="color: red; font-weight: bold">Yes</label>
                                            {{/equal}}
                                        </td>
                                    </tr>
                                    <tr>
                                        <th>
                                           가족관계<br />증명서류
                                        </th>
                                        <td>
                                            {{#if parentInfo.add_file}}
                                                <img src="{{renderImage parentInfo.add_file}}" style="max-width:100px;max-height:150px;" class="_fullWidth _openImagePop thumbnail" />
                                            {{else}}
                                                가족관계 증명서류가 없습니다.
                                            {{/if}}
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                        {{/if}}
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-primary pull-left" data-dismiss="modal"><i class="fa fa-times-circle"></i> 닫기</button>

                    {{#equal detail.state '0'}}
                        {{#adultStatusCheck ../detail.birth ../parentInfo.recant_yn}}
                            <button type="button" class="btn btn-custom-primary _updateBtn"><i class="fa fa-times-circle"></i> 수정</button>
                            <button type="button" class="btn btn-danger _rejectBtn"><i class="fa fa-times-circle"></i> 불가</button>
                            <button type="button" class="btn btn-success _completeBtn"><i class="fa fa-check-circle"></i> 완료</button>
                        {{else}}
                            <span class="exchange_complete_txt">법정대리인 보호자 정보동의 철회로 처리 할 수 없습니다.</span>
                        {{/adultStatusCheck}}
                    {{/equal}}

                    {{#equal detail.state '1'}}
                        <span class="exchange_complete_txt">완료되었습니다.</span>
                    {{/equal}}

                    {{#equal detail.state '2'}}
                        <span class="exchange_reject_txt">불가처리 되었습니다.</span>
                    {{/equal}}

                </div>
            </div>
        </div>
    </form>
</script>

<!-- 환전신청 가능회원 -->
<script type="text/x-handlebars-template" id="tmp_enableSummary">
    <div class="col-lg-12 no-padding">
        <label>ㆍ570별 이상을 보유하고 있는 환전신청이 가능한 회원 리스트입니다.</label>
        <div class="col-lg-6 no-padding pull-right">
            <table class="table table-bordered table-summary pull-right" style="margin-right: 0px;width: 450px">
                <colgroup>
                    <col width="25%"/><col width="25%"/><col width="50%"/>
                </colgroup>
                <tr>
                    <th colspan="2">총 환전 가능금액</th>
                    <th><label class="font-bold" style="padding-top: 9px;width: 170px;">(환전가능 금액/부가세 제외)<br/>총 예상 순 매출</label></th>
                </tr>
                <tr style="background-color: white">
                    <td>{{addComma content.enableCnt}} 명</td>
                    <td>{{exchangeAmt content.totalGold content.specialCnt}}원</td>
                    <td class="font-bold" style="color: #ff5600">{{addComma content.netProfit}}원</td>
                </tr>
            </table>
        </div>
    </div>
</script>

<script type="text/x-handlebars-template" id="tmp_enableTable">
    <table id="list_info" class="table table-sorting table-hover table-bordered">
        <colgroup>
            <col width="5%"/>
            <col width="5%"/>
            <col width="10%"/>
            <col width="10%"/>
            <col width="10%"/>
            <col width="7%"/>
            <col width="10%"/>
            <col width="10%"/>
            <col width="10%"/>
            <col width="10%"/>
            <col width="5%"/>
            <!--<col width="10%"/>-->
        </colgroup>

        <thead id="tableTop">
        <tr>
            <th>No</th>
            <th>상태</th>
            <th>회원번호</th>
            <th>아이디</th>
            <th>닉네임</th>
            <th>성별</th>
            <th>신청가능 별 수</th>
            <th>신청 가능금액</th>
            <th>스페셜DJ혜택</th>
            <th>예상실수령액</th>
            <th>환전횟수</th>
            <!--<th>신청일자</th>-->
        </tr>
        </thead>
        <tbody id="tableBody"></tbody>
    </table>
</script>

<script type="text/x-handlebars-template" id="tmp_enableList">
    {{#each this.enableList as |data|}}
    <tr {{#dalbit_if inner '==' 1}} style="background-color: #dae3f3" {{/dalbit_if}}>
        <td>
            {{indexDesc ../enableCnt data.rowNum}}
        </td>
        <td>
            {{{getMemStateName data.mem_state}}}
        </td>
        <td><a href="javascript://" class="_openMemberPop" data-memno="{{data.mem_no}}">{{data.mem_no}}</a></td>
        <td>{{data.mem_userid}}</td>
        <td>{{data.mem_nick}}</td>
        <td>{{{sexIcon data.mem_sex data.mem_birth_year}}}</td>
        <td>{{addComma data.gold}}별</td>
        <td>{{math data.gold "*" 60}}원</td>
        <td>{{specialBenefit data.gold data.specialCnt}}원</td>
        <td>{{exchangeAmt data.gold data.specialCnt}}원</td>
        <td>{{addComma data.exchangeCnt}}번</td>
    </tr>

    {{else}}
    <tr>
        <td colspan="12">{{isEmptyData}}</td>
    </tr>
    {{/each}}
</script>

<!-- 불가목록 -->
<script type="text/x-handlebars-template" id="tmp_rejectTable">
    <table id="list_info" class="table table-sorting table-hover table-bordered">
        <colgroup>
            <col width="4%"/>
            <col width="3%"/>
            <col width="3%"/>
            <col width="3%"/>
            <col width="5%"/>
            <col width="5%"/>
            <col width="6%"/>
            <col width="5%"/>
            <col width="5%"/>
            <col width="7%"/>
            <col width="6%"/>
            <col width="6%"/>
            <col width="7%"/>
            <col width="3%"/>
            <col width="3%"/>
            <col width="5%"/>
            <col width="6%"/>
            <col width="6%"/>
            <col width="4%"/>
            <col width="5%"/>
            <col width="5%"/>
            <col width="5%"/>
        </colgroup>

        <thead id="tableTop">
        <tr>
            <th>No</th>
            <th>상태</th>
            <th>스페셜<br />여부</th>
            <th>프로필</th>
            <th>회원번호</th>
            <th>닉네임</th>
            <th>성별</th>
            <th>이름</th>
            <th>예금주</th>
            <th>환전신청금액</th>
            <th>스페셜DJ혜택</th>
            <th>환전실수령액</th>
            <th>신청 별 수</th>
            <th>현재 별 수</th>
            <th>테스트ID<br />등록이력</th>
            <th>환전횟수</th>
            <th>환전<br />누적금액</th>
            <th>신청일자</th>
            <th>처리일자</th>
            <th>처리자</th>
            <th>상세보기</th>
        </tr>
        </thead>
        <tbody id="tableBody"></tbody>
    </table>
</script>

<script type="text/x-handlebars-template" id="tmp_rejectList">
    {{#each this.rejectList as |data|}}
    <tr {{#dalbit_if inner '==' 1}} style="background-color: #dae3f3" {{/dalbit_if}}>
        <td>
            {{indexDesc ../rejectCnt data.rowNum}}
        </td>
        <td>
            {{{getMemStateName data.mem_state}}}
        </td>
        <td>
            {{^equal data.benefit 0}}
            <span class="label" style="background-color:red">스페셜DJ</span>
            {{/equal}}
        </td>
        <td >
            <form id="profileImg" method="post" enctype="multipart/form-data">
                <img id="image_section" class="thumbnail fullSize_background no-padding" src="{{renderProfileImage data.image_profile data.mem_sex}}" alt="your image"
                     style="width: 50px;height: 50px;margin-bottom: 0px;" />
            </form>
        </td>
        <td><a href="javascript://" class="_openMemberPop" data-memno="{{data.mem_no}}">{{data.mem_no}}</a></td>
        <td>{{data.mem_nick}}</td>
        <td>{{{sexIcon data.mem_sex data.mem_birth_year}}}</td>
        <td>{{data.mem_name}}</td>
        <td>{{data.account_name}}</td>
        <td>{{addComma data.cash_basic}}원</td>
        <td>{{addComma data.benefit}}원</td>
        <td>{{addComma data.cash_real}}원</td>
        <td>{{addComma data.byeol}}별</td>
        <td>{{addComma data.gold}}별</td>
        <td>{{data.testid_history}}</td>
        <td>{{addComma data.exchangeCnt}}번</td>
        <td>{{addComma data.totalCashReal}}번</td>
        <td>{{convertToDate data.reg_date 'YYYY-MM-DD HH:mm:ss'}}</td>
        <td>{{convertToDate data.op_date 'YYYY-MM-DD HH:mm:ss'}}</td>
        <td>{{data.op_name}}</td>
        <td><button type="button" class="btn btn-primary btn-sm _layerOpen" data-exchangeidx='{{data.idx}}'>보기</button></td>
    </tr>

    {{else}}
    <tr>
        <td colspan="21">{{isEmptyData}}</td>
    </tr>
    {{/each}}
</script>