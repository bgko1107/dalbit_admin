<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<style>
</style>

<div id="wrapper">
    <div id="page-wrapper">
       <div class="widget-content">
           <ul class="nav nav-tabs nav-tabs-custom-colored" role="tablist" id="tablist_con">
               <li class="active"><a href="#recommDJlist" role="tab" data-toggle="tab" class="_tab">추천DJ목록</a></li>
               <%--<li><a href="#recommDJStat" role="tab" data-toggle="tab" class="_tab">오늘의 추천DJ</a></li>--%>
           </ul>
           <div class="tab-content no-padding">
               <div class="tab-pane fade in active" id="recommDJlist"><jsp:include page="recommDJlist.jsp"/></div>
           </div>
       </div>
    </div>
    <!-- /#page-wrapper -->
</div>
<!-- /#wrapper -->

<script type="text/javascript">

    var TAB_INDEX = 0;

    $('._tab').on('click', function(){
        $('#dalList, #sampleDalList, #reqDalList').empty();

        $('#txt_search').val('');

        var me = $(this);
        var tab = me.parent();

        var tabIndex = $('#tablist_con li').index(tab);
        TAB_INDEX = tabIndex;

        if(tabIndex == 0){
            slctType = 3;

        } else if (tabIndex == 1){
            slctType = 1;
        }
        dateType();
    });


    $('#bt_search').on('click', function () {
        if (TAB_INDEX == 0) {
            recommendDjList();
        } else if (TAB_INDEX == 1) {
            // expectiedList();
        }
    });

    $('input[id="searchText"]').keydown(function () {
        if (event.keyCode === 13) {
            $("#bt_search").click();
        };
    });
</script>