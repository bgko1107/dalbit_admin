<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<style>
</style>

<div id="wrapper">
    <div id="page-wrapper">
        <div class="widget-content">
            <ul class="nav nav-tabs nav-tabs-custom-colored" role="tablist" id="tablist_con">
                <li class="active"><a href="#time" role="tab" data-toggle="tab" id="tab_time">시간대별</a></li>
                <li><a href="#day" role="tab" data-toggle="tab" id="tab_day">월간별</a></li>
                <li><a href="#year" role="tab" data-toggle="tab" id="tab_year">연간별</a></li>
                <li><a href="#gift" role="tab" data-toggle="tab" id="tab_gift">방송 선물내역</a></li>
            </ul>
            <div class="tab-content">
                <div class="tab-pane fade in active" id="time" style="width: 2400px;"><jsp:include page="time.jsp"/></div>
                <div class="tab-pane fade" id="day" style="width: 2600px;"><jsp:include page="day.jsp"/></div>
                <div class="tab-pane fade" id="year" style="width: 2600px;"><jsp:include page="year.jsp"/></div>
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
        if(tabId == 'tab_time' || tabId == 'tab_gift'){
            slctType = "0";
        }else if(tabId == 'tab_day') {
            slctType = "1";
        }else if(tabId == 'tab_year') {
            slctType = "2";
        }

        dateType(slctType);

        if(tabId == 'tab_time'){
            getTimeList();
        }else if(tabId == 'tab_day'){
            getDayList();
        }else if(tabId == 'tab_year'){
            getYearList();
        }else if(tabId == 'tab_gift'){
            getGiftHistoryList();
        }
    });

    $("#bt_search").on('click', function(){
        if(tabId == 'tab_time'){
            getTimeList();
        }else if(tabId == 'tab_day'){
            getDayList();
        }else if(tabId == 'tab_year'){
            getYearList();
        }else if(tabId == 'tab_gift'){
            getGiftHistoryList();
        }
    });
</script>