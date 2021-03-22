<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="dummyData"><%= java.lang.Math.round(java.lang.Math.random() * 1000000) %></c:set>

<div id="wrapper">
    <div id="page-wrapper">
        <div id="container-fluid">
            <h3>log - 회원 로그인이력</h3>
            <!-- searchBox -->
            <form id="searchForm">
                <div class="row col-lg-12 form-inline">
                    <div class="widget widget-table searchBoxArea">
                        <div class="widget-header searchBoxRow">
                            <h3 class="title"><i class="fa fa-search"></i> 검색조건</h3>

                            <span id="searchFormRadio"></span>

                            <div class="input-group date" id="rangeDatepicker">
                                <label for="displayDate" class="input-group-addon">
                                    <span><i class="fa fa-calendar"></i></span>
                                </label>
                                <input type="text" name="displayDate" id="displayDate" class="form-control" />
                            </div>

                            <input type="hidden" name="txt_startSel" id="txt_startSel">
                            <input type="hidden" name="txt_endSel" id="txt_endSel" />

                            <%--<input name="txt_startSel" id="txt_startSel">--%>
                            <%--<input name="txt_endSel" id="txt_endSel" />--%>

                            <label><input type="text" class="form-control" id="searchText" name="searchText"></label>
                            <button type="button" class="btn btn-success" id="bt_search">검색</button>
                            <a href="javascript://" class="_prevSearch">[이전]</a>
                            <a href="javascript://" class="_todaySearch">[오늘]</a>
                            <a href="javascript://" class="_nextSearch">[다음]</a>

                            <input type="hidden" name="pageStart" id="pageStart">
                            <input type="hidden" name="pageCnt" id="pageCnt">

                        </div>
                    </div>
                </div>
            </form>
            <!-- // searchBox -->

            <!-- error log table-->
            <div class="row col-lg-12 form-inline">
                <div class="widget widget-table">
                    <div class="widget-content">
                        <table class="table table-bordered table-summary" id="Summary">
                            <thead>
                            <tr>
                                <th>총 : <span id="total">0</span> 건 </th>
                            </tr>
                            </thead>
                            <tbody id="summaryDataTable">
                            </tbody>
                        </table>
                        <table id="loginHistoryList" class="table table-sorting table-hover table-bordered datatable" style="table-layout: fixed;word-break: break-word;">
                            <colgroup>
                                <col width="2%"/><col width="4%"/><col width="7%"/><col width="4%"/><col width="6%"/><col width="10%"/>
                                <col width="20%"/><col width="4%"/><col width="4%"/><col width="4%"/><col width="4%"/>
                            </colgroup>

                            <thead>
                            <th>번호</th>
                            <th>로그인 일시</th>
                            <th>회원</th>
                            <th>성별</th>
                            <th>ip</th>
                            <th>device uuid</th>
                            <th>device token</th>
                            <th>OS구분</th>
                            <th>브라우저정보</th>
                            <th>앱버전</th>
                            <th>location</th>
                            </thead>
                            <tbody id="tableBody">
                            </tbody>
                        </table>
                    </div>
                </div>
                <div class="dataTables_paginate paging_full_numbers" id="login_list_info_paginate"></div>
            </div>
        </div>
    </div>
</div>

<script type="text/javascript" src="/js/code/member/memberCodeList.js?${dummyData}"></script>
<script type="text/javascript">
    var loginHistoryPagingInfo = new PAGING_INFO(0, 1, 500);

    var dateTime = new Date();
    dateTime = moment(dateTime).format("YYYY.MM.DD");
    setTimeDate(dateTime);

    var sDate;
    var eDate;
    var _searchFormRadio ="";
    $(function(){
        $("#searchFormRadio").html(util.getCommonCodeRadio(2, searchFormRadio));

        $("#displayDate").statsDaterangepicker(
            function(start, end, t1) {
                $("#txt_startSel").val(start.format('YYYY.MM.DD'));
                $("#txt_endSel").val(end.format('YYYY.MM.DD'));
            }
        );
        getLoginHistoryList();
    });

    $(document).on('change', 'input[name="searchFormRadio"]', function(){
        radioChange();
    });

    function radioChange(){
        _searchFormRadio = $('input[name="searchFormRadio"]:checked').val();
        if(_searchFormRadio == 2){
            setTimeDate(dateTime);
        }
        setStartDay();
    }

    $(document).on('click', '._prevSearch', function(){
        searchDate('prev');
    });

    $(document).on('click', '._nextSearch', function(){
        searchDate('next');
    });

    $(document).on('click', '._todaySearch', function(){
        $("input:radio[name='searchFormRadio']:radio[value='2']").prop('checked', true);
        _searchFormRadio = $('input[name="searchFormRadio"]:checked').val();
        setTimeDate(dateTime);
        setStartDay();
    });

    function setTimeDate(dateTime){
        loginHistoryPagingInfo.pageNo = 1;
        $("#txt_startSel").val(dateTime);
        $("#txt_endSel").val(dateTime);
        $("#displayDate").val(dateTime + " - " + dateTime);
    }

    function searchDate(dateType){
        if(dateType == 'prev'){
            setDay(-1);
        }else if(dateType == 'next'){
            setDay(1);
        }
    }

    function setDay(days){
        $("#txt_startSel").val(moment($("#txt_startSel").val()).add('days', days).format('YYYY.MM.DD'));
        $("#txt_endSel").val(moment($("#txt_endSel").val()).add('days', days).format('YYYY.MM.DD'));

        $("#displayDate").val($("#txt_startSel").val() + " - " + $("#txt_endSel").val());

        getLoginHistoryList();
    }
    function setStartDay(){
        var date = new Date();
        $("#txt_endSel").val(dateTime);

        if(_searchFormRadio == 1) {     // 일주일 전
            sDate = new Date(Date.parse(date) - 7 * 1000 * 60 * 60 * 24);           // 일주일 전
            sDate = date.getFullYear() +"."+ common.lpad(sDate.getMonth() + 1,2,"0") +"."+ common.lpad(sDate.getDate()+1,2,"0");      // 일주일전
            $("#txt_startSel").val(sDate);
        }else if(_searchFormRadio == 0) {       // 한달전
            var setMonthDate;
            var cal = common.lpad(date.getMonth(),2,"0") + "." + common.lpad(new Date(date.getFullYear(), date.getMonth(), 0).getDate(),2,"0");

            if(common.lpad(date.getMonth(),2,"0") +"."+ common.lpad(date.getDate(),2,"0") > cal) {
                setMonthDate = cal;
            } else {
                setMonthDate = common.lpad(date.getMonth(),2,"0") +"."+ common.lpad(date.getDate(),2,"0");
            }

            sDate = date.getFullYear() + "." + setMonthDate;
            $('#txt_startSel').val(sDate);
        }
        $("#displayDate").val($("#txt_startSel").val() + " - " + $("#txt_endSel").val());

        getLoginHistoryList();
    }

    $(document).ready(function() {
    });

    function compare() {
        var txt_startSel = $('#txt_startSel').val();
        var txt_startSelArr = txt_startSel.split('.');
        var txt_endSel = $('#txt_endSel').val();
        var txt_endSelArr = txt_endSel.split('.');

        var txt_startSelCompare = new Date(txt_startSelArr[0], parseInt(txt_startSelArr[1])-1, txt_startSelArr[2]);
        var txt_endSelCompare = new Date(txt_endSelArr[0], parseInt(txt_endSelArr[1])-1, txt_endSelArr[2]);

        if(txt_startSelCompare.getTime() > txt_endSelCompare.getTime()) {
            alert('시작날짜와 종료날짜를 확인해주세요');
        }
    }

    $('input[id="searchText"]').keydown(function(e) {
        if (e.keyCode === 13) {
            compare();
            loginHistoryPagingInfo.pageNo = 1;
            getLoginHistoryList();
        };
    });

    $('#bt_search').click( function() {       //검색
        compare();
        loginHistoryPagingInfo.pageNo = 1;
        getLoginHistoryList();
    });

    function getLoginHistoryList(){
        $("#pageStart").val(loginHistoryPagingInfo.pageNo);
        $("#pageCnt").val(loginHistoryPagingInfo.pageCnt);

        var data = {};
        data.txt_startSel = $('#txt_startSel').val();
        data.txt_endSel = $('#txt_startEnd').val();
        data.searchText = $('#searchText').val();
        data.pageStart = $("#pageStart").val();
        data.pageCnt = $("#pageCnt").val();

        util.getAjaxData("errorList", "/rest/member/member/login/history", data, fn_success);
    }

    function fn_success(dst_id, response) {
        var template = $('#tmp_loginHistoryList').html();
        var templateScript = Handlebars.compile(template);
        var context = response.data;
        var html = templateScript(context);

        $("#tableBody").html(html);

        $("#total").html(response.data.loginHistCnt);

        loginHistoryPagingInfo.totalCnt = response.data.loginHistCnt;
        console.log(loginHistoryPagingInfo);
        util.renderPagingNavigation("list_info_paginate", loginHistoryPagingInfo);

        if(response.data.length == 0) {
            $("#list_info_paginate").hide();
        } else {
            $("#list_info_paginate").show();
        }

    }

</script>

<script id="tmp_loginHistoryList" type="text/x-handlebars-template">
    {{#each this.loginHistList}}
    <tr>
        <td>{{indexDesc ../loginHistCnt rowNum}}</td>
        <td>{{last_upd_date}}</td>
        <td>
            {{mem_no}}<br/>
            <a href="javascript://" class="_openMemberPop" data-memNo="{{this.mem_no}}">{{mem_nick}}</a>
        </td>
        <td>{{{sexIcon mem_sex}}}</td>
        <td>{{ip}}</td>
        <td style="text-align:left">{{device_uuid}}</td>
        <td style="text-align:left">{{device_token}}</td>
        <td>{{{getCommonCodeLabel os_type 'loginHistoryOsType'}}}</td>
        <td>{{browser}}</td>
        <td>{{app_version}}</td>
        <td>{{location}}</td>
    </tr>
    {{else}}
    <tr>
        <td colspan="10">{{isEmptyData}}</td>
    </tr>
    {{/each}}
</script>