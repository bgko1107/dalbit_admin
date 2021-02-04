<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<style>
</style>


<ul class="nav nav-tabs nav-tabs-custom-colored" role="tablist" id="tablist_con">
    <li class="active"><a href="#mailboxList" role="tab" data-toggle="tab" id="tab_mailboxList">우체통 대화방 내역</a></li>
    <li><a href="#mailboxImg" role="tab" data-toggle="tab" id="tab_mailboxImg">우체통 이미지 내역</a></li>
    <li><a href="#mailboxGift" role="tab" data-toggle="tab" id="tab_mailboxGift">우체통 선물 내역</a></li>
</ul>
<div class="tab-content no-padding">
    <div class="tab-pane fade in active" id="mailboxList"><jsp:include page="mailboxList.jsp"/></div>
    <div class="tab-pane fade" id="mailboxImg"><jsp:include page="mailboxImg.jsp"/></div>
    <div class="tab-pane fade" id="mailboxGift"><jsp:include page="mailboxGift.jsp"/></div>
</div>


<script type="text/javascript">
    var tabId = "tab_mailboxList" ;
    $("#tablist_con li a").on('click', function(){
        tabId = $(this).prop('id');

        if(tabId == "tab_mailboxList" || tabId == "tab_mailboxImg" ){
            slctType = 0;
        }else if(tabId = "tab_mailboxGift"){
            slctType = 3;
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
        if(tabId == "tab_mailboxList" ){
            mailboxList();
        }else if(tabId == "tab_mailboxImg" ){
            mailboxImgList();
        }else if(tabId == "tab_mailboxGift" ){
            mailboxGiftList();
        }
        tabCntSelect();
    });

    function tabCntSelect(){
        var data = {
            'startDate' : $("#startDate").val()
            , 'endDate' : $("#endDate").val()
        };
        util.getAjaxData("storyList", "/rest/content/boardAdm/mailbox/tab/count", data, fn_success_tabCntSelect);
    }
    function fn_success_tabCntSelect(dst_id, response){
        for(var i=0;i<response.data.length;i++){
            if(response.data[i].type == "1"){
                $("#tab_mailboxList").text("우체통 대화방 내역" + "(" + response.data[i].totalCnt +")");
            }else if(response.data[i].type == "2"){
                $("#tab_mailboxImg").text("우체통 이미지 내역" + "(" + response.data[i].totalCnt +")");
            }else if(response.data[i].type == "3"){
                $("#tab_mailboxGift").text("우체통 선물 내역" + "(" + response.data[i].totalCnt +")");
            }
        }
    }
</script>