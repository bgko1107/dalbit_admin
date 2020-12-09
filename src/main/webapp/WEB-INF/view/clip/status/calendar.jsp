<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div class="wrapper">
    <div id="page-wrapper">
        <div id='barArea'></div>
        <div id='lineArea'></div>
        <div id="container-fluid">
            <div class="widget-content col-md-12 mt10 ml15 pl15">
                <div class="calendar col-md-9 no-padding"></div>
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

    $(function(){
    });

    function getCalendarInfo(){
        $("#summary_today").html(moment(new Date()).format('YYYY-MM-DD'));
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

                var startDate = $('.fc-day').not('.fc-other-month').first().data('date').replace(/-/gi,".");
                var endDate = $('.fc-day').not('.fc-other-month').last().data('date').replace(/-/gi,".");
                var month =  $('.fc-day').not('.fc-other-month').first().data('date').replace(/-/gi,".") + " - " + $('.fc-day').not('.fc-other-month').last().data('date').replace(/-/gi,".") + "@";

                $.ajax({
                    url: '/rest/clip/status/info/time',
                    type: 'post',
                    dataType: 'json',
                    data: {
                        dateList : month,
                        startDate : startDate,
                        endDate : endDate,
                        slctType : 1
                    },
                    success: function(response) {
                        console.log(response);
                        $("#totalTable").empty();

                        response.data.totalInfo.sum_reg_maleCnt= 0;
                        response.data.totalInfo.sum_del_maleCnt= 0;
                        response.data.totalInfo.sum_reg_femaleCnt= 0;
                        response.data.totalInfo.sum_del_femaleCnt= 0;
                        response.data.totalInfo.sum_reg_noneCnt= 0;
                        response.data.totalInfo.sum_del_noneCnt= 0;
                        response.data.totalInfo.sum_reg_totalCnt= 0;
                        response.data.totalInfo.sum_del_totalCnt= 0;


                        if(!common.isEmpty(response.data)){
                            response.data.detailList.forEach(function(detail, detailIndex) {
                                detail.reg_maleCnt = detail.open_reg_maleCnt + detail.notopen_reg_maleCnt;
                                detail.del_maleCnt = detail.mem_del_maleCnt + detail.op_del_maleCnt;
                                detail.reg_femaleCnt = detail.open_reg_femaleCnt + detail.notopen_reg_femaleCnt;
                                detail.del_femaleCnt = detail.mem_del_femaleCnt + detail.op_del_femaleCnt;
                                detail.reg_noneCnt = detail.open_reg_noneCnt + detail.notopen_reg_noneCnt;
                                detail.del_noneCnt = detail.mem_del_noneCnt + detail.op_del_noneCnt;
                                detail.reg_totalCnt = detail.open_reg_totalCnt + detail.notopen_reg_totalCnt;
                                detail.del_totalCnt = detail.mem_del_totalCnt + detail.op_del_totalCnt;

                                response.data.totalInfo.sum_reg_maleCnt += detail.reg_maleCnt;
                                response.data.totalInfo.sum_del_maleCnt += detail.del_maleCnt;
                                response.data.totalInfo.sum_reg_femaleCnt += detail.reg_femaleCnt;
                                response.data.totalInfo.sum_del_femaleCnt += detail.del_femaleCnt;
                                response.data.totalInfo.sum_reg_noneCnt += detail.reg_noneCnt;
                                response.data.totalInfo.sum_del_noneCnt += detail.del_noneCnt;
                                response.data.totalInfo.sum_reg_totalCnt += detail.reg_totalCnt;
                                response.data.totalInfo.sum_del_totalCnt += detail.del_totalCnt;

                                var the_date = detail.the_date;
                                var dayTarget = $('.fc-day[data-date="' + the_date + '"]').find('.fc-day-content');
                                var template = $('#tmp_calendarData').html();
                                var templateScript = Handlebars.compile(template);
                                var context = detail;
                                var html = templateScript(context);
                                dayTarget.append(html);
                            });


                            var template = $('#tmp_totalTable').html();
                            var templateScript = Handlebars.compile(template);
                            var detailContext = response.data.totalInfo;
                            var html=templateScript(detailContext);
                            $("#totalTable").append(html);

                            ui.paintColor();
                        }

                        renderChart(response);
                    },
                    error: function(jqXHR, textStatus, errorThrown) { console.log(jqXHR)}
                });
            }
        })
    }

    function renderChart(response){
        var month;

        var day = [];
        var maleCnt = [];
        var maleRegCnt = [];
        var maledelCnt = [];
        var femaleCnt = [];
        var femaleRegCnt = [];
        var femaledelCnt = [];
        var noneCnt = [];
        var noneRegCnt = [];
        var nonedelCnt = [];

        if(common.isEmpty(response.data)){
            $("#lineArea").empty();
            $("#barArea").empty();
            return ;
        }

        for(var i=0;i<response.data.detailList.length;i++){
            response.data.detailList[i].nowMonth = Number(moment().format("MM"));
            response.data.detailList[i].nowDay = common.lpad(Number(moment().format("DD")),2,"0");
            response.data.detailList[i].nowHour = Number(moment().format("HH"));

            response.data.detailList[i].day = response.data.detailList[i].the_date.substr(8,2);
            response.data.detailList[i].month = response.data.detailList[i].the_date.substr(5,2);
            month = response.data.detailList[i].month;

            toDay = week[moment(response.data.detailList[i].the_date.replace(/-/gi,".")).add('days', 0).day()];
            if(toDay == "토"){
                toDay = '<span class="_fontColor" data-fontColor="blue" style="color:blue">' + response.data.detailList[i].the_date.substr(5).replace(/-/gi,".") + "(" + toDay + ")" + '</span>';
            }else if(toDay == "일"){
                toDay = '<span class="_fontColor" data-fontColor="red" style="color:red">' + response.data.detailList[i].the_date.substr(5).replace(/-/gi,".") + "(" + toDay + ")" + '</span>';
            }else{
                toDay = response.data.detailList[i].the_date.substr(5).replace(/-/gi,".") + "(" + toDay + ")";
            }
            response.data.detailList[i].date = toDay;

            day.unshift(toDay);
            maleCnt.unshift(response.data.detailList[i].maleCnt);
            maleRegCnt.unshift(response.data.detailList[i].reg_maleCnt);
            maledelCnt.unshift(response.data.detailList[i].del_maleCnt);
            femaleCnt.unshift(response.data.detailList[i].femaleCnt);
            femaleRegCnt.unshift(response.data.detailList[i].reg_femaleCnt);
            femaledelCnt.unshift(response.data.detailList[i].del_femaleCnt);
            noneCnt.unshift(response.data.detailList[i].noneCnt);
            noneRegCnt.unshift(response.data.detailList[i].reg_noneCnt);
            nonedelCnt.unshift(response.data.detailList[i].del_noneCnt);

        }

        /* 막대차트 [start] */
        var trace_male_cnt = {
            x: day,
            y: maleCnt,
            mode: 'lines',
            name: '<span style="color:blue">남성</span>',
            type : 'bar',
            marker: {
                color: '#99CCFF'
            }
        };

        var trace_female_cnt = {
            x: day,
            y: femaleCnt,
            mode: 'lines',
            name: '<span style="color:red">여성</span>',
            type : 'bar',
            marker: {
                color: '#FF6666'
            }
        };


        var trace_none_cnt = {
            x: day,
            y: noneCnt,
            mode: 'lines',
            name: '<span style="color:black">알수없음</span>',
            type : 'bar',
            marker: {
                color: '#999999'
            }
        };

        var barData = [trace_male_cnt, trace_female_cnt, trace_none_cnt]

        var barLayout = {
            title: month+'월 일자별 - 등록자 현황',
            // height: 500,
            // width: 1300,
            yaxis: {
                range: [0, 100],
                autorange: true
            },
            barmode: 'stack'
        }

        Plotly.newPlot('barArea', barData, barLayout);
        /* 막대차트 [end] */


        /* 라인차트 [start] */
        var trace_male_reg = {
            x: day,
            y: maleRegCnt,
            mode: 'lines',
            name: '<span style="color:blue">남성</span> 등록',
            line: {
                dash: 'solid',
                width: 4,
                color: '#99CCFF'
            },
            marker: {
                color: '#99CCFF'
            }
        };

        var trace_male_del = {
            x: day,
            y: maledelCnt,
            mode: 'lines',
            name: '<span style="color:blue">남성</span> 삭제',
            line: {
                dash: 'dot',
                width: 4,
                color: '#99CCFF'
            },
            marker: {
                color: '#99CCFF'
            }

        };

        var trace_female_reg = {
            x: day,
            y: femaleRegCnt,
            mode: 'lines',
            name: '<span style="color:red">여성</span> 등록',
            line: {
                dash: 'solid',
                width: 4,
                color: '#FF6666'
            },
            marker: {
                color: '#FF6666'
            }
        };

        var trace_female_del = {
            x: day,
            y: femaledelCnt,
            mode: 'lines',
            name: '<span style="color:red">여성</span> 삭제',
            line: {
                dash: 'dot',
                width: 4,
                color: '#FF6666'
            },
            marker: {
                color: '#FF6666'
            }
        };

        var trace_none_reg = {
            x: day,
            y: noneRegCnt,
            mode: 'lines',
            name: '알수없음 등록',
            line: {
                dash: 'solid',
                width: 4,
                color: '#999999'
            },
            marker: {
                color: '#999999'
            }
        };

        var trace_none_del = {
            x: day,
            y: nonedelCnt,
            mode: 'lines',
            name: '알수없음 삭제',
            line: {
                dash: 'dot',
                width: 4,
                color: '#999999'
            },
            marker: {
                color: '#999999'
            }
        };

        var data = [trace_male_reg, trace_male_del, trace_female_reg, trace_female_del, trace_none_reg, trace_none_del];

        var layout = {
            title: month+'월 일자별 - 등록/삭제',
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
    }

</script>

<script type="text/x-handlebars-template" id="tmp_calendarData">
    <div style="color: blue;">{{{sexIcon 'm'}}} : {{addComma maleCnt}}명 / {{addComma reg_maleCnt}}건({{addComma del_maleCnt}}건)</div>
    <div style="color: red;">{{{sexIcon 'f'}}} : {{addComma femaleCnt}}명 / {{addComma reg_femaleCnt}}건({{addComma del_femaleCnt}}건)</div>
    <div style="color: black">{{{sexIcon 'n'}}} : {{addComma noneCnt}}명 / {{addComma reg_noneCnt}}건({{addComma del_noneCnt}}건)</div>
    <div class="font-bold" style="color: #ff5600;">총계 : {{addComma totalCnt}}명 / {{addComma reg_totalCnt}}건({{addComma del_totalCnt}}건)</div>
</script>

<script type="text/x-handlebars-template" id="tmp_totalTable">
    <br/><br/>
    <table class="table table-bordered" style="width: 100%">
        <colgroup>
            <col width="25%"/><col width="25%"/><col width="25%"/><col width="25%"/>
        </colgroup>
        <tbody>
        <tr>
            <th>구분</th>
            <th>총 등록자 수</th>
            <th>총 등록 건</th>
            <th>총 삭제 건</th>
        </tr>
        <tr style="color: blue">
            <td>{{{sexIcon 'm'}}}</td>
            <td>{{addComma sum_maleCnt}}</td>
            <td>{{addComma sum_reg_maleCnt}}</td>
            <td>{{addComma sum_del_maleCnt}}</td>
        </tr>
        <tr style="color: red">
            <td>{{{sexIcon 'f'}}}</td>
            <td>{{addComma sum_femaleCnt}}</td>
            <td>{{addComma sum_reg_femaleCnt}}</td>
            <td>{{addComma sum_del_femaleCnt}}</td>
        </tr>
        <tr>
            <td>{{{sexIcon 'n'}}}</td>
            <td>{{addComma sum_noneCnt}}</td>
            <td>{{addComma sum_reg_noneCnt}}</td>
            <td>{{addComma sum_del_noneCnt}}</td>
        </tr>
        <tr class="font-bold" style="color: #ff5600">
            <td>총합</td>
            <td>{{addComma sum_totalCnt}}</td>
            <td>{{addComma sum_reg_totalCnt}}</td>
            <td>{{addComma sum_del_totalCnt}}</td>
        </tr>
        </tbody>
    </table>
</script>