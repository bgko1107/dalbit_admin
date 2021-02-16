<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<style>
</style>

<div id="wrapper">
    <div id="page-wrapper">
        <div class="col-lg-12 form-inline no-padding" style="padding-top: 2px; padding-bottom: 0px;">
            <div class="widget-content">
                <div class="col-lg-12 no-padding" id="tabContainer">
                    <ul class="nav nav-tabs nav-tabs-custom-colored" role="tablist" id="tablist_con">
                        <li class="active"><a href="#clipList" role="tab" data-toggle="tab" id="tab_new">최신 클립</a></li>
                        <li><a href="#clipList" role="tab" data-toggle="tab" id="tab_hot">인기 클립</a></li>
                        <li><a href="#clipRank" role="tab" data-toggle="tab" id="tab_clipRank">클립 랭킹</a></li>
                        <li><a href="#recommendList" role="tab" data-toggle="tab" id="tab_recommendList">주간 클립 테이블</a></li>
                        <%--<li><a href="#recommendClip" role="tab" data-toggle="tab" id="tab_recommendClip">추천 클립 등록관리</a></li>--%>
                        <li><a href="#category" role="tab" data-toggle="tab" id="tab_category">주제 관리</a></li>
                    </ul>
                </div>
                <div class="tab-content col-lg-12">
                    <div class="tab-pane fade in active" id="clipList"><jsp:include page="clipList.jsp"/></div>      <!-- 인기 클립 -->
                    <div class="tab-pane fade" id="clipRank"><jsp:include page="clipRankList.jsp"/></div>      <!-- 주제 관리 -->
                    <div class="tab-pane fade" id="recommendList"><jsp:include page="recommendList.jsp"/></div>      <!-- 주제 관리 -->
                    <%--<div class="tab-pane fade" id="recommendClip"><jsp:include page="recommendClip.jsp"/></div>      <!-- 주제 관리 -->--%>
                    <div class="tab-pane fade" id="category"><jsp:include page="clipCategoryList.jsp"/></div>      <!-- 주제 관리 -->
                </div>
            </div>
        </div>
    </div>
    <!-- /#page-wrapper -->
</div>
<!-- /#wrapper -->

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

<script type="text/javascript">
    $("#tablist_con li a").on('click', function(){
        tabId = $(this).prop('id');

        $("#page-wrapper").show();
        $("#search_aria").html(util.getCommonCodeSelect(-1, clip_searchType));
        $("#search_aria").hide();
        $("#searchText").val("");
        $("#headerInfo").html("");
        $("#headerInfo").hide();
        $("#sp_radioGroup").hide();
        $("#sp_prevGroup").hide();

        $("#searchClipArea").show();
        $("#searchText").show();
        $("#searchRadio").show();

        if(tabId == 'tab_category'){    // 카테고리
            $("#page-wrapper").hide();
        }else if(tabId == 'tab_clipRank'){
            $("#searchRadio").hide();
            $("#searchClipArea").hide();
            $("#searchText").hide();
            $("#sp_radioGroup").show();
            $("#sp_prevGroup").show();
            slctType = 0;
        }else if(tabId == 'tab_recommendList'){
            $("#sp_prevGroup").show();
            slctType = 1;
        }else{
            slctType = 99;
        }
        dateType();
        $(".searchDate").html($("#onedayDate").val());
        // $("#bt_search").click();
    });

    $("#bt_search").on('click', function(){
        if(tabId == 'tab_hot'){
            initClipHotList();
            getClipList();
        }else if(tabId == 'tab_new'){
            initClipNewList();
            getClipList();
        }else if(tabId == 'tab_clipRank'){
            getClipRankList();
        }else if(tabId == 'tab_recommendList'){
            getRecommendList();
        }else if(tabId == 'tab_category'){
            getClipCategory();
        }
    });

</script>