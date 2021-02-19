<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<style>
</style>

<div id="wrapper">
    <div id="page-wrapper">
        <div class="row col-lg-12 form-inline" style="padding-top: 2px; padding-bottom: 0px;">
            <div class="widget-content">
                <ul class="nav nav-tabs nav-tabs-custom-colored" role="tablist" id="tablist_con">
                    <li><a href="#time" role="tab" data-toggle="tab" id="tab_time">시간대 현황</a></li>
                    <li class="active"><a href="#day" role="tab" data-toggle="tab" id="tab_day">월간 현황</a></li>
                    <%--<li><a href="#month" role="tab" data-toggle="tab" id="tab_month">월간 현황</a></li>--%>
                    <li><a href="#yearState" role="tab" data-toggle="tab" id="tab_yearState">연간 현황</a></li>
                    <li><a href="#history" role="tab" data-toggle="tab" id="tab_history">Push 발송내역</a></li>
                    <li><a href="#notice" role="tab" data-toggle="tab" id="tab_notice">월간 알림 설정현황</a></li>
                    <li><a href="#year" role="tab" data-toggle="tab" id="tab_year">연간 알림 설정 현황</a></li>
                    <li><a href="/content/push/list" id="tab_push">알림/Push 운영자 직접발송</a></li>
                </ul>
                <div class="tab-content">
                    <div class="tab-pane fade" id="time"><jsp:include page="time.jsp"/></div>
                    <div class="tab-pane fade  in active" id="day"><jsp:include page="day.jsp"/></div>
                    <%--<div class="tab-pane fade" id="month"><jsp:include page="month.jsp"/></div>--%>
                    <div class="tab-pane fade" id="yearState"><jsp:include page="yearState.jsp"/></div>
                    <div class="tab-pane fade" id="history"><jsp:include page="history.jsp"/></div>
                    <div class="tab-pane fade" id="notice"><jsp:include page="notice.jsp"/></div>
                    <div class="tab-pane fade" id="year"><jsp:include page="year.jsp"/></div>
                </div>
            </div>
        </div>
    </div>
    <!-- /#page-wrapper -->
</div>
<!-- /#wrapper -->

<script type="text/javascript">
    var tabId = 'tab_day';
    $("#tablist_con li a").on('click', function(){
        tabId = $(this).prop('id');
        $("#searchText").hide();
        $("#searchMemberArea").hide();
        if(tabId == 'tab_time' || tabId == 'tab_history'){
            slctType = 0;
            if(tabId == 'tab_history'){
                $("#searchText").show();
                $("#searchMemberArea").show();
            }
        }else if(tabId == 'tab_day' || tabId == 'tab_month' || tabId == 'tab_notice'){
            slctType = 1;
        }else if(tabId == 'tab_year' || tabId == 'tab_yearState'){
            slctType = 2;
        }

        dateType(slctType);
    });

    $("#bt_search").on('click', function(){
        if(tabId == 'tab_time') {
            getTotal();
        }else if(tabId == 'tab_day'){
            getDay();
        }else if(tabId == 'tab_month'){
            getMonth();
        }else if(tabId == 'tab_year'){
            getYear();
        }else if(tabId == 'tab_notice'){
            getNotice();
        }else if(tabId == 'tab_history'){
            getHistory();
        }else if(tabId == 'tab_yearState'){
            getYearState();
        }
    });
</script>