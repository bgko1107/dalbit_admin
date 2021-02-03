<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" isELIgnored="false" %>

<div id="contentTab">
    <ul class="nav nav-tabs nav-tabs-custom-colored" role="tablist">
        <li class="active"><a href="#policyList" role="tab" data-toggle="tab" id="tab_policyList" onclick="tabClick(this.id)">서비스 정책관리</a></li>
    </ul>
    <div class="tab-content no-padding">
        <div class="tab-pane fade in active" id="policyList"><jsp:include page="/WEB-INF/view/content/servicePolicy/policyList.jsp"/></div>     <!-- 상세 -->
    </div>
</div>

<script>
    var tabId ="tab_policyList";
    function tabClick(id){
        tabId = id;
        $('#bt_search').click();
    }
    $('#bt_search').click( function() {       //검색
        if(tabId == "tab_policyList"){
            getPolicyList();
        }
    });
</script>