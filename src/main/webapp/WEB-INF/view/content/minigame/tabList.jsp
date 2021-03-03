<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<style>
</style>


<ul class="nav nav-tabs nav-tabs-custom-colored" role="tablist" id="tablist_con">
    <li class="active"><a href="#miniGame" role="tab" data-toggle="tab" id="tab_miniGame">미니게임 관리</a></li>
    <li><a href="#gameHistory" role="tab" data-toggle="tab" id="tab_gameHistory">게임 진행내역</a></li>
</ul>
<div class="tab-content no-padding">
    <div class="tab-pane fade in active" id="miniGame"><jsp:include page="minigame.jsp"/></div>
    <div class="tab-pane fade" id="gameHistory"><jsp:include page="gameHistory.jsp"/></div>
</div>


<script type="text/javascript">
    var tabId = "tab_miniGame" ;
    $("#tablist_con li a").on('click', function(){
        tabId = $(this).prop('id');

        $("#searchMemberArea").empty();
        if(tabId == "tab_miniGame"){
            slctType = 1;
        }else if(tabId == "tab_gameHistory"){

            $("#searchMemberArea").html(util.getCommonCodeSelect(1, searchMember));
            slctType = 0;
        }
        dateType();
    });

    $('input[id="txt_search"]').keydown(function(e) {
        if(e.keyCode == 13) {
            $("#bt_search").click();
        }
    });

    $('#bt_search').on('click', function() {
        if(tabId == "tab_miniGame"){
            miniGameList();
        }else if(tabId == "tab_gameHistory"){
            gameHistory();
        }
    });

</script>