<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div class="col-md-12" style="padding-right: 0px;">
    <div class="row col-lg-12 pl0 pr0 no-padding">
        <div class="col-lg-12 no-padding">
            <div class="col-lg-3 no-padding">
                <table class="table table-bordered _tableHeight no-padding" data-height="19px" style="display:none;">
                    <tr>
                        <th class="_bgColor" data-bgcolor="#dae3f3">달 자동교환 설정상태</th>
                        <td>
                            <select id="changeAutoSetting" name="changeAutoSetting" class="form-control searchType" style="width: 100%">
                                <option value="0">OFF</option>
                                <option class="font-bold" style="color: #7030a0;" value="1">ON</option>
                            </select>
                        </td>
                        <td><button class="btn btn-default btn-sm" id="bt_changeAutoSetting" onclick="bt_changeAutoSetting_click();" style="width: 100%">설정완료</button></td>
                    </tr>
                </table>
            </div>
            <div class="col-lg-5 pull-right no-padding">
                <span id="change_summaryArea"></span>
            </div>
            <br/>
            <br/>
            <br/>
            <div class="col-md-4 no-padding">
                <div class="col-md-3 no-padding mr10">
                    <span id="changeList_searchType" onchange="changeList_searchType_click();"></span>
                </div>
                <div class="col-md-3 no-padding" style="display: none;">
                        <span>
                            <select id="changeAutoSettingFilter" name="changeAutoSettingFilter" class="form-control searchType" style="width: 100%" onchange="changeAutoSetting_change();">
                                <option value="0">자동설정 전체</option>
                                <option class="font-bold" style="color: #7030a0;" value="1">ON</option>
                                <option value="2">OFF</option>
                            </select>
                        </span>
                </div>
            </div>

            <%--<span id="changeList_searchType" onchange="changeList_searchType_click();"></span>--%>
            <%--<div class="col-md-3 no-padding">--%>
                <%--<span>--%>
                    <%--<select id="changeAutoSettingFilter" name="changeAutoSettingFilter" class="form-control searchType" style="width: 100%" onchange="changeAutoSetting_change();">--%>
                        <%--<option value="0">자동설정 전체</option>--%>
                        <%--<option class="font-bold" style="color: #7030a0;" value="1">ON</option>--%>
                    <%--</select>--%>
                <%--</span>--%>
            <%--</div>--%>
        </div>
    </div>
    <div class="row col-lg-12 mt15 no-padding">
        <div class="dataTables_paginate paging_full_numbers" id="list_info_paginate_top"></div>
        <table id="list_info" class="table table-sorting table-hover table-bordered">
            <thead id="tableTop">
            <tr>
                <th>No</th>
                <%--<th>자동설정</th>--%>
                <th>교환일시</th>
                <th>회원번호</th>
                <th>닉네임</th>
                <th>성별</th>
                <th>등급</th>
                <th>레벨</th>
                <th>교환 횟 수</th>
                <th>교환 전 별 수</th>
                <th>교환 전 달 수</th>
                <th>교환 별 수</th>
                <th>교환 달 수</th>
                <th>교환 후 별 수</th>
                <th>교환 후 달 수</th>
            </tr>
            </thead>
            <tbody id="tableBody"></tbody>
        </table>
        <div class="dataTables_paginate paging_full_numbers" id="list_info_paginate"></div>
    </div>
</div>
<script>
    var itemPagingInfo = new PAGING_INFO(0,1,50);
    var orderType = 0;

    $(document).ready(function() {
        $("#changeList_searchType").html(util.getCommonCodeSelect(-1, changeList_searchType));
    });

    function getHistory_changeDetail() {     // 상세보기
        getList();
    }

    function getParameter(){

        return data = {
            searchText : memNo
            , searchType : ""
            , innerType : 0
            , orderType : orderType
            , pageNo : itemPagingInfo.pageNo
            , pageCnt : itemPagingInfo.pageCnt
            , autoType : $("#changeAutoSettingFilter").val()
            , startDate : "2020-01-01"
            , endDate : "2999-12-31"
        };
    }

    function getList(){
        util.getAjaxData("select", "/rest/money/item/list", getParameter(), fn_succ_list);
    }

    function fn_succ_list(dst_id, response) {

        var template = $('#tmp_changeItemList').html();
        var templateScript = Handlebars.compile(template);
        var context = response.data;
        var html = templateScript(context);
        $("#tableBody").html(html);
        itemPagingInfo.totalCnt = response.data.totalInfo.totalCnt;

        if(response.data.detailList.length > 0){
            util.renderPagingNavigation("list_info_paginate_top", itemPagingInfo);
            util.renderPagingNavigation("list_info_paginate", itemPagingInfo);
        }

        $("#changeAutoSetting").val(response.data.setting.auto_change);

        change_summary(response);
    }

    function change_summary(json){
        console.log(json.data);

        var template = $("#change_tableSummary").html();
        var templateScript = Handlebars.compile(template);
        var data = {
            content : json.data.totalInfo
            , length : json.data.totalInfo
        };
        var html = templateScript(data);
        $("#change_summaryArea").html(html);
        ui.tableHeightSet();
    }

    function handlebarsPaging(targetId, pagingInfo){
        itemPagingInfo = pagingInfo;
        getList();
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
        console.log(response);
    }

    function changeList_searchType_click(){
        itemPagingInfo.pageNo = 1;
        orderType = $("select[name='changeList']").val();
        getList();
    }

    function bt_changeAutoSetting_click(){
        var sw = false;
        if($("#changeAutoSetting").val() == "1"){
            if(confirm("자동교환을 설정(ON) 하시겠습니까?")){
                sw = true;
            }else{
                return false;
            }
        }
        if($("#changeAutoSetting").val() == "0"){
            if(confirm("자동교환을 해제(OFF) 하시겠습니까?")){
                sw = true;
            }else{
                return false;
            }
        }
        if(sw){
            var data = {
                mem_no : memNo
                ,auto_change: $("#changeAutoSetting").val()
            };
            console.log(data);
            util.getAjaxData("select", "/rest/member/member/setChangeAutoSetting", data, getList);
        }
    }

    function changeAutoSetting_change(){
        itemPagingInfo.pageNo = 1;
        orderType = $("select[name='changeList']").val();
        getList();
    }

</script>


<script type="text/x-handlebars-template" id="tmp_changeItemList">
    {{#each this.detailList as |data|}}
    <tr {{#dalbit_if data.inner '==' 1}} style="background-color : #dae3f3" {{/dalbit_if}}>
        <td>
            {{indexDesc ../totalInfo/totalCnt data.rowNum}}
        </td>
        <%--<td>--%>
            <%--{{#dalbit_if auto '==' 1}}--%>
                <%--<span class="font-bold" style="color: #7030a0;">ON</span>--%>
            <%--{{else}}--%>
                <%--OFF--%>
            <%--{{/dalbit_if}}--%>
        <%--</td>--%>
        <td>
            {{data.last_upd_date}}
        </td>
        <td><a href="javascript://" class="_openMemberPop" data-memno="{{data.mem_no}}">{{data.mem_no}}</a></td>
        <td>{{data.mem_nick}}</td>
        <td>{{{sexIcon data.mem_sex data.mem_birth_year}}}</td>
        <td>{{addComma data.mem_grade}}</td>
        <td>{{addComma data.mem_level}}</td>
        <td>{{addComma data.changeCnt}}번</td>
        <td>{{addComma data.gold_old}}별</td>
        <td>{{addComma data.ruby_old}}달</td>
        <td>{{addComma data.gold}}별</td>
        <td>{{addComma data.ruby}}달</td>
        <td>{{addComma data.gold_new}}별</td>
        <td>{{addComma data.ruby_new}}달</td>
    </tr>

    {{else}}
    <tr>
        <td colspan="20">{{isEmptyData}}</td>
    </tr>
    {{/each}}
</script>

<script id="change_tableSummary" type="text/x-handlebars-template">
    <table class="table table-condensed table-dark-header table-bordered no-margin _tableHeight no-padding no-margin" data-height="19px">
        <colgroup>
            <col width="20%"/><col width="20%"/><col width="20%"/><col width="20%"/><col width="20%"/>
        </colgroup>
        <tr>
            <th colspan="5" style="background-color: #4472c4; color: white;">교환 현황</th>
        </tr>
        <tr style="background-color: #cfd5ea">
            <td>구분</td>
            <%--<td>건 수(자동교환)</td>--%>
            <td>건 수</td>
            <td>별 수</td>
            <td>교환 달 수</td>
            <td>환전 가치 금액</td>
        </tr>
        <tr class="font-bold" style="color: #ff6600;">
            <th style="background-color: #d9d9d9">총합</th>
            <%--<th style="background-color: #f2f2f2">{{addComma content.totalCnt}}({{addComma content.auto_changeCnt}})건</th>--%>
            <th style="background-color: #f2f2f2">{{addComma content.totalCnt}}건</th>
            <th style="background-color: #f2f2f2">{{addComma content.totalByeolCnt}}별</th>
            <th style="background-color: #f2f2f2">{{addComma content.totalDalCnt}}달</th>
            <th style="background-color: #f2f2f2">{{addComma content.totalExchangeAmt}}원</th>
        </tr>
    </table>
</script>