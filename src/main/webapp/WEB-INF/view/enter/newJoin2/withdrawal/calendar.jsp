<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div class="wrapper">
    <div id="page-wrapper">
        <div class="col-md-12 no-padding">
            <div id='barArea'></div>
        </div>
        <div class="col-md-12 no-padding">
            <div id='lineArea'></div>
        </div>
        <div id="container-fluid">
            <div class="widget-content col-md-12">
                <div class="calendar col-md-8 no-padding"></div>
                <div class="col-md-3 no-padding" id="totalTable"></div>

            </div>
        </div>
    </div>
</div>
<!-- /wrapper -->


<!-- Javascript -->
<script src="/template/js/plugins/fullcalendar/fullcalendar.js"></script>
<script src="/template/js/plugins/jquery-simplecolorpicker/jquery.simplecolorpicker.js"></script>
<script src='https://cdn.plot.ly/plotly-latest.min.js'></script>
<script type="text/javascript">

    var accum_total_join_cnt = 0;
    var accum_total_out_cnt = 0;
    var accum_total_join_before_cnt = 0;
    var accum_total_out_before_cnt = 0;
    var accum_auto_out_Cnt = 0;

    $(function(){
        // getCalendar();
    });

    function getCalendar(){
        $("#summary_today").html(moment(new Date()).format('YYYY-MM-DD'));
        setTimeout(function(){
            renderCalendar();
        },160)
    }

    function renderCalendar(){
        var tmp_sDate = $("#startDate").val();

        beforeSDate = moment($("#startDate").val()).add("months", -1).format('YYYY.MM.01');
        var monthLastDate = new Date(beforeSDate.substr(0,4),beforeSDate.substr(5,7),-1);
        beforeEDate = beforeSDate.substr(0,8) +(monthLastDate.getDate() + 1);

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
                        , beforeStartDate : beforeSDate
                        , beforeEndDate : beforeEDate
                        , slctType : 1
                        , slctTab : 2
                    },
                    success: function(response) {
                        accum_total_join_cnt = 0;
                        accum_total_out_cnt = 0;
                        accum_total_join_before_cnt = 0;
                        accum_total_out_before_cnt = 0;
                        accum_auto_out_Cnt = 0;

                        if(!common.isEmpty(response.data.detailList)){
                            response.data.detailList.forEach(function(detail, detailIndex) {

                                var sw = false;
                                var total_out_before_cnt = 0;
                                response.data.detailList2.forEach(function(detail2, detailIndex2) {
                                    if(detail.daily == detail2.daily){
                                        sw = true;
                                        total_join_before_cnt = detail2.total_join_cnt;
                                        total_out_before_cnt = detail2.total_out_cnt;

                                        accum_total_join_before_cnt = accum_total_join_before_cnt + total_join_before_cnt;
                                        accum_total_out_before_cnt = accum_total_out_before_cnt + total_out_before_cnt;
                                    }
                                });
                                if(sw){
                                    detail.total_inc_out_cnt = detail.total_out_cnt - total_out_before_cnt;
                                    accum_total_out_cnt = accum_total_out_cnt + detail.total_out_cnt;
                                    detail.accum_total_out_cnt = accum_total_out_cnt;

                                    accum_auto_out_Cnt = accum_auto_out_Cnt + detail.auto_out_Cnt;
                                    detail.accum_auto_out_Cnt = accum_auto_out_Cnt;
                                }else{
                                    detail.total_inc_out_cnt = detail.total_out_cnt - 0;
                                    accum_total_out_cnt = accum_total_out_cnt + detail.total_out_cnt;
                                    detail.accum_total_out_cnt = accum_total_out_cnt;

                                    accum_auto_out_Cnt = accum_auto_out_Cnt + detail.auto_out_Cnt;
                                    detail.accum_auto_out_Cnt = accum_auto_out_Cnt;
                                }

                                var the_date = detail.the_date;
                                var dayTarget = $('.fc-day[data-date="' + the_date + '"]').find('.fc-day-content');
                                var template = $('#tmp_calendarData').html();
                                var templateScript = Handlebars.compile(template);
                                var context = detail;
                                var html = templateScript(context);
                                dayTarget.append(html);
                            });
                        }

                        if(response.result == "success"){
                            response.data.totalInfo.cnt = response.data.detailList.length;
                            response.data.totalInfo.sum_total_inc_out_cnt = response.data.totalInfo.sum_total_out_cnt - response.data.totalInfo2.sum_total_out_cnt;
                        }


                        $("#totalTable").empty();
                        var template = $('#tmp_totalTable').html();
                        var templateScript = Handlebars.compile(template);
                        var detailContext = response.data.totalInfo;
                        var html=templateScript(detailContext);
                        $("#totalTable").append(html);
                        ui.paintColor();

                        renderChart(response);
                    }
                });
            }
        });
    }


    function renderChart(response) {
        var month;

        var day = [];
        var total_out_cnt = [];

        if (common.isEmpty(response.data)) {
            $("#lineArea").empty();
            $("#barArea").empty();
            return;
        }

        response.data.detailList.sort(function (a, b) { // 오름차순
            return b["daily"] - a["daily"];
        });

        for (var i = 0; i < response.data.detailList.length; i++) {
            response.data.detailList[i].nowMonth = Number(moment().format("MM"));
            response.data.detailList[i].nowDay = common.lpad(Number(moment().format("DD")), 2, "0");
            response.data.detailList[i].nowHour = Number(moment().format("HH"));

            response.data.detailList[i].day = response.data.detailList[i].the_date.substr(8, 2);
            response.data.detailList[i].month = response.data.detailList[i].the_date.substr(5, 2);
            month = response.data.detailList[i].month;

            toDay = week[moment(response.data.detailList[i].the_date.replace(/-/gi, ".")).add('days', 0).day()];
            if (toDay == "토") {
                toDay = '<span class="_fontColor" data-fontColor="blue" style="color:blue">' + response.data.detailList[i].the_date.substr(5).replace(/-/gi, ".") + "(" + toDay + ")" + '</span>';
            } else if (toDay == "일") {
                toDay = '<span class="_fontColor" data-fontColor="red" style="color:red">' + response.data.detailList[i].the_date.substr(5).replace(/-/gi, ".") + "(" + toDay + ")" + '</span>';
            } else {
                toDay = response.data.detailList[i].the_date.substr(5).replace(/-/gi, ".") + "(" + toDay + ")";
            }
            response.data.detailList[i].date = toDay;

            day.unshift(toDay);
            total_out_cnt.unshift(response.data.detailList[i].total_out_cnt);


        }

        /* 막대차트 [start] */
        var trace_out_cnt = {
            x: day,
            y: total_out_cnt,
            mode: 'lines',
            name: '<span>탈퇴</span>',
            type: 'bar',
            text: total_out_cnt.map(String),
            textposition: 'auto',
            hoverinfo: 'none',
            marker: {
                color: '#f8cbad'
            }
        };

        var barData = [trace_out_cnt];

        var barLayout = {
            title: month + '월 일자별 - 탈퇴자 현황',
            // height: 500,
            // width: 1300,
            yaxis: {
                range: [0, 100],
                autorange: true
            },
            barmode: 'stack'
        };

        Plotly.newPlot('barArea', barData, barLayout);
        /* 막대차트 [end] */

        /* 플랫폼별 라인 Chart */
        platform_lineChart();
    }



    function platform_lineChart() {
        var data = {
            startDate: $("#startDate").val()
            , endDate: $("#endDate").val()
            , beforeStartDate : beforeSDate
            , beforeEndDate : beforeEDate
            , slctType: 2
            , slctTab: 2
        };

        console.log(data);
        util.getAjaxData("month", "/rest/enter/newjoin2/info/state", data, fn_platform_success);
    }

    function fn_platform_success(dst_id, response) {
        var month;

        var day = [];
        var total_out_mcnt = [];
        var total_out_fcnt = [];
        var total_out_ncnt = [];

        response.data.detailList.sort(function (a, b) { // 오름차순
            return b["daily"] - a["daily"];
        });

        for (var i = 0; i < response.data.detailList.length; i++) {
            response.data.detailList[i].nowMonth = Number(moment().format("MM"));
            response.data.detailList[i].nowDay = common.lpad(Number(moment().format("DD")), 2, "0");
            response.data.detailList[i].nowHour = Number(moment().format("HH"));

            response.data.detailList[i].day = response.data.detailList[i].the_date.substr(8, 2);
            response.data.detailList[i].month = response.data.detailList[i].the_date.substr(5, 2);
            month = response.data.detailList[i].month;

            toDay = week[moment(response.data.detailList[i].the_date.replace(/-/gi, ".")).add('days', 0).day()];
            if (toDay == "토") {
                toDay = '<span class="_fontColor" data-fontColor="blue" style="color:blue">' + response.data.detailList[i].the_date.substr(5).replace(/-/gi, ".") + "(" + toDay + ")" + '</span>';
            } else if (toDay == "일") {
                toDay = '<span class="_fontColor" data-fontColor="red" style="color:red">' + response.data.detailList[i].the_date.substr(5).replace(/-/gi, ".") + "(" + toDay + ")" + '</span>';
            } else {
                toDay = response.data.detailList[i].the_date.substr(5).replace(/-/gi, ".") + "(" + toDay + ")";
            }
            response.data.detailList[i].date = toDay;

            day.unshift(toDay);
            total_out_mcnt.unshift(response.data.detailList[i].total_out_mcnt);
            total_out_fcnt.unshift(response.data.detailList[i].total_out_fcnt);
            total_out_ncnt.unshift(response.data.detailList[i].total_out_ncnt);
        }

        /* 라인차트 [start] */
        var trace_male = {
            x: day,
            y: total_out_mcnt,
            mode: 'lines',
            name: '<span style="color:blue">남성</span>',
            line: {
                dash: 'solid',
                width: 4,
                color: 'blue'
            },
            marker: {
                color: 'blue'
            }
        };

        var trace_female = {
            x: day,
            y: total_out_fcnt,
            mode: 'lines',
            name: '<span style="color:red">여성</span>',
            line: {
                dash: 'solid',
                width: 4,
                color: 'red'
            },
            marker: {
                color: 'red'
            }

        };

        var trace_none = {
            x: day,
            y: total_out_ncnt,
            mode: 'lines',
            name: '<span style="color:black">알수없음</span>',
            line: {
                dash: 'solid',
                width: 4,
                color: 'black'
            },
            marker: {
                color: 'black'
            }
        };

        var data = [trace_none,trace_female,trace_male];

        var layout = {
            title: month+'월 일자별 - 성별 탈퇴 현황',
            // height: 500,
            // width: 1300,
            yaxis: {
                range: [0, 100],
                autorange: true
            },
            legend: {
                y: 0.5,
                traceorder: 'reversed',
                font: {
                    size: 16
                }
            }
        };

        Plotly.newPlot('lineArea', data, layout);
        /* 라인차트 [end] */
        setSummary(response.data);

    }

</script>

<script type="text/x-handlebars-template" id="tmp_calendarData">
    <div class="font-bold" style="color: #ff5600;">탈퇴 총계 : {{addComma total_out_cnt}}({{addComma auto_out_Cnt}})</div>
    <div class="font-bold" style="color: black;">탈퇴 누적 : {{addComma accum_total_out_cnt}}({{addComma accum_auto_out_Cnt}})</div>
    <div class="{{upAndDownClass total_inc_out_cnt}}" style="color: black;">전월 대비 :
        <span {{#dalbit_if total_inc_out_cnt '>' 0 }} style="color: red" {{/dalbit_if}}
              {{#dalbit_if total_inc_out_cnt '<' 0 }} style="color: blue" {{/dalbit_if}} >
            <i class="fa {{upAndDownIcon total_inc_out_cnt}}"></i> <span>{{addComma total_inc_out_cnt}}</span>
        </span>
    </div>
    <div class="font-bold" style="font-size: 10px">
        <span style="color: blue">남</span>/
        <span style="color: red">여</span>/
        <span style="color: black">알수없음 탈퇴:</span><br/>
        <span style="color: blue">{{addComma total_out_mcnt}}</span>/
        <span style="color: red">{{addComma total_out_fcnt}}</span>/
        <span style="color: black">{{addComma total_out_ncnt}}</span></div>
</script>

<script type="text/x-handlebars-template" id="tmp_totalTable">
    <table class="table table-bordered">
        <colgroup>
            <col width="20%"/><col width="20%"/><col width="20%"/><col width="20%"/><col width="20%"/>
        </colgroup>
        <tbody>
            <tr>
                <th>구분</th>
                <th>가입</th>
                <th>탈퇴<br>(자동)</th>
                <th>휴면</th>
                <th>휴면<br/>해제</th>
            </tr>
            <tr class="font-bold" style="color: #ff5600">
                <td>총합</td>
                <td>{{addComma sum_total_join_cnt}}</td>
                <td>{{addComma sum_total_out_cnt}}<br/>({{addComma sum_auto_out_cnt}})</td>
                <td>{{addComma sum_sleep_cnt}}</td>
                <td>{{addComma sum_return_cnt}}</td>
            </tr>
            <tr>
                <td>{{{sexIcon 'n'}}}</td>
                <td>{{addComma sum_total_join_ncnt}}</td>
                <td>{{addComma sum_total_out_ncnt}}<br/>({{addComma sum_auto_out_mcnt}})</td>
                <td>{{addComma sum_sleep_mcnt}}</td>
                <td>{{addComma sum_return_mcnt}}</td>
            </tr>
            <tr>
                <td>{{{sexIcon 'm'}}}</td>
                <td>{{addComma sum_total_join_mcnt}}</td>
                <td>{{addComma sum_total_out_mcnt}}<br/>({{addComma sum_auto_out_fcnt}})</td>
                <td>{{addComma sum_sleep_fcnt}}</td>
                <td>{{addComma sum_return_fcnt}}</td>
            </tr>
            <tr>
                <td>{{{sexIcon 'f'}}}</td>
                <td>{{addComma sum_total_join_fcnt}}</td>
                <td>{{addComma sum_total_out_fcnt}}<br/>({{addComma sum_auto_out_ncnt}})</td>
                <td>{{addComma sum_sleep_ncnt}}</td>
                <td>{{addComma sum_return_ncnt}}</td>
            </tr>
            <tr>
                <th colspan="2" class="_bgColor" data-bgColor="#ffe699">가입 대비<br/>탈퇴 비율</th>
                <th class="_bgColor" data-bgColor="#fff2cc">{{average sum_total_out_cnt sum_total_join_cnt}}%</th>
                <th class="_bgColor" data-bgColor="#a9d18e">휴면 대비<br/>해제 비율</th>
                <th class="_bgColor" data-bgColor="#e2f0d9">{{average sum_return_cnt sum_sleep_cnt}}%</th>
            </tr>
        </tbody>
    </table>
</script>