<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div id="wrapper">
    <div id="page-wrapper">
        <div class="widget-content">
            <ul class="nav nav-tabs nav-tabs-custom-colored" role="tablist" id="tablist_con">
                <li class="active"><a href="#weekly" role="tab" data-toggle="tab" id="tab_weekly">위클리픽</a></li>
                <li><a href="#second" role="tab" data-toggle="tab" id="tab_second">15초 광고 모델</a></li>
            </ul>
            <div class="tab-content no-padding">
                <div class="tab-pane fade in active" id="weekly"><jsp:include page="weekly.jsp"/></div>
                <%--<div class="tab-pane fade" id="second"><jsp:include page="second.jsp"/></div>--%>
            </div>
        </div>
    </div>
    <!-- /#page-wrapper -->
</div>
<!-- /#wrapper -->

<script type="text/javascript">

    var tabId = "tab_weekly";
    $("#tablist_con li a").on('click', function(){
        tabId = $(this).prop('id');

        $("#bt_search").click();
    });

    $("#bt_search").on('click', function(){
        //if(tabId == 'tab_weekly'){
        $('#detailArea').hide();
        getMarketingList(tabId);
        /*}else if(tabId == 'tab_second') {
            getMarketingList(tabId);
        }*/
    });
</script>