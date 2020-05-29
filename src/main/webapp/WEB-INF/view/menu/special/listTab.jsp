<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<style>
</style>

<div id="wrapper">
    <div id="page-wrapper">
       <div class="widget-content">
           <ul class="nav nav-tabs nav-tabs-custom-colored" role="tablist" id="tablist_con">
               <li class="active"><a href="#dal" role="tab" data-toggle="tab" class="_tab">스페셜 달D</a></li>
               <li><a href="#reqDal" role="tab" data-toggle="tab" class="_tab">스페셜 신청 달D</a></li>
           </ul>
           <div class="tab-content no-padding">
               <div class="tab-pane fade in active" id="dal"><jsp:include page="specialDal.jsp"/></div>           <!-- 스페셜 달D -->
               <div class="tab-pane fade" id="reqDal"><jsp:include page="reqSpecialDal.jsp"/></div>               <!-- 스페셜 신청 달D -->
           </div>
       </div>
    </div>
    <!-- /#page-wrapper -->
</div>
<!-- /#wrapper -->

<script type="text/javascript">
    $(function(){
        getList();
    });

    function getList(){

        //getSummary();

        // $('#tablist_con li.active:first a').click();
        $('#dalList').empty();
        $('#sampleDalList').empty();
        $('#reqDalList').empty();

        ui.topScroll();

        var index = $("#tablist_con li").index(("#tablist_con li.active"));
        index == 0 ? init() : initReq();
    }

    function emptySearch() {
        $('#txt_search').val('');
        $('#searchArea').html(util.getCommonCodeSelect(-1, special_searchType));
    }

    $('._tab').on('click', function(){
        $('#dalList, #sampleDalList, #reqDalList').empty();

        var me = $(this);
        var tab = me.parent();

        var tabIndex = $('#tablist_con li').index(tab);
        if(tabIndex == 0){
            emptySearch();
            specialDjPagingInfo.pageNo = 1;
            init();
        } else{
            emptySearch();
            initReq();
        }
    });
</script>