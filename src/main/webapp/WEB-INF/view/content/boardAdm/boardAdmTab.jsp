<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<style>
</style>


<ul class="nav nav-tabs nav-tabs-custom-colored" role="tablist" id="tablist_con">
    <li class="active"><a href="#storyList" role="tab" data-toggle="tab" id="tab_storyList">사연</a></li>
    <li><a href="#fanBoardList" role="tab" data-toggle="tab" id="tab_fanBoardList">팬보드</a></li>
    <li><a href="#fanBoardReply" role="tab" data-toggle="tab" id="tab_fanBoardReply">팬보드댓글</a></li>
    <li><a href="#noticeList" role="tab" data-toggle="tab" id="tab_noticeList">방송방공지</a></li>
    <li><a href="#broadNoticeList" role="tab" data-toggle="tab" id="tab_broadNoticeList">회원공지</a></li>   <!-- 2020.10.06 방송공지 -> 회원공지 텍스트 변경(이상훈 과장님 요청) -->
    <li><a href="#broadNoticeReply" role="tab" data-toggle="tab" id="tab_broadNoticeReply">회원공지댓글</a></li>   <!-- 2020.11.10 추가 -->
    <li><a href="#profileMsgList" role="tab" data-toggle="tab" id="tab_profileMsgList">프로필메세지</a></li>
    <li><a href="#clipReply" role="tab" data-toggle="tab" id="tab_clipReply">클립댓글</a></li> <!-- 클립댓글-->
    <li><a href="#mailboxList" role="tab" data-toggle="tab" id="tab_mailboxList">우체통</a></li>
</ul>
<div class="tab-content no-padding">
    <div class="tab-pane fade in active" id="storyList"><jsp:include page="storyList.jsp"/></div>
    <div class="tab-pane fade" id="fanBoardList"><jsp:include page="fanBoardList.jsp"/></div>
    <div class="tab-pane fade" id="fanBoardReply"><jsp:include page="fanBoardReply.jsp"/></div>
    <div class="tab-pane fade" id="noticeList"><jsp:include page="noticeList.jsp"/></div>
    <div class="tab-pane fade" id="broadNoticeList"><jsp:include page="broadNoticeList.jsp"/></div>
    <div class="tab-pane fade" id="broadNoticeReply"><jsp:include page="broadNoticeReply.jsp"/></div>
    <div class="tab-pane fade" id="profileMsgList"><jsp:include page="profileMsgList.jsp"/></div>
    <div class="tab-pane fade" id="clipReply"><jsp:include page="clipReply.jsp"/></div>
    <div class="tab-pane fade" id="mailboxList"><jsp:include page="mailboxList.jsp"/></div>
</div>


<script type="text/javascript">
    var tabId = "tab_storyList" ;
    $("#tablist_con li a").on('click', function(){
        tabId = $(this).prop('id');

        slctType = 3;
        if(tabId == "tab_mailboxList" ){
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
        $("#summaryArea").empty();
        if(tabId == "tab_storyList" ){
            storyList();
        }else if(tabId == "tab_fanBoardList" ){
            fanBoardList();
        }else if(tabId == "tab_fanBoardReply" ){
            fanBoardReply();
        }else if(tabId == "tab_noticeList" ){
            noticeList();
        }else if(tabId == "tab_broadNoticeList" ){
            broadNoticeList();
        }else if(tabId == "tab_broadNoticeReply") {
            broadNoticeReply();
        }else if(tabId == "tab_profileMsgList" ){
            profileMsgList();
        }else if(tabId == "tab_clipReply" ){
            clipReplyList();
        }else if(tabId == "tab_mailboxList" ){
            mailboxList();
        }
        tabCntSelect();
    });


    function tabCntSelect(){
        var data = {
            'txt_search' : $('#txt_search').val()
            , 'start_sel' : $("#startDate").val()
            , 'end_sel' : $("#endDate").val()
            , 'broState' : 0
            , 'searchType' : 0
            , 'boardType' : 1
            , 'status' : 0
        };
        util.getAjaxData("storyList", "/rest/content/boardAdm/tab/count", data, fn_success_tabCntSelect);
    }
    function fn_success_tabCntSelect(dst_id, response){

        console.log(response);
        $("#tab_mailboxList").text("우체통" + "(" + response.data.mailboxCnt +")");
        $("#tab_storyList").text("사연" + "(" + response.data.storyListCnt +")");
        $("#tab_fanBoardList").text("팬보드" + "(" + response.data.fanBoardListCnt +")");
        $("#tab_fanBoardReply").text("팬보드댓글" + "(" + response.data.fanBoardReplyCnt +")");
        $("#tab_noticeList").text("방송방공지" + "(" + response.data.noticeListCnt +")");
        $("#tab_broadNoticeList").text("회원공지" + "(" + response.data.broadNoticeListCnt +")");
        $("#tab_broadNoticeReply").text("회원공지댓글" + "(" + response.data.broadNoticeReplyCnt + ")");
        $("#tab_profileMsgList").text("프로필 메시지" + "(" + response.data.profileMsgListCnt +")");
        $("#tab_clipReply").text("클립댓글" + "(" + response.data.clipReplyCnt +")");
    }
</script>