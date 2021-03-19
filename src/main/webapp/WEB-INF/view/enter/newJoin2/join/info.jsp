<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="dummyData"><%= java.lang.Math.round(java.lang.Math.random() * 1000000) %></c:set>

<%
    String in_tabType = request.getParameter("tabType");
%>

<div id="wrapper">
    <div id="page-wrapper" class="col-lg-8 no-padding">
        <div class="container-fluid">

            <form id="searchForm">
                <div class="row col-lg-12 no-padding form-inline">
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

                                    <span id="searchCheck" style="display: none">
                                        <label class="control-inline fancy-checkbox custom-color-green">
                                            <input type="checkbox" name="search_testId" id="search_testId" value="1" checked="true">
                                            <span>테스트 아이디 제외</span>
                                        </label>

                                        <label class="control-inline fancy-checkbox custom-color-green">
                                            <input type="checkbox" name="search_joinPath" id="search_joinPath" value="1">
                                            <span>광고유입</span>
                                        </label>
                                    </span>
                                </td>
                            </tr>
                        </table>
                    </div>
                </div>
            </form>
        </div>
    </div>

    <div class="col-lg-4" id="stateSummary">
        <span id="summary"></span>
    </div>

    <div class="col-lg-4" id="joinListSummary" style="display: none">
        <span id="joinList_summaryArea"></span>
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

    var memoIdx;
    var memoDate;

    var slctType = 1;

    var tabType = <%=in_tabType%>;

    $(function(){
        $("#searchMemberArea").html(util.getCommonCodeSelect(1, searchMember));

        setDayButton();

        $('input[id="searchText"]').keydown(function(e) {
            if (e.keyCode === 13) {
                getUserInfo();
            };
        });

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
        response.totalInfo.accum_total_join_cnt = accum_total_join_cnt;
        response.totalInfo.accum_total_out_cnt = accum_total_out_cnt;
        response.totalInfo.accum_total_join_before_cnt = accum_total_join_before_cnt;
        response.totalInfo.accum_total_out_before_cnt = accum_total_out_before_cnt;

        response.totalInfo.sum_total_join_cnt = response.totalInfo.sum_pc_total_join_cnt + response.totalInfo.sum_aos_total_join_cnt + response.totalInfo.sum_ios_total_join_cnt;
        response.totalInfo2.sum_total_join_cnt = response.totalInfo2.sum_pc_total_join_cnt + response.totalInfo2.sum_aos_total_join_cnt + response.totalInfo2.sum_ios_total_join_cnt;

        response.totalInfo.sum_inc_total_cnt = response.totalInfo.accum_total_join_cnt - response.totalInfo.accum_total_join_before_cnt;

        var template = $('#tmp_summary').html();
        var templateScript = Handlebars.compile(template);
        var context = response.totalInfo;
        var html=templateScript(context);
        $("#summary").html(html);

        ui.tableHeightSet();
        ui.paintColor();
    }

    function joinListSummary(json){
        $("#stateSummary").hide();
        $("#joinListSummary").show();
        var template = $("#joinList_tableSummary").html();
        var templateScript = Handlebars.compile(template);
        var data = {
            content : json.summary
            , length : json.recordsTotal
        };
        var html = templateScript(data);
        $("#joinList_summaryArea").html(html);

        ui.tableHeightSet();
        ui.paintColor();
    }
</script>



<script type="text/x-handlebars-template" id="tmp_summary">
    <table class="table table-bordered _tableHeight no-margin" data-height="23px">
        <colgroup>
            <col width="8.3%"/><col width="8.3%"/><col width="8.3%"/><col width="8.3%"/><col width="8.3%"/>
            <col width="8.3%"/><col width="8.3%"/><col width="8.3%"/>
        </colgroup>
        <tr>
            <th rowspan="2" class="_bgColor _fontColor" data-bgColor="#b4c7e7">SNS 별</th>
            <th class="_bgColor" data-bgColor="#dae3f3">{{{renderSlct 'p' 15}}}</th>
            <th class="_bgColor" data-bgColor="#dae3f3">{{{renderSlct 'k' 17}}}</th>
            <th class="_bgColor" data-bgColor="#dae3f3">{{{renderSlct 'n' 18}}}</th>
            <th class="_bgColor" data-bgColor="#dae3f3">{{{renderSlct 'f' 18}}}</th>
            <th class="_bgColor" data-bgColor="#dae3f3">{{{renderSlct 'i' 18}}}</th>
            <th class="_bgColor" data-bgColor="#dae3f3">{{{renderSlct 'g' 15}}}</th>
            <th rowspan="3" class="_bgColor _fontColor" data-bgColor="#d9d9d9">총 가입 수</th>
        </tr>
        <tr>
            <td>{{addComma sum_phone_join_cnt}}<br/>({{average sum_phone_join_cnt sum_total_join_cnt}}%)</td>
            <td>{{addComma sum_kakao_join_cnt}}<br/>({{average sum_kakao_join_cnt sum_total_join_cnt}}%)</td>
            <td>{{addComma sum_naver_join_cnt}}<br/>({{average sum_naver_join_cnt sum_total_join_cnt}}%)</td>
            <td>{{addComma sum_fbook_join_cnt}}<br/>({{average sum_fbook_join_cnt sum_total_join_cnt}}%)</td>
            <td>{{addComma sum_apple_join_cnt}}<br/>({{average sum_apple_join_cnt sum_total_join_cnt}}%)</td>
            <td>{{addComma sum_google_join_cnt}}<br/>({{average sum_google_join_cnt sum_total_join_cnt}}%)</td>
        </tr>
        <tr>
            <th rowspan="2" class="_bgColor _fontColor" data-bgColor="#f8cbad">플랫폼 별</th>
            <th colspan="2" class="_bgColor" data-bgColor="#fbe5d6">AOS</th>
            <th colspan="2" class="_bgColor" data-bgColor="#fbe5d6">IOS</th>
            <th colspan="2" class="_bgColor" data-bgColor="#fbe5d6">PC</th>
        </tr>
        <tr>
            <td colspan="2">{{addComma sum_aos_total_join_cnt}}<br/>({{average sum_aos_total_join_cnt sum_total_join_cnt}}%)</td>
            <td colspan="2">{{addComma sum_ios_total_join_cnt}}<br/>({{average sum_ios_total_join_cnt sum_total_join_cnt}}%)</td>
            <td colspan="2">{{addComma sum_pc_total_join_cnt}}<br/>({{average sum_pc_total_join_cnt sum_total_join_cnt}}%)</td>
            <td class="{{upAndDownClass sum_inc_total_cnt}}"><span style="color: #555555">{{addComma sum_total_join_cnt}}</span> <br/> (<i class="fa {{upAndDownIcon sum_inc_total_cnt}}"></i> <span>{{addComma sum_inc_total_cnt}}</span>)</td>
        </tr>
    </table>
</script>



<script id="joinList_tableSummary" type="text/x-handlebars-template">
    <table class="table table-bordered _tableHeight no-margin" data-height="23px">
        <colgroup>
            <col width="8.3%"/><col width="8.3%"/><col width="8.3%"/><col width="8.3%"/><col width="8.3%"/>
            <col width="8.3%"/><col width="8.3%"/><col width="8.3%"/>
        </colgroup>
        <tr>
            <th rowspan="2" class="_bgColor _fontColor" data-bgColor="#b4c7e7">SNS 별</th>
            <th class="_bgColor" data-bgColor="#dae3f3">{{{renderSlct 'p' 15}}}</th>
            <th class="_bgColor" data-bgColor="#dae3f3">{{{renderSlct 'k' 17}}}</th>
            <th class="_bgColor" data-bgColor="#dae3f3">{{{renderSlct 'n' 18}}}</th>
            <th class="_bgColor" data-bgColor="#dae3f3">{{{renderSlct 'f' 18}}}</th>
            <th class="_bgColor" data-bgColor="#dae3f3">{{{renderSlct 'i' 18}}}</th>
            <th class="_bgColor" data-bgColor="#dae3f3">{{{renderSlct 'g' 15}}}</th>
            <th rowspan="3" class="_bgColor _fontColor" data-bgColor="#d9d9d9">총 가입 수</th>
        </tr>
        <tr>
            <td>{{addComma content.slctPhonCnt}}<br/>({{average content.slctPhonCnt content.allCnt}}%)</td>
            <td>{{addComma content.slctFaceCnt}}<br/>({{average content.slctFaceCnt content.allCnt}}%)</td>
            <td>{{addComma content.slctGoogleCnt}}<br/>({{average content.slctGoogleCnt content.allCnt}}%)</td>
            <td>{{addComma content.slctKakaoCnt}}<br/>({{average content.slctKakaoCnt content.allCnt}}%)</td>
            <td>{{addComma content.slctNaverCnt}}<br/>({{average content.slctNaverCnt content.allCnt}}%)</td>
            <td>{{addComma content.slctAppleCnt}}<br/>({{average content.slctAppleCnt content.allCnt}}%)</td>
        </tr>
        <tr>
            <th rowspan="2" class="_bgColor _fontColor" data-bgColor="#f8cbad">플랫폼 별</th>
            <th colspan="2" class="_bgColor" data-bgColor="#fbe5d6">AOS</th>
            <th colspan="2" class="_bgColor" data-bgColor="#fbe5d6">IOS</th>
            <th colspan="2" class="_bgColor" data-bgColor="#fbe5d6">PC</th>
        </tr>
        <tr>
            <td colspan="2">{{addComma content.aosCnt}}<br/>({{average content.aosCnt content.allCnt}}%)</td>
            <td colspan="2">{{addComma content.iosCnt}}<br/>({{average content.iosCnt content.allCnt}}%)</td>
            <td colspan="2">{{addComma content.pcCnt}}<br/>({{average content.pcCnt content.allCnt}}%)</td>
            <td>{{addComma content.allCnt}}</td>
        </tr>
    </table>
</script>