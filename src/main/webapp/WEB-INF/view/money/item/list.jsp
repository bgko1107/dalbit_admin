<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="cfn" uri="/WEB-INF/tld/comFunction.tld" %>
<c:set var="dummyData"><%= java.lang.Math.round(java.lang.Math.random() * 1000000) %></c:set>

<div id="wrapper">
    <div id="page-wrapper">
        <div class="container-fluid">
            <!-- serachBox -->
            <form id="searchForm">
                <div class="row col-lg-12 form-inline no-padding">
                    <%--<input type="hidden" name="pageStart" id="pageStart">
                    <input type="hidden" name="pageCnt" id="pageCnt">--%>
                    <div class="widget widget-table searchBoxArea">
                        <div class="widget widget-table searchBoxArea">
                            <table>
                                <tr>
                                    <th style="background-color:#4472c4;color:#e9ee17;width: 70px">
                                        <i class="fa fa-search"></i><br/>검색
                                    </th>
                                    <td style="text-align: left">

                                        <jsp:include page="../../searchArea/dateRangeSearchArea.jsp"/>

                                        <input type="text" class="form-control" id="onedayDate" name="onedayDate">

                                        <input class="hide" name="startDate" id="startDate" style="width: 100px">
                                        <input class="hide" name="endDate" id="endDate" style="width: 100px">
                                        <%--<input name="startDate" id="startDate" style="width: 100px">--%>
                                        <%--<input name="endDate" id="endDate" style="width: 100px">--%>
                                        <label><input type="text" class="form-control" name="searchText" id="searchText" placeholder="검색어를 입력해주세요." style="display: none"></label>

                                        <button type="button" class="btn btn-success" id="bt_search">검색</button>
                                        <a href="javascript://" class="_prevSearch">[이전]</a>
                                        <a href="javascript://" class="_todaySearch">[오늘]</a>
                                        <a href="javascript://" class="_nextSearch">[다음]</a>

                                        <span id="searchCheck">
                                            <label class="control-inline fancy-checkbox custom-color-green">
                                                <input type="checkbox" name="search_testId" id="search_testId" value="1">
                                                <span>테스트 아이디 제외</span>
                                            </label>
                                        </span>
                                    </td>
                                </tr>
                            </table>
                        </div>
                    </div>
                </div>
            </form>
            <!-- //serachBox -->
            <div class="row widget-content col-md-6 no-padding">
                <ul class="nav nav-tabs nav-tabs-custom-colored" role="tablist">
                    <li><a href="/money/resource/info?tabType=0">시간대별</a></li>
                    <li><a href="/money/resource/info?tabType=1">월간별</a></li>
                    <li><a href="/money/resource/info?tabType=2">연간별</a></li>
                    <li><a href="/money/resource/info?tabType=3">회원Data</a></li>
                    <li><a href="/money/resource/info?tabType=4">달 구매내역</a></li>
                    <li><a href="/money/resource/info?tabType=5">달 사용내역</a></li>
                    <li class="active"><a href="#change" >교환내역</a></li>
                    <li><a href="/status/exchange/info" id="tab_exchangeList" title="환전내역으로 이동합니다.">환전내역</a></li>
                </ul>
            </div>
            <div class="col-lg-5 pull-right no-padding" id="div_changeSummary" style="margin-right: 13px;">
                <span id="change_summaryArea"></span>
            </div>
            <div class="col-lg-5 pull-right no-padding" id="div_autoChangeSummary" style="margin-right: 13px;display: none">
                <span id="autoChange_summaryArea"></span>
            </div>
            <div class="tab-content">
                <div class="tab-pane fade in active" id="change" >
                    <div class="row widget-content col-md-6 no-padding mt10">
                        <ul class="nav nav-tabs nav-tabs-custom-colored" role="tablist">
                            <li class="active"><a href="#changeList" role="tab" data-toggle="tab" id="tab_changeList" onclick="tab_changeListClick(this.id)">교환내역</a></li>
                            <%--<li><a href="#changeAuto" role="tab" data-toggle="tab" id="tab_changeAuto" onclick="tab_changeListClick(this.id)"> 자동교환 설정내역</a></li>--%>
                        </ul>
                        <div class="col-md-12 no-padding mt10">
                            <span style="color: red">* 환전 가치금액은 -500원의 수수료를 제외하여 산전된 금액입니다.</span>
                        </div>
                    </div>
                    <div class="tab-content no-padding">
                        <div class="tab-pane fade in active" id="changeList" >
                            <jsp:include page="changeList.jsp"/>
                        </div>
                        <div class="tab-pane fade" id="changeAuto" >
                            <jsp:include page="changeAutoList.jsp"/>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<jsp:include page="../../searchArea/daySearchFunction.jsp"/>

<button class="btn btn-primary btn-lg" data-toggle="modal" data-target="#detailView" id="showModal" style="display:none;">레이어팝업오픈버튼</button>

<div class="modal fade" id="detailView" tabindex="-1" role="dialog" aria-labelledby="detailViewLabel" aria-hidden="true"></div>

<form name="excelForm" id="excelForm"></form>

<script type="text/javascript" src="/js/lib/jquery.table2excel.js"></script>
<script type="text/javascript" src="/js/code/money/exchangeCodeList.js?${dummyData}"></script>
<script type="text/javascript" src="/js/code/member/memberCodeList.js?${dummyData}"></script>
<script type="text/javascript" src="/js/handlebars/moneyHelper.js?${dummyData}"></script>
<script type="text/javascript">
    var changeTabId = "tab_changeList";
    var orderType = 0;
    slctType = 3;
    $(function(){
        dateType(slctType);

        if(changeTabId == "tab_changeList") {
            getList();
        }else{
            getAutoList();
        }
    });

    function getParameter(){
         var data = {
            searchText : $("#searchText").val()
            , searchType : ""
            , innerType : $('input[name="search_testId"]').prop('checked') ? 1 : 0
            , startDate : $("#startDate").val()
            , endDate : $("#endDate").val()
            , orderType : orderType
            , pageNo : itemPagingInfo.pageNo
            , pageCnt : itemPagingInfo.pageCnt
            , autoType : $("#changeAutoSetting").val()
        };

        console.log(data);

        return data;
    }

    function getList(){
        util.getAjaxData("select", "/rest/money/item/list", getParameter(), fn_succ_list);
    }

    function getAutoList(){
        util.getAjaxData("select", "/rest/money/item/autoList", getParameter(), fn_succ_autoList);
    }

    $('#bt_search').on('click', function(){
        if(changeTabId == "tab_changeList") {
            itemPagingInfo.pageNo = 1;
            getList();
        }else{
            autoChangePagingInfo.pageNo = 1;
            getAutoList();
        }
    });

    $('input[id="search_value"]').on('keydown', function(e) {    // textBox 처리
        if(e.keyCode == 13) {
            if(changeTabId == "tab_changeList") {
                itemPagingInfo.pageNo = 1;
                getList();
            }else{
                autoChangePagingInfo.pageNo = 1;
                getAutoList();
            }
        };
    });

    $('._tab').on('click', function(){
        $('._tab').removeClass('active');
        $(this).addClass('active');

        if(changeTabId == "tab_changeList") {
            itemPagingInfo.pageNo = 1;
            getList();
        }else{
            autoChangePagingInfo.pageNo = 1;
            getAutoList();
        }
    });

    $('input[name="search_testId"]').on('change', function(){
        if(changeTabId == "tab_changeList") {
            itemPagingInfo.pageNo = 1;
            getList();
        }else{
            autoChangePagingInfo.pageNo = 1;
            getAutoList();
        }
    });

    function tab_changeListClick(tmp){
        changeTabId = tmp;
        if(changeTabId == "tab_changeList"){
            $("#div_changeSummary").show();
            $("#div_autoChangeSummary").hide();
            getList();
        }else if(changeTabId == "tab_changeAuto"){
            $("#div_changeSummary").hide();
            $("#div_autoChangeSummary").show();
            getAutoList();
        }
    }

    function handlebarsPaging(targetId, pagingInfo){
        console.log(" --------------------- ");
        console.log(targetId);
        if(targetId == "list_info_paginate_top" || targetId == "list_info_paginate"){
            itemPagingInfo = pagingInfo;
            getList();
        }else{
            autoChangePagingInfo = pagingInfo;
            getAutoList();
        }
    }


</script>
