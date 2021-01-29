<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!--방송건수 차트-->
<div class="widget row">
    <!-- end chart tab nav -->
    <div class="col-md-8 no-padding">
        <span class="font-bold mt5">* 플랫폼별(접속)</span>
        <div id='loginBrowserBarChart'></div>
    </div>
    <div class="col-md-4 no-padding">
        <span class="font-bold mt5">* 플랫폼별(접속)</span>
        <div id='loginBrowserPieChart'></div>
    </div>
    <div class="col-md-8 no-padding">
        <span class="font-bold mt5">* 성별(접속)</span>
        <div id='loginTotalChart'></div>
    </div>
    <div class="col-md-4 no-padding">
        <span class="font-bold mt5">* 연령별(접속)</span>
        <div id='loginAgeChart'></div>
    </div>
    <!-- end chart placeholder-->
    <hr class="separator">
</div>

<script type="text/javascript">

    function fn_loginBrowser_success(dst_id, response, param){

        if($('input[name="slctType"]:checked').val() == 1) {
            response.data.detailList.sort(function(a, b) { // 오름차순
                return a["day"] - b["day"];
            });
        }

        var detailData = response.data;
        var chartData = getLoginBrowserChart(detailData, param);

        //바
        var aos = {
            type: 'bar',
            x: chartData.x,
            y: chartData.aos,
            name: "안드로이드",
            marker: { color: '#2ca02c', line: { width: 0 }, },
            hovertemplate: "<b>안드로이드:%{y}",
        };
        var ios = {
            type: 'bar',
            x: chartData.x,
            y: chartData.ios,
            name: "IOS",
            marker: { color: '#ff7f0e', line: { width: 0 }, },
            hovertemplate: "<b>IOS:%{y}",
        };
        var pc = {
            type: 'bar',
            x: chartData.x,
            y: chartData.pc,
            name: "PC",
            marker: { color: '#1f77b4', line: { width: 0 }, },
            hovertemplate: "<b>PC:%{y}",
        };

        var data = [aos,ios,pc];

        var layout = {
            xaxis: { range: [0, chartData.dataLength], autorange: false },
            yaxis: { range: [0, chartData.max_y], autorange: false},
            legend: { y: 1, y: 1, traceorder: 'reversed'
                , font: { size: 13 }
            },
            margin: {
                l: 120,
                r: 50,
                t: 20,
                b: 100,
                pad: 4
            },
        };

        var config = {responsive: true};
        Plotly.newPlot('loginBrowserBarChart', data, layout, config );

        var json = {
            values: chartData.sumPlaform,
            labels: ['안드로이드', 'IOS', 'PC'],
            type: 'pie',
            hole: .6
        }

        var data = [json];

        var layout = {
            title: '',
        };
        Plotly.newPlot('loginBrowserPieChart', data, layout);
    }

    function getLoginBrowserChart(detailData, param) {
        //x축
        var arrayList_x = [];
        var dataLength = detailData.detailList.length;
        for (var i = 0; i < dataLength; i++) {
            var array = {};
            if($('input[name="slctType"]:checked').val() == 0) {
                array = detailData.detailList[i].hour +'시';
            }else if($('input[name="slctType"]:checked').val() == 1) {
                array = detailData.detailList[i].day + "일";
            }else if($('input[name="slctType"]:checked').val() == 2) {
                array = detailData.detailList[i].month +'월';
            }
            arrayList_x.push(array);
        }

        //y축
        var arrayList_aos = [];
        var max_aos = 10;  //최대값
        for(var i=0 ; i<dataLength; i++) {
            var array = {};
            array = detailData.detailList[i].androidCnt;
            arrayList_aos.push(array);
            if(max_aos < array){
                max_aos = array + 10;
            }
        }

        //y축
        var arrayList_ios = [];
        var max_ios = 10;  //최대값
        for(var i=0 ; i<dataLength; i++) {
            var array = {};
            array = detailData.detailList[i].iosCnt;
            arrayList_ios.push(array);
            if(max_ios < array){
                max_ios = array + 10;
            }
        }

        //y축
        var arrayList_pc = [];
        var max_pc = 10;  //최대값
        for(var i=0 ; i<dataLength; i++) {
            var array = {};
            array = detailData.detailList[i].pcCnt;
            arrayList_pc.push(array);
            if(max_pc < array){
                max_pc = array + 10;
            }
        }

        var sumPlaform = [detailData.totalInfo.sum_androidCnt, detailData.totalInfo.sum_iosCnt, detailData.totalInfo.sum_pcCnt];

        var max_y;
        var max_list = [
            Math.max.apply(null, arrayList_aos),
            Math.max.apply(null, arrayList_ios),
            Math.max.apply(null, arrayList_pc),
        ];
        max_y = Math.max.apply(null, max_list);

        var resultData = {
            x : arrayList_x
            , aos : arrayList_aos
            , ios : arrayList_ios
            , pc : arrayList_pc
            , sumPlaform : sumPlaform
            , dataLength : dataLength
            , max_y : max_y
        };

        console.log(resultData);
        return resultData;
    }

    function fn_loginTotal_success(dst_id, response, param){
        var detailData = response.data.totalInfo;
        var chartData = getLoginTotalChart(detailData, param);

        var json = {
            values: chartData.sumGender,
            labels: ['남', '여', '알수없음'],
            type: 'pie',
            hole: .6
        }
        var data = [json];
        var layout = { title: '', };
        Plotly.newPlot('loginTotalChart', data, layout);
    }

    function getLoginTotalChart(detailData, param) {
        //x축
        var sumGender = [detailData.sum_maleCnt, detailData.sum_femaleCnt, detailData.sum_noneCnt];
        var resultData = { sumGender : sumGender };
        return resultData;
    }

    function fn_loginAge_success(dst_id, response, param){
        var detailData = response.data.totalInfo;
        var chartData = getLoginAgeChart(detailData, param);

        var json = {
            values: chartData.sumAge,
            labels: ['미선택', '10대', '20대', '30대', '40대', '50대', '60대'],
            type: 'pie',
            hole: .6
        }
        var data = [json];
        var layout = { title: '', };
        Plotly.newPlot('loginAgeChart', data, layout);
    }

    function getLoginAgeChart(detailData, param) {
        //x축
        var sumAge = [detailData.sum_age00Cnt, detailData.sum_age10Cnt, detailData.sum_age20Cnt, detailData.sum_age30Cnt, detailData.sum_age40Cnt, detailData.sum_age50Cnt, detailData.sum_age60Cnt];
        var resultData = { sumAge : sumAge };
        return resultData;
    }

</script>