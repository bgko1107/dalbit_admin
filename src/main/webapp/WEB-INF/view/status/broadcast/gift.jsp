<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!-- 방송 > 선물 -->
<div class="widget widget-table mb10">
    <div class="widget-content mt10">
        <span class="_searchDate"></span>
        <table class="table table-bordered">
            <colgroup>
                <col width="14.8%"/><col width="14.2%"/><col width="14.2%"/><col width="14.2%"/><col width="14.2%"/>
                <col width="14.2%"/><col width="14.2%"/>
            </colgroup>
            <thead>
            <tr>
                <th></th>
                <th>총 선물 건수</th>
                <th>총 선물 달수</th>
                <th>일반선물 건수</th>
                <th>일반선물 달수</th>
                <th>비밀선물 건수</th>
                <th>비밀선물 달수</th>
            </tr>
            </thead>
            <tbody  id="giftListBody">
            </tbody>
        </table>
    </div>
    <div class="widget-footer">
        <span>
            <%--<button class="btn btn-default print-btn pull-right" type="button" id="excelDownBtn"><i class="fa fa-print"></i>Excel Down</button>--%>
        </span>
    </div>
</div>

<script type="text/javascript">

    function broadcastGift(){
        util.getAjaxData("broadcastGift", "/rest/status/broadcast/broadcastGift/list", $("#searchForm").serialize(), fn_broadcastGift_success);
    }

    function fn_broadcastGift_success(dst_id, response) {
        var isDataEmpty = response.data.detailList == null;
        $("#giftListBody").empty();
        if(!isDataEmpty){
            var template = $('#tmp_giftTotal').html();
            var templateScript = Handlebars.compile(template);
            var totalContext = response.data.totalInfo;
            var totalHtml = templateScript(totalContext);
            $("#giftListBody").append(totalHtml);

            response.data.detailList.slctType = $('input:radio[name="slctType"]:checked').val();
        }

        var template = $('#tmp_giftDetailList').html();
        var templateScript = Handlebars.compile(template);
        var detailContext = response.data.detailList;
        var html=templateScript(detailContext);
        $("#giftListBody").append(html);

        if(isDataEmpty){
            $("#giftListBody td:last").remove();
        }else{
            $("#giftListBody").append(totalHtml);
        }
    }
</script>

<script type="text/x-handlebars-template" id="tmp_giftTotal">
    <tr class="success font-bold">
        <td>소계</td>
        <td>{{addComma sum_totalGiftCnt}}</td>
        <td>{{addComma sum_totalGiftAmount}}</td>
        <td>{{addComma sum_normalGiftCnt}}</td>
        <td>{{addComma sum_normalGiftAmount}}</td>
        <td>{{addComma sum_secretGiftCnt}}</td>
        <td>{{addComma sum_secretGiftAmount}}</td>
    </tr>
</script>

<script type="text/x-handlebars-template" id="tmp_giftDetailList">
    {{#each this as |data|}}
    <tr>
        <td class="font-bold">
            {{#equal ../slctType 0}}{{data.hour}}시{{/equal}}
            {{#equal ../slctType 1}}{{data.daily}}{{/equal}}
            {{#equal ../slctType 2}}{{data.monthly}}월{{/equal}}
        </td>
        <td>{{addComma totalGiftCnt}}</td>
        <td>{{addComma totalGiftAmount}}</td>
        <td>{{addComma normalGiftCnt}}</td>
        <td>{{addComma normalGiftAmount}}</td>
        <td>{{addComma secretGiftCnt}}</td>
        <td>{{addComma secretGiftAmount}}</td>
    </tr>
    {{else}}
    <tr>
        <td colspan="22" class="noData">{{isEmptyData}}<td>
    </tr>
    {{/each}}
</script>