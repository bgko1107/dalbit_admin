<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div id="wrapper">
    <div id="page-wrapper">
        <div class="row col-lg-12 form-inline" style="padding-top: 2px; padding-bottom: 0px;">
            <div class="widget-content">
                <ul class="nav nav-tabs nav-tabs-custom-colored" role="tablist" id="tablist_con">
                    <li class="active"><a href="#eventDetail" role="tab" data-toggle="tab" id="tab_eventDetail">이벤트 정보</a></li>
                    <li><a href="#eventPrize" role="tab" data-toggle="tab" id="tab_eventPrize">경품 관리</a></li>
                    <li><a href="#eventWinnerApplicant" role="tab" data-toggle="tab" id="tab_eventWinnerApplicant">응모자 / 당첨자 관리</a></li>
                    <li><a href="#eventWinnerAnnounce" role="tab" data-toggle="tab" id="tab_eventWinnerAnnounce">당첨자 발표</a></li>
                    <li><a href="#eventReply" role="tab" data-toggle="tab" id="tab_eventReply">이벤트 댓글</a></li>
                </ul>
                <div class="tab-content">
                    <div class="tab-pane fade in active" id="eventDetail"><jsp:include page="eventDetail.jsp"/></div>
                    <div class="tab-pane fade" id="eventPrize"><jsp:include page="eventPrize.jsp"/></div>
                    <div class="tab-pane fade" id="eventWinnerApplicant"><jsp:include page="eventWinnerApplicant.jsp"/></div>
                    <div class="tab-pane fade" id="eventWinnerAnnounce"><jsp:include page="eventWinnerAnnounce.jsp"/></div>
                    <div class="tab-pane fade" id="eventReply"><jsp:include page="eventReply.jsp"/></div>
                </div>
            </div>
        </div>
    </div>
</div>

<script type="text/javascript">
    $(document).ready(function () {
    });

    $('#tab_eventWinnerAnnounce').on('click', function() {
        if($('#tab_eventWinnerAnnounce').attr('disabled')) {
            alert('당첨자 선정을 완료해야 당첨자 발표가 가능합니다.');
            return false;
        } else {
            initWinnerAnnounce();
        }
    });

    $('#tablist_con li a').on('click', function() {

       var tab = $(this).prop('id').split("_")[1];
       if(tab == 'eventDetail') {
           initDetail();
       } else if(tab == 'eventPrize') {
           initPrize();
       } else if(tab == 'eventWinnerApplicant') {
           initWinnerApplicant();
       } else if(tab == 'eventWinnerAnnounce') {
           initWinnerAnnounce();
       } else if(tab == 'eventReply') {
           initEventReply();
       }
    });

    function showTab(){
        var eventidx = $("#eventidx").val();
        if(eventidx == 0) {
            initDetail_insert();
            $('#tab_eventPrize').hide();
            $('#tab_eventWinnerApplicant').hide();
            $('#tab_eventWinnerAnnounce').hide();
        } else if (eventidx != 0) {
            initDetail();
            $('#tab_eventPrize').show();
            $('#tab_eventWinnerApplicant').show();
            $('#tab_eventWinnerAnnounce').show();
            tabClick();
        }
        $(".main-content").show();
    }

    function tabClick() {
        $('#tablist_con li a').on('click', function() {
            var tab = $(this).prop('id').split("_")[1];
            if(tab == 'eventPrize') {
                initPrize();
            } else if(tab == 'eventWinnerApplicant') {
                initWinnerApplicant();
            } else if(tab == 'eventWinnerAnnounce') {
                initWinnerAnnounce();
            }
        });
    }

</script>