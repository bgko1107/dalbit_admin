<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="dummyData"><%= java.lang.Math.round(java.lang.Math.random() * 1000000) %></c:set>

<!-- 결제환불 > 총계 -->
<div class="widget widget-table mb10">
    <div class="widget-content mt10" id="divWithdrawalByeol">
        <%--<a href="javascript://" class="_prevSearch">[이전]</a>--%>
        <span class="_searchDate"></span>
        <%--<a href="javascript://" class="_nextSearch">[다음]</a>--%>
        <div class="dataTables_paginate paging_full_numbers" id="withdrawalByeol_paginate_top"></div>
        <table class="table table-bordered">
            <colgroup>
                <col width="20%"/><col width="20%"/><col width="20%"/><col width="20%"/><col width="20%"/>
            </colgroup>
            <thead>
            <tr>
                <th rowspan="2" class="_bgColor _fontColor" data-bgcolor="#00b050" data-fontcolor="white">회원정보</th>
                <th colspan="2" class="_bgColor _fontColor" data-bgcolor="#548235" data-fontcolor="white">별</th>
            </tr>
            <tr>
                <th class="_bgColor _fontColor" data-bgcolor="#548235" data-fontcolor="white">수량</th>
                <th class="_bgColor _fontColor" data-bgcolor="#548235" data-fontcolor="white">금액</th>
            </tr>
            </thead>
            <tbody id="withdrawalByeolTableBody"></tbody>
        </table>
        <div class="dataTables_paginate paging_full_numbers" id="withdrawalByeol_paginate"></div>
    </div>
</div>
<button class="btn btn-default btn-sm print-btn pull-left excelDownBtn_withdrawalByeol" type="button"><i class="fa fa-print"></i>Excel Down</button>
<button class="btn btn-default btn-sm print-btn pull-right excelDownBtn_withdrawalByeol" type="button"><i class="fa fa-print"></i>Excel Down</button>

<script type="text/javascript">
    var withdrawalByeolPagingInfo = new PAGING_INFO(0,1,100);

    function getWithdrawalByeolList(pagingNo){
        if(!common.isEmpty(pagingNo)){
            withdrawalByeolPagingInfo.pageNo = pagingNo;
        }else{
            withdrawalByeolPagingInfo.pageNo = 1;
        }
        var data = {
            startDate : $("#startDate").val()
            ,endDate : $("#endDate").val()
            , 'pageNo' : withdrawalByeolPagingInfo.pageNo
            , 'pageCnt' : withdrawalByeolPagingInfo.pageCnt
        };
        util.getAjaxData("withdrawalByeol", "/rest/enter/pay/withdrawal/byeol", data, fn_withdrawalByeol_success);
    }

    function fn_withdrawalByeol_success(data, response){
        $("#withdrawalByeolTableBody").empty();

        var template = $('#tmp_withdrawalByeolDetailList').html();
        var templateScript = Handlebars.compile(template);
        var detailContext = response.data;
        var html=templateScript(detailContext);
        $("#withdrawalByeolTableBody").append(html);

        if(response.data.length == 0) {
            $("#withdrawalByeol_paginate_top").hide();
            $('#withdrawalByeol_paginate').hide();
        } else {
            withdrawalByeolPagingInfo.totalCnt = response.data.totalInfo.totalCnt;
            util.renderPagingNavigation('withdrawalByeol_paginate_top', withdrawalByeolPagingInfo);
            util.renderPagingNavigation('withdrawalByeol_paginate', withdrawalByeolPagingInfo);
            withdrawalByeolPagingInfo.pageNo=1;

            $("#withdrawalByeol_paginate_top").show();
            $('#withdrawalByeol_paginate').show();
        }
        ui.paintColor();
        ui.tableHeightSet();
    }

    $('.excelDownBtn_withdrawalByeol').on('click', function(){

        var formData = new FormData();
        formData.append("startDate", $("#startDate").val());

        util.excelDownload($(this), "/rest/enter/pay/withdrawal/byeol/listExcel", formData,
            function () {
                console.log("fn_success_excel");
            }, function () {
                console.log("fn_fail_excel");
            })
    });

</script>

<script type="text/x-handlebars-template" id="tmp_withdrawalByeolDetailList">
    <tr class="_bgColor font-bold" data-bgcolor="#f2f2f2">
        <td>합계</td>
        <td>{{addComma totalInfo.byeol}}</td>
        <td>{{addComma totalInfo.byeolAmt}}</td>
    </tr>
    {{#each this.detailList as |data|}}
    <tr>
        <td>
            <a href="javascript://" class="_openMemberPop" data-memNo="{{mem_no}}">{{mem_no}}</a><br/>
            {{nickName}} {{{sexIcon memSex}}}
        </td>
        <td>{{addComma byeol 'Y'}}</td>
        <td>{{addComma byeolAmt 'Y'}}</td>
    </tr>
    {{else}}
    <tr>
        <td colspan="2" class="noData">{{isEmptyData}}<td>
    </tr>
    {{/each}}
</script>