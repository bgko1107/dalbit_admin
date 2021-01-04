<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="cfn" uri="/WEB-INF/tld/comFunction.tld" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<sec:authentication var="principal" property="principal" />
<c:set var="dummyData"><%= java.lang.Math.round(java.lang.Math.random() * 1000000) %></c:set>
<style>
</style>

<div id="wrapper">
    <div id="page-wrapper">
        <div class="row col-lg-12 form-inline">
            <div class="widget-content">
                <ul class="nav nav-tabs nav-tabs-custom-colored" role="tablist" id="tablist_con">
                    <li class="active"><a href="#total" role="tab" data-toggle="tab" id="tab_total">총계</a></li>
                    <li><a href="/money/exchange/list?tabType=1" id="tab_specialDj">스페셜DJ</a></li>
                    <li><a href="/money/exchange/list?tabType=2" id="tab_user">일반회원</a></li>
                    <c:if test="${fn:contains('|이재은|이형원|전유신|강다인|고병권|이재호|양효진|최계석|손우걸|', principal.getUserInfo().getName())}">
                        <li class="_tab ml15">
                            <a href="/money/exchange/list?tabType=3" id="rejectList">취소내역</a>
                        </li>
                    </c:if>
                    <li><a href="/money/exchange/list?tabType=4" id="enableList">환전신청 가능회원</a></li>
                </ul>
                <div class="tab-content">
                    <div class="tab-pane fade in active" id="total"><jsp:include page="total.jsp"/></div>      <!-- 총계 -->
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
        if(tabId == 'tab_total'){
            getMonthList();
        }

        $(".searchDate").html($("#onedayDate").val());
    });

    $("#bt_search").on('click', function(){

        if($('input[name="slctType"]:first').prop('checked')){
            $("._searchDate").html($("#startDate").val() + " (" + toDay + ")");
        }
        getList();
        $("#tablist_con li.active a").click();
    });
</script>