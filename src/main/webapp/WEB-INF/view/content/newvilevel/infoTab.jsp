<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<style>
</style>

<div id="wrapper">
    <div id="page-wrapper">
        <div class="col-lg-12 form-inline no-padding" style="padding-top: 2px; padding-bottom: 0px;">
            <div class="widget-content">
                <div class="col-lg-12 no-padding" id="tabContainer">
                    <ul class="nav nav-tabs nav-tabs-custom-colored" role="tablist" id="tablist_con">
                        <li class="active"><a href="#day" role="tab" data-toggle="tab" id="tab_day">일자별 현황</a></li>
                        <li><a href="#detail" role="tab" data-toggle="tab" id="tab_detail">상세 내역</a></li>
                    </ul>
                </div>
                <div class="tab-content col-lg-12">
                    <div class="tab-pane fade in active" id="day"><jsp:include page="day.jsp"/></div>      <!-- 일자별 현황 -->
                    <div class="tab-pane fade" id="detail"><jsp:include page="detail.jsp"/></div>      <!-- 상세 내역 -->
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

        dateType();
    });

    $("#bt_search").on('click', function(){
        if(tabId == 'tab_day'){
            $("#searchCheck").hide();
            $("#searchText").hide();
            getDayList();
        }else if(tabId == 'tab_detail'){
            $("#searchCheck").show();
            $("#searchText").show();
            getDetailList();
        }
    });

</script>