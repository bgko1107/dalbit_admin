
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<style>
</style>

<div id="wrapper">
    <div id="page-wrapper">
        <div class="widget-content">
            <ul class="nav nav-tabs nav-tabs-custom-colored" role="tablist" id="tablist_con">
                <li class="active"><a href="#time" role="tab" data-toggle="tab" id="tab_time">시간대별</a></li>
                <li><a href="#month" role="tab" data-toggle="tab" id="tab_month">월간별</a></li>
            </ul>
            <div class="tab-content">
                <div class="tab-pane fade in active" id="time"><jsp:include page="time.jsp"/></div>
                <div class="tab-pane fade" id="month"><jsp:include page="month.jsp"/></div>
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
        if(tabId == 'tab_time'){
            slctType = 0;
            $(".searchDate").html($("#onedayDate").val() + " (" + toDay + ")");
        }else if(tabId == 'tab_month') {
            slctType = 1;
        }
        dateType();
    });

    $("#bt_search").on('click', function(){
        if(tabId == 'tab_time'){
            getTime();
        }else if(tabId == 'tab_month') {
            getMonth();
        }
    });
</script>