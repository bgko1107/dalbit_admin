<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="dummyData" value="<%= java.lang.Math.round(java.lang.Math.random() * 1000000) %>" />

<div id="wrapper">
    <div id="page-wrapper">
        <div class="container-fluid form-inline">
            <div class="row">

                <div class="col-lg-12 mb15">
                    <b>보름달 띄우기를 관리할 수 있는 메뉴입니다.<br/>조건 수정 시 방을 만들 때 시점으로 데이터가 적용됩니다. 방송 중이면 수정 전 조건으로 적용됩니다.</b>
                </div>

                <!-- tab -->
                <div class="col-lg-12">
                    <div class="widget-content">
                        <div id="tabContainer">
                            <ul class="nav nav-tabs nav-tabs-custom-colored" role="tablist" id="tablist_con">
                                <li class="active"><a href="#condition" role="tab" data-toggle="tab" id="tab_condition" class="_fullmoonTab" data-clickcnt="1">조건 관리</a></li>
                                <li><a href="#word" role="tab" data-toggle="tab" id="tab_word" class="_fullmoonTab" data-clickcnt="0">문구 관리</a></li>
                                <li><a href="#event" role="tab" data-toggle="tab" id="tab_event" class="_fullmoonTab" data-clickcnt="0">이벤트 관리</a></li>
                            </ul>
                        </div>

                        <div class="tab-content">
                            <div class="tab-pane fade in active" id="condition"><jsp:include page="condition.jsp"/></div>      <!-- 조건 관리 -->
                            <div class="tab-pane fade" id="word"><jsp:include page="word.jsp"/></div>              <!-- 문구 관리 -->
                            <div class="tab-pane fade" id="event"><jsp:include page="event.jsp"/></div>              <!-- 문구 관리 -->
                        </div>
                    </div>
                </div>
                <!-- //tab -->

            </div> <!-- //row -->
        </div> <!-- //container-fluid form-inline -->
    </div> <!-- //page-wrapper -->
</div> <!-- //wrapper -->


<script type="text/javascript">
    /*$(document).on('click', '#tablist_con li', function(){
       console.log('tab click');

    });*/

    $('._fullmoonTab').on('click', function(){
       var me = $(this);
       var clickCnt = me.data('clickcnt');
       if(0 == clickCnt){
           me.data('clickcnt', clickCnt+1);
           if(me.prop('id') == 'tab_word'){
               getFullmoonWord();
           }
       }
        if(me.prop('id') == 'tab_event'){
            getFullmoonEventList();
        }
    });
</script>