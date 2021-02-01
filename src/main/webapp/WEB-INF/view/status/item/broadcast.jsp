<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!-- 회원가입 > 총계 -->
<div class="widget widget-table mb10">
    <div class="widget-content mt10">
        <span class="_searchDate2"></span>
        <select name="itemType_broad" class="form-control" onchange="itemTypeChange();">
            <option value="0" selected="selected">전체</option>
            <option value="1">일반</option>
            <option value="2">콤보</option>
            <option value="3">감정</option>
        </select>
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
                <th>아이템 달</th>
                <th>아이템 판매 수</th>
                <th>아이템 판매 달</th>
                <th>아이템 누적 판매량</th>
                <%--<th>누적 판매 달수</th>--%>
            </tr>
            </thead>
            <tbody id="broadTableBody"></tbody>
        </table>
        <div class="dataTables_paginate paging_full_numbers" id="list_broadcast_paginate"></div>
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

    giftBroadcastListPagingInfo = new PAGING_INFO(0, 1, 50);

    function getBroadList(){

        $("#searchForm #pageNo").val(giftBroadcastListPagingInfo.pageNo);
        $("#searchForm #pageCnt").val(giftBroadcastListPagingInfo.pageCnt);

        var data = {};
        data.slctType = $('input[name="slctType2"]:checked').val();
        data.startDate = $("#startDate").val();
        data.endDate = $("#endDate").val();
        data.pageNo = giftBroadcastListPagingInfo.pageNo;
        data.pageCnt = giftBroadcastListPagingInfo.pageCnt;
        data.itemType = $('select[name=itemType_broad]').val();
        util.getAjaxData("memberList", "/rest/status/item/broad/list", data, fn_broadJoin_success);
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
            giftBroadcastListPagingInfo.totalCnt = pagingInfo.totalCnt;
            util.renderPagingNavigation('list_broadcast_paginate', giftBroadcastListPagingInfo);

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
        <td><img class="_webpImage" src="{{data.item_thumbnail}}" width="50" height="50" data-webpImage="{{webp_image}}"/></td>
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