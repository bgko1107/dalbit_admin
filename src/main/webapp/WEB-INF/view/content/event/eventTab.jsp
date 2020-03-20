<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" isELIgnored="false" %>

<div id="contentTap">
    <ul class="nav nav-tabs nav-tabs-custom-colored" role="tablist">
        <li><a href="#eventDetail" role="tab" data-toggle="tab" id="tab_eventDetail" onclick="onClickContentTab(this.id)">이벤트 상세정보</a></li>
        <li><a href="#eventReport" role="tab" data-toggle="tab" id="tab_eventReport" onclick="onClickContentTab(this.id)">응모자/당첨자</a></li>
    </ul>
    <div class="tab-content">
        <div class="tab-pane fade" id="eventDetail"><jsp:include page="/WEB-INF/view/content/event/eventDetail.jsp"/></div>     <!-- 상세 -->
        <div class="tab-pane fade" id="eventReport"><jsp:include page="/WEB-INF/view/content/event/eventReport.jsp"/></div>     <!-- 응모자/당첨자 -->
    </div>
</div>

<script>
    $(document).ready(function() {
    });

    //Tab 선택시 호출 함수
    function onClickContentTab(id){
        var targetName = id.split("_")[1];
        var targetFnc = eval("fnc_"+targetName);

        targetFnc.init();
    }
</script>