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
            <div class="col-md-12 no-padding">
                <form id="searchForm">
                    <div class="row col-lg-7 form-inline no-padding">
                        <%--<input type="hidden" name="pageStart" id="pageStart">
                        <input type="hidden" name="pageCnt" id="pageCnt">--%>
                        <div class="widget widget-table searchBoxArea">
                            <table>
                                <tr>
                                    <th rowspan="2" style="background-color:#4472c4;color:#e9ee17;width: 70px">
                                        <i class="fa fa-search"></i><br/>검색
                                    </th>
                                    <th id="th_bottonList">
                                        <jsp:include page="../../searchArea/daySearchFunction.jsp"/>
                                        <div>
                                            <div id="div_monthButton"><jsp:include page="../../searchArea/monthSearchArea.jsp"/></div>
                                        </div>
                                    </th>
                                </tr>
                                <tr>
                                    <td style="text-align: left">
                                        <jsp:include page="../../searchArea/dateRangeSearchArea.jsp"/>
                                        <input id="monthDate" type="text" class="form-control"/>
                                        <input class="hide" name="startDate" id="startDate" style="width: 100px">
                                        <input class="hide" name="endDate" id="endDate" style="width: 100px">
                                        <%--<input name="startDate" id="startDate" style="width: 100px">--%>
                                        <%--<input name="endDate" id="endDate" style="width: 100px">--%>

                                        <span id="searchMemberArea" style="margin-top:2px; " onchange="btSearchClick();"></span>
                                        <label><input type="text" class="form-control" name="searchText" id="searchText" placeholder="검색어를 입력해주세요."></label>

                                        <button type="button" class="btn btn-success" id="bt_search">검색</button>
                                        <a href="javascript://" class="_prevSearch">[이전]</a>
                                        <a href="javascript://" class="_todaySearch">[오늘]</a>
                                        <a href="javascript://" class="_nextSearch">[다음]</a>

                                        <span id="searchCheck">
                                            <label class="control-inline fancy-checkbox custom-color-green">
                                                <input type="checkbox" name="search_testId" id="search_testId" value="1" checked="true">
                                                <span>테스트 아이디 제외</span>
                                            </label>
                                        </span>
                                        <label class="control-inline fancy-checkbox custom-color-green" id="exchangeCheckArea">
                                            <input type="checkbox" name="search_exchangeYn" id="search_exchangeYn" value="1">
                                            <span>1회 이상 환전 회원</span>
                                        </label>
                                    </td>
                                </tr>
                            </table>
                        </div>
                    </div>
                </form>
                <div class="col-md-5 no-padding pull-right">
                    <div id="summaryArea"></div>
                </div>
            </div>
            <!-- //serachBox -->

            <div class="row widget-content">
                <ul class="nav nav-tabs nav-tabs-custom-colored" role="tablist" style="width: 932px">
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
            <div class="row tab-content">
                <div class="tab-pane fade in active" id="exchange" >
                    <!-- DATA TABLE -->
                    <div class="col-lg-12 form-inline no-padding" id="topBotton">
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
                                    <a href="javascript://" id="rejectList" name="rejectList" role="tab" data-toggle="tab">취소내역</a>
                                </li>
                            </c:if>

                            <li class="_tab">
                                <a href="javascript://" id="enableList" name="enableList" role="tab" data-toggle="tab">환전신청 가능회원</a>
                            </li>
                        </ul>

                        <div>
                            <div class="col-lg-12 no-padding" style="margin-left: 0px">
                                <div id="summaryTable"></div>

                                <div class="col-md-12 no-padding">
                                    <div class="col-md-2 no-padding pull-right" id="div_testIdTable">
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


<div class="modal fade" id="exchangeDetailModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog" style="width: 300px;display: table;">
        <div class="modal-content">
            <div class="modal-header">
                <span id="modal_accountName"></span>
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
            </div>
            <div class="modal-body">
                <span id="modal_realcash"></span><br/>
                <span id="modal_nomal"></span><br/>
                <span id="modal_special"></span><br/>
                <span id="modal_tax"></span><br/>
                <span id="modal_fees"></span>
            </div>
            <div class="modal-footer">
            </div>
        </div>
    </div>
</div>

<script type="text/javascript" src="/js/lib/jquery.table2excel.js"></script>
<script type="text/javascript" src="/js/code/money/exchangeCodeList.js?${dummyData}"></script>
<script type="text/javascript" src="/js/code/member/memberCodeList.js?${dummyData}"></script>
<script type="text/javascript" src="/js/handlebars/moneyHelper.js?${dummyData}"></script>
<script type="text/javascript">

    var exchangePagingInfo = new PAGING_INFO(0,1,50);
    var limitDay = moment(new Date()).format('YYYYMMDD');

    var tabType = <%=in_tabType%>;

    var detailIdx;
    var detailMemNo;
    var before_add_file1;
    var before_add_file2;
    var before_add_file3;

    slctType = 1;

    var selectTab;
    $(function(){

        console.log(tabType);
        if(!common.isEmpty(tabType)){
            $('#topBotton li:eq(' + tabType + ') a').tab('show');
        }


        setDayButton();

        // getList();
        $("#searchMemberArea").html(util.getCommonCodeSelect(1, searchMember));
    });

    function getParameter(viewName){
        return data = {
            isSpecial : $('._tab.active a').data('specialdj')
            , search_year : common.substr($("#startDate").val(),0,4)
            , search_month : common.substr($("#startDate").val(),5,2)
            , search_state : $("#search_state").val()
            , exchange_sort : $("#exchange_sort").val()
            , gender : $("#gender").val()
            , search_value : $("#searchText").val()
            , search_testId : $('input[name="search_testId"]').prop('checked') ? 1 : 0
            , search_exchangeYn : $('input[name="search_exchangeYn"]').prop('checked') ? 'Y' : 'N'
            , pageStart : exchangePagingInfo.pageNo
            , pageNo : exchangePagingInfo.pageNo
            , pageCnt : exchangePagingInfo.pageCnt
            , limitDay : limitDay
            , viewName : viewName

            , startDate : $("#startDate").val()
            , endDate : $("#endDate").val()
            , searchText : $("#searchText").val()
            , slctType : $("#search_state").val()
            , orderType : $("#exchange_sort").val()
            , innerType : $('input[name="search_testId"]').prop('checked') ? 1 : 0
            , djType : $('._tab.active a').data('specialdj')
            , newSearchType : $("#searchMember").val()
        };
    }

    function getSummary(){

        console.log(getParameter());

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
        selectTab = targetAnchor.data('specialdj');
        console.log("-------------------------------");
        console.log(selectTab);

        // console.log(targetAnchor.data('specialdj'));
        // console.log(targetAnchor.prop('id'));


        if(targetAnchor.data('specialdj') != null){
            $("#monthDate").show();
            $("#exchangeCheckArea").attr('style', 'display:none !important;');
            $("#searchStateArea").show();
            $("#summaryArea").show();
            $("#div_testIdTable").hide();
            $("#th_bottonList").show();
            // $("#searchText").hide();
            $('._nextSearch').show();
            $('._prevSearch').show();
            $('._todaySearch').show();

            exchangeList(tmp);
        }else if(targetAnchor.prop('id') == 'rejectList'){
            $("#monthDate").show();
            $("#exchangeCheckArea").attr('style', 'display:none !important;');
            $("#searchStateArea").show();
            $("#summaryArea").hide();
            $("#div_testIdTable").show();
            $("#th_bottonList").show();
            // $("#searchText").show();

            $('._nextSearch').show();
            $('._prevSearch').show();
            $('._todaySearch').show();
            rejectList();

        }else if(targetAnchor.prop('id') == 'enableList') {
            $("#monthDate").hide();
            $("#th_bottonList").hide();
            // $("#searchText").show();
            $("#exchangeCheckArea").show();
            $("#searchStateArea").hide();
            $("#summaryArea").show();
            $("#div_testIdTable").show();

            $('._prevSearch').hide();
            $('._todaySearch').hide();
            $('._nextSearch').hide();

            enableList();
        }
    }

    function exchangeList(tmp){

        console.log(tmp);


        if(common.isEmpty(tmp) || tmp != "button"){
            var template = $('#tmp_exchangeSummary').html();
            var templateScript = Handlebars.compile(template);
            var html = templateScript();
            $("#summaryArea").html(html);

            var template = $('#tmp_exchangeSummary2').html();
            var templateScript = Handlebars.compile(template);
            var html = templateScript();
            $("#summaryTable").html(html);

            $("#searchStateArea").html(util.getCommonCodeSelect('', search_exchange_state));
            $("#exchangeSort").html(util.getCommonCodeSelect('', exchange_sort));
            $("#selGender").html(util.getCommonCodeSelect('', gender));

            ui.tableHeightSet();
        }

        var data = {
            selectTab : selectTab
        }

        var template = $('#tmp_exchangeTable').html();
        var templateScript = Handlebars.compile(template);
        var context = data;
        var html = templateScript(context);
        $("#listTable").html(html);

        ui.paintColor();

        $("#allChk").removeAttr('checked');
        getSummary();

        console.log(getParameter());
        util.getAjaxData("select", "/rest/money/exchange/exchange/list", getParameter(), fn_succ_list);
    }

    function enableList(){
        $('#summaryTable').empty();

        var template = $('#tmp_enableSummary').html();
        var templateScript = Handlebars.compile(template);
        var html = templateScript();
        $("#summaryArea").html(html);

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
        getList();
    });

    $('input[id="searchText"]').on('keydown', function(e) {    // textBox 처리
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
        response.data.selectTab = selectTab;

        var template = $('#tmp_exchangeList').html();
        var templateScript = Handlebars.compile(template);
        var context = response.data;
        var html = templateScript(context);
        $("#tableBody").html(html);

        /*2일 이상된 미처리 데이터가 있을 경우 체크*/
        var is_waring = false;
        var checkPassDay = moment(new Date()).add('days', -1).format('YYYYMMDD');
        if(0 < response.data.exchangeCnt){
            response.data.exchangeList.forEach(function(data, index){
                if(Number(moment(data.reg_date).format('YYYYMMDD')) < Number(checkPassDay) && data.state == "0"){
                    is_waring = true;
                }
            });
        }
        if(is_waring){
            $("#warning_desc").show();
            if(${fn:contains("/dev/", cfn:getActiveProfile())}) {
                alert('2일 이상된 미처리 데이터가 존재합니다.\n환전 완료여부를 한번 더 확인해주세요.');
            }
        }

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
        $("#summaryArea").html(html);

        ui.paintColor();
        ui.tableHeightSet();

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
        hiddenData += hidden.replace('{name}', 'search_value').replace('{value}', getParameter().search_value);
        hiddenData += hidden.replace('{name}', 'limitDay').replace('{value}', getParameter().limitDay);

        $("#excelForm").html(hiddenData).attr({
            method : 'post'
            , action : '/money/exchange/listExcel'
            , target : 'iframe_excel_download'
        }).submit();
    });

    $(document).on('click', '#completeListBtn', function(){
        $("#rangeDatepickerExcel, #completeExcelDownBtn").show();
        setRangeDatepicker();
    });

    $(document).on('click', '#completeExcelDownBtn', function(){
        if($("#startDateExcel").val() == '' || $("#endDateExcel").val() == ''){
            alert('날짜를 선택해주세요.');
            return false;
        }

        var hidden = '<input type="hidden" name="{name}" value="{value}">';

        var hiddenData = '';
        hiddenData += hidden.replace('{name}', 'startDate').replace('{value}', $("#startDateExcel").val());
        hiddenData += hidden.replace('{name}', 'endDate').replace('{value}', $("#endDateExcel").val());
        hiddenData += hidden.replace('{name}', 'search_testId').replace('{value}', $('input[name="search_testId"]').prop('checked') ? 1 : 0);

        $("#excelForm").html(hiddenData).attr({
            method : 'post'
            , action : '/money/exchange/completeListExcel'
            , target : 'iframe_excel_download'
        }).submit();
    });

    function fn_success_excel(response) {
    }

    function fn_fail_excel(response){
        alert('현재 환전 처리일이 아니거나, 처리되지 않은 신청 건이 없습니다.');
    }

    $(document).on('click', '._layerOpen', function(title, content){

        var detailData = getParameter();
        detailData.idx = $(this).data('exchangeidx');
        delete detailData.search_state;

        console.log(detailData);
        util.getAjaxData("select", "/rest/money/exchange/detail", detailData, fn_succ_detail);
    });

    function fn_succ_detail(dist_id, response){
        var template = $('#tmp_layer_detail').html();
        var templateScript = Handlebars.compile(template);
        var context = response.data;
        var html = templateScript(context);
        $("#detailView").html(html);

        ui.paintColor();
        showModal();

        detailIdx = response.data.detail.idx;
        detailMemNo = response.data.detail.mem_no;
        before_add_file1 = response.data.detail.add_file1;
        before_add_file2 = response.data.detail.add_file2;
        before_add_file3 = response.data.detail.add_file3;

        if(response.data.detail.op_date != ''){
            $("#div_opDate").find("#txt_opDate").datepicker();
            $("#div_opDate").find("#txt_opDate").val(response.data.detail.op_date.substr(0,10).replace(/-/gi,"."));
            $("#div_opDate").find("#timeHour").val(response.data.detail.op_date.substr(11,2));
            $("#div_opDate").find("#timeMinute").val(response.data.detail.op_date.substr(14,2));
        }
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
        if(confirm('취소처리 하시겠습니까?\n취소처리 시 환전 신청한 별 수가 반환됩니다.')){
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
                // console.log(JSON.parse(response));
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
        // file3 upload -> done
        if($("#add_file3").val().indexOf('_1/') >= 0) {
            var data = {
                'tempFileURI': $("#add_file3").val()
            };
            util.getAjaxData("add_file3", PHOTO_SERVER_URL + "/done", data, fn_pathChange_success);
        }
    }

    function fn_pathChange_success(dst_id, response) {
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

        $("#startDateExcel").val(startDate);
        $("#endDateExcel").val(endDate);

        $('#rangeDate').daterangepicker({
            startDate: startDate,
            endDate: endDate
        }, function(startDate,endDate){
            $("#startDateExcel").val(moment(startDate).format("YYYY.MM.DD"));
            $("#endDateExcel").val(moment(endDate).format("YYYY.MM.DD"));
            $("#displayDateExcel").val($("#startDateExcel").val() + ' - ' + $("#endDateExcel").val());
        });
    }

    function opDateUpdate(data){
        var selOpDate = $("#div_opDate").find("#txt_opDate").val() + " " + $("#div_opDate").find("#timeHour").val() +":"+ $("#div_opDate").find("#timeMinute").val() + ":00";
        if(moment(data.data('regdate')).format("YYYYMMDDHHmmss") > moment(selOpDate).format("YYYYMMDDHHmmss")){
            alert('신청일자를 확인해 주세요. \n\n' +
                  '신청일자 : ' + moment(data.data('regdate')).format("YYYY.MM.DD HH:mm:ss") + '\n' +
                  '완료일자 : ' + moment(selOpDate).format("YYYY.MM.DD HH:mm:ss"));
            return;
        }

        var obj = {
            idx : data.data('idx')
            , op_date : selOpDate
        };

        util.getAjaxData("complete", "/rest/money/exchange/opdate/update", obj, fn_opdateUpdate_complete);
    }
    function fn_opdateUpdate_complete(dst_id, response){
        if(response.result="success"){
            alert(response.message);
            closeModal();
            getList();
        }else{
            alert(response.result.message);
        }
    }

    function imageUpload(){
        alert('접수서류를 변경 하시겠습니까?');
        var data = {
            idx : detailIdx
            , mem_no : detailMemNo
            , add_file1 : $("#add_file1").val()
            , add_file2 : $("#add_file2").val()
            , add_file3 : $("#add_file3").val()
            , before_add_file1 : before_add_file1
            , before_add_file2 : before_add_file2
            , before_add_file3 : before_add_file3
        };

        console.log(data);

        util.getAjaxData("imageUpload","/rest/money/exchange/image/upload", data, fn_opdateUpdate_complete);
    }

    function btSearchClick(){
        $("#bt_search").click();
    }

    $(document).on('click','#totalCashReal', function(){
        var data = {
            idx : $(this).data('idx')
            , account_name : $(this).data('account_name')
        };
        util.getAjaxData("exchangeDetail","/rest/money/exchange/cash/real/detail", data, fn_exchangeDetail_success);
    });

    function fn_exchangeDetail_success(dst_id, response, param){
        $("#modal_accountName").html('<span>회원명 : ' + param.account_name + '</span>' );

        $("#modal_realcash").html('<span>환전 신청 별 : ' + common.addComma(response.data.byeol) + '</span> <span class="pull-right"> ' + common.addComma(response.data.cash_real) + '</span>'  );
        $("#modal_nomal").html('<span>일반 : ' + + common.addComma(response.data.gold) + '</span> <span class="pull-right"> ' + common.addComma(response.data.goldAmt) + '</span>' );
        $("#modal_special").html('<span>스패셜 : ' + + common.addComma(response.data.silver) + '</span> <span class="pull-right"> ' + common.addComma(Number(response.data.silverAmt) + Number(response.data.benefit)) + '</span>' );
        $("#modal_tax").html('<span>원천징수세액</span> <span class="pull-right">' + common.addComma(Number(response.data.income_tax) + Number(response.data.resident_tax)) +' </span>' );
        $("#modal_fees").html('<span>수수료</span> <span class="pull-right">' + common.addComma(response.data.transfer_fee) +' </span>' );

        $("#exchangeDetailModal").modal('show');
    }


</script>


<script type="text/x-handlebars-template" id="tmp_exchangeSummary">
    <div class="col-lg-12 no-padding" style="height: 106px;">
        <table class="table table-bordered table-summary pull-right no-margin _tableHeight" style="width: 48%;font: message-box;" data-height="24">
            <colgroup>
                <col width="80px"/>
                <col width="80px"/>
                <col width="100px"/>
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
                <th>환전취소</th>
                <td><span class="_summary_user_6">0</span>건</td>
                <!-- 양과장님 요청으로 수치 표현 안함 -->
                <!--<td><span class="_summary_special_7">0</span>원</td>
                <td><span class="_summary_special_8">0</span>별</td>-->
                <td>-</td>
                <td>-</td>
            </tr>
            </tbody>
        </table>
        <table class="table table-bordered table-summary pull-right no-margin _tableHeight" style="width: 48%" data-height="24">
            <colgroup>
                <col width="80px"/>
                <col width="80px"/>
                <col width="100px"/>
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
                <th>환전취소</th>
                <td><span class="_summary_special_6">0</span>건</td>
                <!-- 양과장님 요청으로 수치 표현 안함 -->
                <!--<td><span class="_summary_special_7">0</span>원</td>
                <td><span class="_summary_special_8">0</span>별</td>-->
                <td>-</td>
                <td>-</td>
            </tr>
            </tbody>
        </table>
    </div>
</script>
<script type="text/x-handlebars-template" id="tmp_exchangeSummary2">
    <div class="col-md-12 no-padding">
        <div class="col-md-12 no-padding">
            <div class="col-lg-6 no-padding mt10">
                <label>ㆍ환전완료 정보를 확인하고, 환전 취소 회원에 대한 응대를 할 수 있습니다.</label><br/>
                <label>ㆍ환전 취소처리 시 신청한 환전별은 환불처리 됩니다.</label>
                <div id="warning_desc" style="display:none;">
                    <label style="color:red"><h2>2일 이상 된 미처리 데이터가 존재합니다.<br />환전 완료여부를 한번 더 확인해주세요.</h2></label>
                </div>
            </div>
            <div class="col-md-6 mt10">

                <div class="pull-right">
                    <table class="table table-sorting table-hover table-bordered mt5" style="margin-bottom: 0px">
                        <colgroup>
                            <col width="15%"/><col width="65%"/>
                        </colgroup>
                        <tr>
                            <td style="background-color: #dae3f3"></td><td>테스트 아이디</td>
                        </tr>
                    </table>
                    <br/>
                    <br/>
                    <button class="btn btn-sm btn-success print-btn ml5 mr5 no-margin" type="button" id="excelDownBtn"><i class="fa fa-print"></i> Excel Down</button>
                    <button class="btn btn-sm btn-primary print-btn ml5 mr5 no-margin" type="button" id="completeBtn"><i class="fa fa-check-square"></i> 선택 완료처리</button>
                    <button class="btn btn-sm btn-success print-btn" type="button" id="completeListBtn"><i class="fa fa-print"></i>완료내역 받기</button>

                    <div class="input-group date" id="rangeDatepickerExcel" style="display:none;">
                        <label for="rangeDate" class="input-group-addon">
                            <span><i class="fa fa-calendar"></i></span>
                        </label>
                        <input id="rangeDate" type="text" class="form-control"/>
                    </div>

                    <input type="hidden" name="startDateExcel" id="startDateExcel">
                    <input type="hidden" name="endDateExcel" id="endDateExcel" />

                    <button class="btn btn-sm btn-success print-btn" type="button" id="completeExcelDownBtn" style="display:none;"><i class="fa fa-print"></i>Down</button>
                </div>
            </div>
        </div>
        <%--<div class="col-md-12">--%>
            <%--<div>--%>
            <%--</div>--%>
        <%--</div>--%>
        <div class="col-md-6 no-padding">
            <span id="searchStateArea" onchange="searchStateArea_click();"></span>
            <span id="exchangeSort" onchange="exchangeSort_click();"></span>
            <c:if test="${fn:contains('|이형원|전유신|고병권|이재호|', principal.getUserInfo().getName())}">
                <span id="selGender" onchange="gender_click();"></span>
            </c:if>
        </div>
    </div>
</script>

<script type="text/x-handlebars-template" id="tmp_exchangeTable">
    <table id="list_info" class="table table-sorting table-hover table-bordered">
        <colgroup>
            <%--<col width="3%"/>--%>
            <%--<col width="3%"/>--%>
            <%--<col width="1%"/>--%>
            <%--<col width="3%"/>--%>
            <%--<col width="5%"/>--%>
            <%--<col width="6%"/>--%>
            <%--<col width="3%"/>--%>
            <%--<col width="5%"/>--%>
            <%--<col width="5%"/>--%>
            <%--<col width="5%"/>--%>
            <%--<col width="5%"/>--%>
            <%--<col width="5%"/>--%>
            <%--<col width="5%"/>--%>
            <%--<col width="5%"/>--%>
            <%--<col width="3%"/>--%>
            <%--<col width="3%"/>--%>
            <%--<col width="5%"/>--%>
            <%--<col width="5%"/>--%>
            <%--<col width="5%"/>--%>
            <%--<col width="5%"/>--%>
            <%--<col width="5%"/>--%>
            <%--<col width="4%"/>--%>
            <%--<col width="4%"/>--%>
            <%--<col width="5%"/>--%>
        </colgroup>

        <thead id="tableTop">
        <tr>
            <th>No</th>
            <th>상태</th>
            <th><input type="checkbox" id="allChk"></th>
            <th>프로필</th>
            <c:if test="${fn:contains('|이형원|전유신|고병권|이재호|', principal.getUserInfo().getName())}">
                <th>신분증</th>
            </c:if>
            <th>회원정보</th>
            <th>미성년자<br />여부</th>
            <th>예금주</th>
            <th>신청금액</th>
            {{#dalbit_if selectTab '==' 1}}<th>스페셜DJ<br />혜택</th>{{/dalbit_if}}
            <th>실수령액</th>
            <th>환전<br />누적금액</th>
            <th>신청 전 별</th>
            <th>신청 별</th>
            <th>신청 후 별</th>
            <th>현재 별</th>
            <th>환전횟수</th>
            <th>이전 환전일자</th>
            <th>재 신청기간</th>
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
        <c:if test="${fn:contains('|이형원|전유신|고병권|이재호|', principal.getUserInfo().getName())}">
    <td >
    <img src="{{renderImage data.add_file1}}" style="max-width:50px;max-height:50px;" class="thumbnail fullSize_background no-padding no-margin" />
    </td>
</c:if>
        <td><a href="javascript://" class="_openMemberPop" data-memno="{{data.mem_no}}">{{data.mem_no}}</a><br/>{{data.mem_nick}}</td>
        <td>{{{calcAge data.birth}}}{{#equal data.recant_yn 'y'}}<br /><span style='font-weight:bold'>[철회됨]</span>{{/equal}}</td>
        <td>{{data.account_name}}</td>
        <td>{{addComma data.cash_basic}}원</td>
        {{#dalbit_if ../selectTab '==' 1}}<td>{{addComma data.benefit}}원</td>{{/dalbit_if}}
        <td><a href="javascript://" id="totalCashReal" data-idx="{{idx}}" data-account_name="{{account_name}}">{{addComma data.cash_real}}원</a></td>
        <td>{{addComma data.totalCashReal}}원</td>
        <td>{{addComma data.gold_old}}별</td>
        <td>{{addComma data.byeol}}별</td>
        <td>{{addComma data.mod_gold}}별</td>
        <td>{{addComma data.gold}}별</td>
        <td>{{addComma data.exchangeCnt}}번</td>
        <td>{{#dalbit_if data.last_reg_date '!=' ''}}{{convertToDate data.last_reg_date 'YYYY-MM-DD HH:mm:ss'}}{{/dalbit_if}}</td>
        <td>{{#dalbit_if data.reapply_exchage '!=' ''}}{{timeStampDay data.reapply_exchage}}{{/dalbit_if}}</td>
        <td>{{convertToDate data.reg_date 'YYYY-MM-DD HH:mm:ss'}}</td>
        <td>{{convertToDate data.op_date 'YYYY-MM-DD HH:mm:ss'}}</td>
        <td>{{{stateName data.state}}}</td>
        <td>{{data.op_name}}</td>
        <td><button type="button" class="btn btn-primary btn-sm _layerOpen" data-exchangeidx='{{data.idx}}'>보기</button></td>
    </tr>

    {{else}}
    <tr>
        <c:choose>
    <c:when test="${fn:contains('|이형원|전유신|고병권|이재호|', principal.getUserInfo().getName())}">
        <td colspan="24">{{isEmptyData}}</td>
    </c:when>
    <c:otherwise>
        <td colspan="23">{{isEmptyData}}</td>
    </c:otherwise>
</c:choose>
    </tr>
    {{/each}}
</script>

<script type="text/x-handlebars-template" id="tmp_layer_detail">
    <form id="exchangeForm">
        <input type="hidden" name="idx" value="{{detail.idx}}" />
        <div class="modal-dialog" style="{{#if parentInfo.parents_name}}{{/if}}width:900px; {{^if parentInfo.parents_name}}width:750px{{/if}}">
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
                                <colgroup>
                                    <col width="13%">
                                    <col width="31%">
                                    <col width="13%">
                                    <col width="47%">
                                </colgroup>
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
                                        </td>
                                        <th>주민번호</th>
                                        <td>
                                            <input type="text" class="form-control" id="social_no" name="social_no" maxlength="13" value="{{detail.social_no}}" />
                                            <br />
                                            [{{convertJumin detail.social_no}}]
                                        </td>
                                    </tr>

                                    <tr>
                                        <th>세금신고<br />대상자</th>
                                        <td>
                                            {{#equal detail.prevAccountName ''}}
                                                <span class="_fontColor" data-fontcolor="red">이전 환전승인내역이 없습니다.</span>
                                            {{/equal}}
                                            {{detail.prevAccountName}}
                                        </td>
                                        <th>세금신고<br />주민번호</th>
                                        <td>
                                            {{convertJumin detail.prevSocialNo}}
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
                                        <td>
                                            <input type="hidden" name="phone_no" value="{{phoneNumHyphen detail.phone_no}}" />
                                            {{phoneNumHyphen detail.phone_no}}
                                            / {{phoneNumHyphen detail.mem_phone}}
                                        </td>
                                        <th>수정일자</th>
                                        <td>{{detail.last_upd_date}} ({{detail.op_name}})</td>
                                    </tr>

                                    <tr>
                                        <th>
                                            접수서류<br/>
                                            <button type="button" class="btn btn-success btn-xm" onclick="imageUpload();">저장완료</button>
                                        </th>
                                        <td colspan="3">
                                            <div class="col-lg-4" style="border:solid 1px black">
                                                <a href="javascript://">
                                                    <img class="_fullWidth _openImagePop thumbnail" src="{{renderImage detail.add_file1}}" style="width:170px;height:116px;" />
                                                </a>
                                                <input id="files1" type="file" onchange="photoSubmit($(this))">
                                                <input type="hidden" class="_hidden_filename" name="add_file1" id="add_file1" value="{{detail.add_file1}}" />
                                            </div>
                                            <div class="col-lg-4" style="border:solid 1px black">
                                                <a href="javascript://">
                                                    <img class="_fullWidth _openImagePop thumbnail"  src="{{renderImage detail.add_file2}}" style="width:170px;height:116px;"/>
                                                </a>
                                                <input id="files2" type="file" onchange="photoSubmit($(this))"/>
                                                <input type="hidden" class="_hidden_filename" name="add_file2" id="add_file2" value="{{detail.add_file2}}" />
                                            </div>
                                            <div class="col-lg-4" style="border:solid 1px black">
                                                <a href="javascript://">
                                                    <img class="_fullWidth _openImagePop thumbnail"  src="{{renderImage detail.add_file3}}" style="width:170px;height:116px;" />
                                                </a>
                                                <input id="files3" type="file" onchange="photoSubmit($(this))"/>
                                                <input type="hidden" class="_hidden_filename" name="add_file3" id="add_file3" value="{{detail.add_file3}}" />
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
                                            {{#dalbit_if detail.op_date '==' ''}}
                                                -
                                            {{else}}

                                                {{detail.op_date}}
                                            <%--    <div class="no-padding" id="div_opDate">
                                                    <div class="input-group date" id="opDate">
                                                        <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                                                        <input type="text" class="form-control" id="txt_opDate" style="width:83px; height:35px;">
                                                    </div>
                                                    {{{getCommonCodeSelect 00 'timeHour'}}}
                                                    <span> : </span>
                                                    {{{getCommonCodeSelect 00 'timeMinute'}}}
                                                    <button type="button" class="btn btn-danger btn-xm pull-right mt5" onclick="opDateUpdate($(this));" data-idx="{{detail.idx}}" data-regdate="{{detail.reg_date}}">변경</button>
                                                </div>--%>
                                            {{/dalbit_if}}
                                        </td>
                                    </tr>

                                    <tr>
                                        <th>
                                            미처리 사유
                                        </th>
                                        <td colspan="3">
                                            <input type="hidden" id="send_title" name="send_title">
                                            {{{getCommonCodeSelect detail.send_type 'exchange_cancel_type'}}} <label id="label_send_title">{{detail.send_title}}</label>
                                            <p class="no-margin no-padding" style="font-size:0.9em; color:red;">* 사유 선택 후 취소 처리 시 회원에게 푸시 메시지, SMS로 발송됩니다</p>
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
                            <button type="button" class="btn btn-danger _rejectBtn"><i class="fa fa-times-circle"></i> 취소</button>
                            <button type="button" class="btn btn-success _completeBtn"><i class="fa fa-check-circle"></i> 완료</button>
                        {{else}}
                            <span class="exchange_complete_txt">법정대리인 보호자 정보동의 철회로 처리 할 수 없습니다.</span>
                        {{/adultStatusCheck}}
                    {{/equal}}

                    {{#equal detail.state '1'}}
                        <span class="exchange_complete_txt">완료되었습니다.</span>
                    {{/equal}}

                    {{#equal detail.state '2'}}
                        <span class="exchange_reject_txt">취소처리 되었습니다.</span>
                    {{/equal}}

                </div>
            </div>
        </div>
    </form>
</script>

<!-- 환전신청 가능회원 -->
<script type="text/x-handlebars-template" id="tmp_enableSummary">
    <div class="col-lg-12 no-padding" style="height: 75px;">
        <table class="table table-bordered table-summary pull-right no-margin _tableHeight" data-height="24" style="font:message-box;">
            <colgroup>
                <col width="25%"/><col width="28%"/><col width="12%"/><col width="15%"/><col width="20%"/>
            </colgroup>
            <tr>
                <th colspan="5" class="_bgColor _fontColor" data-bgcolor="black" data-fontcolor="white">환전 신청 가능 (570별) 이상 회원 중</th>
            </tr>
            <tr>
                <th colspan="2">구분</th>
                <th>회원 수</th>
                <th>요청 가능 별</th>
                <th>환전 가능 금액</th>
            </tr>
            <tr>
                <th colspan="2" class="_bgColor" data-bgcolor="#fbe5d6">1회도 신청하지 않은 회원</th>
                <td>{{addComma content.notExchangeMemberCnt}} 명</td>
                <td>{{addComma content.notExchangeMemberByeol}} 별</td>
                <td>{{addComma content.notExchangeMemberAmt}} 원</td>
            </tr>
            <tr>
                <th rowspan="2" class="_bgColor" data-bgcolor="#e2f0d9">1회 이상 환전 신청 회원 중</th>
                <th class="_bgColor" data-bgcolor="#e2f0d9">3개월 내 환전 한 회원 잔여</th>
                <td>{{addComma content.month3ExchangeMemberCnt}} 명</td>
                <td>{{addComma content.month3ExchangeMemberByeol}} 별</td>
                <td>{{addComma content.month3ExchangeMemberAmt}} 원</td>
            </tr>
            <tr>
                <th class="_bgColor" data-bgcolor="#e2f0d9">3개월 이상 환전하지 않은 회원</th>
                <td>{{addComma content.monthNot3ExchangeMemberCnt}} 명</td>
                <td>{{addComma content.monthNot3ExchangeMemberByeol}} 별</td>
                <td>{{addComma content.monthNot3ExchangeMemberAmt}} 원</td>
            </tr>
            <tr>
                <th colspan="2">총계</th>
                <td class="_fontColor font-bold" data-fontcolor="#ff6600">{{addComma content.exchangeTotal}} 명</td>
                <td class="_fontColor font-bold" data-fontcolor="#ff6600">{{addComma content.exchangeByeolTotal}} 별</td>
                <td class="_fontColor font-bold" data-fontcolor="#ff6600">{{addComma content.exchangeAmtTotal}} 원</td>
            </tr>
        </table>
    </div>
</script>

<script type="text/x-handlebars-template" id="tmp_enableTable">
    <table id="list_info" class="table table-sorting table-hover table-bordered">
        <colgroup>
            <col width="5%"/><col width="5%"/><col width="8.1%"/><col width="8.1%"/><col width="8.1%"/>
            <col width="8.1%"/><col width="8.1%"/><col width="8.1%"/><col width="8.1%"/><col width="8.1%"/>
            <col width="8.1%"/><col width="8.1%"/><col width="8.1%"/>
        </colgroup>

        <thead id="tableTop">
        <tr>
            <th>No</th>
            <th>상태</th>
            <th>회원정보</th>
            <th>성별</th>
            <th>최근 완료 환전일시</th>
            <th>최근 환전 별 수</th>
            <th>최근 환전 수령금액</th>
            <th>환전 누적금액</th>
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
            <td><a href="javascript://" class="_openMemberPop" data-memno="{{data.mem_no}}">{{data.mem_no}}</a> <br/> {{data.mem_nick}}</td>
            <td>{{{sexIcon data.mem_sex data.mem_birth_year}}}</td>
            <td>{{data.op_date}}</td>
            <td>{{#dalbit_if data.byeol '!=' 0}} {{addComma data.byeol}} {{/dalbit_if}}</td>
            <td>{{#dalbit_if data.cash_real '!=' 0}} {{addComma data.cash_real}} {{/dalbit_if}}</td>
            <td>{{#dalbit_if data.totalCashReal '!=' 0}} {{addComma data.totalCashReal}}원 {{/dalbit_if}}</td>
            <td>{{addComma data.gold}}별</td>
            <td>{{math data.gold "*" 60}}원</td>
            <td>{{specialBenefit data.gold data.specialCnt}}원</td>
            <td>{{exchangeAmt data.gold data.specialCnt}}원</td>
            <td>
                {{#dalbit_if data.exchangeCnt '!=' 0}}
                    <a href="javascript://" class="_openMemberPop" data-memno="{{data.mem_no}}" data-tabid="tab_exchangeDetail">{{addComma data.exchangeCnt}}번</a>
                {{else}}
                    {{addComma data.exchangeCnt}}번
                {{/dalbit_if}}
            </td>
        </tr>

    {{else}}
        <tr>
            <td colspan="12">{{isEmptyData}}</td>
        </tr>
    {{/each}}
</script>

<!-- 취소목록 -->
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