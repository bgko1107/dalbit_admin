<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="dummyData"><%= java.lang.Math.round(java.lang.Math.random() * 1000000) %></c:set>

<div id="wrapper">
    <div id="page-wrapper">
        <div id="container-fluid" class="col-lg-12 no-padding">
            <!-- searchBox -->
            <form id="searchForm">
                <div class="col-lg-12 form-inline no-padding">
                    <div class="widget widget-table searchBoxArea">

                        <table>
                            <tr>
                                <th rowspan="2" style="background-color:#4472c4;color:#e9ee17;width: 70px">
                                    <i class="fa fa-search"></i><br/>검색
                                </th>
                                <th id="th_bottonList">
                                    <jsp:include page="../../searchArea/daySearchFunction.jsp"/>
                                    <div>
                                        <div id="div_dayButton" style="display: none"><jsp:include page="../../searchArea/daySearchArea.jsp"/></div>
                                        <div id="div_monthButton"><jsp:include page="../../searchArea/monthSearchArea.jsp"/></div>
                                        <div id="div_yearButton" style="display: none"><jsp:include page="../../searchArea/yearSearchArea.jsp"/></div>
                                    </div>
                                </th>
                            </tr>
                            <tr>
                                <td style="text-align: left">
                                    <input id="onedayDate" type="text" class="form-control" style="display: none">
                                    <input id="monthDate" type="text" class="form-control"/>
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
                    </div>
                </div>
            </form>
            <!-- //serachBox -->
            <!-- 접속 관련 통계 데이터-->
            <div class="row col-lg-12 form-inline hide">
                <div class="widget widget-table mb10">
                    <div class="widget-header">
                        <h3><i class="fa fa-table"></i> 로그인 통계 현황</h3>
                    </div>
                    <div class="widget-content mt10">
                        <table class="table table-bordered">
                            <colgroup>
                                <col width="10%"/><col width="10%"/><col width="10%"/><col width="10%"/><col width="10%"/>
                                <col width="10%"/><col width="10%"/><col width="10%"/><col width="10%"/><col width="10%"/>
                            </colgroup>
                            <thead>
                            <tr>
                                <th></th>
                                <th>실시간</th>
                                <th>전일</th>
                                <th>증감</th>
                                <th>주간</th>
                                <th>전주</th>
                                <th>증감</th>
                                <th>월간</th>
                                <th>전월</th>
                                <th>증감</th>
                            </tr>
                            </thead>
                            <tbody id="loginLiveTableBody"></tbody>
                        </table>
                    </div>
                </div>
            </div>
            <!-- // 접속 관련 통계 데이터 -->
        </div> <!-- // container-fluid -->
        <!-- tab -->
        <div class="no-padding col-lg-12" id="infoTab">
            <jsp:include page="infoTab.jsp"/>
        </div>
        <!-- //tab -->
    </div> <!-- // page-wrapper -->
</div> <!-- // wrapper -->

<script type="text/javascript" src="/js/code/enter/joinCodeList.js?${dummyData}"></script>
<script type="text/javascript" src="/js/util/statUtil.js?${dummyData}"></script>

<script type="text/javascript">

    $(function() {
        slctType = 1;
        dateType();
    });

    function dataSet(){
        var startDate = $("#startDate").val();
        var endDate = $("#endDate").val();

        var data = {
            slctType : slctType,
            startDate : startDate,
            endDate : endDate
        };

        return data;
    }


    function resourceClipStatusClick(data){
        console.log(data);

        var param = "?sdate=" + $("#startDate").val();

        // 주제 코드로  이름 추출
        if(!common.isEmpty(data.subjecttype)){
            subjectCodeList.forEach(function(code){
                if(code.value == data.subjecttype){
                    param += "&subjectname=" + code.code;
                }
            });
        }

        // DOM data -> queryString 으로 추가
        Object.keys(data).forEach(function(key){
            param += "&" + key  + "=" + data[key]
        });

        var popupUrl = "/clip/status/popup/detail" + param;

        util.windowOpen(popupUrl,"1020","700","달 정보 데이터");
    }

</script>

<script type="text/x-handlebars-template" id="tmp_loginLive">
    <tr>
        <th>{{{sexIcon 'm'}}}</th>
        <td>{{addComma m_now_cnt}}</td>
        <td>{{addComma m_yes_cnt}}</td>
        <td class="{{upAndDownClass m_now_inc_cnt}}"><i class="fa {{upAndDownIcon m_now_inc_cnt}}"></i> {{addComma m_now_inc_cnt}}</td>
        <td>{{addComma m_week_cnt}}</td>알림
        <td>{{addComma m_bweek_cnt}}</td>
        <td class="{{upAndDownClass m_week_inc_cnt}}"><i class="fa {{upAndDownIcon m_week_inc_cnt}}"></i> {{addComma m_week_inc_cnt}}</td>
        <td>{{addComma m_month_cnt}}</td>
        <td>{{addComma m_bmonth_cnt}}</td>
        <td class="{{upAndDownClass m_month_inc_cnt}}"><i class="fa {{upAndDownIcon m_month_inc_cnt}}"></i> {{addComma m_month_inc_cnt}}</td>
    </tr>
    <tr>
        <th>{{{sexIcon 'f'}}}</th>
        <td>{{addComma f_now_cnt}}</td>
        <td>{{addComma f_yes_cnt}}</td>
        <td class="{{upAndDownClass f_now_inc_cnt}}"><i class="fa {{upAndDownIcon f_now_inc_cnt}}"></i> {{addComma f_now_inc_cnt}}</td>
        <td>{{addComma f_week_cnt}}</td>
        <td>{{addComma f_bweek_cnt}}</td>
        <td class="{{upAndDownClass f_week_inc_cnt}}"><i class="fa {{upAndDownIcon f_week_inc_cnt}}"></i> {{addComma f_week_inc_cnt}}</td>
        <td>{{addComma f_month_cnt}}</td>
        <td>{{addComma f_bmonth_cnt}}</td>
        <td class="{{upAndDownClass f_month_inc_cnt}}"><i class="fa {{upAndDownIcon f_month_inc_cnt}}"></i> {{addComma f_month_inc_cnt}}</td>
    </tr>
    <tr>
        <th>알수없음</th>
        <td>{{addComma n_now_cnt}}</td>
        <td>{{addComma n_yes_cnt}}</td>
        <td class="{{upAndDownClass n_now_inc_cnt}}"><i class="fa {{upAndDownIcon n_now_inc_cnt}}"></i> {{addComma n_now_inc_cnt}}</td>
        <td>{{addComma n_week_cnt}}</td>
        <td>{{addComma n_bweek_cnt}}</td>
        <td class="{{upAndDownClass n_week_inc_cnt}}"><i class="fa {{upAndDownIcon n_week_inc_cnt}}"></i> {{addComma n_week_inc_cnt}}</td>
        <td>{{addComma n_month_cnt}}</td>
        <td>{{addComma n_bmonth_cnt}}</td>
        <td class="{{upAndDownClass n_month_inc_cnt}}"><i class="fa {{upAndDownIcon n_month_inc_cnt}}"></i> {{addComma n_month_inc_cnt}}</td>
    </tr>
    <tr>
        <th>합계</th>
        <td>{{addComma t_now_cnt}}</td>
        <td>{{addComma t_yes_cnt}}</td>
        <td class="{{upAndDownClass t_now_inc_cnt}}"><i class="fa {{upAndDownIcon t_now_inc_cnt}}"></i> {{addComma t_now_inc_cnt}}</td>
        <td>{{addComma t_week_cnt}}</td>
        <td>{{addComma t_bweek_cnt}}</td>
        <td class="{{upAndDownClass t_week_inc_cnt}}"><i class="fa {{upAndDownIcon t_week_inc_cnt}}"></i> {{addComma t_week_inc_cnt}}</td>
        <td>{{addComma t_month_cnt}}</td>
        <td>{{addComma t_bmonth_cnt}}</td>
        <td class="{{upAndDownClass t_month_inc_cnt}}"><i class="fa {{upAndDownIcon t_month_inc_cnt}}"></i> {{addComma t_month_inc_cnt}}</td>
    </tr>
</script>