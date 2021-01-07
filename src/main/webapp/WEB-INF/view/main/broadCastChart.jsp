<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!--방송건수 차트-->
<div class="widget row">
    <!-- end chart tab nav -->
    <%--<div class="col-md-6 no-padding">--%>
        <%--<span class="font-bold mt5">* 성별(방송)</span>--%>
        <%--<div id='broadcastGenderChart'></div>--%>
    <%--</div>--%>
    <%--<div class="col-md-6 no-padding">--%>
        <%--<span class="font-bold mt5">* 연령별(방송)</span>--%>
        <%--<div id='broadcastAgeChart'></div>--%>
    <%--</div>--%>

    <div class="col-md-6 no-padding">
        <span class="font-bold mt5">* 성별(방송)</span>
        <div id='broadcastGenderChart'></div>
    </div>
    <div class="col-md-6 no-padding">
        <span class="font-bold mt5">* 성별(방송/비중복)</span>
        <div id='broadcastGenderUniqueChart'></div>
    </div>
    <div class="col-md-6 no-padding">
        <span class="font-bold mt5">* 성별(청취자)</span>
        <div id='listenerGenderChart'></div>
    </div>
    <div class="col-md-6 no-padding">
        <span class="font-bold mt5">* 성별(청취자/비중복)</span>
        <div id='listenerGenderUniqueChart'></div>
    </div>

    <div class="col-md-6 no-padding">
        <span class="font-bold mt5">* 성별(게스트)</span>
        <div id='guestGenderChart'></div>
    </div>
    <div class="col-md-6 no-padding">
        <span class="font-bold mt5">* 성별(게스트/비중복)</span>
        <div id='guestGenderUniqueChart'></div>
    </div>
    <!-- end chart placeholder-->
    <hr class="separator">
</div>

<script type="text/javascript">

    // function fn_broadcastDj_success(dst_id, response, param){
    //     var detailData = response.data.totalInfo;
    //     var chartData = getLoginTotalChart(detailData, param);
    //
    //     var json = {
    //         values: chartData.sumGender,
    //         labels: ['남', '여', '알수없음'],
    //         type: 'pie',
    //         hole: .6
    //     }
    //     var data = [json];
    //     var layout = { title: '', };
    //     Plotly.newPlot('broadcastGenderChart', data, layout);
    //
    //     var json = {
    //         values: chartData.sumAge,
    //         labels: ['10대', '20대', '30대', '40대', '50대', '60대'],
    //         type: 'pie',
    //         hole: .6
    //     }
    //     var data = [json];
    //     var layout = { title: '', };
    //     Plotly.newPlot('broadcastAgeChart', data, layout);
    // }
    //
    // function getLoginTotalChart(detailData, param) {
    //     //x축
    //     var sumGender = [detailData.sum_maleCnt, detailData.sum_femaleCnt, detailData.sum_noneCnt];
    //     var sumAge = [detailData.sum_dj10Cnt, detailData.sum_dj20Cnt, detailData.sum_dj30Cnt, detailData.sum_dj40Cnt, detailData.sum_dj50Cnt, detailData.sum_dj60Cnt];
    //     var resultData = { sumGender : sumGender,sumAge : sumAge };
    //     return resultData;
    // }

    function fn_listener_success(dst_id, response, param) {

        var detailData = response.data.totalInfo;
        var chartData = getLoginListenChart(detailData, param);

        var json = {
            values: chartData.sumGender,
            labels: ['남', '여', '알수없음'],
            type: 'pie',
            hole: .6
        }
        var data = [json];
        var layout = { title: '', };
        Plotly.newPlot('broadcastGenderChart', data, layout);

        var json = {
            values: chartData.sumGenderUnique,
            labels: ['남', '여', '알수없음'],
            type: 'pie',
            hole: .6
        }
        var data = [json];
        var layout = { title: '', };
        Plotly.newPlot('broadcastGenderUniqueChart', data, layout);


        var json = {
            values: chartData.sumListenerGender,
            labels: ['남', '여', '알수없음'],
            type: 'pie',
            hole: .6
        }
        var data = [json];
        var layout = { title: '', };
        Plotly.newPlot('listenerGenderChart', data, layout);

        var json = {
            values: chartData.sumListenerGenderUnique,
            labels: ['남', '여', '알수없음'],
            type: 'pie',
            hole: .6
        }
        var data = [json];
        var layout = { title: '', };
        Plotly.newPlot('listenerGenderUniqueChart', data, layout);

        var json = {
            values: chartData.sumGuestGender,
            labels: ['남', '여', '알수없음'],
            type: 'pie',
            hole: .6
        }
        var data = [json];
        var layout = { title: '', };
        Plotly.newPlot('guestGenderChart', data, layout);

        var json = {
            values: chartData.sumGuestGenderUnique,
            labels: ['남', '여', '알수없음'],
            type: 'pie',
            hole: .6
        }
        var data = [json];
        var layout = { title: '', };
        Plotly.newPlot('guestGenderUniqueChart', data, layout);
    }

    function getLoginListenChart(detailData, param) {
        //x축
        var sumGender = [detailData.total_create_mCnt, detailData.total_create_fCnt, detailData.total_create_nCnt];
        var sumGenderUnique = [detailData.total_unique_dj_mCnt, detailData.total_unique_dj_fCnt, detailData.total_unique_dj_nCnt];
        var sumListenerGender = [detailData.total_listener_mCnt, detailData.total_listener_fCnt, detailData.total_listener_nCnt];
        var sumListenerGenderUnique = [detailData.total_unique_listener_mCnt, detailData.total_unique_listener_fCnt, detailData.total_unique_listener_nCnt];
        var sumGuestGender = [detailData.total_guest_mCnt, detailData.total_guest_fCnt, detailData.total_guest_nCnt];
        var sumGuestGenderUnique = [detailData.total_guest_unique_mCnt, detailData.total_guest_unique_fCnt, detailData.total_guest_unique_nCnt];
        var resultData = { sumGender : sumGender,sumGenderUnique : sumGenderUnique, sumListenerGender:sumListenerGender,sumListenerGenderUnique: sumListenerGenderUnique, sumGuestGender: sumGuestGender, sumGuestGenderUnique: sumGuestGenderUnique };
        return resultData;
    }

</script>