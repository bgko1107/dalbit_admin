<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<ul class="nav nav-tabs nav-tabs-custom-colored" role="tablist" id="tablist_con">
    <li class="active"><a href="#quest" role="tab" data-toggle="tab" id="tab_quest">퀘스트 이벤트</a></li>
    <li ><a href="#questStat" role="tab" data-toggle="tab" id="tab_questStat">퀘스트 현황</a></li>
    <li ><a href="#questMember" role="tab" data-toggle="tab" id="tab_questMember">참여자 목록</a></li>
</ul>
<div class="tab-content no-padding">
    <div class="tab-pane fade in active" id="quest"><jsp:include page="quest.jsp"/></div>
    <div class="tab-pane fade" id="questStat"><jsp:include page="questStat.jsp"/></div>
    <%--<div class="tab-pane fade" id="questMember"><jsp:include page="questMember.jsp"/></div>--%>
</div>


<script type="text/javascript">
    var tabId = "tab_quest" ;
    $("#tablist_con li a").on('click', function(){
        tabId = $(this).prop('id');

        $("#div_searchForm").hide();

        if(tabId == "tab_newrecord"){
            $('#bt_search').click();
        }else if(tabId == "tab_questStat"){
            $("#div_searchForm").show();
            slctType = 1;
            dateType();
        }else if(tabId == "tab_questMember"){
            $("#div_searchForm").show();
            slctType = 1;
            dateType();
        }
    });

    $('#bt_search').on('click', function() {
        $("#summaryArea").empty();
        if(tabId == "tab_newrecord" ){
            questList();
        }else if(tabId == "tab_questStat" ){
            questStat();
        }else if(tabId == "tab_questStat" ){
            questMember();
        }
    });

</script>