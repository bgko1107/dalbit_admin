<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!--방송건수 차트-->
<div class="widget row">
    <div class="widget-content">
        <!-- end chart tab nav -->
        <div class="col-md-8 no-padding">
            <span class="font-bold mt5">* 수단별(결제)</span>
            <div id='payWayBarChart'></div>
        </div>
        <div class="col-md-4 no-padding">
            <span class="font-bold mt5">* 수단별(결제)</span>
            <div id='payWayPieChart'></div>
        </div>
        <div class="col-md-8 no-padding">
            <span class="font-bold mt5">* 성별(결제)</span>
            <div id='payGenderPieChart'></div>
        </div>
        <div class="col-md-4 no-padding">
            <span class="font-bold mt5">* 연령별(결제)</span>
            <div id='payAgePieChart'></div>
        </div>
        <%--<div class="col-md-6 no-padding">--%>
            <%--<div id='payCancelWayBarChart'></div>--%>
        <%--</div>--%>
        <%--<div class="col-md-6 no-padding">--%>
            <%--<div id='payCancelWayPieChart'></div>--%>
        <%--</div>--%>
        <!-- end chart placeholder-->
    </div>
</div>

<script type="text/javascript">

    function fn_payWay_success(dst_id, response, param){
        var detailData = response.data.totalInfo;
        var chartData = getPayWayChart(detailData, param);

        var color = [
            '#186dd0'
            ,'#00ffbc'
            ,'#00ff4a'
            ,'#3dff00'
            ,'#8fff00'
            ,'#e6ff00'
            ,'#ffda00'
            ,'#ffac00'
            ,'#ff4700'
            ,'#ff0091'
            ,'#ff00d4'
            ,'#bc00ff'
            ,'#9900ff'
        ]

        //바
        // var payWay = {
        //     type: 'bar',
        //     x: chartData.x,
        //     y: chartData.y,
        //     customdata : chartData.xCnt,
        //     name: "",
        //     marker: { color: color, line: { width: 0 }, },
        //     hovertemplate: "<b>%{customdata:,.0f}건 / %{y:,.0f}",
        // };
        //
        // var data = [payWay];
        //
        // var layout = {
        //     xaxis: { range: [0, 12], autorange: false },
        //     yaxis: { range: [0, chartData.max_x], autorange: false ,tickformat: ',d',},
        //     legend: { y: 1, y: 1, traceorder: 'reversed',separators : '.,'
        //         , font: { size: 13 }
        //     }
        // };
        //
        // var config = {responsive: true};
        // Plotly.newPlot('payWayBarChart', data, layout, config );


        var data = [{
            type: 'bar',
            x: chartData.x,
            y: chartData.y,
            orientation: 'h',
            marker: { color: color, line: { width: 0 }, },
            customdata : chartData.xCnt,
            hovertemplate: "<b>%{customdata:,.0f}건 / %{x:,.0f}",
        }];

        var layout = {
            xaxis: { range: [0, chartData.max_x], autorange: false ,tickformat: ',d',},
            yaxis: { range: [0, 10], autorange: false ,tickformat: ',d',},
            legend: { y: 1, y: 1, traceorder: 'reversed',separators : '.,'
                , font: { size: 13 }
            },
            margin: {
                l: 120,
                r: 50,
                t: 20,
                b: 20,
                pad: 4
            },
        };

        Plotly.newPlot('payWayBarChart', data, layout);



        var json = {
            values: chartData.x,
            labels: chartData.y,
            type: 'pie',
            hole: .6
        }
        var data = [json];
        var layout = {
            margin: {
                l: 120,
                r: 50,
                t: 20,
                b: 20,
                pad: 4
            },
        };
        Plotly.newPlot('payWayPieChart', data, layout);
    }

    function getPayWayChart(detailData, param) {

        //x축
        var arrayList_max_x = [
            common.charVatMinus(detailData.sum_mcAmt),
            common.charVatMinus(detailData.sum_cnAmt),
            common.charVatMinus(detailData.sum_inappAmt),
            common.charVatMinus(detailData.sum_vaAmt),
            common.charVatMinus(detailData.sum_gmAmt),
            common.charVatMinus(detailData.sum_hmAmt),
            // detailData.sum_ggAmt,
            // detailData.sum_gcAmt,
            common.charVatMinus(detailData.sum_tmoneyAmt),
            common.charVatMinus(detailData.sum_cashbeeAmt),
            common.charVatMinus(detailData.sum_paycoAmt),
            common.charVatMinus(detailData.sum_kakaopayAmt),
            common.charVatMinus(detailData.sum_kakaomoneyAmt),
        ];

        var max_x;
        max_x = Math.max.apply(null, arrayList_max_x);

        //x축
        var arrayList_x = [
            common.charVatMinus(detailData.sum_mcAmt),
            common.charVatMinus(detailData.sum_cnAmt),
            common.charVatMinus(detailData.sum_inappAmt),
            common.charVatMinus(detailData.sum_vaAmt),
            common.charVatMinus(detailData.sum_gmAmt),
            common.charVatMinus(detailData.sum_hmAmt),
            // detailData.sum_ggAmt,
            // detailData.sum_gcAmt,
            common.charVatMinus(detailData.sum_tmoneyAmt),
            common.charVatMinus(detailData.sum_cashbeeAmt),
            common.charVatMinus(detailData.sum_paycoAmt),
            common.charVatMinus(detailData.sum_kakaopayAmt),
            common.charVatMinus(detailData.sum_kakaomoneyAmt),
        ];
        var arrayList_xCnt = [
            detailData.sum_mcCnt,
            detailData.sum_cnCnt,
            detailData.sum_inappCnt,
            detailData.sum_vaCnt,
            detailData.sum_gmCnt,
            detailData.sum_hmCnt,
            // detailData.sum_ggCnt,
            // detailData.sum_gcCnt,
            detailData.sum_tmoneyCnt,
            detailData.sum_cashbeeCnt,
            detailData.sum_paycoCnt,
            detailData.sum_kakaopayCnt,
            detailData.sum_kakaomoneyCnt,
        ];

        //y축
        var arrayList_y = [
            "휴대폰",
            "카드",
            "인앱결제(아이폰)",
            "가상계좌아체",
            "문화상품권",
            "해피머니상품권",
            // "스마트문상(게임)",
            // "도서문화상품권",
            "티머니",
            "캐시비",
            "페이코",
            "카카오페이(카드)",
            "카카오페이(머니)",
        ];

        var resultData = {
            x : arrayList_x
            , xCnt : arrayList_xCnt
            , y : arrayList_y
            , max_x : max_x
        };

        console.log(resultData);
        return resultData;
    }


    function fn_agePay_success(dst_id, response, param){
        var detailData = response.data.totalInfo;
        var chartData = getPayGenderAgeChart(detailData, param);

        var json = {
            values: chartData.genderAmt,
            labels: chartData.genderType,
            type: 'pie',
            hole: .6
        }
        var data = [json];
        var layout = {
            title: '',
        };
        Plotly.newPlot('payGenderPieChart', data, layout);


        var json = {
            values: chartData.ageAmt,
            labels: chartData.ageType,
            type: 'pie',
            hole: .6
        }
        var data = [json];
        var layout = {
            title: '',
        };
        Plotly.newPlot('payAgePieChart', data, layout);

    }

    function getPayGenderAgeChart(detailData, param) {

        var genderAmt = [
            common.charVatMinus(detailData.sum_maleAmt),
            common.charVatMinus(detailData.sum_femaleAmt),
            common.charVatMinus(detailData.sum_noneAmt),
        ];
        var genderType = [
            "남",
            "여",
            "알수없음",
        ];

        var ageAmt = [
            common.charVatMinus(detailData.sum_age10Amt),
            common.charVatMinus(detailData.sum_age20Amt),
            common.charVatMinus(detailData.sum_age30Amt),
            common.charVatMinus(detailData.sum_age40Amt),
            common.charVatMinus(detailData.sum_age50Amt),
            common.charVatMinus(detailData.sum_age60Amt),
        ];
        var ageType = [
            "10대",
            "20대",
            "30대",
            "40대",
            "50대",
            "60대",
        ];

        var resultData = {
            genderAmt : genderAmt
            , genderType : genderType
            , ageAmt : ageAmt
            , ageType : ageType
        };

        console.log(resultData);
        return resultData;
    }


</script>