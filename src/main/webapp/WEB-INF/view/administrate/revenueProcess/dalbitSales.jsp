<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="dummyData"><%= java.lang.Math.round(java.lang.Math.random() * 1000000) %></c:set>

<!-- 결제환불 > 총계 -->
<div class="widget widget-table mb10">
    <div class="widget-content mt10" id="divDalbitSales">
        <%--<a href="javascript://" class="_prevSearch">[이전]</a>--%>
        <span class="_searchDate"></span>
        <%--<a href="javascript://" class="_nextSearch">[다음]</a>--%>
        <div class="dataTables_paginate paging_full_numbers" id="dalSales_paginate_top"></div>
        <table class="table table-bordered">
            <colgroup>
                <col width="9%"/><col width="9%"/><col width="9%"/><col width="9%"/><col width="9%"/>
                <col width="9%"/><col width="9%"/><col width="9%"/><col width="9%"/><col width="9%"/>
                <col width="9%"/>
            </colgroup>
            <thead>
            <tr>
                <th rowspan="2" class="_bgColor _fontColor" data-bgcolor="#548235" data-fontcolor="white">유저</th>
                <th rowspan="2" class="_bgColor _fontColor" data-bgcolor="#548235" data-fontcolor="white">유형</th>
                <th rowspan="2" class="_bgColor _fontColor" data-bgcolor="#548235" data-fontcolor="white">DJ</th>
                <th colspan="3" class="_bgColor _fontColor" data-bgcolor="#548235" data-fontcolor="white">달</th>
                <th rowspan="2" class="_bgColor _fontColor" data-bgcolor="#548235" data-fontcolor="white">별</th>
                <th rowspan="2" class="_bgColor _fontColor" data-bgcolor="#548235" data-fontcolor="white">선수금</th>
                <th rowspan="2" class="_bgColor _fontColor" data-bgcolor="#548235" data-fontcolor="white">미지급</th>
                <th rowspan="2" class="_bgColor _fontColor" data-bgcolor="#548235" data-fontcolor="white">매출액</th>
                <th rowspan="2" class="_bgColor _fontColor" data-bgcolor="#548235" data-fontcolor="white">충당부채</th>
            </tr>
            <tr>
                <th class="_bgColor _fontColor" data-bgcolor="#548235" data-fontcolor="white">유료</th>
                <th class="_bgColor _fontColor" data-bgcolor="#548235" data-fontcolor="white">무료</th>
                <th class="_bgColor _fontColor" data-bgcolor="#548235" data-fontcolor="white">합계</th>
            </tr>
            </thead>
            <tbody id="dalbitSalesTableBody"></tbody>
        </table>
        <div class="dataTables_paginate paging_full_numbers" id="dalSales_paginate"></div>
    </div>
</div>
<button class="btn btn-default btn-sm print-btn pull-left excelDownBtn_dalSales" type="button"><i class="fa fa-print"></i>Excel Down</button>
<button class="btn btn-default btn-sm print-btn pull-right excelDownBtn_dalSales" type="button"><i class="fa fa-print"></i>Excel Down</button>

<script type="text/javascript">

    var dalSalesPagingInfo = new PAGING_INFO(0,1,100);

    function getDalbitSalesList(pagingNo){
        if(!common.isEmpty(pagingNo)){
            dalSalesPagingInfo.pageNo = pagingNo;
        }else{
            dalSalesPagingInfo.pageNo = 1;
        }

        var data = {
            slctType : slctType
            ,startDate : $("#startDate").val()
            ,endDate : $("#endDate").val()
            , pageNo : dalSalesPagingInfo.pageNo
            , pageCnt : dalSalesPagingInfo.pageCnt
        };
        util.getAjaxData("dalbitSales", "/rest/enter/pay/dal/sales", data, fn_dalbitSales_success);
    }

    function fn_dalbitSales_success(data, response){
        $("#dalbitSalesTableBody").empty();

        response.data.detailList.slctType = slctType;
        var template = $('#tmp_dalbitSalesDetailList').html();
        var templateScript = Handlebars.compile(template);
        var detailContext = response.data;
        var html=templateScript(detailContext);
        $("#dalbitSalesTableBody").append(html);

        dalSalesPagingInfo.totalCnt = response.data.totalInfo.totalCnt;
        util.renderPagingNavigation('dalSales_paginate_top', dalSalesPagingInfo);
        util.renderPagingNavigation('dalSales_paginate', dalSalesPagingInfo);
        dalSalesPagingInfo.pageNo=1;

        if(response.data.length == 0) {
            $("#dalSales_paginate_top").hide();
            $('#dalSales_paginate').hide();
        } else {
            $("#dalSales_paginate_top").show();
            $('#dalSales_paginate').show();
        }

        ui.tableHeightSet();
        ui.paintColor();
    }

    $('.excelDownBtn_dalSales').on('click', function(){
        var formData = new FormData();
        formData.append("startDate", $("#startDate").val());

        util.excelDownload($(this), "/rest/enter/pay/dal/sales/listExcel", formData,
            function () {
                console.log("fn_success_excel");
            }, function () {
                console.log("fn_fail_excel");
            });
    });

</script>

<script type="text/x-handlebars-template" id="tmp_dalbitSalesDetailList">
    <tr class="_bgColor font-bold" data-bgcolor="#f2f2f2">
        <td>합계</td>
        <td></td>
        <td></td>
        <td>{{addComma totalInfo.payDal}}</td>
        <td>{{addComma totalInfo.freeDal}}</td>
        <td>{{addComma totalInfo.totalDal}}</td>
        <td>{{addComma totalInfo.totalByeol}}</td>
        <td>{{addComma totalInfo.firstAmt}}</td>
        <td>{{addComma totalInfo.unpaidAmt}}</td>
        <td>{{addComma totalInfo.salesAmt}}</td>
        <td>{{addComma totalInfo.freeSalesAmt}}</td>
    </tr>
    {{#each this.detailList as |data|}}
    <tr>
        <td>
            <a href="javascript://" class="_openMemberPop" data-memNo="{{mem_no}}">{{mem_no}}</a><br/>
            {{nickName}} {{{sexIcon memSex}}}({{memAge}})
        </td>
        <td>
            {{#dalbit_if slctType '==' 1}}
                방송
            {{else}}
                {{#dalbit_if slctType '==' 2}}
                    클립
                {{else}}
                    {{#dalbit_if slctType '==' 3}}
                        부스터
                    {{else}}
                        우체통
                    {{/dalbit_if}}
                {{/dalbit_if}}
            {{/dalbit_if}}

        </td>
        <td>
            {{#dalbit_if memType '==' 0}}
                일반
            {{else}}
                스페셜
            {{/dalbit_if}}
        </td>
        <td>{{addComma payDal 'Y'}}</td>
        <td>{{addComma freeDal 'Y'}}</td>
        <td>{{addComma totalDal 'Y'}}</td>
        <td>{{addComma totalByeol 'Y'}}</td>
        <td>{{addComma firstAmt 'Y'}}</td>
        <td>{{addComma unpaidAmt 'Y'}}</td>
        <td>{{addComma salesAmt 'Y'}}</td>
        <td>{{addComma freeSalesAmt 'Y'}}</td>
    </tr>
    {{/each}}
</script>