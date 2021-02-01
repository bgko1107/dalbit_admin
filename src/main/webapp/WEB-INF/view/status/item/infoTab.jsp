<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<style>
</style>

<div id="wrapper">
    <div id="page-wrapper">
        <div class="row col-lg-9 form-inline" style="padding-top: 2px; padding-bottom: 0px;">
            <div class="widget-content">
                <ul class="nav nav-tabs nav-tabs-custom-colored" role="tablist" id="tablist_con">
                    <li class="active"><a href="#total" role="tab" data-toggle="tab" id="tab_total">총계</a></li>
                    <li><a href="#gender" role="tab" data-toggle="tab" id="tab_genderDetail">성별</a></li>
                    <li><a href="#age" role="tab" data-toggle="tab" id="tab_ageDetail">연령별</a></li>
                    <li><a href="#broadcast" role="tab" data-toggle="tab" id="tab_broadcastDetail">방송</a></li>
                    <li><a href="#clip" role="tab" data-toggle="tab" id="tab_clipDetail">클립</a></li>
                    <%--<li><a href="#storeEtc" role="tab" data-toggle="tab" id="tab_storeEtcDetail">스토어/기타</a></li>--%>
                    <%--<li><a href="#item" role="tab" data-toggle="tab" id="tab_itemDetail">아이템 전체</a></li>--%>
                    <%--<li><a href="#buyHistory" role="tab" data-toggle="tab" id="tab_buyHistoryDetail">구매 내역</a></li>--%>
                    <li><a href="#mailbox" role="tab" data-toggle="tab" id="tab_mailbox">우체통</a></li>
                </ul>
                <div class="tab-content">
                    <div class="tab-pane fade in active" id="total"><jsp:include page="total.jsp"/></div>      <!-- 총계 -->
                    <div class="tab-pane fade" id="gender"><jsp:include page="gender.jsp"/></div>    <!-- 성별 -->
                    <div class="tab-pane fade" id="age"><jsp:include page="age.jsp"/></div>    <!-- 연령별 -->
                    <div class="tab-pane fade" id="broadcast"><jsp:include page="broadcast.jsp"/></div>    <!-- 방송 -->
                    <div class="tab-pane fade" id="clip"><jsp:include page="clip.jsp"/></div>    <!-- 클립 -->
                    <div class="tab-pane fade" id="storeEtc"><jsp:include page="storeEtc.jsp"/></div>    <!-- 스토어/기타 -->
                    <div class="tab-pane fade" id="item"><jsp:include page="item.jsp"/></div>    <!-- 아이템 전체 -->
                    <div class="tab-pane fade" id="buyHistory"><jsp:include page="buyHistory.jsp"/></div>    <!-- 구매 내역 -->
                    <div class="tab-pane fade" id="mailbox"><jsp:include page="mailbox.jsp"/></div>    <!-- 우체통 -->
                </div>
            </div>
        </div>
    </div>
    <!-- /#page-wrapper -->
</div>
<!-- /#wrapper -->

<script type="text/javascript">
    var tabId = "tab_total";
    $("#tablist_con li a").on('click', function(){
        tabId = $(this).prop('id');
        $("#slctTypeArea").show();
        $("#slctTypeArea2").hide();

        if(tabId == 'tab_broadcastDetail' || tabId == 'tab_clipDetail' || tabId == 'tab_mailbox'){
            $("#slctTypeArea").hide();
            $("#slctTypeArea2").show();
        }

        radioChange();

        $(".searchDate").html($("#onedayDate").val());
    });

    $("#bt_search").on('click', function(){

        if(tabId == 'tab_broadcastDetail' || tabId == 'tab_clipDetail' || tabId == 'tab_mailbox') {
            if ($('input[name="slctType2"]:first').prop('checked')) {
                $("._searchDate2").html($("#startDate").val() + " (" + toDay + ")");
            }
        }else{
            if($('input[name="slctType"]:first').prop('checked')){
                $("._searchDate").html($("#startDate").val() + " (" + toDay + ")");
            }
        }

        if(tabId == 'tab_total'){
            getTotalList();
        }else if(tabId == 'tab_genderDetail'){
            getGenderList();
        }else if(tabId == 'tab_ageDetail'){
            getAgeList();
        }else if(tabId == 'tab_broadcastDetail'){
            getBroadList();
        }else if(tabId == 'tab_clipDetail'){
            getClipList();
        }else if(tabId == 'tab_castDetail'){
        }else if(tabId == 'tab_storeEtcDetail') {
        }else if(tabId == 'tab_itemDetail') {
        }else if(tabId == 'tab_buyHistoryDetail') {
        }else if(tabId == 'tab_mailbox') {
            getMailboxList();
        }
    });
</script>