<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<style>
</style>

<div id="wrapper">
    <div id="page-wrapper">
       <div class="widget-content">
           <ul class="nav nav-tabs nav-tabs-custom-colored" role="tablist" id="tablist_con">
               <li class="active"><a href="#dal" role="tab" data-toggle="tab" class="_tab">샤이닝 DJ</a></li>
               <li><a href="#reqDal" role="tab" data-toggle="tab" class="_tab">예상 후보 파악</a></li>
           </ul>
           <div class="tab-content no-padding">
               <div class="tab-pane fade in active" id="dal"><jsp:include page="shiningList.jsp"/></div>
               <div class="tab-pane fade" id="reqDal"><jsp:include page="expectedList.jsp"/></div>
           </div>
       </div>
    </div>
    <!-- /#page-wrapper -->
</div>
<!-- /#wrapper -->

<script type="text/javascript">

    var TAB_INDEX = 0;

    function getList(){

        $('#dalList').empty();
        $('#sampleDalList').empty();
        $('#reqDalList').empty();

        ui.topScroll();

        var index = $("#tablist_con li").index(("#tablist_con li.active"));
        index == 0 ? shiningList() : expectiedList();

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
        TAB_INDEX = tabIndex;

        if(tabIndex == 0){
            slctType = 1;
        } else if (tabIndex == 1){
            slctType = 0;
        }
        dateType();
    });
</script>