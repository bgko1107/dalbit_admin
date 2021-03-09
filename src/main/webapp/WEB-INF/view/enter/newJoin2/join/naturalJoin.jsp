<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="cfn" uri="/WEB-INF/tld/comFunction.tld" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<sec:authentication var="principal" property="principal" />
<style>
    .xaxislayer-above {
        cursor: pointer;
        pointer-events: all;
    }
</style>
<div class="wrapper">

    <button type="button" class="btn btn-success" id="bt_adbrixAdd" onclick="adbrixAddClick();">애드브릭스 등록</button>
    <div id="page-wrapper">
        <div class="col-md-12 no-padding">
            <div class="adbrix_barArea" id='adbrix_barArea'></div>
        </div>
        <div class="col-md-12 no-padding">
            <div class="adbrix_lineArea" id='adbrix_lineArea'></div>
        </div>
        <div id="container-fluid">
            <div class="widget-content col-md-10 no-padding">
                <button class="btn btn-default btn-sm print-btn pull-right" type="button" id="excelDownBtn"><i class="fa fa-print"></i>Excel Down</button>
                <div class="adbrix_calendar col-md-10 no-padding"></div>
                <div class="col-md-2 no-padding" id="adbrix_totalTable"></div>
            </div>
        </div>
    </div>
</div>
<!-- /wrapper -->

<!-- 애드브릭스 Modal -->
<div class="modal fade" id="adbrixExcelModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog" style="width: 600px;display: table;">
        <div class="modal-content">
            <div class="modal-header">
                <lable>애드브릭스 Excel등록</lable>
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
            </div>
            <div class="modal-body">
                <input type="file" id="file" onchange="jsonDataExcel()">
                <textarea type="textarea" class="form-control" id="txt_jsonData" name="txt_jsonData" style="width: 100%; height: 90%;display: none"></textarea>
                <span class="font-bold" style="color: red;">＊ Excel 파일 등록만 가능합니다.</span>
                <button type="button" class="btn btn-default pull-right" onclick="adbrixListAdd();"><i class="fa fa-times-circle"></i> 등록하기</button>

                <div id="div_gridData"></div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" onclick="adbrixListAdd();"><i class="fa fa-times-circle"></i> 등록하기</button>
            </div>
        </div>
    </div>
</div>
<!-- Modal 끝 -->

<!-- 애드브릭스 Modal -->
<div class="modal fade" id="adbrixMemoModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog" style="width: 400px;display: table;">
        <div class="modal-content">
            <div class="modal-header">
                <lable>⊙ 메모</lable>
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
            </div>
            <div class="modal-body">
                <textarea type="textarea" class="form-control" id="memo" name="memo" style="width: 100%; height: 150px;"></textarea>
            </div>
            <div class="modal-footer">
                <c:if test="${fn:contains('|이재은|이형원|고병권|이재호|양효진|이건준|양대기|박진|박희천|', principal.getUserInfo().getName())}">
                    <button type="button" class="btn btn-default" id="bt_adbrixMemoDel" onclick="adbrixMemoAdd('delete');"><i class="fa fa-times-circle"></i> 삭제</button>
                    <button type="button" class="btn btn-default" id="bt_adbrixMemoAdd" onclick="adbrixMemoAdd('insert');"><i class="fa fa-times-circle"></i> 등록하기</button>
                    <button type="button" class="btn btn-default" id="bt_adbrixMemoUpd" onclick="adbrixMemoAdd('update');"><i class="fa fa-times-circle"></i> 수정하기</button>
                </c:if>
            </div>
        </div>
    </div>
</div>
<!-- Modal 끝 -->

<!-- Javascript -->
<script src="/template/js/plugins/fullcalendar/fullcalendar.js"></script>
<script src="/template/js/plugins/jquery-simplecolorpicker/jquery.simplecolorpicker.js"></script>
<script src='https://cdn.plot.ly/plotly-latest.min.js'></script>
<script type="text/javascript">

    var memoIdx;
    var memoDate;
    function adbrixAddClick(){
        $("#txt_jsonData").val('');
        $("#div_gridData").empty();
        $("#file").val("");

        $("#adbrixExcelModal").modal('show');
    }


    function jsonDataExcel() {
        let input = event.target;
        let reader = new FileReader();
        reader.onload = function () {
            let data = reader.result;
            let workBook = XLSX.read(data, { type: 'binary' });
            workBook.SheetNames.forEach(function (sheetName) {
                console.log('SheetName: ' + sheetName);
                let rows = XLSX.utils.sheet_to_json(workBook.Sheets[sheetName]);

                console.log(rows);

                $("#txt_jsonData").val(JSON.stringify(rows));
            })
        };
        reader.readAsBinaryString(input.files[0]);
    }

    function adbrixListAdd(){
        if(confirm('Excel 파일을 등록 하시겠습니까?')){
            $("#adbrixExcelModal").modal('hide');

            var data = {
                adbrixExcelList: $("#txt_jsonData").val()
            };
            util.getAjaxData("month", "/rest/enter/newjoin2/adbrix/add", data, fn_adbrixAdd_success);
        }
    }

    var test1 = null, test2 = null;
    function gridExcelToWeb(file, target){
        var reader = new FileReader();

        reader.onload = function (evt) {
            if (evt.target.readyState == FileReader.DONE) {
                var data = evt.target.result;  //해당 데이터, 웹 서버에서 ajax같은거로 가져온 blob 형태의 데이터를 넣어주어도 동작 한다.
                data = new Uint8Array(data);
                var workbook = XLSX.read(data, { type: 'array' });
                var sheetName = '';
                workbook.SheetNames.forEach( function(data, idx){   //시트 여러개라면 이 안에서 반복문을 통해 돌리면 된다.
                    if(idx == 0){
                        sheetName = data;
                    }
                });
                test1 = workbook;

                var toHtml = XLSX.utils.sheet_to_html(workbook.Sheets[sheetName], { header: '' });

                target.html(toHtml);
                target.find('table').attr({class:'table table-bordered',id:'excelResult'});  //id나 class같은거를 줄 수 있다.
                test2 = toHtml;
                $('#excelResult').find('tr').each(function(idx){
                    if(idx == 0 ){
                        $(this).css({'background-color':'#969da5a3'});
                    }
                });
            }
        };
        reader.readAsArrayBuffer(file);
    }

    $('#file').change( function(){
        const selectedFile = $(this)[0].files[0];
        gridExcelToWeb(selectedFile,  $('#div_gridData'))
    });

    function fn_adbrixAdd_success(dst_id, response){
        if(response.result=="success"){
            alert('애드브릭스 등록 성공');
        }else{
            alert('애드브릭스 등록 실패');
        }
        renderNaturalJoin();
    }


    function getNaturalJoin(){
        setTimeout(function(){
            renderNaturalJoin();
        },160)
    }

    function renderNaturalJoin(){
        var tmp_sDate = $("#startDate").val();
        var tmp_eDate = $("#endDate").val();

        beforeSDate = moment($("#startDate").val()).add("months", -1).format('YYYY.MM.01');
        var monthLastDate = new Date(beforeSDate.substr(0,4),beforeSDate.substr(5,7),-1);
        beforeEDate = beforeSDate.substr(0,8) +(monthLastDate.getDate() + 1);

        $('.adbrix_calendar').fullCalendar('destroy').fullCalendar({
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
                    url: '/rest/enter/newjoin2/info/state/adbrix',
                    type: 'post',
                    dataType: 'json',
                    data: {
                        startDate : tmp_sDate
                        , endDate : tmp_eDate
                    },
                    success: function(response) {
                        if(!common.isEmpty(response.data.detailList)){
                            response.data.detailList.forEach(function(detail, detailIndex) {
                                var sw = false;

                                var the_date = detail.the_date;
                                var dayTarget = $('.fc-day[data-date="' + the_date + '"]').find('.fc-day-content');
                                var template = $('#tmp_adbrix_calendarData').html();
                                var templateScript = Handlebars.compile(template);
                                var context = detail;
                                var html = templateScript(context);
                                dayTarget.append(html);
                            });
                        }

                        if(response.result != "fail"){
                            $("#adbrix_totalTable").empty();
                            var template = $('#tmp_adbrix_totalTable').html();
                            var templateScript = Handlebars.compile(template);
                            var detailContext = response.data.totalInfo;
                            var html=templateScript(detailContext);
                            $("#adbrix_totalTable").append(html);
                            ui.paintColor();
                            renderAdbrixChart(response);
                        }else{
                            $("#adbrix_totalTable").empty();
                            $("#adbrix_barArea").empty();
                            $("#adbrix_lineArea").empty();
                        }

                    }
                });
            }
        });
    }


    function renderAdbrixChart(response) {
        var month;
        var day = [];
        var natural_joinCnt = [];

        if (response.result == "fail") {
            $("#adbrix_lineArea").empty();
            $("#adbrix_barArea").empty();
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

            var tmp_memoYn = "";
            if(response.data.detailList[i].memoYn == 1){
                tmp_memoYn = ' <span>🚩</span>';
            }
            if (toDay == "토") {
                toDay = '<span class="_fontColor" data-fontColor="blue" style="color:blue">' + response.data.detailList[i].the_date.substr(5).replace(/-/gi, ".") + "(" + toDay + ")" + '</span>' + tmp_memoYn;
            } else if (toDay == "일") {
                toDay = '<span class="_fontColor" data-fontColor="red" style="color:red">' + response.data.detailList[i].the_date.substr(5).replace(/-/gi, ".") + "(" + toDay + ")" + '</span>' + tmp_memoYn;
            } else {
                toDay = response.data.detailList[i].the_date.substr(5).replace(/-/gi, ".") + "(" + toDay + ")" + tmp_memoYn;
            }
            response.data.detailList[i].date = toDay;

            day.unshift(toDay);
            natural_joinCnt.unshift(response.data.detailList[i].natural_joinCnt);


        }

        /* 막대차트 [start] */
        var trace_join_cnt = {
            x: day,
            y: natural_joinCnt,
            // mode: 'lines',
            name: '<span>가입</span>',
            type: 'bar',
            text: natural_joinCnt.map(String),
            textposition: 'auto',
            hoverinfo: 'none',

            marker: {
                color: '#99CCFF'
            }
        };

        console.log(trace_join_cnt);

        var barData = [trace_join_cnt];

        var barLayout = {
            title: month + '월 > 일자별 자연 가입자 현황',
            // height: 500,
            // width: 1300,
            yaxis: {
                range: [0, 100],
                autorange: true,
                fixedrange: true
            },
            xaxis : {fixedrange: true},
            barmode: 'stack'
        };

        Plotly.newPlot('adbrix_barArea', barData, barLayout);
        /* 막대차트 [end] */

        /* 플랫폼별 라인 Chart */
        adbrix_lineChart();
    }



    function adbrix_lineChart() {
        var data = {
            startDate: $("#startDate").val()
            , endDate: $("#endDate").val()
        };
        util.getAjaxData("month", "/rest/enter/newjoin2/info/state/adbrix", data, fn_adbrix_success);
    }

    function fn_adbrix_success(dst_id, response) {
        var month;

        var day = [];
        var total_joinCnt = [];
        var natural_joinCnt = [];
        var uac = [];
        var ios = [];
        var aos = [];
        var iosAos = [];

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

                var tmp_memoYn = "";
                if(response.data.detailList[i].memoYn == 1){
                    tmp_memoYn = ' <span>🚩</span>';
                }

                toDay = week[moment(response.data.detailList[i].the_date.replace(/-/gi, ".")).add('days', 0).day()];
                if (toDay == "토") {
                    toDay = '<span class="_fontColor" data-fontColor="blue" style="color:blue">' + response.data.detailList[i].the_date.substr(5).replace(/-/gi, ".") + "(" + toDay + ")" + '</span>' + tmp_memoYn;
                } else if (toDay == "일") {
                    toDay = '<span class="_fontColor" data-fontColor="red" style="color:red">' + response.data.detailList[i].the_date.substr(5).replace(/-/gi, ".") + "(" + toDay + ")" + '</span>' + tmp_memoYn;
                } else {
                    toDay = response.data.detailList[i].the_date.substr(5).replace(/-/gi, ".") + "(" + toDay + ")" + tmp_memoYn;
                }
                response.data.detailList[i].date = toDay;

                day.unshift(toDay);
                natural_joinCnt.unshift(response.data.detailList[i].natural_joinCnt);
                total_joinCnt.unshift(response.data.detailList[i].total_joinCnt);
                uac.unshift(response.data.detailList[i].uac);
                ios.unshift(response.data.detailList[i].ios);
                aos.unshift(response.data.detailList[i].aos);
                iosAos.unshift(response.data.detailList[i].ios_aos);
            }

            /* 라인차트 [start] */
            var trace_natural = {
                x: day,
                y: natural_joinCnt,
                mode: 'lines',
                name: '<span style="color:#7030a0">자연가입자</span>',
                line: {
                    dash: 'solid',
                    width: 4,
                    color: '#7030a0'
                },
                marker: {
                    color: '#7030a0'
                }

            };

            var trace_total = {
                x: day,
                y: total_joinCnt,
                mode: 'lines',
                name: '<span style="color:#ffc000">전체가입자</span>',
                line: {
                    dash: 'dot',
                    width: 4,
                    color: '#ffc000'
                },
                marker: {
                    color: '#ffc000'
                }

            };

            var trace_uac = {
                x: day,
                y: uac,
                mode: 'lines',
                name: '<span style="color:#548235">UAC</span>',
                line: {
                    dash: 'solid',
                    width: 4,
                    color: '#548235'
                },
                marker: {
                    color: '#548235'
                }
            };

            var trace_ios = {
                x: day,
                y: ios,
                mode: 'lines',
                name: '<span style="color:#4472c4">IOS</span>',
                line: {
                    dash: 'dot',
                    width: 4,
                    color: '#4472c4'
                },
                marker: {
                    color: '#4472c4'
                }
            };

            var trace_aos = {
                x: day,
                y: aos,
                mode: 'lines',
                name: '<span style="color:#000000">AOS</span>',
                line: {
                    dash: 'solid',
                    width: 4,
                    color: '#000000'
                },
                marker: {
                    color: '#000000'
                }
            };

            var trace_iosAos = {
                x: day,
                y: iosAos,
                mode: 'lines',
                name: '<span style="color:#000000">iosAos</span>',
                line: {
                    dash: 'dot',
                    width: 4,
                    color: '#c00000'
                },
                marker: {
                    color: '#c00000'
                }
            };

            var data = [trace_natural, trace_total, trace_uac, trace_ios, trace_aos, trace_iosAos];

            var layout = {
                title: month + '월 > 일자별 자연 가입 현황',
                // height: 500,
                // width: 1300,
                yaxis: {
                    range: [0, 100],
                    autorange: true,
                    fixedrange: true
                },
                xaxis : {fixedrange: true},
                legend: {
                    y: 0.5,
                    traceorder: 'reversed',
                    font: {
                        size: 16
                    }
                }
            };


            // Plotly.newPlot('adbrix_lineArea', data, layout);
            /* 라인차트 [end] */


            var myPlot = document.getElementById('adbrix_lineArea');
            Plotly.newPlot(myPlot, data, layout);
            myPlot.on('plotly_afterplot', function(){
                Plotly.d3.selectAll(".xaxislayer-above").selectAll('text')
                    .on("click", function(d) {
                        try{
                            adbrixMemo(year + "." +  $(this).text().substr(0,5));
                        } catch (e){
                        }
                    });
            });


            $("#stateSummary").hide();
            // setSummary(response.data);
        }else{
            $("#adbrix_lineArea").empty();
        }
    }

    function adbrixMemo(param){
        memoDate = param;
        var data = {
            startDate: param
        };
        util.getAjaxData("memo", "/rest/enter/newjoin2/info/state/adbrix/memo", data, fn_adbrixMemo_success);
    }

    function fn_adbrixMemo_success(dst_id,response){
        $("#adbrixMemoModal").modal('show');
        if(!common.isEmpty(response.data)){
            memoIdx = common.replaceHtml(response.data.idx);
            $("#memo").val(response.data.memo);
            $("#bt_adbrixMemoAdd").hide();
            $("#bt_adbrixMemoUpd").show();
        }else{
            $("#memo").val("");
            $("#bt_adbrixMemoAdd").show();
            $("#bt_adbrixMemoUpd").hide();
        }
    }

    function adbrixMemoAdd(gubun){

        var message = "";
        if(gubun=="delete") {
            message = "등록된 메모를 삭제하시겠습니까?";
        }else if(gubun=="insert") {
            message = "메모를 등록하시겠습니까?";
        }else if(gubun=="update"){
            message = "등록된 메모를 수정하시겠습니까?";
        }

        if(confirm(message)){
            var data = {
                memoIdx: memoIdx
                , gubun: gubun
                , memo : common.replaceHtml($("#memo").val())
                , startDate : memoDate
            };
            util.getAjaxData("memo", "/rest/enter/newjoin2/info/state/adbrix/memo/edit", data, fn_adbrixMemoEdit_success);
        }
    }

    function fn_adbrixMemoEdit_success(dst_id, response){
        $("#adbrixMemoModal").modal('hide');
        renderNaturalJoin();
    }

    $(document).on('click', '#excelDownBtn', function (){
        var formElement = document.querySelector("form");
        var formData = new FormData(formElement);
        formData.append("startDate", $("#startDate").val());
        formData.append("endDate", $("#endDate").val());
        util.excelDownload($(this), "/rest/enter/newjoin2/adbrix/excel", formData, function(){
            console.log("fn_success_excel");
        })
    }) ;




</script>

<script type="text/x-handlebars-template" id="tmp_adbrix_calendarData">
    <div class="font-bold" style="color: black;">전체가입자 : {{addComma total_joinCnt}}</div>
    <div class="font-bold" style="color: #ff5600;">자연가입자 : {{addComma natural_joinCnt}}</div>
    <div style="color: black;">UAC : {{addComma uac}}</div>
    <div style="color: black;">오퍼월(IOS+AOS) : {{addComma ios_aos}}</div>
</script>

<script type="text/x-handlebars-template" id="tmp_adbrix_totalTable">
    <table class="table table-bordered" style="width: 100%">
        <colgroup>
            <col width="67%"/><col width="33%"/>
        </colgroup>
        <tbody>
        <tr>
            <th>구분</th>
            <th>총합</th>
        </tr>
        <tr class="font-bold">
            <td>총 가입자</td>
            <td>{{addComma total_joinCnt}}</td>
        </tr>
        <tr class="font-bold" style="color: #ff5600">
            <td>총 자연가입자</td>
            <td>{{addComma natural_joinCnt}}</td>
        </tr>
        <tr class="font-bold">
            <td>총 UAC</td>
            <td>{{addComma uac}}</td>
        </tr>
        <tr class="font-bold">
            <td>총 오퍼월 IOS+AOS</td>
            <td>{{addComma ios_aos}}</td>
        </tr>
        </tbody>
    </table>
</script>