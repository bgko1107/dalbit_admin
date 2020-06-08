<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!-- 회원가입 > 총계 -->
<div class="widget widget-table mb10">
    <div class="widget-content mt10">
        <a href="javascript://" class="_prevSearch">[이전]</a>
        <span class="_searchDate"></span>
        <a href="javascript://" class="_nextSearch">[다음]</a>
        <table class="table table-bordered">
            <colgroup>
                <col width="6.2%"/><col width="13.4%"/><col width="13.4%"/><col width="13.4%"/><col width="13.4%"/>
                <col width="13.4%"/><col width="13.4%"/><col width="13.4%"/>
            </colgroup>
            <thead>
            <tr>
                <th>No</th>
                <th>아이템 이미지</th>
                <th>아이템 명</th>
                <th>금액</th>
                <th>판매 량</th>
                <th>판매 달수</th>
                <th>누적 판매량</th>
                <%--<th>누적 판매 달수</th>--%>
            </tr>
            </thead>
            <tbody id="broadTableBody"></tbody>
        </table>
        <div class="dataTables_paginate paging_full_numbers" id="list_info_paginate"></div>
    </div>
    <div class="widget-footer">
        <span>
            <%--<button class="btn btn-default print-btn pull-right" type="button" id="excelDownBtn"><i class="fa fa-print"></i>Excel Down</button>--%>
        </span>
    </div>
</div>

<script type="text/javascript">
    $(function(){
        getBroadList();
    });

    giftHistoryListPagingInfo = new PAGING_INFO(0, 1, 50);

    function getBroadList(){
        $("#searchForm #pageNo").val(giftHistoryListPagingInfo.pageNo);
        $("#searchForm #pageCnt").val(giftHistoryListPagingInfo.pageCnt);
        $("#searchForm #searchType").val(0);
        util.getAjaxData("memberList", "/rest/status/item/broad/list", $("#searchForm").serialize(), fn_broadJoin_success);
    }

    function fn_broadJoin_success(data, response){
        var isDataEmpty = response.data.detailList == null;
        $("#broadTableBody").empty();
        if(!isDataEmpty){
            var template = $('#tmp_broadTotal').html();
            var templateScript = Handlebars.compile(template);
            var totalContext = response.data.totalInfo;
            var totalHtml = templateScript(totalContext);
            $("#broadTableBody").append(totalHtml);

            response.data.detailList.slctType = $('input[name="slctType"]:checked').val()
        }

        var template = $('#tmp_broadDetailList').html();
        var templateScript = Handlebars.compile(template);
        var detailContext = response.data.detailList;
        var html=templateScript(detailContext);
        $("#broadTableBody").append(html);

        if(response.data != ''){
            var pagingInfo = response.data.totalInfo;
            giftHistoryListPagingInfo.totalCnt = pagingInfo.totalCnt;
            util.renderPagingNavigation('list_info_paginate', giftHistoryListPagingInfo);

            detailContext.totalCnt = pagingInfo.totalCnt;
        }

        if(isDataEmpty){
            $("#broadTableBody td:last").remove();
        }else{
            $("#broadTableBody").append(totalHtml);
        }
    }
</script>
<script type="text/x-handlebars-template" id="tmp_broadTotal">
    <tr class="success font-bold">
        <td>소계</td>
        <td></td>
        <td></td>
        <td></td>
        <td>{{addComma sum_itemCnt}}</td>
        <td>{{addComma sum_itemAmt}}</td>
        <td>{{addComma sum_totalItemCnt}}</td>
        <!--<td>{{addComma sum_totalItemAmt}}</td>-->
    </tr>
</script>

<script type="text/x-handlebars-template" id="tmp_broadDetailList">
    {{#each this as |data|}}
    <tr>
        <td class="font-bold">{{rowNum}}</td>
        <td><img src="{{data.item_thumbnail}}" width="50" height="50" /></td>
        <td>{{item_name}}</td>
        <td>{{sale_price}}</td>
        <td>{{addComma itemCnt}}</td>
        <td>{{addComma itemAmt}}</td>
        <td>{{addComma totalItemCnt}}</td>
        <!--<td>{{addComma totalItemAmt}}</td>-->
    </tr>
    {{else}}
    <%--<tr>--%>
    <td colspan="11" class="noData">{{isEmptyData}}<td>
        <%--</tr>--%>
        {{/each}}
</script>