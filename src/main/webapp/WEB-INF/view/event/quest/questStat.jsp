<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!-- 보름달 완성 조건(DJ) -->
<div class="col-md-12 no-padding" id="detailInfo">
    <div class="col-lg-12 form-inline mt15 no-padding">
        <div class="widget widget-table">
            <div class="widget-content mt10">
                <table class="table table-sorting table-hover table-bordered">
                    <colgroup>
                        <col width="6.6%"/><col width="6.6%"/><col width="6.6%"/><col width="6.6%"/><col width="6.6%"/>
                        <col width="6.6%"/><col width="6.6%"/><col width="6.6%"/><col width="6.6%"/><col width="6.6%"/>
                        <col width="6.6%"/><col width="6.6%"/><col width="6.6%"/><col width="6.6%"/><col width="6.6%"/>
                    </colgroup>
                    <thead>
                    <tr>
                        <th></th>
                        <th>로그인수</th>
                        <th>참여자수</th>
                        <th>참여건수</th>
                        <th>퀘스트1</th>
                        <th>퀘스트2</th>
                        <th>퀘스트3</th>
                        <th>퀘스트4</th>
                        <th>퀘스트5</th>
                        <th>퀘스트6</th>
                        <th>퀘스트7</th>
                        <th>퀘스트8</th>
                        <th>보너스</th>
                        <th>경험치</th>
                        <th>달</th>
                    </tr>
                    </thead>
                    <tbody id="questStatTbody">
                    </tbody>
                </table>
            </div>
        </div>
    </div>
    <div class="widget-content col-md-12 no-padding">
        <div class="calendar col-md-8 no-padding"></div>
        <div class="col-md-4 no-padding">
            <div id='pieArea'></div>
        </div>
    </div>
</div>
<!-- //보름달 완성 조건(DJ) -->

<script src="/template/js/plugins/fullcalendar/fullcalendar.js"></script>
<script src='/js/lib/plotly-latest.min.js'></script>

<script>

    function questStat() {

        var template = $('#tmp_questStat_detail').html();
        var templateScript = Handlebars.compile(template);
        var html = templateScript();
        $("#questStatTbody").html(html);

        setTimeout(function(){
            renderCalendar();
        },160)
    }


    function renderCalendar(){
        var tmp_sDate = $("#startDate").val();

        $('.calendar').fullCalendar('destroy').fullCalendar({
            header: {
                //left: 'month, agendaWeek, agendaDay',
                left: '',
                center: 'prev, title, next',
                right: 'today',
            },
            sundayFontColor:'red',
            saturdayFontColor:'blue',

            year : Number(tmp_sDate.substring(0,4)),
            month : Number(tmp_sDate.substring(5,7)) -1,

            events: function(start, end, timezone, callback) {
                $(".fc-header").hide();

                $.ajax({
                    url: '/rest/enter/newjoin2/info/state',
                    type: 'post',
                    dataType: 'json',
                    data: {
                        startDate : $('.fc-day').not('.fc-other-month').first().data('date').replace(/-/gi,".")
                        , endDate : $('.fc-day').not('.fc-other-month').last().data('date').replace(/-/gi,".")
                        , slctType : 1
                        , slctTab : 2
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
                        setChart(response);
                    }
                });
            }
        });

        setChart();
    }

    function setChart(response){
        /* 파이차트 [start] */
        var json = {
            values: [57.7, 42.3],
            labels: ['안드로이드', '아이폰'],
            type: 'pie'
        }

        var data = [json];

        var layout = {
            title: '앱다운로드 현황',
            height: 400,
            width: 500
        };

        Plotly.newPlot('pieArea', data, layout);
    }

</script>




<script id="tmp_questStat_detail" type="text/x-handlebars-template">
    <tr>
        <th>오늘</th>
        <td>0</td>
        <td>0</td>
        <td>0</td>
        <td>0</td>
        <td>0</td>
        <td>0</td>
        <td>0</td>
        <td>0</td>
        <td>0</td>
        <td>0</td>
        <td>0</td>
        <td>0</td>
        <td>0</td>
        <td>0</td>
    </tr>
    <tr>
        <th>이번달</th>
        <td>0</td>
        <td>0</td>
        <td>0</td>
        <td>0</td>
        <td>0</td>
        <td>0</td>
        <td>0</td>
        <td>0</td>
        <td>0</td>
        <td>0</td>
        <td>0</td>
        <td>0</td>
        <td>0</td>
        <td>0</td>
    </tr>
    <tr>
        <th>지난달</th>
        <td>0</td>
        <td>0</td>
        <td>0</td>
        <td>0</td>
        <td>0</td>
        <td>0</td>
        <td>0</td>
        <td>0</td>
        <td>0</td>
        <td>0</td>
        <td>0</td>
        <td>0</td>
        <td>0</td>
        <td>0</td>
    </tr>
</script>

<script type="text/x-handlebars-template" id="tmp_calendarData">
    <div>로그인수:0</div>
    <div>참여자수:0</div>
    <div>참여건수:0</div>
    <div>경험치:0</div>
    <div>달:0</div>
</script>