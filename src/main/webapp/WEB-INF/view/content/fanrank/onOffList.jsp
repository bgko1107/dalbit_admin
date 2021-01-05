<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="dummyData"><%= java.lang.Math.round(java.lang.Math.random() * 1000000) %></c:set>

<div id="wrapper">
    <div id="page-wrapper">
        <div class="container-fluid">
            <!-- serachBox -->
            <form id="searchForm">
                <div class="row col-lg-12 form-inline">
                    <div class="widget widget-table searchBoxArea">
                        <table>
                            <tr>
                                <th rowspan="2" style="background-color:#4472c4;color:#e9ee17;width: 70px">
                                    <i class="fa fa-search"></i><br/>검색
                                </th>
                                <th id="th_bottonList">
                                    <jsp:include page="../../searchArea/daySearchFunction.jsp"/>
                                    <div>
                                        <div id="div_dayButton"><jsp:include page="../../searchArea/daySearchArea.jsp"/></div>
                                        <div id="div_monthButton" style="display: none"><jsp:include page="../../searchArea/monthSearchArea.jsp"/></div>
                                        <div id="div_yearButton" style="display: none"><jsp:include page="../../searchArea/yearSearchArea.jsp"/></div>
                                    </div>
                                </th>
                            </tr>
                            <tr>
                                <td style="text-align: left">
                                    <label class="control-inline fancy-radio custom-color-green">
                                        <input type="radio" name="slctType" value='0' checked="checked" />
                                        <span><i></i>일간</span>
                                    </label>
                                    <label class="control-inline fancy-radio custom-color-green">
                                        <input type="radio" name="slctType" value='1' />
                                        <span><i></i>월간</span>
                                    </label>
                                    <label class="control-inline fancy-radio custom-color-green">
                                        <input type="radio" name="slctType" value='2' />
                                        <span><i></i>연간</span>
                                    </label>

                                    <jsp:include page="../../searchArea/dateRangeSearchArea.jsp"/>

                                    <input id="onedayDate" type="text" class="form-control" style="width: 196px;" />
                                    <input id="monthDate" type="text" class="form-control" style="width: 196px; display:none;"/>
                                    <input id="yearDate" type="text" class="form-control" style="width: 196px; display:none;"/>

                                    <input class="hide" name="startDate" id="startDate" style="width: 100px">
                                    <input class="hide" name="endDate" id="endDate" style="width: 100px">
                                    <label><input type="text" class="form-control" name="searchText" id="searchText" placeholder="검색어를 입력해주세요." style="display: none"></label>

                                    <button type="button" class="btn btn-success" id="bt_search">검색</button>
                                    <a href="javascript://" class="_prevSearch">[이전]</a>
                                    <a href="javascript://" class="_todaySearch">[오늘]</a>
                                    <a href="javascript://" class="_nextSearch">[다음]</a>
                                </td>
                            </tr>
                        </table>
                    </div>
                </div>
            </form>
            <!-- // serachBox -->

            <!-- data table -->
            <div class="row col-lg-12 form-inline">
                <div class="col-lg-12 no-padding no-margin">
                    <div class="col-lg-3 no-padding no-margin" id="on_off_summary">
                        <table class="table table-sorting table-hover table-bordered datatable">
                            <tr>
                                <th>미 반영 중복 합계</th>
                                <th>미 반영 비중복 합계</th>
                            </tr>
                            <tr>
                                <td><span id="summary_allCnt">0</span></td>
                                <td><span id="summary_uniqueCnt">0</span></td>
                            </tr>
                        </table>
                    </div>
                </div>

                <div class="tab-content">
                    <div class="tab-pane fade in active">
                        <div class="widget widget-table">
                            <div class="widget-content mt10">
                                <table id="onOffList" class="table table-sorting table-hover table-bordered datatable"></table>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!-- // data table -->

        </div> <!-- // container-fluid -->
    </div> <!-- // page-wrapper -->
</div> <!-- //wrapper -->

<script type="text/javascript" src="/js/dataTablesSource/content/fanrankDataTableSource.js?${dummyData}"></script>
<script type="text/javascript">

    $(document).ready(function() {
        slctType = 0;
        setDayButton();

        initOnOffList();
    });

    $('input[id="searchText"]').keydown(function(e) {
        if(e.keyCode == 13) {
            initOnOffList();
        }
    });
    $("#bt_search").on('click', function() {
        initOnOffList();
    });

    $('input[name="slctType"]').on('change', function(){
        slctType = $('input:radio[name="slctType"]:checked').val()
        //dateType(slctType);

        dateType();

        initOnOffList();
    });

    var dtList_info_data = function (data) {
        var slctType = $('input[name="slctType"]:checked').val();

        var checkDate;
        if(slctType == 0){
            checkDate = $("#onedayDate").val();
        }else if(slctType == 1){
            checkDate = $("#monthDate").val() + '.01';
        }else if(slctType == 2){
            checkDate = $("#yearDate").val() + '.01.01';
        }

        var data = {
            slctType : slctType
            , mem_no : 0
            , checkDate : checkDate
        }
        
        return data;
    };

    var onOffList_info;
    function initOnOffList(){
        onOffList_info = new DalbitDataTable($("#onOffList"), dtList_info_data(), fanrank.onOffList, null, summary);
        onOffList_info.useCheckBox(false);
        onOffList_info.useIndex(true);
        onOffList_info.setPageLength(50);
        onOffList_info.createDataTable();
    }

    function summary(json){
        console.log('summary')
        console.log(json);
        if(common.isEmpty(json.summary)){
            $("#summary_allCnt").html(common.addComma(0));
            $("#summary_uniqueCnt").html(common.addComma(0));
        }else{
            var _summary = json.summary;
            $("#summary_allCnt").html(common.addComma(_summary.allCnt));
            $("#summary_uniqueCnt").html(common.addComma(_summary.uniqueCnt));
        }

    }
</script>