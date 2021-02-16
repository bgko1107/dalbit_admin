<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<style>
</style>

<div id="wrapper">
    <div id="page-wrapper">
       <div class="widget-content">
           <ul class="nav nav-tabs nav-tabs-custom-colored" role="tablist" id="tablist_con">
               <li class="active"><a href="#dal" role="tab" data-toggle="tab" class="_tab">스페셜 DJ</a></li>
               <li><a href="#reqDal" role="tab" data-toggle="tab" class="_tab">스페셜 DJ 신청</a></li>
               <li><a href="#reqManage" role="tab" data-toggle="tab" class="_tab">스페셜 DJ 신청관리</a></li>
               <li><a href="#reqAble" role="tab" data-toggle="tab" class="_tab">스페셜 DJ 신청 가능 회원</a></li>
               <li><a href="#bestAble" role="tab" data-toggle="tab" class="_tab">베스트 스페셜 DJ 가능 회원</a></li>
           </ul>
           <div class="tab-content no-padding">
               <div class="tab-pane fade in active" id="dal"><jsp:include page="specialDal.jsp"/></div>
               <div class="tab-pane fade" id="reqDal"><jsp:include page="reqSpecialDal.jsp"/></div>
               <div class="tab-pane fade" id="reqManage"><jsp:include page="reqManageList.jsp"/></div>
               <div class="tab-pane fade" id="reqAble"><jsp:include page="reqAbleSpecialDal.jsp"/></div>
               <div class="tab-pane fade" id="bestAble"><jsp:include page="bestSpecialDal.jsp"/></div>
           </div>
       </div>
    </div>
    <!-- /#page-wrapper -->
</div>
<!-- /#wrapper -->

<script type="text/javascript">

    function getList(){

        $('#dalList').empty();
        $('#sampleDalList').empty();
        $('#reqDalList').empty();

        ui.topScroll();

        var index = $("#tablist_con li").index(("#tablist_con li.active"));
        index == 0 ? init() : initReq()

    }

    function emptySearch() {
        $('#txt_search').val('');
        $('#searchArea').html(util.getCommonCodeSelect(-1, searchMember, 'Y', 'searchType'));
    }

    $('._tab').on('click', function(){
        $('#dalList, #sampleDalList, #reqDalList').empty();

        emptySearch();

        var me = $(this);
        var tab = me.parent();

        var tabIndex = $('#tablist_con li').index(tab);

        $("#searchMemberArea").show();
        if(tabIndex == 0){

            specialDjPagingInfo.pageNo = 1;
            init();
        } else if (tabIndex == 1){
            initReq();
        } else if(tabIndex == 2) {
            $("#searchMemberArea").hide();
            $("#reqManageDetail").empty();
            initManage();
        } else if(tabIndex == 3){
            initReqAble();
        } else if (tabIndex == 4) {
            initbestAble();
        }
    });
</script>