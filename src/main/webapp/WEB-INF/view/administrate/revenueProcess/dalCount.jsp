<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="dummyData"><%= java.lang.Math.round(java.lang.Math.random() * 1000000) %></c:set>

<!-- 결제환불 > 총계 -->
<div class="widget widget-table mb10">
    <div class="widget-content mt10" id="divDalCount">
        <%--<a href="javascript://" class="_prevSearch">[이전]</a>--%>
        <span class="_searchDate"></span>
        <%--<a href="javascript://" class="_nextSearch">[다음]</a>--%>
        <table class="table table-bordered">
            <colgroup>
                <col width="2.7%"/><col width="2.7%"/><col width="2.7%"/><col width="2.7%"/><col width="2.7%"/>
                <col width="2.7%"/><col width="2.7%"/><col width="2.7%"/><col width="2.7%"/><col width="2.7%"/>
                <col width="2.7%"/><col width="2.7%"/><col width="2.7%"/><col width="2.7%"/><col width="2.7%"/>
                <col width="2.7%"/><col width="2.7%"/><col width="2.7%"/><col width="2.7%"/><col width="2.7%"/>
                <col width="2.7%"/><col width="2.7%"/><col width="2.7%"/><col width="2.7%"/><col width="2.7%"/>
                <col width="2.7%"/><col width="2.7%"/><col width="2.7%"/><col width="2.7%"/><col width="2.7%"/>
                <col width="2.7%"/><col width="2.7%"/><col width="2.7%"/><col width="2.7%"/><col width="2.7%"/>
                <col width="2.7%"/><col width="2.7%"/>
            </colgroup>
            <thead>
            <tr>
                <th rowspan="4" class="_bgColor _fontColor" data-bgcolor="#00b050" data-fontcolor="white">조회일자</th>
                <th colspan="33" class="_bgColor _fontColor" data-bgcolor="#548235" data-fontcolor="white">달빛라이브 [달_수량]</th>
            </tr>
            <tr>
                <th rowspan="2" colspan="2" class="_bgColor _fontColor" data-bgcolor="#548235" data-fontcolor="white">기초</th>
                <th colspan="11" class="_bgColor _fontColor" data-bgcolor="#548235" data-fontcolor="white">증가</th>
                <th colspan="18" class="_bgColor _fontColor" data-bgcolor="#548235" data-fontcolor="white">감소</th>
                <th rowspan="2" colspan="2" class="_bgColor _fontColor" data-bgcolor="#548235" data-fontcolor="white">기말</th>
            </tr>
            <tr>
                <th rowspan="2" class="_bgColor _fontColor" data-bgcolor="#548235" data-fontcolor="white">전체합계</th>
                <th colspan="5" class="_bgColor _fontColor" data-bgcolor="#548235" data-fontcolor="white">유료</th>
                <th colspan="4" class="_bgColor _fontColor" data-bgcolor="#548235" data-fontcolor="white">무료</th>
                <th rowspan="2" class="_bgColor _fontColor" data-bgcolor="#548235" data-fontcolor="white">전체합계</th>
                <th colspan="9" class="_bgColor _fontColor" data-bgcolor="#548235" data-fontcolor="white">유료</th>
                <th colspan="9" class="_bgColor _fontColor" data-bgcolor="#548235" data-fontcolor="white">무료</th>
            </tr>
            <tr>
                <th class="_bgColor _fontColor" data-bgcolor="#7b7b7b" data-fontcolor="white">유료</th>
                <th class="_bgColor _fontColor" data-bgcolor="#7b7b7b" data-fontcolor="white">무료</th>
                <th class="_bgColor _fontColor" data-bgcolor="#7b7b7b" data-fontcolor="white">합계</th>
                <th class="_bgColor _fontColor" data-bgcolor="#7b7b7b" data-fontcolor="white">PG사 결제</th>
                <th class="_bgColor _fontColor" data-bgcolor="#7b7b7b" data-fontcolor="white">달 전환</th>
                <th class="_bgColor _fontColor" data-bgcolor="#7b7b7b" data-fontcolor="white">선물하기</th>
                <th class="_bgColor _fontColor" data-bgcolor="#7b7b7b" data-fontcolor="white">관리자지급</th>
                <th class="_bgColor _fontColor" data-bgcolor="#7b7b7b" data-fontcolor="white">합계</th>
                <th class="_bgColor _fontColor" data-bgcolor="#7b7b7b" data-fontcolor="white">이벤트</th>
                <th class="_bgColor _fontColor" data-bgcolor="#7b7b7b" data-fontcolor="white">선물하기</th>
                <th class="_bgColor _fontColor" data-bgcolor="#7b7b7b" data-fontcolor="white">관리자지급</th>
                <th class="_bgColor _fontColor" data-bgcolor="#7b7b7b" data-fontcolor="white">합계</th>
                <th class="_bgColor _fontColor" data-bgcolor="#7b7b7b" data-fontcolor="white">방송</th>
                <th class="_bgColor _fontColor" data-bgcolor="#7b7b7b" data-fontcolor="white">클립</th>
                <th class="_bgColor _fontColor" data-bgcolor="#7b7b7b" data-fontcolor="white">우체통</th>
                <th class="_bgColor _fontColor" data-bgcolor="#7b7b7b" data-fontcolor="white">선물하기</th>
                <th class="_bgColor _fontColor" data-bgcolor="#7b7b7b" data-fontcolor="white">환불</th>
                <th class="_bgColor _fontColor" data-bgcolor="#7b7b7b" data-fontcolor="white">회원탈퇴</th>
                <th class="_bgColor _fontColor" data-bgcolor="#7b7b7b" data-fontcolor="white">휴면탈퇴</th>
                <th class="_bgColor _fontColor" data-bgcolor="#7b7b7b" data-fontcolor="white">관리자회수</th>
                <th class="_bgColor _fontColor" data-bgcolor="#7b7b7b" data-fontcolor="white">합계</th>
                <th class="_bgColor _fontColor" data-bgcolor="#7b7b7b" data-fontcolor="white">방송</th>
                <th class="_bgColor _fontColor" data-bgcolor="#7b7b7b" data-fontcolor="white">클립</th>
                <th class="_bgColor _fontColor" data-bgcolor="#7b7b7b" data-fontcolor="white">우체통</th>
                <th class="_bgColor _fontColor" data-bgcolor="#7b7b7b" data-fontcolor="white">선물하기</th>
                <th class="_bgColor _fontColor" data-bgcolor="#7b7b7b" data-fontcolor="white">환불</th>
                <th class="_bgColor _fontColor" data-bgcolor="#7b7b7b" data-fontcolor="white">회원탈퇴</th>
                <th class="_bgColor _fontColor" data-bgcolor="#7b7b7b" data-fontcolor="white">휴면탈퇴</th>
                <th class="_bgColor _fontColor" data-bgcolor="#7b7b7b" data-fontcolor="white">관리자회수</th>
                <th class="_bgColor _fontColor" data-bgcolor="#7b7b7b" data-fontcolor="white">유료</th>
                <th class="_bgColor _fontColor" data-bgcolor="#7b7b7b" data-fontcolor="white">무료</th>
            </tr>
            </thead>
            <tbody id="dalCountTableBody"></tbody>
        </table>
    </div>
</div>
<a type='button' class="btn btn-default print-btn pull-left dalCountExcel" download="" href="#" onclick="return ExcellentExport.excel(this, 'divDalCount', 'Sheet1');"><i class="fa fa-print"></i>Excel Down</a>
<a type='button' class="btn btn-default print-btn pull-right dalCountExcel" download="" href="#" onclick="return ExcellentExport.excel(this, 'divDalCount', 'Sheet1');"><i class="fa fa-print"></i>Excel Down</a>

<script type="text/javascript">

    function getDalCountList(){
        $(".dalCountExcel").attr('download' , "달빛Live_수익인식Process(달수)_" + moment($("#startDate").val()).add('days', 0).format('YYYY.MM.DD') + ".xls");

        var data = {
            slctType : slctType
            ,startDate : $("#startDate").val()
            ,endDate : $("#endDate").val()
        };
        util.getAjaxData("dalCount", "/rest/enter/pay/dal/count", data, fn_dalCount_success);
    }

    function fn_dalCount_success(data, response){
        $("#dalCountTableBody").empty();

        response.data.detailList.slctType = slctType;
        var template = $('#tmp_dalCountDetailList').html();
        var templateScript = Handlebars.compile(template);
        var detailContext = response.data.detailList;
        var html=templateScript(detailContext);
        $("#dalCountTableBody").append(html);

        ui.tableHeightSet();
    }
    function dalDateClick(data){
        var popupUrl = "/administrate/revenueProcess/popup/dalAmt?startDate=" + encodeURIComponent(data.thedate);
        util.windowOpen(popupUrl,"1914","968","달 정보 데이터");
    }
</script>

<script type="text/x-handlebars-template" id="tmp_dalCountDetailList">
    {{#each this as |data|}}
    <tr>
        <td class="font-bold">
            {{#dalbit_if ../slctType '==' 1}}
                <a href="javascript://" onclick="dalDateClick($(this).data())" data-thedate="{{the_date}}">{{the_date}}</a>
            {{else}}
                {{the_date}}
            {{/dalbit_if}}
        </td>
        <td>{{addComma oldPayDal 'Y'}}</td>
        <td>{{addComma oldFreeDal 'Y'}}</td>
        <td>{{addComma addTotalDal 'Y'}}</td>
        <td>{{addComma addPayTotal 'Y'}}</td>
        <td>{{addComma addPayPg 'Y'}}</td>
        <td>{{addComma addPayChange 'Y'}}</td>
        <td>{{addComma addPayGift 'Y'}}</td>
        <td>{{addComma addPayOp 'Y'}}</td>
        <td>{{addComma addFreeTotal 'Y'}}</td>
        <td>{{addComma addFreeEvent 'Y'}}</td>
        <td>{{addComma addFreeGift 'Y'}}</td>
        <td>{{addComma addFreeOp 'Y'}}</td>
        <td>{{addComma subTotalDal 'Y'}}</td>
        <td>{{addComma subPayTotal 'Y'}}</td>
        <td>{{addComma subPayBroad 'Y'}}</td>
        <td>{{addComma subPayClip 'Y'}}</td>
        <td>{{addComma subPayMailbox 'Y'}}</td>
        <td>{{addComma subPayGift 'Y'}}</td>
        <td>{{addComma subPayCancel 'Y'}}</td>
        <td>{{addComma subPayWithdrawal 'Y'}}</td>
        <td>{{addComma subPayWithdrawalSleep 'Y'}}</td>
        <td>{{addComma subPayOp 'Y'}}</td>
        <td>{{addComma subFreeTotal 'Y'}}</td>
        <td>{{addComma subFreeBroad 'Y'}}</td>
        <td>{{addComma subFreeClip 'Y'}}</td>
        <td>{{addComma subFreeMailbox 'Y'}}</td>
        <td>{{addComma subFreeGift 'Y'}}</td>
        <td>{{addComma subFreeCancel 'Y'}}</td>
        <td>{{addComma subFreeWithdrawal 'Y'}}</td>
        <td>{{addComma subFreeWithdrawlSleep 'Y'}}</td>
        <td>{{addComma subFreeOp 'Y'}}</td>
        <td>{{addComma newPayDal 'Y'}}</td>
        <td>{{addComma newFreeDal 'Y'}}</td>
    </tr>
    {{/each}}
</script>