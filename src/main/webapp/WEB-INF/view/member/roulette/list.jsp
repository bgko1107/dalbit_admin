<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="dummyData"><%= java.lang.Math.round(java.lang.Math.random() * 1000000) %></c:set>

<div class="col-lg-12 no-padding">
    <div class="widget widget-table" id="main_table">
        <div class="widget-content">
            <div class="col-md-12 no-padding mt10">
                <span id="winTypeArea"></span>
                <div class="input-group date " id="rouletteRangeDatepicker">
                    <label for="rouletteDisplayDate" class="input-group-addon">
                        <span><i class="fa fa-calendar"></i></span>
                    </label>
                    <input type="text" name="rouletteDisplayDate" id="rouletteDisplayDate" class="form-control" />
                </div>
                <input type="hidden" name="rouletteStartDate" id="rouletteStartDate">
                <input type="hidden" name="rouletteEndDate" id="rouletteEndDate" />
                <%--<input name="rouletteStartDate" id="rouletteStartDate">--%>
                <%--<input name="rouletteEndDate" id="rouletteEndDate" />--%>
                <button type="button" class="btn btn-success" id="bt_rouletteSearch">검색</button>
                <a href="javascript://" class="_roulettePrevSearch">[이전]</a>
                <a href="javascript://" class="_rouletteTodaySearch">[오늘]</a>
                <a href="javascript://" class="_rouletteNextSearch">[다음]</a>
            </div>
            <table id="applyList" class="table table-sorting table-hover table-bordered datatable">
                <thead>
                </thead>
                <tbody>
                </tbody>
            </table>
        </div>
    </div>
</div>
<script src="/js/dataTablesSource/status/levelDataTableSource.js?${dummyData}"></script>
<script src="../../../js/lib/jquery.table2excel.js"></script>
<script type="text/javascript" src="/js/code/content/contentCodeList.js?${dummyData}"></script>
<script type="text/javascript" src="/js/code/member/memberCodeList.js?${dummyData}"></script>
<script type="text/javascript" src="/js/dataTablesSource/content/eventRouletteDataTableSource.js?${dummyData}"></script>

<script type="text/javascript">

    var dateTime = new Date();
    $(document).ready(function() {
        dateTime = moment(dateTime).format("YYYY.MM.DD");

        $("#rouletteDisplayDate").statsDaterangepicker(
            function(start, end, t1) {
                $("#rouletteStartDate").val(start.format('YYYY.MM.DD'));
                $("#rouletteEndDate").val(end.format('YYYY.MM.DD'));
            }
        );

        $("#rouletteStartDate").val(dateTime);
        $("#rouletteEndDate").val(dateTime);

        $('#winTypeArea').html(util.getCommonCodeSelect('-1', roulette_winType));
    });

    $('#bt_rouletteSearch').click(function() {
        getHistory_rouletteList();
    });

    function getHistory_rouletteList(tmp) {

        var roulette_dtList_info;
        var dtList_info_data = function (data) {
            data.winType = $('#winType').val();   // 참여 구분
            data.searchType = -1;    // 검색 조건
            data.txt_search = memNo;                   // 검색 창
            data.startDate =  $("#rouletteStartDate").val();
            data.endDate =  $("#rouletteEndDate").val();
        };

        roulette_dtList_info = new DalbitDataTable($('#applyList'), dtList_info_data, EventRouletteDataTableSource.applyList, $('#searchForm'));
        roulette_dtList_info.useCheckBox(false);
        roulette_dtList_info.useIndex(true);
        roulette_dtList_info.setPageLength(50);
        roulette_dtList_info.useInitReload(true);
        roulette_dtList_info.createDataTable();
    }

    $(document).on('click', '._roulettePrevSearch', function(){
        prevNext(true);
    });

    $(document).on('click', '._rouletteNextSearch', function(){
        prevNext(false);
    });

    $(document).on('click', '._rouletteTodaySearch', function(){
        $("#rouletteStartDate").val(dateTime);
        $("#rouletteEndDate").val(dateTime);
        $("#rouletteDisplayDate").val($("#rouletteStartDate").val() + " - " + $("#rouletteEndDate").val());
        $("#bt_rouletteSearch").click();
    });

    function prevNext(isPrev){
        var addDate = isPrev ? -1 : 1;
        $("#rouletteStartDate").val(moment($("#rouletteStartDate").val()).add("days", addDate).format('YYYY.MM.DD'));
        $("#rouletteEndDate").val(moment($("#rouletteEndDate").val()).add("days", addDate).format('YYYY.MM.DD'));
        $("#rouletteDisplayDate").val($("#rouletteStartDate").val() + " - " + $("#rouletteEndDate").val());
        $("#bt_rouletteSearch").click();
    }

</script>
