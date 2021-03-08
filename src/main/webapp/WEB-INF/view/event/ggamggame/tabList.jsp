<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<ul class="nav nav-tabs nav-tabs-custom-colored" role="tablist" id="tablist_con">
    <li class="active"><a href="#newrecord" role="tab" data-toggle="tab" id="tab_newrecord">신기록 이벤트</a></li>
</ul>
<div class="tab-content no-padding">
    <div class="tab-pane fade in active" id="newrecord"><jsp:include page="newrecord.jsp"/></div>
</div>


<script type="text/javascript">
    var tabId = "tab_newrecord" ;
    $("#tablist_con li a").on('click', function(){
        tabId = $(this).prop('id');

        if(tabId == "tab_newrecord"){
            slctType = 99;
        }
        dateType();
    });
    $('input[id="txt_search"]').keydown(function(e) {
        if(e.keyCode == 13) {
            $("#bt_search").click();
        }
    });
    $('#bt_search').on('click', function() {
        $("#summaryArea").empty();
        if(tabId == "tab_newrecord" ){
            newrecordList();
        }
    });

</script>