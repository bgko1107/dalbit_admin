<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="dummyData" value="<%= java.lang.Math.round(java.lang.Math.random() * 1000000) %>" />

<div id="wrapper">
    <div id="page-wrapper">
        <div class="container-fluid">
            <!-- tab -->
            <div class="col-lg-12 no-padding">
                <div class="widget-content">
                    <div id="tabContainer">
                        <ul class="nav nav-tabs nav-tabs-custom-colored" role="tablist" id="tablist_con">
                            <li class="active"><a href="#condition" role="tab" data-toggle="tab" id="tab_condition" class="_videoSettingTab" data-clickcnt="1">설정 관리</a></li>
                        </ul>
                    </div>

                    <div class="col-lg-12 no-padding">
                      <br/><span class="font-bold">1:1 영상대화의 설정을 관리할 수 있습니다.</span>
                    </div>

                    <div class="tab-content">
                        <div class="tab-pane fade in active" id="condition"><jsp:include page="list.jsp"/></div>      <!-- 조건 관리 -->
                    </div>
                </div>
            </div>
            <!-- //tab -->
        </div> <!-- //container-fluid form-inline -->
    </div> <!-- //page-wrapper -->
</div> <!-- //wrapper -->


<script type="text/javascript">

    $('._videoSettingTab').on('click', function(){
       var me = $(this);
       var clickCnt = me.data('clickcnt');
       /*if(0 == clickCnt){
           me.data('clickcnt', clickCnt+1);
           if(me.prop('id') == 'tab_word'){
               getFullmoonWord();
           }
       }
        if(me.prop('id') == 'tab_event'){
            getFullmoonEventList();
        }*/
    });
</script>