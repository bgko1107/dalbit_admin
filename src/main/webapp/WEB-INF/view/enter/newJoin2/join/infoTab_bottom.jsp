<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div id="wrapper">
    <div id="page-wrapper">
        <div class="col-lg-12 no-padding" style="padding-top: 2px; padding-bottom: 0px;">
            <div class="widget-content">
                <ul class="nav nav-tabs nav-tabs-custom-colored" role="tablist" id="tablist_con">
                    <li class="active"><a href="#calendar" role="tab" data-toggle="tab" id="tab_calendar">일자별</a></li>
                    <li><a href="#time" role="tab" data-toggle="tab" id="tab_time">시간대별</a></li>
                    <li><a href="#month" role="tab" data-toggle="tab" id="tab_month">월간별</a></li>
                    <li><a href="#list" role="tab" data-toggle="tab" id="tab_list">가입 회원내역</a></li>
                    <%--<li><a href="/member/join/list?toptabType=1" id="tab_memberJoin" title="회원검색으로 이동합니다.">가입 회원내역</a></li>--%>
                </ul>
                <div class="tab-content">
                    <div class="tab-pane fade in active" id="calendar"><jsp:include page="calendar.jsp"/></div>     <!-- 일자별 -->
                    <div class="tab-pane fade" id="time"><jsp:include page="time.jsp"/></div>                       <!-- 실시간 -->
                    <div class="tab-pane fade" id="month"><jsp:include page="month.jsp"/></div>                     <!-- 월간별 -->
                    <div class="tab-pane fade" id="list"><jsp:include page="list.jsp"/></div>                       <!-- 가입 회원내역 -->
                </div>
            </div>
        </div>
    </div>
    <!-- /#page-wrapper -->
</div>
<!-- /#wrapper -->

<script type="text/javascript">
    var tabId = "tab_calendar";

    var sDate;
    var eDate;
    var beforeSDate;
    var beforeEDate;
    var twoAgoSDate;
    var twoAgoEDate;

    $("#tablist_con li a").on('click', function(){

        tabId = $(this).prop('id');

        $("#searchText").hide();
        $("#searchMemberArea").hide();
        if(tabId == 'tab_time'){
            slctType = 0;
        }else if(tabId == 'tab_calendar' || tabId == 'tab_month') {
            slctType = 1;
        }else if(tabId == 'tab_list') {
            $("#searchText").show();
            $("#searchMemberArea").show();
            slctType = 3;
        }

        dateType(slctType);

        $("#searchFormRadio").hide();
        $("#searchCheck").hide();
        $("#txt_search").hide();
        $("#stateSummary").show();
        $("#joinListSummary").hide();

        $(".searchDate").html($("#onedayDate").val());
    });

    $("#bt_search").on('click', function(){
        if(tabId != 'tab_list'){
            if(tabId == 'tab_time'){
                getTime();
            }else if(tabId == 'tab_calendar') {
                getCalendar();
            }else if(tabId == 'tab_month') {
                getMonth();
            }
        }else if (tabId == 'tab_list'){
            getUserInfo();
        }
    });
</script>