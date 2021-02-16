<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<style>
</style>

<div id="wrapper">
    <div id="page-wrapper">
        <div class="col-lg-12 form-inline no-padding" style="padding-top: 2px; padding-bottom: 0px;">
            <div class="widget-content">
                <div class="row col-lg-9" id="tabContainer">
                    <ul class="nav nav-tabs nav-tabs-custom-colored" role="tablist" id="tablist_con">
                        <li class="active"><a href="#all" role="tab" data-toggle="tab" id="tab_all">전체 클립</a></li>
                        <li><a href="#all" role="tab" data-toggle="tab" id="tab_today">일자별 클립</a></li>
                        <li><a href="#member" role="tab" data-toggle="tab" id="tab_member">회원별 클립</a></li>
                        <li><a href="#listen" role="tab" data-toggle="tab" id="tab_listen">클립 청취내역</a></li>
                        <li><a href="#gift" role="tab" data-toggle="tab" id="tab_gift">클립 선물내역</a></li>
                        <li><a href="#remove" role="tab" data-toggle="tab" id="tab_remove">클립 삭제내역</a></li>
                        <li><a href="#copyright" role="tab" data-toggle="tab" id="tab_copyright">저작권 청취내역</a></li>
                    </ul>
                </div>
                <div class="col-lg-3" id="headerInfo">
                </div>
                <div class="tab-content col-lg-12">
                    <div class="tab-pane fade in active" id="all"><jsp:include page="history.jsp"/></div>      <!-- 클립 관리(전체/오늘) -->
                    <%--<div class="tab-pane fade" id="today"><jsp:include page="history.jsp"/></div>      <!-- 클립 관리 -->--%>
                    <div class="tab-pane fade" id="member"><jsp:include page="member.jsp"/></div>      <!-- 클립 관리(회원별) -->
                    <div class="tab-pane fade" id="listen"><jsp:include page="listen.jsp"/></div>    <!-- 클립 청취 -->
                    <div class="tab-pane fade" id="gift"><jsp:include page="gift.jsp"/></div>    <!-- 클립 선물 -->
                    <div class="tab-pane fade" id="remove"><jsp:include page="remove.jsp"/></div>    <!-- 클립 삭제 -->
                    <div class="tab-pane fade" id="copyright"><jsp:include page="copyright.jsp"/></div>    <!-- 저작권 청취 내역 -->
                </div>
            </div>
        </div>
    </div>
    <!-- /#page-wrapper -->
    <!-- 팬보드 댓글 보기 -->
    <div class="modal fade" id="clipReplyModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
        <div class="modal-dialog" style="width: 800px;">
            <div class="modal-content">
                <div class="modal-header no-padding">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                </div>
                <div class="modal-body" style="display: table">
                    <div class="col-md-12 no-padding" id="div_reply">
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<!-- /#wrapper -->

<script type="text/javascript">
    var tabId = 'tab_all';

    $("#tablist_con li a").on('click', function(){
        tabId = $(this).prop('id');

        $("#search_aria").html(util.getCommonCodeSelect(-1, clip_searchType));
        $("#search_aria").hide();
        $("#txt_search").val("");
        $("#headerInfo").html("");
        $("#headerInfo").hide();
        $("#page-wrapper").css("height", "85px");
        $("#searchContainer").removeClass("col-lg-7");
        $("#totalContainer").removeClass("col-lg-5");
        $("#tabContainer").removeClass("col-lg-7");
        $("#searchContainer").addClass("col-lg-9");
        $("#totalContainer").addClass("col-md-3");
        $("#tabContainer").addClass("col-lg-9");

        $("._prevSearch").hide();
        $("._todaySearch").hide();
        $("._nextSearch").hide();

        $("input:radio[name='isChoiceDate']:radio[value='1']").prop('checked', true);  // 날짜 전체, 선택 여부

        $("#isChoiceDateArea").hide();
        $("#searchClipArea").show();
        $("#searchClipArea").empty();

        $("#searchClipArea").empty();
        $("#searchClipArea").append(util.getCommonCodeSelect(-1, searchClip));

        $("#searchText").attr('style', 'width: 188px;');
        if(tabId == 'tab_all'){         //클립 관리 (전체)
            slctType = 99;
            $("input:radio[name='isChoiceDate']:radio[value='-1']").prop('checked', true);  // 날짜 전체, 선택 여부
            $('#searchText, #bt_search').show();
            initClipHistory();
        }else if(tabId == 'tab_today'){     //클립 관리 (오늘)
            $("#searchText").attr('style', 'width: 100px;');
            slctType = 3;
            $("._prevSearch").show();
            $("._todaySearch").show();
            $("._nextSearch").show();
            $('#searchText, #bt_search').show();
            initClipHistory();
        }else if(tabId == 'tab_member'){    // 클립 관리 (회원)
            // $("#searchClipArea").append(util.getCommonCodeSelect(-1, searchMember));
            slctType = 99;
            $("input:radio[name='isChoiceDate']:radio[value='-1']").prop('checked', true);  // 날짜 전체, 선택 여부
            $("#search_aria").html(util.getCommonCodeSelect(-1, clip_member_searchType));
            $('#searchText, #bt_search').show();
        }else if(tabId == 'tab_listen'){    // 클립 청취
            slctType = 3;
            $("._prevSearch").show();
            $("._todaySearch").show();
            $("._nextSearch").show();
            $("#search_aria").html(util.getCommonCodeSelect(-1, clip_listen_searchType));
            $("#div_stepButtonArea").show();
            $('#searchText, #bt_search').show();
        }else if(tabId == 'tab_gift'){      // 클립 선물
            slctType = 3;
            $("._prevSearch").show();
            $("._todaySearch").show();
            $("._nextSearch").show();
            $("#search_aria").html(util.getCommonCodeSelect(-1, clip_gift_searchType));
            $("#isChoiceDateArea").show();
            $('#searchText, #bt_search').show();
        }else if(tabId == 'tab_remove'){        //클립 삭제
            slctType = 3;
            $("._prevSearch").show();
            $("._todaySearch").show();
            $("._nextSearch").show();
            $("#isChoiceDateArea").show();
            $('#searchText, #bt_search').show();
        }else if(tabId == 'tab_copyright'){
            slctType = 1;
            $("._prevSearch").show();
            $("._todaySearch").show();
            $("._nextSearch").show();
            $('#searchText').hide();
            $("#searchClipArea").hide();
            initClipHistory();
            $("#page-wrapper").css("height", "90px");
        }
        dateType();

        $(".searchDate").html($("#onedayDate").val());
        $("#bt_search").click();
    });

    $("#bt_search").on('click', function(){
        if($('input[name="slctType"]:first').prop('checked')){
            $("._searchDate").html($("#startDate").val() + " (" + toDay + ")");
        }
        if(tabId == 'tab_all'){
            getHistory();
        }else if(tabId == 'tab_today'){
            getHistory();
        }else if(tabId == 'tab_member'){
            getHistoryMember();
        }else if(tabId == 'tab_listen'){
            getHistoryListen();
        }else if(tabId == 'tab_gift'){
            getHistoryGift();
        }else if(tabId == 'tab_remove'){
            getHistoryRemove();
        }else if(tabId == 'tab_copyright') {
            copyrightPagingInfo.pageNo = 1;
            getHistoryCopyright();
        }
    });

</script>