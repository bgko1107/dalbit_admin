<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<style>
</style>

<div id="wrapper">
    <div id="page-wrapper">
        <div class="widget-content">
            <ul class="nav nav-tabs nav-tabs-custom-colored" role="tablist" id="tablist_con">
                <li class="active"><a href="#time" role="tab" data-toggle="tab" id="tab_time">시간대별(종합)</a></li>
                <li><a href="#timeDetail" role="tab" data-toggle="tab" id="tab_timeDetail">시간대별(상세)</a></li>
                <li><a href="#day" role="tab" data-toggle="tab" id="tab_day">월간별(종합)</a></li>
                <li><a href="#dayDetail" role="tab" data-toggle="tab" id="tab_dayDetail">월간별(상세)</a></li>
                <li><a href="#year" role="tab" data-toggle="tab" id="tab_year">연간별(종합)</a></li>
                <li><a href="#yearDetail" role="tab" data-toggle="tab" id="tab_yearDetail">연간별(상세)</a></li>
                <li><a href="#gift" role="tab" data-toggle="tab" id="tab_gift">방송 선물내역</a></li>
            </ul>
            <div class="tab-content">
                <div class="tab-pane fade in active timeBroad" id="time"><jsp:include page="time.jsp"/></div>
                <div class="tab-pane fade timeBroad" id="timeDetail"><jsp:include page="time.jsp"/></div>
                <div class="tab-pane fade dayBroad" id="day"><jsp:include page="day.jsp"/></div>
                <div class="tab-pane fade dayBroad" id="dayDetail"><jsp:include page="day.jsp"/></div>
                <div class="tab-pane fade yearBroad" id="year" ><jsp:include page="year.jsp"/></div>
                <div class="tab-pane fade yearBroad" id="yearDetail" ><jsp:include page="year.jsp"/></div>
                <div class="tab-pane fade" id="gift"><jsp:include page="gift.jsp"/></div>
            </div>
        </div>
    </div>
    <!-- /#page-wrapper -->
</div>
<!-- /#wrapper -->

<script type="text/javascript">
    var tabId = "tab_time";
    $("#tablist_con li a").on('click', function(){
        tabId = $(this).prop('id');

        if(tabId == 'tab_gift'){
            $("#checkTestid").show();
        }else{
            $("#checkTestid").hide();
        }
        if(tabId == 'tab_time' || tabId == 'tab_timeDetail' || tabId == 'tab_gift'){
            slctType = "0";
        }else if(tabId == 'tab_day' || tabId == 'tab_dayDetail') {
            slctType = "1";
        }else if(tabId == 'tab_year' || tabId == 'tab_yearDetail') {
            slctType = "2";
        }

        dateType(slctType);
    });

    $("#bt_search").on('click', function(){
        if(tabId == 'tab_time' || tabId == 'tab_timeDetail'){
            getTimeList();
        }else if(tabId == 'tab_day' || tabId == 'tab_dayDetail'){
            getDayList();
        }else if(tabId == 'tab_year' || tabId == 'tab_yearDetail'){
            getYearList();
        }else if(tabId == 'tab_gift'){
            getGiftHistoryList();
        }
    });
</script>