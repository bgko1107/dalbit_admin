<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="dummyData"><%= java.lang.Math.round(java.lang.Math.random() * 1000000) %></c:set>

<div id="wrapper">
    <div id="page-wrapper">
        <div class="container-fluid">
            <!--가입/탈퇴-->
            <form id="searchForm">
                <div class="row form-inline">
                    <div class="widget widget-table searchBoxArea">
                        <table>
                            <tr>
                                <th rowspan="2" style="background-color:#4472c4;color:#e9ee17;width: 70px">
                                    <i class="fa fa-search"></i><br/>검색
                                    <jsp:include page="../searchArea/daySearchFunction.jsp"/>
                                </th>
                                <th id="th_bottonList">
                                    <div>
                                        <div id="div_dayButton"><jsp:include page="../searchArea/daySearchArea.jsp"/></div>
                                        <div id="div_monthButton" style="display: none"><jsp:include page="../searchArea/monthSearchArea.jsp"/></div>
                                        <div id="div_yearButton" style="display: none"><jsp:include page="../searchArea/yearSearchArea.jsp"/></div>
                                    </div>
                                </th>
                            </tr>
                            <tr>
                                <td style="text-align: left">
                                    <span id="slctTypeArea"></span>

                                    <input id="onedayDate" type="text" class="form-control" >
                                    <input id="monthDate" type="text" class="form-control" style="display: none"/>
                                    <input id="yearDate" type="text" class="form-control" style="display: none"/>

                                    <input class="hide" name="startDate" id="startDate" style="width: 100px">
                                    <input class="hide" name="endDate" id="endDate" style="width: 100px">
                                    <%--<input name="startDate" id="startDate" style="width: 100px">--%>
                                    <%--<input name="endDate" id="endDate" style="width: 100px">--%>

                                    <button type="button" class="btn btn-success" id="bt_search">검색</button>
                                    <a href="javascript://" class="_prevSearch">[이전]</a>
                                    <a href="javascript://" class="_todaySearch">[오늘]</a>
                                    <a href="javascript://" class="_nextSearch">[다음]</a>

                                </td>
                            </tr>
                        </table>

                        <%--<div class="widget-header searchBoxRow">--%>
                            <%--<h3 class="title"><i class="fa fa-search"></i> 검색조건</h3>--%>
                            <%--<div>--%>
                                <%--<span id="slctTypeArea"></span>--%>
                                <%--<div class="input-group date" id="oneDayDatePicker">--%>
                                    <%--<label for="onedayDate" class="input-group-addon">--%>
                                        <%--<span><i class="fa fa-calendar" id="onedayDateBtn"></i></span>--%>
                                    <%--</label>--%>
                                    <%--<input type="text" class="form-control" id="onedayDate" name="onedayDate">--%>
                                <%--</div>--%>

                                <%--<div class="input-group date" id="monthDatepicker" style="display:none;">--%>
                                    <%--<label for="monthDate" class="input-group-addon">--%>
                                        <%--<span><i class="fa fa-calendar"></i></span>--%>
                                    <%--</label>--%>
                                    <%--<input id="monthDate" type="text" class="form-control" style="width: 196px;"/>--%>
                                <%--</div>--%>

                                <%--<div class="input-group date" id="yearDatepicker" style="display:none;">--%>
                                    <%--<label for="yearDate" class="input-group-addon">--%>
                                        <%--<span><i class="fa fa-calendar"></i></span>--%>
                                    <%--</label>--%>
                                    <%--<input id="yearDate" type="text" class="form-control" style="width: 196px;"/>--%>
                                <%--</div>--%>


                                <%--<input type="hidden" name="startDate" id="startDate">--%>
                                <%--<input type="hidden" name="endDate" id="endDate" />--%>

                                <%--&lt;%&ndash;<input name="startDate" id="startDate">&ndash;%&gt;--%>
                                <%--&lt;%&ndash;<input name="endDate" id="endDate" />&ndash;%&gt;--%>
                                <%--<button type="button" class="btn btn-success" id="bt_search">검색</button>--%>
                                <%--<a href="javascript://" class="_prevSearch">[이전]</a>--%>
                                <%--<a href="javascript://" class="_todaySearch">[오늘]</a>--%>
                                <%--<a href="javascript://" class="_nextSearch">[다음]</a>--%>
                            <%--</div>--%>
                        <%--</div>--%>
                    </div>
                </div>
            </form>

            <div class="row">
                <div class="widget widget-table mb10 col-lg-3 no-padding">
                    <div class="widget-header">
                        <h3>
                            <a href="javascript://" onclick="labelClick(0);">
                                <i class="fa fa-bar-chart-o"></i> 가입 / 탈퇴
                            </a>
                        </h3>
                        <h3 class="pull-right">
                            <a href="/enter/newJoin/info" onclick="labelClick(0);">
                                <i class="fa fa-search"></i> 상세보기
                            </a>
                        </h3>
                    </div>
                    <div class="widget-content mt10">
                        <table class="table table-condensed table-dark-header table-bordered">
                            <thead>
                            <tr>
                                <th></th>
                                <th>수치</th>
                                <th>증감</th>
                            </tr>
                            </thead>
                            <tbody id="joinWithdrawal_tableBody">
                            </tbody>
                        </table>
                    </div>
                </div>
                <!--//가입/탈퇴-->

                <!--접속자-->
                <div class="widget widget-table mb10 col-lg-3 no-padding">
                    <div class="widget-header">
                        <h3>
                            <a href="javascript://" onclick="labelClick(1);">
                                <i class="fa fa-bar-chart-o"></i> 접속자 (PV/UV)
                            </a>
                        </h3>
                        <h3 class="pull-right">
                            <a href="/connect/login/info" onclick="labelClick(0);">
                                <i class="fa fa-search"></i> 상세보기
                            </a>
                        </h3>
                    </div>
                    <div class="widget-content mt10">
                        <table class="table table-condensed table-dark-header table-bordered">
                            <thead>
                            <tr>
                                <th></th>
                                <th>수치</th>
                                <th>증감</th>
                            </tr>
                            </thead>
                            <tbody id="login_tableBody">
                            </tbody>
                        </table>
                    </div>
                </div>
                <!--//접속자-->

                <!--방송개설/청취자-->
                <div class="widget widget-table mb10 col-lg-3 no-padding">
                    <div class="widget-header">
                        <h3>
                            <a href="javascript://" onclick="labelClick(2);">
                                <i class="fa fa-bar-chart-o"></i> 방송개설/청취자
                            </a>
                        </h3>
                        <h3 class="pull-right">
                            <a href="/status/newBroadcast/info" onclick="labelClick(0);">
                                <i class="fa fa-search"></i> 상세보기
                            </a>
                        </h3>
                    </div>
                    <div class="widget-content mt10">
                        <table class="table table-condensed table-dark-header table-bordered">
                            <thead>
                            <tr>
                                <th></th>
                                <th>건수</th>
                                <th>증감</th>
                            </tr>
                            </thead>
                            <tbody id="broadcastListener_tableBody">
                            </tbody>
                        </table>
                    </div>
                </div>
                <!--//방송개설/청취자-->

                <!--결제/결제취소/환불/환전-->
                <div class="widget widget-table mb10 col-lg-3 no-padding">
                    <div class="widget-header">
                        <h3>
                            <a href="javascript://" onclick="labelClick(3);">
                                <i class="fa fa-bar-chart-o"></i> 결제/결제 취소/환불/환전
                            </a>
                        </h3>
                        <h3 class="pull-right">
                            <a href="/enter/newPay/info" onclick="labelClick(0);">
                                <i class="fa fa-search"></i> 상세보기
                            </a>
                        </h3>
                    </div>
                    <div class="widget-content mt10">
                        <table class="table table-condensed table-dark-header table-bordered">
                            <thead>
                            <tr>
                                <th></th>
                                <th>건수</th>
                                <th>증감</th>
                                <th>금액</th>
                                <th>증감</th>
                            </tr>
                            </thead>
                            <tbody id="paymentCancel_tableBody">
                            </tbody>
                        </table>
                    </div>
                </div>
                <!--//결제/결제취소/환불/환전-->
            </div>


            <!--방송건수 차트-->
            <div class="widget row">
                <!-- end chart tab nav -->
                <div class="chart-content">
                    <div id='lineArea'></div>
                </div>

                <div class="col-md-12" style="display: none" id="joinChart">
                    <jsp:include page="joinChart.jsp"/>
                </div>
                <div class="col-md-12 " style="display: none" id="loginChart">
                    <jsp:include page="loginChart.jsp"/>
                </div>
                <div class="col-md-12 " style="display: none" id="broadCastChart">
                    <jsp:include page="broadCastChart.jsp"/>
                </div>
                <div class="col-md-12 " style="display: none" id="payChart">
                    <jsp:include page="payChart.jsp"/>
                </div>
            </div>
        </div> <!-- //container-fluid -->
    </div> <!-- //page-wrapper -->
</div> <!-- //wrapper -->

<script src='/js/lib/plotly-latest.min.js'></script>
<script type="text/javascript" src="/js/code/enter/joinCodeList.js?${dummyData}"></script>
<script type="text/javascript" src="/js/handlebars/statusHelper.js?${dummyData}"></script>
<script type="text/javascript" src="/js/util/statUtil.js?${dummyData}"></script>

<script type="text/javascript">
    var dataType = 0;

    $(function(){
        $("#slctTypeArea").append(util.getCommonCodeRadio(0, join_slctType));
        slctType = 0;
        setDayButton();
        searchData("all");

        $("#bt_search").on('click', function(){
            searchData("all");
        });
    });


    $(document).on('change', 'input[name="slctType"]', function(){
        slctType = $('input[name="slctType"]:checked').val()
        dateType();
    });

    var data = {};

    function searchData(tmp){
        // chartParam.slctDate = $("#startDate").val() + ' 23:59:59';
        $("#joinChart").hide();
        $("#loginChart").hide();
        $("#broadCastChart").hide();
        $("#payChart").hide();

        if(dataType == 0) {
            $("#joinChart").show();
        }else if(dataType == 1){
            $("#loginChart").show();
        }else if(dataType == 2){
            $("#broadCastChart").show();
        }else{
            $("#payChart").show();
        }

        data.slctType = $('input[name="slctType"]:checked').val();
        data.startDate = $("#startDate").val();
        data.endDate = $("#endDate").val();

        if(tmp == "all"){
            util.getAjaxData("statJoin", "/rest/mainStatus/new/main/stat/join", data, fn_join_withdrawal_success);
            util.getAjaxData("statLogin", "/rest/mainStatus/new/main/stat/login", data, fn_login_success);
            util.getAjaxData("statBroadCast", "/rest/mainStatus/new/main/stat/broadCast", data, fn_broadcastListener_success);
            util.getAjaxData("statPayInfo", "/rest/mainStatus/new/main/stat/pay", data, fn_paymentCancel_success);
        }else{
            if(dataType == 0){
                // 가입/탈퇴
                util.getAjaxData("statJoin", "/rest/mainStatus/new/main/stat/join", data, fn_join_withdrawal_success);
            }else if(dataType == 1){
                // 접속 자
                util.getAjaxData("statLogin", "/rest/mainStatus/new/main/stat/login", data, fn_login_success);
            }else if(dataType == 2){
                // 방송개설/청취자
                util.getAjaxData("statBroadCast", "/rest/mainStatus/new/main/stat/broadCast", data, fn_broadcastListener_success);
            }else if(dataType == 3){
                // 결제/결제취소/환불/환전
                util.getAjaxData("statPayInfo", "/rest/mainStatus/new/main/stat/pay", data, fn_paymentCancel_success);
            }
        }
    }

    function labelClick(tmp){
        dataType = tmp;
        searchData();
    }

    function fn_join_withdrawal_success(dst_id, response, param){
        $("#joinWithdrawal_tableBody").empty();

        var template = $('#tmp_joinWithdrawal_tableBody').html();
        var templateScript = Handlebars.compile(template);
        var context = response.data;
        var html=templateScript(context);
        $("#joinWithdrawal_tableBody").append(html);
        if(dataType == 0) {
            listSort(dst_id, response, param);
            // 회원가입 플랫폼
            if($('input[name="slctType"]:checked').val() == 1){
                data.slctType = 3;
            }else if($('input[name="slctType"]:checked').val() == 2){
                data.slctType = 4;
            }
            util.getAjaxData("live", "/rest/mainStatus/new/main/stat/join/platform", data, fn_platform_success);
            // util.getAjaxData("platformGenderList", "/rest/enter/join/platform/gender", data, fn_platform_success);

            data.slctType = $('input[name="slctType"]:checked').val();
            // 회원가입 성별, 회원가입 연령
            util.getAjaxData("genderList", "/rest/enter/join/info/gender", data, fn_genderAge_success);
        }

    }

    function fn_login_success(dst_id, response, param){
        $("#login_tableBody").empty();

        var template = $('#tmp_login_tableBody').html();
        var templateScript = Handlebars.compile(template);
        var context = response.data;
        var html=templateScript(context);
        $("#login_tableBody").append(html);
        if(dataType == 1) {
            listSort(dst_id, response, param);
            // 접속 플랫폼
            util.getAjaxData("browser", "/rest/connect/login/info/browser", data, fn_loginBrowser_success);
            // 접속자 성별
            util.getAjaxData("loginTotal", "/rest/mainStatus/new/main/stat/login/total", data, fn_loginTotal_success);
            // 접속자 연령
            util.getAjaxData("loginTotal", "/rest/mainStatus/new/main/stat/login/age", data, fn_loginAge_success);
        }
    }


    function fn_broadcastListener_success(dst_id, response, param){
        $("#broadcastListener_tableBody").empty();
        var template = $('#tmp_broadcastListener_tableBody').html();
        var templateScript = Handlebars.compile(template);
        var context = response.data.totalInfo;
        var html=templateScript(context);
        $("#broadcastListener_tableBody").append(html);
        if(dataType == 2) {
            listSort(dst_id, response, param);
            // 방송 개설 성별, 방송 개설 연령
            // util.getAjaxData("broadcastDj", "/rest/status/broadcast/info/dj", data, fn_broadcastDj_success);

            // 방송개설/청취자 현황 성별/ 비중복 수치
            util.getAjaxData("time", "/rest/status/newBroadcast/info/time", data, fn_listener_success);
        }
    }

    function fn_paymentCancel_success(dst_id, response, param){
        $("#paymentCancel_tableBody").empty();

        var template = $('#tmp_paymentCancel_tableBody').html();
        var templateScript = Handlebars.compile(template);
        var context = response.data;
        var html=templateScript(context);
        $("#paymentCancel_tableBody").append(html);
        if(dataType == 3) {
            listSort(dst_id, response, param);
            // 결제수단
            util.getAjaxData("way", "/rest/enter/pay/way", data, fn_payWay_success);
            // 결제성별, 결제 연령
            util.getAjaxData("age", "/rest/enter/pay/age", data, fn_agePay_success);
            // 결제 취소 수단
        }
    }

    function listSort(dst_id, response, param){
        if($('input[name="slctType"]:checked').val() == 0 || $('input[name="slctType"]:checked').val() == 2) {
            if($('input[name="slctType"]:checked').val() == 0){
                var sortingField = "hour";
            }else{
                if(dataType == 0 || dataType == 2 || dataType == 3) {
                    var sortingField = "monthly";
                }else if(dataType == 1) {
                    var sortingField = "month";
                }
            }
            response.data.detailList.sort(function(a, b) { // 오름차순
                return a[sortingField] - b[sortingField];
            });
            if(dataType == 0) {
                response.data.withdrawDetailList.sort(function(a, b) { // 오름차순
                    return a[sortingField] - b[sortingField];
                });
            }
            if(dataType == 1) {
                response.data.overDetailList.sort(function(a, b) { // 오름차순
                    return a[sortingField] - b[sortingField];
                });
            }
            if(dataType == 2) {
            }
            if(dataType == 3) {
                response.data.detailList2.sort(function(a, b) { // 오름차순
                    return a[sortingField] - b[sortingField];
                });
            }
        }else if($('input[name="slctType"]:checked').val() == 1) {
            response.data.detailList.sort(function(a, b) { // 오름차순
                return a.daily < b.daily ? -1 : a.daily > b.daily ? 1 : 0;
            });
            if(dataType == 0) {
                response.data.withdrawDetailList.sort(function(a, b) { // 오름차순
                    return a.daily < b.daily ? -1 : a.daily > b.daily ? 1 : 0;
                });
            }
            if(dataType == 1) {
                response.data.overDetailList.sort(function(a, b) { // 오름차순
                    return a.daily < b.daily ? -1 : a.daily > b.daily ? 1 : 0;
                });
            }
            if(dataType == 2) {
            }
            if(dataType == 3) {
                response.data.detailList2.sort(function(a, b) { // 오름차순
                    return a.daily < b.daily ? -1 : a.daily > b.daily ? 1 : 0;
                });
            }
        }

        setChart1(dst_id, response.data, param);
    }

    function setChart1(dst_id, response, param){
        var detailData = response;
        var chartData;
        var lineName;
        var barName;
        var lineTitle;
        var barTitle;
        chartData = getChartData(detailData, param);
        if(dataType == 0) {
            lineName = "가입";
            barName = "탈퇴";
            lineTitle = "<b>가입:%{y:,.0f}";
            barTitle = "<b>탈퇴:%{y:,.0f}";
        }else if(dataType == 1) {
            lineName = "UV";
            barName = "PV";
            lineTitle = "<b>UV:%{y:,.0f}";
            barTitle = "<b>PV:%{y:,.0f}";
        }else if(dataType == 2) {
            lineName = "청취자";
            barName = "방송방";
            lineTitle = "<b>청취자:%{y:,.0f}";
            barTitle = "<b>방송방:%{y:,.0f}";
        }else if(dataType == 3) {
            lineName = "결제";
            barName = "환전";
            lineTitle = "<b>%{customdata}";
            barTitle = "<b>%{customdata}";
        }
        /* 라인차트 [start] */

        var trace = {
            x: chartData.x,
            y: chartData.y,
            customdata : chartData.yCnt,
            mode: 'lines',
            name: lineName,
            line: { dash: 'line', width: 4 },
            marker: { },
            hovertemplate: lineTitle,
        };
        //바
        var bar = {
            type: 'bar',
            x: chartData.x,
            y: chartData.bar_y,
            customdata : chartData.bar_yCnt,
            name: barName,
            marker: { color: '#e48701', line: { width: 0 }, },
            hovertemplate: barTitle,
        };
        var data = [trace, bar];
        var layout = {
            xaxis: { range: [0, chartData.dataLength], autorange: false },
            yaxis: { range: [0, chartData.max_y], autorange: false ,tickformat: ',d',},
            legend: { y: 1, y: 1, traceorder: 'reversed',separators : '.,'
                    , font: { size: 13 }
            },
            margin: {
                l: 120,
                r: 50,
                t: 20,
                b: 50,
                pad: 4
            },
            height : 290,

        };
        var config = { responsive: true };
        Plotly.newPlot('lineArea', data, layout, config);
    }

    function getChartData(detailData, param) {
        //x축
        var arrayList_x = [];
        var dataLength = detailData.detailList.length;
        for (var i = 0; i < dataLength; i++) {
            var array = {};
            if($('input[name="slctType"]:checked').val() == 0) {
                array = detailData.detailList[i].hour + '시';
            }else if($('input[name="slctType"]:checked').val() == 1){
                if(dataType == 0 || dataType == 2 || dataType == 3) {
                    array = detailData.detailList[i].daily.split("-")[1] + "월" + detailData.detailList[i].daily.split("-")[2] + "일";
                }else if(dataType == 1) {
                    array = detailData.detailList[i].month + "월" + detailData.detailList[i].day + "일";
                }
            }else if($('input[name="slctType"]:checked').val() == 2){
                if(dataType == 0 || dataType == 2 || dataType == 3) {
                    array = detailData.detailList[i].monthly + "월";
                }else if(dataType == 1) {
                    array = detailData.detailList[i].month + "월";
                }
            }
            arrayList_x.push(array);
        }

        //y축
        var arrayList_y = [];
        var arrayList_yCnt = [];
        var max_y = 10;  //최대값
        for(var i=0 ; i<dataLength; i++) {
            var array = {};
            if(dataType == 0) {
                array = detailData.detailList[i].totalCnt;
            }else if(dataType == 1) {
                array = detailData.overDetailList[i].totalCnt;
            }else if(dataType == 2) {
                array = detailData.detailList[i].listenerCnt;
            }else if(dataType == 3) {
                array = detailData.detailList[i].succAmt;
            }
            arrayList_y.push(array);

            if(dataType == 3) {
                var arrayCnt = {};
                arrayCnt = "결제:" + common.addComma(detailData.detailList[i].succCnt)+ "건 : " + common.vatMinus(detailData.detailList[i].succAmt) + "원<br>"
                      + "증감: " + common.addComma(detailData.detailList[i].inc_succCnt) + "건 : " + common.vatMinus(detailData.detailList[i].inc_succAmt) + "원";
                arrayList_yCnt.push(arrayCnt);
            }
            if(max_y < array){
                max_y = Number(array) + 10;
            }
        }
        // 막대 ----------------
        var arrayBarList_y = [];
        var arrayBarList_yCnt = [];
        var barMax_y = 10;  //최대값

        for (var i = 0; i < dataLength; i++) {
            var array = {};
            if(dataType == 0) {
                array = detailData.withdrawDetailList[i].totalCnt;
            }else if(dataType == 1) {
                array = detailData.detailList[i].totalCnt;
            }else if(dataType == 2) {
                array = detailData.detailList[i].createCnt;
            }else if(dataType == 3) {
                if(!common.isEmpty(detailData.detailList2[i])){
                    array = common.charVatMinus(detailData.detailList2[i].succAmt);
                }else{
                    array = 0;
                }
            }
            if(dataType == 3) {
                var arrayCnt = {};
                if(!common.isEmpty(detailData.detailList2[i])) {
                    arrayCnt = "결제:" + common.addComma(detailData.detailList2[i].succCnt)+ "건 : " + common.vatMinus(detailData.detailList2[i].succAmt) + "원<br>"
                            + "증감: " + common.addComma(detailData.detailList2[i].inc_succCnt) + "건 : " + common.vatMinus(detailData.detailList2[i].inc_succAmt) + "원";
                }else{
                    arrayCnt = "환전:0건/0";
                }
                arrayBarList_yCnt.push(arrayCnt);
            }

            arrayBarList_y.push(array);
            if (barMax_y < array) {
                barMax_y = Number(array) + 10;
            }
        }
        if(barMax_y > max_y){
            max_y = barMax_y;
        }

        var resultData = {
            x : arrayList_x
            , y : arrayList_y
            , yCnt : arrayList_yCnt
            , bar_y : arrayBarList_y
            , bar_yCnt : arrayBarList_yCnt
            , max_y : max_y
            , dataLength : dataLength
        };

        console.log(resultData);
        return resultData;
    }

</script>
<script type="text/x-handlebars-template" id="tmp_joinWithdrawal_tableBody">
    <tr>
        <th>가입</th>
        <td>{{addComma totalInfo.sum_totalCnt}}</td>
        <td class="{{upAndDownClass totalInfo.inc_sum_totalCnt}}"><i class="fa {{upAndDownIcon totalInfo.inc_sum_totalCnt}}"></i> {{addComma totalInfo.inc_sum_totalCnt}}</td>
    </tr>
    <tr>
        <th>탈퇴</th>
        <td>{{addComma withdrawTotalInfo.sum_totalCnt}}</td>
        <td class="{{upAndDownClass withdrawTotalInfo.inc_sum_totalCnt}}"><i class="fa {{upAndDownIcon withdrawTotalInfo.inc_sum_totalCnt}}"></i> {{addComma withdrawTotalInfo.inc_sum_totalCnt}}</td>
    </tr>
</script>

<script type="text/x-handlebars-template" id="tmp_login_tableBody">
    <tr>
        <th>PV</th>
        <td>{{addComma overTotalInfo.sum_totalCnt}}</td>
        <td class="{{upAndDownClass overTotalInfo.inc_sum_totalCnt}}"><i class="fa {{upAndDownIcon overTotalInfo.inc_sum_totalCnt}}"></i> {{addComma overTotalInfo.inc_sum_totalCnt}}</td>
    </tr>
    <tr>
        <th>UV</th>
        <td>{{addComma totalInfo.sum_totalCnt}}</td>
        <td class="{{upAndDownClass totalInfo.inc_sum_totalCnt}}"><i class="fa {{upAndDownIcon totalInfo.inc_sum_totalCnt}}"></i> {{addComma totalInfo.inc_sum_totalCnt}}</td>
    </tr>
</script>

<script type="text/x-handlebars-template" id="tmp_broadcastListener_tableBody">
    <tr>
        <th>방송방</th>
        <td>{{addComma sum_createCnt}}</td>
        <td class="{{upAndDownClass inc_sum_createCnt}}"><i class="fa {{upAndDownIcon inc_sum_createCnt}}"></i> {{addComma inc_sum_createCnt}}</td>
    </tr>
    <tr>
        <th>청취자</th>
        <td>{{addComma sum_listenerCnt}}</td>
        <td class="{{upAndDownClass inc_sum_listenerCnt}}"><i class="fa {{upAndDownIcon inc_sum_listenerCnt}}"></i> {{addComma inc_sum_listenerCnt}}</td>
    </tr>
    <tr>
        <th>게스트</th>
        <td>{{addComma sum_guestCnt}}</td>
        <td class="{{upAndDownClass inc_sum_guestCnt}}"><i class="fa {{upAndDownIcon inc_sum_guestCnt}}"></i> {{addComma inc_sum_guestCnt}}</td>
    </tr>
    <tr>
        <th>선물(금액)</th>
        <td>{{addComma sum_giftCnt}} ({{sum_giftAmount}} 달)</td>
        <td class="{{upAndDownClass inc_sum_giftCnt}}"><i class="fa {{upAndDownIcon inc_sum_giftCnt}}"></i> {{addComma inc_sum_giftCnt}}</td>
    </tr>
</script>

<script type="text/x-handlebars-template" id="tmp_paymentCancel_tableBody">
    <tr>
        <th>결제</th>
        <td>{{vatMinus totalInfo.sum_succCnt}}</td>
        <td class="{{upAndDownClass totalInfo.inc_sum_succCnt}}"><i class="fa {{upAndDownIcon totalInfo.inc_sum_succCnt}}"></i> {{vatMinus totalInfo.inc_sum_succCnt}} </td>
        <td>{{vatMinus totalInfo.sum_succAmt}}</td>
        <td class="{{upAndDownClass totalInfo.inc_sum_succAmt}}"><i class="fa {{upAndDownIcon totalInfo.inc_sum_succAmt}}"></i> {{vatMinus totalInfo.inc_sum_succAmt}} </td>
    </tr>
    <tr>
        <th>결제취소</th>
        <td>0</td>
        <td class="{{upAndDownClass cancelCnt}}"><i class="fa {{upAndDownIcon cancelCnt}}"></i> 0 </td>
        <td>0</td>
        <td class="{{upAndDownClass cancelAmt}}"><i class="fa {{upAndDownIcon cancelAmt}}"></i> 0 </td>
    </tr>
    <tr>
        <th>환불</th>
        <td>0</td>
        <td class="{{upAndDownClass cancelCnt}}"><i class="fa {{upAndDownIcon cancelCnt}}"></i> 0 </td>
        <td>0</td>
        <td class="{{upAndDownClass cancelAmt}}"><i class="fa {{upAndDownIcon cancelAmt}}"></i> 0 </td>
    </tr>
    <tr>
        <th>환전</th>
        <td>{{vatMinus totalInfo2.sum_succCnt}}</td>
        <td class="{{upAndDownClass totalInfo2.inc_sum_succCnt}}"><i class="fa {{upAndDownIcon totalInfo2.inc_sum_succCnt}}"></i> {{vatMinus totalInfo2.inc_sum_succCnt}} </td>
        <td>{{vatMinus totalInfo2.sum_succAmt}}</td>
        <td class="{{upAndDownClass totalInfo2.inc_sum_succAmt}}"><i class="fa {{upAndDownIcon totalInfo2.inc_sum_succAmt}}"></i> {{vatMinus totalInfo2.inc_sum_succAmt}} </td>
    </tr>
</script>