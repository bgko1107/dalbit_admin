<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="dummyData"><%= java.lang.Math.round(java.lang.Math.random() * 1000000) %></c:set>

<%
    String in_tabType = request.getParameter("tabType");
%>

<div id="wrapper">
    <div id="page-wrapper" class="col-lg-6 no-padding">
        <div class="container-fluid">
            <form id="searchForm">
                <div class="row form-inline">
                    <div class="widget widget-table searchBoxArea">
                        <table>
                            <tr>
                                <th rowspan="2" style="background-color:#4472c4;color:#e9ee17;width: 70px">
                                    <i class="fa fa-search"></i><br/>검색
                                </th>
                                <th id="th_bottonList">
                                    <jsp:include page="../../../searchArea/daySearchFunction.jsp"/>
                                    <div>
                                        <div id="div_dayButton" style="display: none"><jsp:include page="../../../searchArea/daySearchArea.jsp"/></div>
                                        <div id="div_monthButton" ><jsp:include page="../../../searchArea/monthSearchArea.jsp"/></div>
                                    </div>
                                </th>
                            </tr>
                            <tr>
                                <td style="text-align: left">
                                    <jsp:include page="../../../searchArea/dateRangeSearchArea.jsp"/>

                                    <input type="text" class="form-control" id="onedayDate" name="onedayDate" style="display: none">

                                    <input id="monthDate" type="text" class="form-control" style="width: 196px;"/>

                                    <input class="hide" name="startDate" id="startDate" style="width: 100px">
                                    <input class="hide" name="endDate" id="endDate" style="width: 100px">
                                    <%--<input name="startDate" id="startDate" style="width: 100px">--%>
                                    <%--<input name="endDate" id="endDate" style="width: 100px">--%>
                                    <span id="searchMemberArea" onchange="getUserInfo();" style="display: none"></span>
                                    <label><input type="text" class="form-control" name="searchText" id="searchText" placeholder="검색어를 입력해주세요." style="display: none"></label>

                                    <button type="button" class="btn btn-success" id="bt_search">검색</button>
                                    <a href="javascript://" class="_prevSearch">[이전]</a>
                                    <a href="javascript://" class="_todaySearch">[오늘]</a>
                                    <a href="javascript://" class="_nextSearch">[다음]</a>

                                    <%--<span id="searchCheck" style="display: none">--%>
                                        <%--<label class="control-inline fancy-checkbox custom-color-green">--%>
                                            <%--<input type="checkbox" name="search_testId" id="search_testId" value="1" checked="true">--%>
                                            <%--<span>테스트 아이디 제외</span>--%>
                                        <%--</label>--%>

                                        <%--<label class="control-inline fancy-checkbox custom-color-green">--%>
                                            <%--<input type="checkbox" name="search_joinPath" id="search_joinPath" value="1">--%>
                                            <%--<span>광고유입</span>--%>
                                        <%--</label>--%>
                                    <%--</span>--%>
                                </td>
                            </tr>
                        </table>
                    </div>
                </div>
            </form>
        </div>
    </div>

    <div class="col-lg-6" id="stateSummary">
        <span id="summary"></span>
    </div>

    <div class="col-lg-6" id="joinListSummary" style="display: none">
        <span id="joinList_summaryArea"></span>
    </div>

    <div class="col-lg-6" id="dormancySummary" style="display: none">
        <span id="dormancyList_summaryArea"></span>
    </div>

    <!-- tab -->
    <div class="no-padding" id="infoTab">
        <jsp:include page="infoTab.jsp"/>
    </div>
    <!-- //tab -->
</div>

<script type="text/javascript" src="/js/code/enter/joinCodeList.js?${dummyData}"></script>
<script type="text/javascript" src="/js/util/statUtil.js?${dummyData}"></script>
<script type="text/javascript" src="/js/handlebars/statusHelper.js?${dummyData}"></script>

<script type="text/javascript">

    // setTimeDate(dateTime);

    var slctType = 1;

    var tabType = <%=in_tabType%>;

    $(function(){
        $("#searchMemberArea").html(util.getCommonCodeSelect(1, searchMember));

        setDayButton();
    });

    function setRangeDate(displayDate, startDate, endDate){
        $("#onedayDate").val(startDate);
        $("#startDate").val(startDate);
        $("#endDate").val(endDate);
        $("#displayDate").val(startDate.substr(0,7));
        $("#yearDate").val(startDate.substr(0,4));
    }

    function setSummary(response){
        $("#stateSummary").show();
        $("#joinListSummary").hide();
        $("#dormancySummary").hide();

        response.totalInfo.accum_total_join_cnt = accum_total_join_cnt;
        response.totalInfo.accum_total_out_cnt = accum_total_out_cnt;
        response.totalInfo.accum_total_join_before_cnt = accum_total_join_before_cnt;
        response.totalInfo.accum_total_out_before_cnt = accum_total_out_before_cnt;


        response.totalInfo.sum_total_out_cnt = response.totalInfo.sum_pc_total_out_cnt + response.totalInfo.sum_aos_total_out_cnt + response.totalInfo.sum_ios_total_out_cnt;
        response.totalInfo2.sum_total_out_cnt = response.totalInfo2.sum_pc_total_out_cnt + response.totalInfo2.sum_aos_total_out_cnt + response.totalInfo2.sum_ios_total_out_cnt;

        response.totalInfo.sum_inc_total_cnt = response.totalInfo.sum_total_join_cnt - response.totalInfo2.sum_total_join_cnt;
        response.totalInfo.sum_inc_out_total_cnt = response.totalInfo.sum_total_out_cnt - response.totalInfo2.sum_total_out_cnt;

        response.totalInfo.sum_inc_sleep_cnt = response.totalInfo.sum_sleep_cnt - response.totalInfo2.sum_sleep_cnt;
        response.totalInfo.sum_inc_return_cnt = response.totalInfo.sum_return_cnt - response.totalInfo2.sum_return_cnt;

        var template = $('#tmp_summary').html();
        var templateScript = Handlebars.compile(template);
        var context = response.totalInfo;
        var html=templateScript(context);
        $("#summary").html(html);

        ui.tableHeightSet();
        ui.paintColor();
    }

    function withdrawalListSummary(json){
        $("#stateSummary").hide();
        $("#joinListSummary").show();
        $("#dormancySummary").hide();
        var template = $("#joinList_tableSummary").html();
        var templateScript = Handlebars.compile(template);
        var data = {
            content : json.summary
            , length : json.recordsTotal
        }
        var html = templateScript(data);
        $("#joinList_summaryArea").html(html);

        ui.tableHeightSet();
        ui.paintColor();
    }

    function dormancyListSummary(json){
        $("#stateSummary").hide();
        $("#joinListSummary").hide();
        $("#dormancySummary").show();
        var template = $("#dormancyList_tableSummary").html();
        var templateScript = Handlebars.compile(template);
        var content = json.summary;
        var html = templateScript(content);
        $("#dormancyList_summaryArea").html(html);

        ui.tableHeightSet();
        ui.paintColor();
    }
</script>

<script type="text/x-handlebars-template" id="tmp_summary">
    <table class="table table-bordered _tableHeight no-margin" data-height="23px">
        <colgroup>
            <col width="8.3%"/><col width="8.3%"/><col width="8.3%"/><col width="8.3%"/><col width="8.3%"/>
            <col width="8.3%"/><col width="8.3%"/><col width="10%"/><col width="10%"/><col width="10%"/>
        </colgroup>

        <tr>
            <th colspan="3" class="_bgColor" data-bgColor="#b3c7e7">성별</th>
            <th colspan="3" class="_bgColor" data-bgColor="#f8cbaa">플랫폼별</th>
            <th colspan="4" class="_bgColor" data-bgColor="#bfbfbf">총합</th>
        </tr>
        <tr>
            <th class="_bgColor" data-bgColor="#dbe2f4">{{{sexIcon 'm'}}}</th>
            <th class="_bgColor" data-bgColor="#dbe2f4">{{{sexIcon 'f'}}}</th>
            <th class="_bgColor" data-bgColor="#dbe2f4">{{{sexIcon 'n'}}}</th>
            <th class="_bgColor" data-bgColor="#fde6d8">AOS</th>
            <th class="_bgColor" data-bgColor="#fde6d8">IOS</th>
            <th class="_bgColor" data-bgColor="#fde6d8">PC</th>
            <th class="_bgColor" data-bgColor="#ffe699">가입</th>
            <th class="_bgColor" data-bgColor="#f2f2f2">탈퇴<br/>(자동)</th>
            <th class="_bgColor" data-bgColor="#c5e0b4">휴면</th>
            <th class="_bgColor" data-bgColor="#f2f2f2">해제</th>
        </tr>
        <tr>
            <td rowspan="2">{{sum_total_out_mcnt}}<br/>({{average  sum_total_out_mcnt sum_total_out_cnt}}%)</td>
            <td rowspan="2">{{sum_total_out_fcnt}}<br/>({{average  sum_total_out_fcnt sum_total_out_cnt}}%)</td>
            <td rowspan="2">{{sum_total_out_ncnt}}<br/>({{average  sum_total_out_ncnt sum_total_out_cnt}}%)</td>
            <td rowspan="2">{{sum_aos_total_out_cnt}}<br/>({{average  sum_aos_total_out_cnt sum_total_out_cnt}}%)</td>
            <td rowspan="2">{{sum_ios_total_out_cnt}}<br/>({{average  sum_ios_total_out_cnt sum_total_out_cnt}}%)</td>
            <td rowspan="2">{{sum_pc_total_out_cnt}}<br/>({{average sum_pc_total_out_cnt sum_total_out_cnt}}%)</td>
            <td class="{{upAndDownClass sum_inc_total_cnt}}"><span style="color: #555555">{{sum_total_join_cnt}}</span> <br/> (<i class="fa {{upAndDownIcon sum_inc_total_cnt}}"></i> <span>{{addComma sum_inc_total_cnt}}</span>)</td>
            <td class="{{upAndDownClass sum_inc_out_total_cnt}}">
                <span style="color: #555555">{{sum_total_out_cnt}}</span> (<i class="fa {{upAndDownIcon sum_inc_out_total_cnt}}"></i> <span>{{addComma sum_inc_out_total_cnt}}</span>)<br/>
                <span style="color: #555555">({{addComma sum_auto_out_cnt}})</span>
            </td>
            <td class="{{upAndDownClass sum_inc_sleep_cnt}}">
                <span style="color: #555555">{{addComma sum_sleep_cnt}}</span> (<i class="fa {{upAndDownIcon sum_inc_sleep_cnt}}"></i> <span>{{addComma sum_inc_sleep_cnt}}</span>)
            </td>
            <td class="{{upAndDownClass sum_inc_return_cnt}}">
                <span style="color: #555555">{{addComma sum_return_cnt}}</span> (<i class="fa {{upAndDownIcon sum_inc_return_cnt}}"></i> <span>{{addComma sum_inc_return_cnt}}</span>)
            </td>
        </tr>
        <tr>
            <th class="_bgColor" data-bgColor="#ffe699">가입 대비<br/>탈퇴 비율</th>
            <td>{{average sum_total_out_cnt sum_total_join_cnt}}%</td>
            <th class="_bgColor" data-bgColor="#c5e0b4">휴변 대비<br/>해제 비율</th>
            <td>{{average sum_return_cnt sum_sleep_cnt}}%</td>
        </tr>
    </table>
    <span class="_fontColor pull-right" data-fontColor="red">＊ 자동이란? 장기 미접속 회원에 대한 자동탈퇴 회원</span>
</script>

<script id="joinList_tableSummary" type="text/x-handlebars-template">
    <table class="table table-bordered _tableHeight no-margin" data-height="23px">
        <colgroup>
            <col width="8.3%"/><col width="8.3%"/><col width="8.3%"/><col width="8.3%"/><col width="8.3%"/>
            <col width="8.3%"/><col width="8.3%"/><col width="8.3%"/>
        </colgroup>

        <colgroup>
            <col width="8.3%"/><col width="8.3%"/><col width="8.3%"/><col width="8.3%"/><col width="8.3%"/>
            <col width="8.3%"/><col width="8.3%"/><col width="10%"/><col width="10%"/>
        </colgroup>

        <tr>
            <th colspan="3" class="_bgColor" data-bgColor="#b3c7e7">성별</th>
            <th colspan="3" class="_bgColor" data-bgColor="#f8cbaa">플랫폼별</th>
            <th class="_bgColor" data-bgColor="#bfbfbf">총합</th>
        </tr>
        <tr>
            <th class="_bgColor" data-bgColor="#dbe2f4">{{{sexIcon 'm'}}}</th>
            <th class="_bgColor" data-bgColor="#dbe2f4">{{{sexIcon 'f'}}}</th>
            <th class="_bgColor" data-bgColor="#dbe2f4">{{{sexIcon 'n'}}}</th>
            <th class="_bgColor" data-bgColor="#fde6d8">AOS</th>
            <th class="_bgColor" data-bgColor="#fde6d8">IOS</th>
            <th class="_bgColor" data-bgColor="#fde6d8">PC</th>
            <th class="_bgColor" data-bgColor="#f2f2f2">탈퇴</th>
        </tr>
        <tr>
            <td>{{content.maleCnt}}<br/>({{average content.maleCnt content.allCnt}}%)</td>
            <td>{{content.femaleCnt}}<br/>({{average content.femaleCnt content.allCnt}}%)</td>
            <td>{{content.noneCnt}}<br/>({{average content.noneCnt content.allCnt}}%)</td>
            <td>{{content.aosCnt}}<br/>({{average content.aosCnt content.allCnt}}%)</td>
            <td>{{content.iosCnt}}<br/>({{average content.iosCnt content.allCnt}}%)</td>
            <td>{{content.pcCnt}}<br/>({{average content.pcCnt content.allCnt}}%)</td>
            <td>{{content.allCnt}}</td>
        </tr>
    </table>
</script>


<script type="text/x-handlebars-template" id="dormancyList_tableSummary">
    <table class="table table-bordered _tableHeight no-margin" data-height="23px">
        <colgroup>
            <col width="8.3%"/><col width="8.3%"/><col width="8.3%"/><col width="8.3%"/><col width="8.3%"/>
            <col width="8.3%"/><col width="8.3%"/><col width="10%"/><col width="10%"/><col width="10%"/>
        </colgroup>

        <tr>
            <th colspan="3" class="_bgColor" data-bgColor="#b3c7e7">성별</th>
            <th colspan="3" class="_bgColor" data-bgColor="#f8cbaa">플랫폼별</th>
            <th colspan="4" class="_bgColor" data-bgColor="#bfbfbf">총합</th>
        </tr>
        <tr>
            <th class="_bgColor" data-bgColor="#dbe2f4">{{{sexIcon 'm'}}}</th>
            <th class="_bgColor" data-bgColor="#dbe2f4">{{{sexIcon 'f'}}}</th>
            <th class="_bgColor" data-bgColor="#dbe2f4">{{{sexIcon 'n'}}}</th>
            <th class="_bgColor" data-bgColor="#fde6d8">AOS</th>
            <th class="_bgColor" data-bgColor="#fde6d8">IOS</th>
            <th class="_bgColor" data-bgColor="#fde6d8">PC</th>
            <th class="_bgColor" data-bgColor="#ffe699">가입</th>
            <th class="_bgColor" data-bgColor="#f2f2f2">탈퇴<br/>(자동)</th>
            <th class="_bgColor" data-bgColor="#c5e0b4">휴면</th>
            <th class="_bgColor" data-bgColor="#f2f2f2">해제</th>
        </tr>
        <tr>
            <td rowspan="2">{{sum_sleep_mcnt}}<br/>({{average  sum_sleep_mcnt sum_sleep_cnt}}%)</td>
            <td rowspan="2">{{sum_sleep_fcnt}}<br/>({{average  sum_sleep_fcnt sum_sleep_cnt}}%)</td>
            <td rowspan="2">{{sum_sleep_ncnt}}<br/>({{average  sum_sleep_ncnt sum_sleep_cnt}}%)</td>
            <td rowspan="2">{{sum_aos_total_sleep_cnt}}<br/>({{average  sum_aos_total_sleep_cnt sum_sleep_cnt}}%)</td>
            <td rowspan="2">{{sum_ios_total_sleep_cnt}}<br/>({{average  sum_ios_total_sleep_cnt sum_sleep_cnt}}%)</td>
            <td rowspan="2">{{sum_pc_total_sleep_cnt}}<br/>({{average sum_pc_total_sleep_cnt sum_sleep_cnt}}%)</td>
            <td>{{sum_total_join_cnt}}</td>
            <td>{{sum_total_out_cnt}} ({{sum_auto_out_cnt}})</td>
            <td>{{sum_sleep_cnt}}</td>
            <td>{{sum_return_cnt}}</td>
        </tr>
        <tr>
            <th class="_bgColor" data-bgColor="#ffe699">가입 대비<br/>탈퇴 비율</th>
            <td>{{average sum_total_out_cnt sum_total_join_cnt}}%</td>
            <th class="_bgColor" data-bgColor="#c5e0b4">휴변 대비<br/>해제 비율</th>
            <td>{{average sum_return_cnt sum_sleep_cnt}}%</td>
        </tr>
    </table>
    <span class="_fontColor pull-right" data-fontColor="red">＊ 자동이란? 장기 미접속 회원에 대한 자동탈퇴 회원</span>
</script>