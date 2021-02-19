<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="dummyData"><%= java.lang.Math.round(java.lang.Math.random() * 1000000) %></c:set>

<div id="wrapper">
    <div id="page-wrapper">
        <!-- serachBox -->
        <form id="searchForm">
            <div class="col-lg-12 form-inline no-padding">
                <div class="widget widget-table searchBoxArea">
                    <table>
                        <tr>
                            <th rowspan="2" style="background-color:#4472c4;color:#e9ee17;width: 70px">
                                <i class="fa fa-search"></i><br/>검색
                            </th>
                        </tr>
                        <tr>
                            <td style="text-align: left">
                                <span id="searchMemberArea" onchange="btSearchClick();"></span>
                                <label><input type="text" class="form-control" id="txt_search" name="txt_search"></label>
                                <button type="button" class="btn btn-success" id="bt_search">검색</button>

                                <label class="control-inline"><span>◈ 최근 2주간 미접속 회원</span></label>
                                <label class="control-inline fancy-radio custom-color-green" >
                                    <input type="radio" name="include_radio" checked="checked" value="0">
                                    <span><i></i>포함</span>
                                </label>
                                <label class="control-inline fancy-radio custom-color-green">
                                    <input type="radio" name="include_radio" value="1">
                                    <span><i></i>제외</span>
                                </label>

                                <label class="control-inline fancy-checkbox custom-color-green">
                                    <input type="checkbox" name="search_testId" id="search_testId" value="1" checked="true">
                                    <span>테스트 아이디 제외</span>
                                </label>
                            </td>
                        </tr>
                    </table>
                </div>
            </div>
            <!-- //serachBox -->
        </form>
        <div>
            <div class="col-md-12 no-padding mb10">
                <div class="pull-right">
                    <span id="level_summaryArea"></span>
                </div>
            </div>
            <div class="col-md-12 no-padding">
                <div class="pull-right">
                    <span id="level_summaryArea2"></span>
                </div>
            </div>

            <div class="col-md-12 no-padding">
                <label id="level" onchange="sel_change_levelInnerArea();"></label>
                <label id="levelFilter" onchange="sel_change_levelFilter();"></label>
                <table id="list_info" class="table table-sorting table-hover table-bordered">
                    <thead></thead>
                    <tbody></tbody>
                </table>
            <%--<button class="btn btn-default btn-sm print-btn pull-right" type="button" id="excelDownBtn"><i class="fa fa-print"></i>Excel Down</button>--%>
            </div>
        </div>
    </div> <!-- //page-wrapper -->
</div> <!-- //wrapper -->

<script src="/js/dataTablesSource/status/levelDataTableSource.js?${dummyData}"></script>
<script src="/js/code/status/statusCodeList.js?${dummyData}"></script>

<script type="text/javascript">

    $(document).ready(function() {
        $("#searchMemberArea").html(util.getCommonCodeSelect(1, searchMember));
    });

    $(document).on('change', 'input[name="searchFormRadio"]', function(){
        radioChange();
    });

    function radioChange(){
        _searchFormRadio = $('input[name="searchFormRadio"]:checked').val();
        if(_searchFormRadio == 2){
            setTimeDate(dateTime);
        }
        setStartDay();
    }

    $(document).on('click', '._prevSearch', function(){
        searchDate('prev');
    });

    $(document).on('click', '._nextSearch', function(){
        searchDate('next');
    });

    $(document).on('click', '._todaySearch', function(){
        $("input:radio[name='searchFormRadio']:radio[value='2']").prop('checked', true);
        _searchFormRadio = $('input[name="searchFormRadio"]:checked').val();
        setTimeDate(dateTime);
        setStartDay();
    });

    function setTimeDate(dateTime){
        $("#startDate").val(dateTime);
        $("#endDate").val(dateTime);
        $("#displayDate").val(dateTime + " - " + dateTime);
    }

    function searchDate(dateType){
        if(dateType == 'prev'){
            setDay(-1);
        }else if(dateType == 'next'){
            setDay(1);
        }
    }

    function setDay(days){
        $("#startDate").val(moment($("#startDate").val()).add('days', days).format('YYYY.MM.DD'));
        $("#endDate").val(moment($("#endDate").val()).add('days', days).format('YYYY.MM.DD'));

        $("#displayDate").val($("#startDate").val() + " - " + $("#endDate").val());

        getMemLevelSearch();
    }
    var sDate;
    var eDate;
    function setStartDay(){
        var date = new Date();
        $("#endDate").val(dateTime);

        if(_searchFormRadio == 1) {     // 일주일 전
            sDate = new Date(Date.parse(date) - 7 * 1000 * 60 * 60 * 24);           // 일주일 전
            sDate = date.getFullYear() +"."+ common.lpad(sDate.getMonth() + 1,2,"0") +"."+ common.lpad(sDate.getDate()+1,2,"0");      // 일주일전
            $("#startDate").val(sDate);
        }else if(_searchFormRadio == 0) {       // 한달전
            $("#startDate").val(date.getFullYear() +"."+ common.lpad(date.getMonth(),2,"0") +"."+ common.lpad(date.getDate(),2,"0"));        // 한달전
        }
        $("#displayDate").val($("#startDate").val() + " - " + $("#endDate").val());

        getMemLevelSearch();
    }

    $('input[id="txt_search"]').keydown(function() {
        if (event.keyCode === 13) {
            getMemLevelSearch();
        };
    });

    $('#bt_search').click( function() {       //검색
        getMemLevelSearch();
    });

    init();

    function init(){
        txt_search = $('#txt_search').val();
        sDate = $("#startDate").val();
        eDate = $("#endDate").val();
    }

    function getMemLevelSearch(){
        sDate = $("#startDate").val();
        eDate = $("#endDate").val();
        txt_search = $('#txt_search').val();
        tmp_inner = $('input[name="search_testId"]').is(":checked") ? "0" : "1";

        dtList_info.reload(level_listSummary);
    }

    $("input[name='include_radio']").change(function () {
        tmp_include = this.value;
        getMemLevelSearch();
    });

    $("input[name='search_testId']").change(function () {
        getMemLevelSearch();
    });

    var tmp_include = "0";
    var tmp_level = "-1";
    var tmp_inner = 0;
    var tmp_filter = 0;
    var dtList_info;
    var lengthCnt = 100;

    function getMemLevelList() {
        var dtList_info_data = function(data) {
            data.searchText = txt_search;                        // 검색명
            data.sDate = sDate;
            data.eDate = eDate;
            data.checkLevel = tmp_level;
            data.testId = tmp_inner;
            data.lastConnectCheck = tmp_include;
            data.slctType = tmp_filter;
            data.newSearchType = $("#searchMember").val();
        };
        dtList_info = new DalbitDataTable($("#list_info"), dtList_info_data, levelDataTableSource.memLevelList);
        dtList_info.useCheckBox(false);
        dtList_info.useIndex(true);
        dtList_info.setPageLength(lengthCnt);
        dtList_info.useInitReload(true);
        dtList_info.createDataTable(level_listSummary);

        $("#level").html(util.getCommonCodeSelect('', level));
        $("#levelFilter").html(util.getCommonCodeSelect('', levelFilter));

    }

    function level_listSummary(json){
        var template = $("#level_tableSummary").html();
        var templateScript = Handlebars.compile(template);
        var data = {
            content : json.summary
            , length : json.recordsTotal
        };
        var html = templateScript(data);
        $("#level_summaryArea").html(html);


        $("#list_info th:eq(" + (2) + ")").css("background-color", "#ffe699");
        $("#list_info th:eq(" + (12) + ")").css("background-color", "#ffe699");
        for(var i=-1;i<lengthCnt;i++){
            $("#list_info tr:eq(" + i + ") td:eq(" + (2) + ")").css("background-color", "#fff7e5");
            $("#list_info tr:eq(" + i + ") td:eq(" + (12) + ")").css("background-color", "#fff7e5");
        }

    }

    function sel_change_levelInnerArea(){
        tmp_level = $("select[name='level']").val();
        dtList_info.reload(level_listSummary);
    }
    function sel_change_levelFilter(){
        tmp_filter = $("select[name='levelFilter']").val();
        dtList_info.reload(level_listSummary);
    }

    $(document).on('click', '._levelClick', function(){
        _level10 = $(this).data('level');
        var data = {};
        data.level = $(this).data('level');
        data.inner = tmp_inner;
        data.include = tmp_include;

        util.getAjaxData("summary", "/rest/status/level/summary",data, level_summary_success);
    });

    function level_summary_success(dst_id, response, param) {
        dalbitLog(param);

        var template = $("#level_tableSummary2").html();
        var templateScript = Handlebars.compile(template);
        var data = {
            content : response.summary
        };
        var html = templateScript(data);
        $("#level_summaryArea2").html(html);

        var header = 9;
        for (var i = param.level; i > (param.level-10); i--) {
            $("#tableHeader tr:eq(0) th:eq(" + header + ")").html(i + "Lv");
            header--;
        }
    }
    // /*=============엑셀==================*/
    // $('#excelDownBtn').on('click', function(){
    //     var formElement = document.querySelector("form");
    //     var formData = new FormData(formElement);
    //     formData.append("searchText", txt_search);
    //     formData.append("period", tmp_period);
    //     formData.append("sDate", sDate);
    //     formData.append("eDate", eDate);
    //     formData.append("ostype", tmp_ostype);
    //     formData.append("searchPayStatus", tmp_searchPayStatus);
    //     formData.append("innerType", tmp_innerType);
    //     formData.append("payWay", tmp_payWay);
    //
    //     util.excelDownload($(this), "/rest/payment/pay/listExcel", formData);
    //
    // });

    function btSearchClick(){
        $("#bt_search").click();
    }

</script>

<script id="level_tableSummary" type="text/x-handlebars-template">
    <table class="table table-condensed table-dark-header table-bordered no-margin" style="width: 600px;">
        <colgroup>
            <col width="16.6%"/><col width="16.6%"/><col width="16.6%"/><col width="16.6%"/><col width="16.6%"/>
            <col width="16.6%"/>
        </colgroup>
        <thead>
            <tr>
                <th>사용자</th><th>0Lv</th><th>1Lv~10Lv</th><th>11Lv~20Lv</th><th>21Lv~30Lv</th><th>31Lv~40Lv</th><th>41Lv~50Lv</th><th>51Lv~60Lv</th>
                <th>61Lv~70Lv</th>
                <th>71Lv~80Lv</th>
                <th>81Lv~90Lv</th>
                <th>91Lv~100Lv</th>
            </tr>
        </thead>
        <tr class="font-bold">
            <td style="color: red">{{addComma content.totalLevelCnt}}</td>
            <td>{{addComma content.level0}}</td>
            <td><a href="javascript://" class="_levelClick" data-level = "10">{{addComma content.level10}}</a></td>
            <td><a href="javascript://" class="_levelClick" data-level = "20">{{addComma content.level20}}</a></td>
            <td><a href="javascript://" class="_levelClick" data-level = "30">{{addComma content.level30}}</a></td>
            <td><a href="javascript://" class="_levelClick" data-level = "40">{{addComma content.level40}}</a></td>
            <td><a href="javascript://" class="_levelClick" data-level = "50">{{addComma content.level50}}</a></td>
            <td><a href="javascript://" class="_levelClick" data-level = "60">{{addComma content.level60}}</a></td>
            <td><a href="javascript://" class="_levelClick" data-level = "70">{{addComma content.level70}}</a></td>
            <td><a href="javascript://" class="_levelClick" data-level = "80">{{addComma content.level80}}</a></td>
            <td><a href="javascript://" class="_levelClick" data-level = "90">{{addComma content.level90}}</a></td>
            <td><a href="javascript://" class="_levelClick" data-level = "100">{{addComma content.level100}}</a></td>
        </tr>
    </table>
</script>

<script id="level_tableSummary2" type="text/x-handlebars-template">
    <table class="table table-condensed table-dark-header table-bordered no-margin" style="width: 1000px;">
        <colgroup>
            <col width="8%"/><col width="8%"/><col width="8%"/><col width="8%"/><col width="8%"/><col width="8%"/>
            <col width="8%"/><col width="8%"/><col width="8%"/><col width="8%"/><col width="8%"/><col width="8%"/>
            <col width="8%"/><col width="8%"/>
        </colgroup>
        <thead id="tableHeader">
            <tr>
                <th>1Lv</th>
                <th>2Lv</th>
                <th>3Lv</th>
                <th>4Lv</th>
                <th>5Lv</th>
                <th>6Lv</th>
                <th>7Lv</th>
                <th>8Lv</th>
                <th>9Lv</th>
                <th>10Lv</th>
                <th>총합</th>
            </tr>
        </thead>
        <tbody>
            <tr class="font-bold">
                <td>{{addComma content.level1}}</td>
                <td>{{addComma content.level2}}</td>
                <td>{{addComma content.level3}}</td>
                <td>{{addComma content.level4}}</td>
                <td>{{addComma content.level5}}</td>
                <td>{{addComma content.level6}}</td>
                <td>{{addComma content.level7}}</td>
                <td>{{addComma content.level8}}</td>
                <td>{{addComma content.level9}}</td>
                <td>{{addComma content.level10}}</td>
                <td>{{addComma content.totalLevelCnt}}</td>
            </tr>
        </tbody>
    </table>
</script>