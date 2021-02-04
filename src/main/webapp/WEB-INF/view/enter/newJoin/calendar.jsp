<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div class="wrapper">
    <div id="page-wrapper">
        <div id="container-fluid">
            <div class="widget-content col-md-10">
                <div class="calendar col-md-10 no-padding"></div>
                <div class="col-md-2 no-padding" id="totalTable"></div>
            </div>
        </div>
    </div>
</div>
<!-- /wrapper -->


<!-- Javascript -->
<script src="/template/js/plugins/fullcalendar/fullcalendar.js"></script>
<script src="/template/js/plugins/jquery-simplecolorpicker/jquery.simplecolorpicker.js"></script>
<script type="text/javascript">

    $(function(){
        //init();
    });

    function getCalendar(){
        $("#summary_today").html(moment(new Date()).format('YYYY-MM-DD'));
        renderCalendar();
    }

    function renderCalendar(){
        $('.calendar').fullCalendar('destroy').fullCalendar({
            header: {
                //left: 'month, agendaWeek, agendaDay',
                left: '',
                center: 'prev, title, next',
                right: 'today',
            },
            sundayFontColor:'red',
            saturdayFontColor:'blue',
            events: function(start, end, timezone, callback) {
                var month =  $('.fc-day').not('.fc-other-month').first().data('date').replace(/-/gi,".") + " - " + $('.fc-day').not('.fc-other-month').last().data('date').replace(/-/gi,".") + "@";
                $.ajax({
                    url: '/rest/enter/newJoin/info/calender',
                    type: 'post',
                    dataType: 'json',
                    data: {
                        dateList : month,
                        slctType : 1
                    },
                    success: function(response) {
                        if(!common.isEmpty(response.data.detailList)){
                            response.data.detailList.forEach(function(detail, detailIndex) {
                                var the_date = detail.the_date;
                                var dayTarget = $('.fc-day[data-date="' + the_date + '"]').find('.fc-day-content');
                                var template = $('#tmp_calendarData').html();
                                var templateScript = Handlebars.compile(template);
                                var context = detail;
                                var html = templateScript(context);
                                dayTarget.append(html);
                            });
                        }

                        $("#totalTable").empty();
                        var template = $('#tmp_totalTable').html();
                        var templateScript = Handlebars.compile(template);
                        var detailContext = response.data.totalInfo;
                        var html=templateScript(detailContext);
                        $("#totalTable").append(html);
                        ui.paintColor();
                    }
                });
            }
        });
    }

</script>

<script type="text/x-handlebars-template" id="tmp_calendarData">
    <div style="color: blue;">{{{sexIcon 'm'}}} : {{addComma total_join_mCnt}}/{{addComma total_out_mCnt}} ({{average total_out_mCnt total_out_Cnt 0}}%)</div>
    <div style="color: red;">{{{sexIcon 'f'}}} : {{addComma total_join_fCnt}}/{{addComma total_out_fCnt}} ({{average total_out_fCnt total_out_Cnt 0}}%)</div>
    <div style="color: black">{{{sexIcon 'n'}}} : {{addComma total_join_nCnt}}/{{addComma total_out_nCnt}} ({{average total_out_nCnt total_out_Cnt 0}}%)</div>
    <div class="font-bold" style="color: #ff5600;">총계 : {{addComma total_join_Cnt}}/{{addComma total_out_Cnt}} ({{average total_out_Cnt total_out_Cnt 0}}%)</div>
</script>

<script type="text/x-handlebars-template" id="tmp_totalTable">
    <br/><br/>
    <table class="table table-bordered" style="width: 100%">
        <colgroup>
            <col width="33%"/><col width="33%"/><col width="33%"/>
        </colgroup>
        <tbody>
            <tr>
                <th>구분</th>
                <th>가입수</th>
                <th>탈퇴수</th>
            </tr>
            <tr style="color: blue">
                <td>{{{sexIcon 'm'}}}</td>
                <td>{{addComma total_join_mCnt}} ({{average total_join_mCnt total_join_Cnt 0}}%)</td>
                <td>{{addComma total_out_mCnt}} ({{average total_out_mCnt total_out_Cnt 0}}%)</td>
            </tr>
            <tr style="color: red">
                <td>{{{sexIcon 'f'}}}</td>
                <td>{{addComma total_join_fCnt}} ({{average total_join_fCnt total_join_Cnt 0}}%)</td>
                <td>{{addComma total_out_fCnt}} ({{average total_out_fCnt total_out_Cnt 0}}%)</td>
            </tr>
            <tr>
                <td>{{{sexIcon 'n'}}}</td>
                <td>{{addComma total_join_nCnt}} ({{average total_join_nCnt total_join_Cnt 0}}%)</td>
                <td>{{addComma total_out_nCnt}} ({{average total_out_nCnt total_out_Cnt 0}}%)</td>
            </tr>
            <tr class="font-bold" style="color: #ff5600">
                <td>총합</td>
                <td>{{addComma total_join_Cnt}} ({{average total_join_Cnt total_join_Cnt 0}}%)</td>
                <td>{{addComma total_out_Cnt}} ({{average total_out_Cnt total_out_Cnt 0}}%)</td>
            </tr>
        </tbody>
    </table>
</script>