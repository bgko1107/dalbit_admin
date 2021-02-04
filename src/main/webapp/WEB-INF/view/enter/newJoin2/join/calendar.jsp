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
<script src='https://cdn.plot.ly/plotly-latest.min.js'></script>
<script type="text/javascript">


    var accum_total_join_cnt = 0;
    var accum_total_out_cnt = 0;
    var accum_total_join_before_cnt = 0;
    var accum_total_out_before_cnt = 0;

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
                        , slctTab : 1
                    },
                    success: function(response) {
                        accum_total_join_cnt = 0;
                        accum_total_out_cnt = 0;
                        accum_total_join_before_cnt = 0;
                        accum_total_out_before_cnt = 0;
                        if(!common.isEmpty(response.data.detailList)){
                            response.data.detailList.forEach(function(detail, detailIndex) {
                                var sw = false;
                                var total_join_before_cnt = 0;
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
                                    detail.total_inc_join_cnt = detail.total_join_cnt - total_join_before_cnt;
                                    accum_total_join_cnt = accum_total_join_cnt + detail.total_join_cnt;
                                    detail.accum_total_join_cnt = accum_total_join_cnt;

                                    detail.total_inc_out_cnt = detail.total_out_cnt - total_join_before_cnt;
                                    accum_total_out_cnt = accum_total_out_cnt + detail.total_out_cnt;
                                    detail.accum_total_out_cnt = accum_total_out_cnt;
                                }else{
                                    detail.total_inc_join_cnt = detail.total_join_cnt - 0;
                                    accum_total_join_cnt = accum_total_join_cnt + detail.total_join_cnt;
                                    detail.accum_total_join_cnt = accum_total_join_cnt;

                                    detail.total_inc_out_cnt = detail.total_out_cnt - 0;
                                    accum_total_out_cnt = accum_total_out_cnt + detail.total_out_cnt;
                                    detail.accum_total_out_cnt = accum_total_out_cnt;
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

                        if(response.result != "fail"){
                            if(moment(new Date()).format('YYYY.MM') == tmp_sDate.substring(0,7)){       // 같은달이면 전일 누적 / 전일 일수
                                response.data.totalInfo.befor_accum_total_join_cnt = response.data.detailList[response.data.detailList.length - 2].accum_total_join_cnt;
                                response.data.totalInfo.befor_accum_total_out_cnt = response.data.detailList[response.data.detailList.length - 2].accum_total_out_cnt;
                                response.data.totalInfo.cnt = response.data.detailList.length - 1;
                            }else{
                                response.data.totalInfo.befor_accum_total_join_cnt = response.data.detailList[response.data.detailList.length-1].accum_total_join_cnt;
                                response.data.totalInfo.befor_accum_total_out_cnt = response.data.detailList[response.data.detailList.length-1].accum_total_out_cnt;
                                response.data.totalInfo.cnt = response.data.detailList.length;
                            }

                            response.data.totalInfo.sum_total_inc_join_cnt = response.data.totalInfo.sum_total_join_cnt - accum_total_join_before_cnt;
                            response.data.totalInfo.sum_total_inc_out_cnt = response.data.totalInfo.sum_total_out_cnt - accum_total_out_before_cnt;
                            $("#totalTable").empty();
                            var template = $('#tmp_totalTable').html();
                            var templateScript = Handlebars.compile(template);
                            var detailContext = response.data.totalInfo;
                            var html=templateScript(detailContext);
                            $("#totalTable").append(html);
                            ui.paintColor();
                            renderChart(response);
                        }else{
                            $("#totalTable").empty();
                            $("#barArea").empty();
                            $("#lineArea").empty();
                        }

                    }
                });
            }
        });
    }


    function renderChart(response) {
        var month;

        var day = [];
        var total_join_cnt = [];

        if (response.result == "fail") {
            console.log("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! ");
            $("#lineArea").empty();
            $("#barArea").empty();
            return false;
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
            total_join_cnt.unshift(response.data.detailList[i].total_join_cnt);


        }

        /* 막대차트 [start] */
        var trace_join_cnt = {
            x: day,
            y: total_join_cnt,
            // mode: 'lines',
            name: '<span>가입</span>',
            type: 'bar',
            text: total_join_cnt.map(String),
            textposition: 'auto',
            hoverinfo: 'none',

            marker: {
                color: '#99CCFF'
            }
        };

        var barData = [trace_join_cnt];

        var barLayout = {
            title: month + '월 일자별 - 가입자 현황',
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
            , slctTab: 1
        };
        util.getAjaxData("month", "/rest/enter/newjoin2/info/state", data, fn_platform_success);
    }

    function fn_platform_success(dst_id, response) {
        var month;

        var day = [];
        var apple_join_cnt = [];
        var fbook_join_cnt = [];
        var google_join_cnt = [];
        var kakao_join_cnt = [];
        var naver_join_cnt = [];
        var phone_join_cnt = [];

        if(response.result != "fail") {
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
                phone_join_cnt.unshift(response.data.detailList[i].phone_join_cnt);
                kakao_join_cnt.unshift(response.data.detailList[i].kakao_join_cnt);
                naver_join_cnt.unshift(response.data.detailList[i].naver_join_cnt);
                fbook_join_cnt.unshift(response.data.detailList[i].fbook_join_cnt);
                apple_join_cnt.unshift(response.data.detailList[i].apple_join_cnt);
                google_join_cnt.unshift(response.data.detailList[i].google_join_cnt);
            }

            /* 라인차트 [start] */
            var trace_phone = {
                x: day,
                y: phone_join_cnt,
                mode: 'lines',
                name: '<span style="color:#7030a0">Phone</span>',
                line: {
                    dash: 'solid',
                    width: 4,
                    color: '#7030a0'
                },
                marker: {
                    color: '#7030a0'
                }
            };

            var trace_kakao = {
                x: day,
                y: kakao_join_cnt,
                mode: 'lines',
                name: '<span style="color:#ffc000">Kakao</span>',
                line: {
                    dash: 'dot',
                    width: 4,
                    color: '#ffc000'
                },
                marker: {
                    color: '#ffc000'
                }

            };

            var trace_naver = {
                x: day,
                y: naver_join_cnt,
                mode: 'lines',
                name: '<span style="color:#548235">Naver</span>',
                line: {
                    dash: 'solid',
                    width: 4,
                    color: '#548235'
                },
                marker: {
                    color: '#548235'
                }
            };

            var trace_fbook = {
                x: day,
                y: fbook_join_cnt,
                mode: 'lines',
                name: '<span style="color:#4472c4">Facebook</span>',
                line: {
                    dash: 'dot',
                    width: 4,
                    color: '#4472c4'
                },
                marker: {
                    color: '#4472c4'
                }
            };

            var trace_apple = {
                x: day,
                y: apple_join_cnt,
                mode: 'lines',
                name: '<span style="color:#000000">Apple</span>',
                line: {
                    dash: 'solid',
                    width: 4,
                    color: '#000000'
                },
                marker: {
                    color: '#000000'
                }
            };

            var trace_google = {
                x: day,
                y: google_join_cnt,
                mode: 'lines',
                name: '<span style="color:#000000">Google</span>',
                line: {
                    dash: 'dot',
                    width: 4,
                    color: '#c00000'
                },
                marker: {
                    color: '#c00000'
                }
            };

            var data = [trace_google, trace_apple, trace_fbook, trace_naver, trace_kakao, trace_phone];

            var layout = {
                title: month + '월 일자별 - SNS별 가입 현황',
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
        }else{
            $("#lineArea").empty();
        }
    }

</script>

<script type="text/x-handlebars-template" id="tmp_calendarData">
    <div class="font-bold" style="color: #ff5600;">가입 총계 : {{addComma total_join_cnt}}</div>
    <div class="font-bold" style="color: black;">가입 누적 : {{addComma accum_total_join_cnt}}</div>
    <div class="{{upAndDownClass total_inc_join_cnt}}" style="color: black;">전월 대비 :
        <span {{#dalbit_if total_inc_join_cnt '>' 0 }} style="color: red" {{/dalbit_if}}
              {{#dalbit_if total_inc_join_cnt '<' 0 }} style="color: blue" {{/dalbit_if}} >
            <i class="fa {{upAndDownIcon total_inc_join_cnt}}"></i> <span>{{addComma total_inc_join_cnt}}</span>
        </span>
    </div>
    <div class="font-bold" style="color: black;">탈퇴 총계 : {{addComma total_out_cnt}} <br/> (탈퇴 비율 : {{average total_out_cnt total_join_cnt 0}}%)</div>
</script>

<script type="text/x-handlebars-template" id="tmp_totalTable">
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
            <tr class="font-bold" style="color: #ff5600">
                <td>총합</td>
                <td>{{addComma sum_total_join_cnt}}</td>
                <td>{{addComma sum_total_out_cnt}}</td>
            </tr>
            <tr>
                <td>일평균</td>
                <td>{{division befor_accum_total_join_cnt cnt 0}}</td>
                <td>{{division befor_accum_total_out_cnt cnt 0}}</td>
            </tr>
            <tr>
                <td>전월 대비</td>
                <td class="{{upAndDownClass sum_total_inc_join_cnt}}"><i class="fa {{upAndDownIcon sum_total_inc_join_cnt}}"></i> <span>{{addComma sum_total_inc_join_cnt}}</span></td>
                <td class="{{upAndDownClass sum_total_inc_out_cnt}}"><i class="fa {{upAndDownIcon sum_total_inc_out_cnt}}"></i> <span>{{addComma sum_total_inc_out_cnt}}</span></td>
            </tr>
            <tr>
                <td colspan="2">가입 대비 탈퇴 비율</td>
                <td>{{average sum_total_out_cnt sum_total_join_cnt 0}}%</td>
            </tr>
        </tbody>
    </table>
</script>