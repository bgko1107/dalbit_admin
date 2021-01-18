<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="dummyData"><%= java.lang.Math.round(java.lang.Math.random() * 1000000) %></c:set>

<!-- 결제환불 > 총계 -->
<div class="widget widget-table mb10">
    <div class="widget-content mt10" id="divByeolAmt">
        <%--<a href="javascript://" class="_prevSearch">[이전]</a>--%>
        <span class="_searchDate"></span>
        <%--<a href="javascript://" class="_nextSearch">[다음]</a>--%>
        <div class="dataTables_paginate paging_full_numbers" id="byeolAmt_paginate_top"></div>
        <table class="table table-bordered">
            <colgroup>
                <col width="9%"/><col width="6%"/><col width="6%"/><col width="6%"/><col width="6%"/>
                <col width="6%"/><col width="6%"/><col width="6%"/><col width="6%"/><col width="6%"/>
                <col width="6%"/><col width="6%"/><col width="6%"/><col width="6%"/><col width="6%"/>
            </colgroup>
            <thead>
            <tr>
                <th rowspan="3" class="_bgColor _fontColor" data-bgcolor="#00b050" data-fontcolor="white">회원정보</th>
                <th colspan="14" class="_bgColor _fontColor" data-bgcolor="#548235" data-fontcolor="white">달빛라이브 [별_금액]</th>
            </tr>
            <tr>
                <th rowspan="2" class="_bgColor _fontColor" data-bgcolor="#548235" data-fontcolor="white">기초</th>
                <th colspan="6" class="_bgColor _fontColor" data-bgcolor="#548235" data-fontcolor="white">증가</th>
                <th colspan="6" class="_bgColor _fontColor" data-bgcolor="#548235" data-fontcolor="white">감소</th>
                <th rowspan="2" class="_bgColor _fontColor" data-bgcolor="#548235" data-fontcolor="white">기말</th>
            </tr>
            <tr>
                <th class="_bgColor _fontColor" data-bgcolor="#7b7b7b" data-fontcolor="white">합계</th>
                <th class="_bgColor _fontColor" data-bgcolor="#7b7b7b" data-fontcolor="white">방송</th>
                <th class="_bgColor _fontColor" data-bgcolor="#7b7b7b" data-fontcolor="white">이벤트</th>
                <th class="_bgColor _fontColor" data-bgcolor="#7b7b7b" data-fontcolor="white">클립</th>
                <th class="_bgColor _fontColor" data-bgcolor="#7b7b7b" data-fontcolor="white">우체통</th>
                <th class="_bgColor _fontColor" data-bgcolor="#7b7b7b" data-fontcolor="white">관리자지급</th>
                <th class="_bgColor _fontColor" data-bgcolor="#7b7b7b" data-fontcolor="white">합계</th>
                <th class="_bgColor _fontColor" data-bgcolor="#7b7b7b" data-fontcolor="white">환전</th>
                <th class="_bgColor _fontColor" data-bgcolor="#7b7b7b" data-fontcolor="white">달로 변환</th>
                <th class="_bgColor _fontColor" data-bgcolor="#7b7b7b" data-fontcolor="white">회원탈퇴</th>
                <th class="_bgColor _fontColor" data-bgcolor="#7b7b7b" data-fontcolor="white">휴면탈퇴</th>
                <th class="_bgColor _fontColor" data-bgcolor="#7b7b7b" data-fontcolor="white">관리자회수</th>
            </tr>
            </thead>
            <tbody id="byeolAmtTableBody"></tbody>
        </table>
            <div class="dataTables_paginate paging_full_numbers" id="byeolAmt_paginate"></div>
    </div>
</div>
<button class="btn btn-default btn-sm print-btn pull-left excelDownBtn" type="button"><i class="fa fa-print"></i>Excel Down</button>
<button class="btn btn-default btn-sm print-btn pull-right excelDownBtn" type="button"><i class="fa fa-print"></i>Excel Down</button>

<script type="text/javascript">
    var byeolAmtPagingInfo = new PAGING_INFO(0,1,100);

    $(document).ready(function (){
        getByeolAmtList();
    });

    function getByeolAmtList(pagingNo){
        if(!common.isEmpty(pagingNo)){
            byeolAmtPagingInfo.pageNo = pagingNo;
        }else{
            byeolAmtPagingInfo.pageNo = 1;
        }
        var data = {
            startDate : '${param.startDate}'
            , 'pageNo' : byeolAmtPagingInfo.pageNo
            , 'pageCnt' : byeolAmtPagingInfo.pageCnt
        };
        util.getAjaxData("byeolAmt", "/rest/enter/pay/byeol/amt", data, fn_byeolAmt_success);
    }

    function fn_byeolAmt_success(data, response){
        $("#byeolAmtTableBody").empty();

        var template = $('#tmp_byeolAmtDetailList').html();
        var templateScript = Handlebars.compile(template);
        var detailContext = response.data;
        var html=templateScript(detailContext);
        $("#byeolAmtTableBody").append(html);

        byeolAmtPagingInfo.totalCnt = response.data.totalInfo.totalCnt;
        util.renderPagingNavigation('byeolAmt_paginate_top', byeolAmtPagingInfo);
        util.renderPagingNavigation('byeolAmt_paginate', byeolAmtPagingInfo);
        byeolAmtPagingInfo.pageNo=1;

        if(response.data.length == 0) {
            $("#byeolAmt_paginate_top").hide();
            $('#byeolAmt_paginate').hide();
        } else {
            $("#byeolAmt_paginate_top").show();
            $('#byeolAmt_paginate').show();
        }
        ui.paintColor();
        ui.tableHeightSet();
    }

    function handlebarsPaging(targetId, pagingInfo) {
        if(targetId == "byeolAmt_paginate_top" || targetId == "byeolAmt_paginate") {
            byeolAmtPagingInfo = pagingInfo;
            getByeolAmtList(pagingInfo.pageNo);
        }
    }

    $('.excelDownBtn').on('click', function(){

        var formData = new FormData();
        formData.append("startDate", '${param.startDate}');

        util.excelDownload($(this), "/rest/enter/pay/byeol/amtListExcel", formData,
           function () {
            console.log("fn_success_excel");
        }, function () {
            console.log("fn_fail_excel");
        })
    });

</script>

<script type="text/x-handlebars-template" id="tmp_byeolAmtDetailList">
    <tr class="_bgColor font-bold" data-bgcolor="#f2f2f2">
        <td>합계</td>
        <td>{{addComma totalInfo.oldByeol}}</td>
        <td>{{addComma totalInfo.addTotal}}</td>
        <td>{{addComma totalInfo.addEvent}}</td>
        <td>{{addComma totalInfo.addBroad}}</td>
        <td>{{addComma totalInfo.addClip}}</td>
        <td>{{addComma totalInfo.addMailbox}}</td>
        <td>{{addComma totalInfo.addOp}}</td>
        <td>{{addComma totalInfo.subTotal}}</td>
        <td>{{addComma totalInfo.subExchange}}</td>
        <td>{{addComma totalInfo.subChange}}</td>
        <td>{{addComma totalInfo.subWithdrawal}}</td>
        <td>{{addComma totalInfo.subWithdrawalSleep}}</td>
        <td>{{addComma totalInfo.subOp}}</td>
        <td>{{addComma totalInfo.newByeol}}</td>
    </tr>
    {{#each this.detailList as |data|}}
    <tr>
        <td>
            <a href="javascript://" class="_openMemberPop" data-memNo="{{mem_no}}">{{mem_no}}</a><br/>
            {{nickName}} {{{sexIcon memSex}}}
        </td>
        <td>{{addComma oldByeol 'Y'}}</td>
        <td>{{addComma addTotal 'Y'}}</td>
        <td>{{addComma addEvent 'Y'}}</td>
        <td>{{addComma addBroad 'Y'}}</td>
        <td>{{addComma addClip 'Y'}}</td>
        <td>{{addComma addMailbox 'Y'}}</td>
        <td>{{addComma addOp 'Y'}}</td>
        <td>{{addComma subTotal 'Y'}}</td>
        <td>{{addComma subExchange 'Y'}}</td>
        <td>{{addComma subChange 'Y'}}</td>
        <td>{{addComma subWithdrawal 'Y'}}</td>
        <td>{{addComma subWithdrawalSleep 'Y'}}</td>
        <td>{{addComma subOp 'Y'}}</td>
        <td>{{addComma newByeol 'Y'}}</td>
    </tr>
    {{/each}}
</script>