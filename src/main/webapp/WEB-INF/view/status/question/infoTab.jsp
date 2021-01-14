<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<style>
</style>

<div id="wrapper">
    <div id="page-wrapper">
        <div class="row col-lg-12 form-inline" style="padding-top: 2px; padding-bottom: 0px;">
            <div class="widget-content">
                <ul class="nav nav-tabs nav-tabs-custom-colored" role="tablist" id="tablist_con">
                    <li class="active"><a href="#total" role="tab" data-toggle="tab" id="tab_totalDetail">총계</a></li>
                    <li><a href="#type" role="tab" data-toggle="tab" id="tab_typeDetail">유형별</a></li>
                    <li><a href="#platform" role="tab" data-toggle="tab" id="tab_platformDetail">플랫폼별</a></li>
                    <li><a href="#untreated" role="tab" data-toggle="tab" id="tab_untreatedDetail">미처리</a></li>
                    <li><a href="/customer/question/list?tabType=0" title="전체 문의 페이지로 이동합니다.">전체 문의</a></li>
                    <%--<li><a href="/customer/question/list?tabType=1" title="회원 문의 페이지로 이동합니다.">회원 문의</a></li>--%>
                    <%--<li><a href="/customer/question/list?tabType=2" title="비회원 문의 페이지로 이동합니다.">비회원 문의</a></li>--%>
                    <li><a href="/customer/question/macro?tabType=0" title="매크로 관리 페이지로 이동합니다.">매크로 관리</a></li>
                </ul>
                <div class="tab-content">
                    <div class="tab-pane fade in active" id="total"><jsp:include page="total.jsp"/></div>       <!-- 총계 -->
                    <div class="tab-pane fade" id="type"><jsp:include page="type.jsp"/></div>                   <!-- 유형별 -->
                    <div class="tab-pane fade" id="platform"><jsp:include page="platform.jsp"/></div>           <!-- 플랫폼별 -->
                    <div class="tab-pane fade" id="untreated"><jsp:include page="untreated.jsp"/></div>         <!-- 미처리 -->
                </div>
            </div>
        </div>
    </div>
    <!-- /#page-wrapper -->
</div>
<!-- /#wrapper -->

<script type="text/javascript">
    $("#tablist_con li a").on('click', function(){
        var tabId = $(this).prop('id');
        if(tabId == 'tab_totalDetail'){
            getTotalList();
        }else if(tabId == 'tab_typeDetail'){
            getSlctList();
        }else if(tabId == 'tab_platformDetail'){
            getPlatformList();
        }else if(tabId == 'tab_untreatedDetail'){
            getUntreatedList();
        }

        $(".searchDate").html($("#onedayDate").val());
    });

    $("#bt_search").on('click', function(){

        if($('input[name="slctType"]:first').prop('checked')){
            $("._searchDate").html($("#startDate").val() + " (" + toDay + ")");
        }

        $("#tablist_con li.active a").click();
    });
</script>