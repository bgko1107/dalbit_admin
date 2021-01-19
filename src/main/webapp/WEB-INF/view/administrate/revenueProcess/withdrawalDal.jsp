<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="dummyData"><%= java.lang.Math.round(java.lang.Math.random() * 1000000) %></c:set>

<!-- 결제환불 > 총계 -->
<div class="widget widget-table mb10">
    <div class="widget-content mt10" id="divWithdrawalDal">
        <%--<a href="javascript://" class="_prevSearch">[이전]</a>--%>
        <span class="_searchDate"></span>
        <%--<a href="javascript://" class="_nextSearch">[다음]</a>--%>
        <div class="dataTables_paginate paging_full_numbers" id="withdrawalDal_paginate_top"></div>
        <table class="table table-bordered">
            <colgroup>
                <col width="20%"/><col width="20%"/><col width="20%"/><col width="20%"/><col width="20%"/>
            </colgroup>
            <thead>
            <tr>
                <th rowspan="2" class="_bgColor _fontColor" data-bgcolor="#00b050" data-fontcolor="white">회원정보</th>
                <th colspan="3" class="_bgColor _fontColor" data-bgcolor="#548235" data-fontcolor="white">달[수량]</th>
                <th rowspan="2" class="_bgColor _fontColor" data-bgcolor="#00b050" data-fontcolor="white">달<br/>[금액]</th>
            </tr>
            <tr>
                <th class="_bgColor _fontColor" data-bgcolor="#548235" data-fontcolor="white">유료</th>
                <th class="_bgColor _fontColor" data-bgcolor="#548235" data-fontcolor="white">무료</th>
                <th class="_bgColor _fontColor" data-bgcolor="#548235" data-fontcolor="white">합계</th>
            </tr>
            </thead>
            <tbody id="withdrawalDalTableBody"></tbody>
        </table>
        <div class="dataTables_paginate paging_full_numbers" id="withdrawalDal_paginate"></div>
    </div>
</div>
<button class="btn btn-default btn-sm print-btn pull-left excelDownBtn_withdrawalDal" type="button"><i class="fa fa-print"></i>Excel Down</button>
<button class="btn btn-default btn-sm print-btn pull-right excelDownBtn_withdrawalDal" type="button"><i class="fa fa-print"></i>Excel Down</button>

<script type="text/javascript">
    var withdrawalDalPagingInfo = new PAGING_INFO(0,1,100);

    function getWithdrawalDalList(pagingNo){
        if(!common.isEmpty(pagingNo)){
            withdrawalDalPagingInfo.pageNo = pagingNo;
        }else{
            withdrawalDalPagingInfo.pageNo = 1;
        }
        var data = {
            startDate : $("#startDate").val()
            ,endDate : $("#endDate").val()
            , 'pageNo' : withdrawalDalPagingInfo.pageNo
            , 'pageCnt' : withdrawalDalPagingInfo.pageCnt
        };
        util.getAjaxData("withdrawalDal", "/rest/enter/pay/withdrawal/dal", data, fn_withdrawalDal_success);
    }

    function fn_withdrawalDal_success(data, response){
        $("#withdrawalDalTableBody").empty();

        var template = $('#tmp_withdrawalDalDetailList').html();
        var templateScript = Handlebars.compile(template);
        var detailContext = response.data;
        var html=templateScript(detailContext);
        $("#withdrawalDalTableBody").append(html);


        if(response.data.length == 0) {
            $("#withdrawalDal_paginate_top").hide();
            $('#withdrawalDal_paginate').hide();
        } else {
            withdrawalDalPagingInfo.totalCnt = response.data.totalInfo.totalCnt;
            util.renderPagingNavigation('withdrawalDal_paginate_top', withdrawalDalPagingInfo);
            util.renderPagingNavigation('withdrawalDal_paginate', withdrawalDalPagingInfo);
            withdrawalDalPagingInfo.pageNo=1;

            $("#withdrawalDal_paginate_top").show();
            $('#withdrawalDal_paginate').show();
        }
        ui.paintColor();
        ui.tableHeightSet();
    }

    $('.excelDownBtn_withdrawalDal').on('click', function(){

        var formData = new FormData();
        formData.append("startDate", $("#startDate").val());

        util.excelDownload($(this), "/rest/enter/pay/withdrawal/dal/listExcel", formData,
            function () {
                console.log("fn_success_excel");
            }, function () {
                console.log("fn_fail_excel");
            })
    });

</script>

<script type="text/x-handlebars-template" id="tmp_withdrawalDalDetailList">
    <tr class="_bgColor font-bold" data-bgcolor="#f2f2f2">
        <td>합계</td>
        <td>{{addComma totalInfo.payDal}}</td>
        <td>{{addComma totalInfo.freeDal}}</td>
        <td>{{addComma totalInfo.totalDal}}</td>
        <td>{{addComma totalInfo.dalAmt}}</td>
    </tr>
    {{#each this.detailList as |data|}}
    <tr>
        <td>
            <a href="javascript://" class="_openMemberPop" data-memNo="{{mem_no}}">{{mem_no}}</a><br/>
            {{nickName}} {{{sexIcon memSex}}}
        </td>
        <td>{{addComma payDal 'Y'}}</td>
        <td>{{addComma freeDal 'Y'}}</td>
        <td>{{addComma totalDal 'Y'}}</td>
        <td>{{addComma dalAmt 'Y'}}</td>
    </tr>
    {{else}}
    <tr>
        <td colspan="4" class="noData">{{isEmptyData}}<td>
    </tr>
    {{/each}}
</script>