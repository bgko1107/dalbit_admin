<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="cfn" uri="/WEB-INF/tld/comFunction.tld" %>
<c:set var="dummyData"><%= java.lang.Math.round(java.lang.Math.random() * 1000000) %></c:set>

<!-- DATA TABLE -->
<div class="row col-lg-12 form-inline block ml0 pl0 pr0 no-padding">
    <div>
        <div class="row col-lg-12 pl0 pr0 no-padding">
            <div class="col-lg-12 no-padding">
                <div class="col-md-4 no-padding">
                    <div class="col-md-3 no-padding mr10">
                        <span id="autoChangeList_order" onchange="autoChangeList_order_click();"></span>
                    </div>
                </div>
            </div>
            <div class="col-lg-12 mt15 no-padding">
                <div class="dataTables_paginate paging_full_numbers" id="autoList_info_paginate_top"></div>
                <table id="list_info" class="table table-sorting table-hover table-bordered">
                    <thead id="tableTop">
                    <tr>
                        <th>No</th>
                        <th>설정일시</th>
                        <th>최근 교환일시</th>
                        <th>회원정보</th>
                        <th>성별</th>
                        <th>자동교환 건</th>
                        <th>최근 자동교환 별</th>
                        <th>총 교환 별</th>
                        <th>누적 자동 교환 별</th>
                        <th>보유 달 수</th>
                    </tr>
                    </thead>
                    <tbody id="autoTableBody"></tbody>
                </table>
                <div class="dataTables_paginate paging_full_numbers" id="autoList_info_paginate"></div>
            </div>
            <%--<button class="btn btn-sm btn-success print-btn no-margin pull-right" type="button" id="excelDownBtn"><i class="fa fa-print"></i> Excel Down</button>--%>
        </div>
    </div>
</div>
<!-- DATA TABLE END -->


<button class="btn btn-primary btn-lg" data-toggle="modal" data-target="#detailView" id="showModal" style="display:none;">레이어팝업오픈버튼</button>

<div class="modal fade" id="detailView" tabindex="-1" role="dialog" aria-labelledby="detailViewLabel" aria-hidden="true"></div>

<form name="excelForm" id="excelForm"></form>

<script type="text/javascript" src="/js/lib/jquery.table2excel.js"></script>
<script type="text/javascript" src="/js/code/money/exchangeCodeList.js?${dummyData}"></script>
<script type="text/javascript" src="/js/code/member/memberCodeList.js?${dummyData}"></script>
<script type="text/javascript" src="/js/handlebars/moneyHelper.js?${dummyData}"></script>
<script type="text/javascript" src="/js/handlebars/statusHelper.js?${dummyData}"></script>
<script type="text/javascript">

    $(function(){
        $("#autoChangeList_order").html(util.getCommonCodeSelect(-1, autoChangeList_order));
    });

    var autoChangePagingInfo = new PAGING_INFO(0,1,50);

    function fn_succ_autoList(dst_id, response) {

        var template = $('#tmp_autoChangeItemList').html();
        var templateScript = Handlebars.compile(template);
        var context = response.data;
        var html = templateScript(context);
        $("#autoTableBody").html(html);
        autoChangePagingInfo.totalCnt = response.data.totalInfo.totalCnt;

        if(response.data.detailList.length > 0){
            util.renderPagingNavigation("autoList_info_paginate_top", autoChangePagingInfo);
            util.renderPagingNavigation("autoList_info_paginate", autoChangePagingInfo);
        }
        autoChange_summary(response);
    }

    function autoChange_summary(json){
        console.log(json.data.totalInfo);

        json.data.totalInfo.averageCnt = (json.data.totalInfo.totalCnt / json.data.totalInfo.dateDiff).toFixed(1);
        json.data.totalInfo.averageAutoCnt = (json.data.totalInfo.totalAutoCnt / json.data.totalInfo.dateDiff).toFixed(1);
        json.data.totalInfo.averageAutoByeol = (json.data.totalInfo.totalAutoByeol / json.data.totalInfo.dateDiff).toFixed(1);
        json.data.totalInfo.averageExchangeAmt = (json.data.totalInfo.totalExchangeAmt / json.data.totalInfo.dateDiff).toFixed(1);

        var template = $("#autoChange_tableSummary").html();
        var templateScript = Handlebars.compile(template);
        var data = {
            content : json.data.totalInfo
            , length : json.data.totalInfo
        };
        var html = templateScript(data);
        $("#autoChange_summaryArea").html(html);
        ui.tableHeightSet();
    }

    $('#excelDownBtn').on('click', function(){
        var hidden = '<input type="hidden" name="{name}" value="{value}">';

        var hiddenData = '';
        hiddenData += hidden.replace('{name}', 'isSpecial').replace('{value}', getParameter().isSpecial);
        hiddenData += hidden.replace('{name}', 'search_year').replace('{value}', getParameter().search_year);
        hiddenData += hidden.replace('{name}', 'search_month').replace('{value}', getParameter().search_month);
        hiddenData += hidden.replace('{name}', 'search_state').replace('{value}', 0);
        hiddenData += hidden.replace('{name}', 'search_testId').replace('{value}', getParameter().search_testId);
        hiddenData += hidden.replace('{name}', 'search_type').replace('{value}', getParameter().search_type);
        hiddenData += hidden.replace('{name}', 'search_value').replace('{value}', getParameter().search_value);

        $("#excelForm").html(hiddenData).attr({
            method : 'post'
            , action : '/money/exchange/listExcel'
            , target : 'iframe_excel_download'
        }).submit();
    });

    function fn_success_excel(response) {
    }

    function autoChangeList_order_click(){
        autoChangePagingInfo.pageNo = 1;
        orderType = $("select[name='autoChange_order']").val();
        getAutoList();
    }



</script>

<script type="text/x-handlebars-template" id="tmp_autoChangeItemList">
    {{#each this.detailList as |data|}}
    <tr {{#dalbit_if data.inner '==' 1}} style="background-color : #dae3f3" {{/dalbit_if}}>
        <td>
            {{indexDesc ../totalInfo/totalCnt data.rowNum}}
        </td>
        <td>{{substr data.change_date 0 19}}</td>
        <td>{{substr data.last_upd_date 0 19}}</td>
        <td>
            <a href="javascript://" class="_openMemberPop" data-memno="{{data.mem_no}}">{{data.mem_no}}</a><br/>
            {{data.mem_nick}}
        </td>
        <td>{{{sexIcon data.mem_sex data.mem_birth_year}}}</td>
        <td>{{addComma data.auto_cnt}}건</td>
        <td>{{addComma data.last_byeol}}별</td>
        <td>{{addComma data.total_changebyeol}}별</td>
        <td>{{addComma data.total_byeol}}별</td>
        <td>{{addComma data.dal}}달</td>
    </tr>

    {{else}}
    <tr>
        <td colspan="20">{{isEmptyData}}</td>
    </tr>
    {{/each}}
</script>

<script id="autoChange_tableSummary" type="text/x-handlebars-template">
    <table class="table table-condensed table-dark-header table-bordered no-margin _tableHeight no-padding no-margin" data-height="19px">
        <colgroup>
            <col width="15%"/><col width="15%"/><col width="15%"/><col width="15%"/><col width="15%"/>
        </colgroup>
        <tr>
            <th colspan="5" style="background-color: #4472c4; color: white;">교환 현황</th>
        </tr>
        <tr style="background-color: #cfd5ea">
            <td>구분</td>
            <td>신청 회원 수</td>
            <td>자동 교환 건</td>
            <td>자동 교환 별</td>
            <td>환전 가치 금액</td>
        </tr>
        <tr style="color: blue;">
            <td>{{{sexIcon 'm'}}}</td>
            <td>{{addComma content.maleCnt}}명</td>
            <td>{{addComma content.maleAutoCnt}}건</td>
            <td>{{addComma content.maleAutoByeol}}별</td>
            <td>{{addComma content.maleExchangeAmt}}원</td>
        </tr>
        <tr style="color: red;">
            <td>{{{sexIcon 'f'}}}</td>
            <td>{{addComma content.femaleCnt}}명</td>
            <td>{{addComma content.femaleAutoCnt}}건</td>
            <td>{{addComma content.femaleAutoByeol}}별</td>
            <td>{{addComma content.femaleExchangeAmt}}원</td>
        </tr>
        <tr>
            <td>{{{sexIcon 'n'}}}</td>
            <td>{{addComma content.noneCnt}}명</td>
            <td>{{addComma content.noneAutoCnt}}건</td>
            <td>{{addComma content.noneAutoByeol}}별</td>
            <td>{{addComma content.noneExchangeAmt}}원</td>
        </tr>
        <tr style="color: black;">
            <td>테스트</td>
            <td>{{addComma content.testCnt}}명</td>
            <td>{{addComma content.testAutoCnt}}건</td>
            <td>{{addComma content.testAutoByeol}}별</td>
            <td>{{addComma content.testExchangeAmt}}원</td>
        </tr>
        <tr class="font-bold" style="color: #ff6600;">
            <th style="background-color: #d9d9d9">총합</th>
            <th style="background-color: #f2f2f2">{{addComma content.totalCnt}}명</th>
            <th style="background-color: #f2f2f2">{{addComma content.totalAutoCnt}}건</th>
            <th style="background-color: #f2f2f2">{{addComma content.totalAutoByeol}}별</th>
            <th style="background-color: #f2f2f2">{{addComma content.totalExchangeAmt}}원</th>
        </tr>
        <tr style="color: black;">
            <td>일평균</td>
            <td>{{content.averageCnt}}명</td>
            <td>{{content.averageAutoCnt}}건</td>
            <td>{{content.averageAutoByeol}}별</td>
            <td>{{content.averageExchangeAmt}}원</td>
        </tr>
    </table>
</script>