
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="dummyData"><%= java.lang.Math.round(java.lang.Math.random() * 1000000) %></c:set>

<button class="btn btn-primary btn-lg" data-toggle="modal" data-target="#detailView" id="showModal" style="display:none;">모달창오픈</button>
<div class="modal fade" id="detailView" tabindex="-1" role="dialog" aria-labelledby="detailViewLabel" aria-hidden="true"></div>

<div class="row col-lg-12 form-inline hide mt5 pb0 pr0" style="padding-bottom: 0px;" id="tabList_top">
    <div class="widget-content" >
        <ul class="nav nav-tabs nav-tabs-custom-colored" role="tablist" id="tablist_con">
            <li class="active"><a href="#infoDetail" role="tab" data-toggle="tab">상세정보</a></li>
            <li><a href="#broadcast" role="tab" data-toggle="tab" id="tab_broadcast" onclick="tab_click(this.id);">방송관리</a></li>
            <li><a href="#clip" role="tab" data-toggle="tab" id="tab_clip" onclick="tab_click(this.id);">클립관리</a></li>
            <li><a href="#payDetail" role="tab" data-toggle="tab" id="tab_payDetail" onclick="tab_click(this.id);">결제/취소내역</a></li>
            <li><a href="#walletDetail" role="tab" data-toggle="tab" id="tab_walletDetail" onclick="tab_click(this.id);">내지갑</a></li>       <%-- 2020.07.02 김자운 주임 요청으로 인한 내지갑 UI및 기능 변경 %>
            <%--<li><a href="#giftDetail" role="tab" data-toggle="tab" id="tab_giftDetail" onclick="tab_click(this.id);">선물내역</a></li>--%>
            <li><a href="#exchangeDetail" role="tab" data-toggle="tab" id="tab_exchangeDetail" onclick="tab_click(this.id);">환전내역</a></li>
            <li><a href="#changeDetail" role="tab" data-toggle="tab" id="tab_changeDetail" onclick="tab_click(this.id);">교환내역</a></li>
            <li><a href="#mystarDetail" role="tab" data-toggle="tab" id="tab_mystarDetail" onclick="tab_click(this.id);">마이스타/팬</a></li>
            <li><a href="#notice" role="tab" data-toggle="tab" id="tab_notice" onclick="tab_click(this.id);">회원게시관리</a></li>
            <li><a href="#declaration" role="tab" data-toggle="tab" id="tab_declaration" onclick="tab_click(this.id);">신고내역</a></li>
            <li><a href="#questionDetail" role="tab" data-toggle="tab" id="tab_questionDetail" onclick="tab_click(this.id);">문의내역</a></li>
            <li><a href="#connectState" role="tab" data-toggle="tab" id="tab_connectState" onclick="tab_click(this.id);">접속내역</a></li>
            <li><a href="#edit" role="tab" data-toggle="tab" id="tab_edit" onclick="tab_click(this.id);">수정내역</a></li>
            <li><a href="#levelDetail" role="tab" data-toggle="tab" id="tab_levelDetail" onclick="tab_click(this.id);">레벨</a></li>
        </ul>
        <div class="tab-content">
            <div class="tab-pane fade in active " id="infoDetail"><jsp:include page="memberInfo.jsp"/></div>     <!-- 상세 -->
            <div class="tab-pane fade" id="broadcast"><!-- 방송관리 -->
                <ul class="nav nav-tabs nav-tabs-custom-colored" role="tablist">
                    <li><a href="#broadDetail" role="tab" data-toggle="tab" id="tab_broadDetail" onclick="tab_click(this.id);">방송내역</a></li>
                    <li><a href="#listenDetail" role="tab" data-toggle="tab" id="tab_listenDetail" onclick="tab_click(this.id);">청취내역</a></li>
                </ul>
                <div class="tab-content">
                    <div class="tab-pane fade" id="broadDetail"><jsp:include page="../broadcast/list.jsp"/></div>       <!-- 방송 -->
                    <div class="tab-pane fade" id="listenDetail"><jsp:include page="../listen/list.jsp"/></div>         <!-- 청취 -->
                </div>
            </div>
            <div class="tab-pane fade" id="clip"><!-- 클립관리 -->
                <ul class="nav nav-tabs nav-tabs-custom-colored" role="tablist">
                    <li class="active"><a href="#clipList" role="tab" data-toggle="tab" id="tab_clipList" onclick="tab_click(this.id);">등록 내역</a></li>
                    <li><a href="#clipListenList" role="tab" data-toggle="tab" id="tab_clipListenList" onclick="tab_click(this.id);">청취 내역</a></li>
                </ul>
                <div class="tab-content">
                    <div class="tab-pane fade in active" id="clipList"><jsp:include page="../clip/clipList.jsp"/></div>       <!-- 방송 -->
                    <div class="tab-pane fade" id="clipListenList"><jsp:include page="../clip/clipListenList.jsp"/></div>         <!-- 청취 -->
                </div>
            </div>
            <div class="tab-pane fade" id="payDetail"><jsp:include page="../pay/list.jsp"/></div>               <!-- 결제 -->
            <div class="tab-pane fade" id="walletDetail"><jsp:include page="../wallet/list.jsp"/></div>             <!-- 내지갑-->
            <%--<div class="tab-pane fade" id="giftDetail"><jsp:include page="../gift/list.jsp"/></div>             <!-- 선물 -->--%>
            <div class="tab-pane fade" id="exchangeDetail"><jsp:include page="../exchange/list.jsp"/></div>     <!-- 환전 -->
            <div class="tab-pane fade" id="changeDetail"><jsp:include page="../change/list.jsp"/></div>             <!-- 교환내역 -->
            <div class="tab-pane fade" id="mystarDetail"><jsp:include page="../myStar/list.jsp"/></div>         <!-- 마이스타 -->
            <div class="tab-pane fade" id="notice"><!-- 회원게시관리 -->
                <ul class="nav nav-tabs nav-tabs-custom-colored" role="tablist">
                    <li><a href="#noticeDetail" role="tab" data-toggle="tab" id="tab_noticeBroadcastDetail" onclick="tab_click(this.id);">방송공지</a></li>
                    <li><a href="#noticeDetail" role="tab" data-toggle="tab" id="tab_noticeMemberDetail" onclick="tab_click(this.id);">회원공지</a></li>
                    <li><a href="#fanboardDetail" role="tab" data-toggle="tab" id="tab_fanboardDetail" onclick="tab_click(this.id);">팬보드</a></li>
                    <li><a href="#banwordDetail" role="tab" data-toggle="tab" id="tab_banwordDetail" onclick="tab_click(this.id);">금지어</a></li>
                </ul>
                <div class="tab-content">
                    <div class="tab-pane fade" id="noticeDetail"><jsp:include page="../../content/boardAdm/noticeList.jsp"/></div>         <!-- 회원/방송공지 -->
                    <div class="tab-pane fade" id="fanboardDetail"><jsp:include page="../fanboard/list.jsp"/></div>       <!-- 팬보드 -->
                    <div class="tab-pane fade" id="banwordDetail"><jsp:include page="../banword/list.jsp"/></div>         <!-- 금지어 -->
                </div>
            </div>
            <div class="tab-pane fade" id="declaration"><!-- 신고내역 -->
                <ul class="nav nav-tabs nav-tabs-custom-colored" role="tablist">
                    <li><a href="#declarationDetail" role="tab" data-toggle="tab" id="tab_declarationDetail" onclick="tab_click(this.id);">신고</a></li>
                    <li><a href="#withdrawalDetail" role="tab" data-toggle="tab" id="tab_withdrawalDetail" onclick="tab_click(this.id);">경고/정지</a></li>
                    <li><a href="#forcedDetail" role="tab" data-toggle="tab" id="tab_forcedDetail" onclick="tab_click(this.id);">방송 강제퇴장</a></li>
                </ul>
                <div class="tab-content">
                    <div class="tab-pane fade" id="declarationDetail"><jsp:include page="../declaration/list.jsp"/></div>         <!-- 신고 -->
                    <div class="tab-pane fade" id="withdrawalDetail"><jsp:include page="/WEB-INF/view/customer/restrictions/withdrawalList.jsp"/></div>       <!-- 경고/정지 -->
                    <div class="tab-pane fade" id="forcedDetail"><jsp:include page="/WEB-INF/view/customer/restrictions/forcedList.jsp"/></div>         <!-- 방송 강제퇴장 -->
                </div>


            </div>
            <div class="tab-pane fade" id="questionDetail"><jsp:include page="../question/list.jsp"/></div>     <!-- 문의 -->
            <div class="tab-pane fade" id="connectState"><jsp:include page="../connect/list.jsp"/></div>     <!-- 접속내역 -->
            <div class="tab-pane fade" id="edit"><!-- 수정내역 -->
                <ul class="nav nav-tabs nav-tabs-custom-colored" role="tablist">
                    <li><a href="#editHistory" role="tab" data-toggle="tab" id="tab_editHistory_all" onclick="getHistory_editHistory(this.id, -1);">전체</a></li>
                    <li><a href="#editHistory" role="tab" data-toggle="tab" id="tab_editHistory_profileImg" onclick="getHistory_editHistory(this.id, 1);">프로필이미지</a></li>
                    <li><a href="#roomEditHistory" role="tab" data-toggle="tab" id="tab_roomEditHistory_bgImg" onclick="getHistory_roomEditHistory(this.id, 1);">방송배경이미지</a></li>
                    <li><a href="#editHistory" role="tab" data-toggle="tab" id="tab_editHistory_profileMsg" onclick="getHistory_editHistory(this.id, 3);">프로필메시지</a></li>
                    <li><a href="#editHistory" role="tab" data-toggle="tab" id="tab_editHistory_etc" onclick="getHistory_editHistory(this.id, 4);">개인정보</a></li>
                    <li><a href="#clipEditHistory" role="tab" data-toggle="tab" id="tab_clipEditHistory_all" onclick="getHistory_editHistory(this.id, 5);">클립</a></li>
                </ul>
                <div class="tab-content">
                    <div class="tab-pane fade" id="editHistory"><jsp:include page="../edit/list.jsp"/></div>     <!-- 수정내역 -->
                    <div class="tab-pane fade" id="roomEditHistory"><jsp:include page="../edit/broadcastList.jsp"/></div>     <!-- 방송방수정내역 -->
                    <div class="tab-pane fade" id="clipEditHistory"><jsp:include page="../edit/clipList.jsp"/></div>     <!-- 클립수정내역 -->
                </div>
            </div>
            <div class="tab-pane fade" id="levelDetail"><jsp:include page="../level/list.jsp"/></div>     <!-- 레벨 -->
        </div>
    </div>
</div>


<script type="text/javascript" src="/js/code/member/memberCodeList.js?${dummyData}"></script>
<script type="text/javascript" src="/js/code/customer/customerCodeList.js?${dummyData}"></script>
<script type="text/javascript" src="/js/message/member/memberMessage.js?${dummyData}"></script>
<script type="text/javascript" src="/js/code/broadcast/broadCodeList.js?${dummyData}"></script>

<script>
    $(document).ready(function() {
    });
    var dtList_info_detail;
    var dtList_top_info;

    function tab_click(tmp){
        if(tmp == "tab_broadcast"){
            $("#tab_broadDetail").click();
        }else if(tmp == "tab_broadDetail"){
            getHistory_broadDetail(tmp);
        }else if(tmp == "tab_listenDetail"){
            getHistory_listenDetail(tmp);
        }else if(tmp == "tab_clip"){
            if($("#tab_clip").parent("li").hasClass("active")){
                $("#tab_clipList").click();
                return;
            }
            getHistory_clipList(tmp);
        }else if(tmp == "tab_clipList"){
            if(!$("#tab_clip").parent("li").hasClass("active")){
                $("#tab_clip").click();
            }

            getHistory_clipList(tmp);
        }else if(tmp == "tab_clipListenList"){
            if(!$("#tab_clip").parent("li").hasClass("active")){
                $("#tab_clip").click();
            }

            getHistory_clipListenList(tmp);
        }else if(tmp == "tab_payDetail"){
            getHistory_payDetail(tmp);
        }else if(tmp == "tab_walletDetail"){
            memberWalletInit("dal");
        }else if(tmp == "tab_giftDetail"){
            memberGiftInit("broadGift");
        }else if(tmp == "tab_changeDetail"){
            getHistory_changeDetail();
        }else if(tmp == "tab_mystarDetail"){
            getHistory_mystarDetail(tmp);
        }else if(tmp == "tab_notice"){
            $("#tab_noticeBroadcastDetail").click();
        }else if(tmp == "tab_noticeBroadcastDetail"){
            noticeList(null, tmp);
            // getHistory_noticeDetail(tmp);
        }else if(tmp == "tab_noticeMemberDetail"){
            noticeList(null, tmp);
            // getHistory_noticeDetail(tmp);
        }else if(tmp == "tab_fanboardDetail"){
            getHistory_fanbroadDetail(tmp);
        }else if(tmp == "tab_banwordDetail"){
            getHistory_banwordDetail(tmp);
        }else if(tmp == "tab_declaration"){
            $("#tab_declarationDetail").click();
        }else if(tmp == "tab_declarationDetail"){
            getHistory_declarationDetail(tmp);
        }else if(tmp == "tab_withdrawalDetail"){
            getRes_withdrawalList(memNo);
        }else if(tmp == "tab_forcedDetail") {
            getRes_forcedList(memNo);
        }else if(tmp == "tab_questionDetail"){
            getHistory_questionDetail(tmp);
        }else if(tmp == "tab_exchangeDetail"){
            getHistory_exchangeDetail(tmp);
        }else if(tmp == "tab_connectState"){
            getHistory_connectState(tmp);
        }else if(tmp == "tab_edit"){
            $("#tab_edit").focus();
            $("#tab_editHistory_all").click();
        }else if(tmp == "tab_editHistory_all"){
            $("#tab_editHistory_all").click();
            $("#tab_edit").click();
        }else if(tmp == "tab_editHistory_profileImg"){
            $("#tab_editHistory_profileImg").click();
            $("#tab_edit").click();
        }else if(tmp == "tab_editHistory_bgImg"){
            $("#tab_edit").click();
            $("#tab_editHistory_bgImg").click();
        }else if(tmp == "tab_editHistory_profileMsg"){
            $("#tab_edit").click();
            $("#tab_editHistory_profileMsg").click();
        }else if(tmp == "tab_editHistory_etc"){
            $("#tab_edit").click();
            $("#tab_editHistory_etc").click();
        }else if(tmp == "tab_levelDetail"){
            getHistory_levelHistory(tmp);
        }

    }
</script>