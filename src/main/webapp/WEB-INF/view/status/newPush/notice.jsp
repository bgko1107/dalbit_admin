<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!-- 회원가입 > 총계 -->
<div class="widget widget-table mb10">
    <div class="widget-content mt10">
        <table class="table table-bordered _tableHeight" data-height="23px">
            <colgroup>
                <col width="5.5%"/><col width="4.2%"/><col width="4.2%"/><col width="4.2%"/><col width="4.2%"/>
                <col width="4.2%"/><col width="4.2%"/><col width="4.2%"/><col width="4.2%"/><col width="4.2%"/>
                <col width="4.2%"/><col width="4.2%"/><col width="4.2%"/><col width="4.2%"/><col width="4.2%"/>
                <col width="4.2%"/><col width="4.2%"/><col width="4.2%"/><col width="4.2%"/><col width="4.2%"/>
                <col width="4.2%"/><col width="4.2%"/>
            </colgroup>
            <thead>
            <tr>
                <th rowspan="2" class="thisMonth _bgColor _fontColor" data-bgcolor="black" data-fontcolor="white"></th>
                <th rowspan="2" class="_bgColor" data-bgcolor="#d9d9d7">성별</th>
                <th colspan="2" class="_bgColor" data-bgcolor="#b4c7e7">마이스타<br/>방송시작</th>
                <th colspan="2" class="_bgColor" data-bgcolor="#b4c7e7">마이스타<br/>클립 등록</th>
                <th colspan="2" class="_bgColor" data-bgcolor="#b4c7e7">마이스타<br/>방송공지 등록</th>
                <th colspan="2" class="_bgColor" data-bgcolor="#b4c7e7">마이스타<br/>내 클립</th>
                <th colspan="2" class="_bgColor" data-bgcolor="#b4c7e7">신규 팬 추가</th>
                <th colspan="2" class="_bgColor" data-bgcolor="#b4c7e7">팬보드 신규 글 등록</th>
                <th colspan="2" class="_bgColor" data-bgcolor="#b4c7e7">팬보드 댓글 등록</th>
                <th colspan="2" class="_bgColor" data-bgcolor="#b4c7e7">선물 도착</th>
                <th colspan="2" class="_bgColor" data-bgcolor="#b4c7e7">1:1 문의 답변 도착</th>
                <th colspan="2" class="_bgColor" data-bgcolor="#b4c7e7">알림받기<br/>방송시작</th>
            </tr>
            <tr>
                <th class="_bgColor" data-bgcolor="#f3f1f6"><span style="color: #d9450c;">설정(비율)</span><br/>해제(비율)</th>
                <th class="_bgColor" data-bgcolor="#f3f1f6">설정<br/>총계</th>
                <th class="_bgColor" data-bgcolor="#f3f1f6"><span style="color: #d9450c;">설정(비율)</span><br/>해제(비율)</th>
                <th class="_bgColor" data-bgcolor="#f3f1f6">설정<br/>총계</th>
                <th class="_bgColor" data-bgcolor="#f3f1f6"><span style="color: #d9450c;">설정(비율)</span><br/>해제(비율)</th>
                <th class="_bgColor" data-bgcolor="#f3f1f6">설정<br/>총계</th>
                <th class="_bgColor" data-bgcolor="#f3f1f6"><span style="color: #d9450c;">설정(비율)</span><br/>해제(비율)</th>
                <th class="_bgColor" data-bgcolor="#f3f1f6">설정<br/>총계</th>
                <th class="_bgColor" data-bgcolor="#f3f1f6"><span style="color: #d9450c;">설정(비율)</span><br/>해제(비율)</th>
                <th class="_bgColor" data-bgcolor="#f3f1f6">설정<br/>총계</th>
                <th class="_bgColor" data-bgcolor="#f3f1f6"><span style="color: #d9450c;">설정(비율)</span><br/>해제(비율)</th>
                <th class="_bgColor" data-bgcolor="#f3f1f6">설정<br/>총계</th>
                <th class="_bgColor" data-bgcolor="#f3f1f6"><span style="color: #d9450c;">설정(비율)</span><br/>해제(비율)</th>
                <th class="_bgColor" data-bgcolor="#f3f1f6">설정<br/>총계</th>
                <th class="_bgColor" data-bgcolor="#f3f1f6"><span style="color: #d9450c;">설정(비율)</span><br/>해제(비율)</th>
                <th class="_bgColor" data-bgcolor="#f3f1f6">설정<br/>총계</th>
                <th class="_bgColor" data-bgcolor="#f3f1f6"><span style="color: #d9450c;">설정(비율)</span><br/>해제(비율)</th>
                <th class="_bgColor" data-bgcolor="#f3f1f6">설정<br/>총계</th>
                <th class="_bgColor" data-bgcolor="#f3f1f6"><span style="color: #d9450c;">설정(비율)</span><br/>해제(비율)</th>
                <th class="_bgColor" data-bgcolor="#f3f1f6">설정<br/>총계</th>
            </tr>
            </thead>
            <tbody id="tableNoticeBody"></tbody>
        </table>
    </div>
    <div class="widget-footer">
        <span>
            <%--<button class="btn btn-default print-btn pull-right" type="button" id="excelDownBtn"><i class="fa fa-print"></i>Excel Down</button>--%>
        </span>
    </div>
</div>

<script type="text/javascript">
    $(function(){
    });

    function getNotice(){
        $(".thisMonth").text(moment($("#startDate").val()).add('months', 0).format('YYYY년 MM월'));

        var data = {
            startDate : $("#startDate").val()
            ,endDate : $("#endDate").val()
            ,slctType : 4
        };

        util.getAjaxData("notice", "/rest/status/push/newNotice", data, fn_notice_success);
    }

    function fn_notice_success(data, response){
        dalbitLog(response);
        $("#tableNoticeBody").empty();

        response.data.detailList.nowMonth = Number(moment().format("MM"));
        response.data.detailList.nowDay = Number(moment().format("DD"));
        response.data.detailList.nowHour = Number(moment().format("HH"));
        for(var i=0;i<response.data.detailList.length;i++){
            console.log(response.data.detailList[i].the_date.substr(8,2));
            response.data.detailList[i].day = response.data.detailList[i].the_date.substr(8,2);

            toDay = week[moment(response.data.detailList[i].the_date.replace(/-/gi, ".")).add('days', 0).day()];

            if (toDay == "토") {
                toDay = '<span class="_fontColor" data-fontColor="blue" style="color:blue">' + response.data.detailList[i].the_date + "<br/>(" + toDay + ")" + '</span>';
            } else if (toDay == "일") {
                toDay = '<span class="_fontColor" data-fontColor="red" style="color:red">' + response.data.detailList[i].the_date + "<br/>(" + toDay + ")" + '</span>';
            } else {
                toDay = response.data.detailList[i].the_date+ "<br/>(" + toDay + ")";
            }
            response.data.detailList[i].date = toDay;
        }


        var template = $('#tmp_noticeDetail').html();
        var templateScript = Handlebars.compile(template);
        var detailContext = response.data.detailList;
        var html=templateScript(detailContext);
        $("#tableNoticeBody").append(html);

        ui.tableHeightSet();

        monthRowspan("day");
        // totalRowspan("total");
    }
</script>
<script type="text/x-handlebars-template" id="tmp_noticeDetail">
    {{#each this as |data|}}
    <tr {{#dalbit_if ../nowDay '==' day}} class="font-bold _stateSubTh" {{/dalbit_if}} >
        <td class="day" {{#dalbit_if ../nowDay '!=' day}} style="background-color: #f2f2f2" {{/dalbit_if}}>{{{data.date}}}</td>
        <td>{{{sexIcon data.gender}}}</td>
        <td><span style="color: {{#dalbit_if data.gender '==' 'm'}} blue {{/dalbit_if}}{{#dalbit_if data.gender '==' 'f'}} red {{/dalbit_if}};"><span class="font-bold">{{addComma data.Set_1y}}</span> ({{data.rateSet_1y}})</span><br/>{{addComma data.Set_1n}} ({{data.rateSet_1n}})</td>
        {{#dalbit_if data.gender '==' 'm'}} <td rowspan="3" class="font-bold"><span style="color: #d9450c">{{addComma data.sumSet_1y}}</span><br/>{{addComma data.sumSet_1yn}} </td> {{/dalbit_if}}
        <td><span style="color: {{#dalbit_if data.gender '==' 'm'}} blue {{/dalbit_if}}{{#dalbit_if data.gender '==' 'f'}} red {{/dalbit_if}};"><span class="font-bold">{{addComma data.Set_2y}}</span> ({{data.rateSet_2y}})</span><br/>{{addComma data.Set_2n}} ({{data.rateSet_2n}})</td>
        {{#dalbit_if data.gender '==' 'm'}} <td rowspan="3" class="font-bold"><span style="color: #d9450c">{{addComma data.sumSet_2y}}</span><br/>{{addComma data.sumSet_2yn}} </td> {{/dalbit_if}}
        <td><span style="color: {{#dalbit_if data.gender '==' 'm'}} blue {{/dalbit_if}}{{#dalbit_if data.gender '==' 'f'}} red {{/dalbit_if}};"><span class="font-bold">{{addComma data.Set_3y}}</span> ({{data.rateSet_3y}})</span><br/>{{addComma data.Set_3n}} ({{data.rateSet_3n}})</td>
        {{#dalbit_if data.gender '==' 'm'}} <td rowspan="3" class="font-bold"><span style="color: #d9450c">{{addComma data.sumSet_3y}}</span><br/>{{addComma data.sumSet_3yn}} </td> {{/dalbit_if}}
        <td><span style="color: {{#dalbit_if data.gender '==' 'm'}} blue {{/dalbit_if}}{{#dalbit_if data.gender '==' 'f'}} red {{/dalbit_if}};"><span class="font-bold">{{addComma data.Set_4y}}</span> ({{data.rateSet_4y}})</span><br/>{{addComma data.Set_4n}} ({{data.rateSet_4n}})</td>
        {{#dalbit_if data.gender '==' 'm'}} <td rowspan="3" class="font-bold"><span style="color: #d9450c">{{addComma data.sumSet_4y}}</span><br/>{{addComma data.sumSet_4yn}} </td> {{/dalbit_if}}
        <td><span style="color: {{#dalbit_if data.gender '==' 'm'}} blue {{/dalbit_if}}{{#dalbit_if data.gender '==' 'f'}} red {{/dalbit_if}};"><span class="font-bold">{{addComma data.Set_5y}}</span> ({{data.rateSet_5y}})</span><br/>{{addComma data.Set_5n}} ({{data.rateSet_5n}})</td>
        {{#dalbit_if data.gender '==' 'm'}} <td rowspan="3" class="font-bold"><span style="color: #d9450c">{{addComma data.sumSet_5y}}</span><br/>{{addComma data.sumSet_5yn}} </td> {{/dalbit_if}}
        <td><span style="color: {{#dalbit_if data.gender '==' 'm'}} blue {{/dalbit_if}}{{#dalbit_if data.gender '==' 'f'}} red {{/dalbit_if}};"><span class="font-bold">{{addComma data.Set_6y}}</span> ({{data.rateSet_6y}})</span><br/>{{addComma data.Set_6n}} ({{data.rateSet_6n}})</td>
        {{#dalbit_if data.gender '==' 'm'}} <td rowspan="3" class="font-bold"><span style="color: #d9450c">{{addComma data.sumSet_6y}}</span><br/>{{addComma data.sumSet_6yn}} </td> {{/dalbit_if}}
        <td><span style="color: {{#dalbit_if data.gender '==' 'm'}} blue {{/dalbit_if}}{{#dalbit_if data.gender '==' 'f'}} red {{/dalbit_if}};"><span class="font-bold">{{addComma data.Set_7y}}</span> ({{data.rateSet_7y}})</span><br/>{{addComma data.Set_7n}} ({{data.rateSet_7n}})</td>
        {{#dalbit_if data.gender '==' 'm'}} <td rowspan="3" class="font-bold"><span style="color: #d9450c">{{addComma data.sumSet_7y}}</span><br/>{{addComma data.sumSet_7yn}} </td> {{/dalbit_if}}
        <td><span style="color: {{#dalbit_if data.gender '==' 'm'}} blue {{/dalbit_if}}{{#dalbit_if data.gender '==' 'f'}} red {{/dalbit_if}};"><span class="font-bold">{{addComma data.Set_8y}}</span> ({{data.rateSet_8y}})</span><br/>{{addComma data.Set_8n}} ({{data.rateSet_8n}})</td>
        {{#dalbit_if data.gender '==' 'm'}} <td rowspan="3" class="font-bold"><span style="color: #d9450c">{{addComma data.sumSet_8y}}</span><br/>{{addComma data.sumSet_8yn}} </td> {{/dalbit_if}}
        <td><span style="color: {{#dalbit_if data.gender '==' 'm'}} blue {{/dalbit_if}}{{#dalbit_if data.gender '==' 'f'}} red {{/dalbit_if}};"><span class="font-bold">{{addComma data.Set_9y}}</span> ({{data.rateSet_9y}})</span><br/>{{addComma data.Set_9n}} ({{data.rateSet_9n}})</td>
        {{#dalbit_if data.gender '==' 'm'}} <td rowspan="3" class="font-bold"><span style="color: #d9450c">{{addComma data.sumSet_9y}}</span><br/>{{addComma data.sumSet_9yn}} </td> {{/dalbit_if}}

        <%--<td><span style="color: {{#dalbit_if data.gender '==' 'm'}} blue {{/dalbit_if}}{{#dalbit_if data.gender '==' 'f'}} red {{/dalbit_if}};"><span class="font-bold">{{addComma data.Set_10y}}</span> ({{data.rateSet_10y}})</span><br/>{{addComma data.Set_10n}} ({{data.rateSet_10n}})</td>--%>
        <%--{{#dalbit_if data.gender '==' 'm'}} <td rowspan="3" class="font-bold"><span style="color: #d9450c">{{addComma data.sumSet_10y}}</span><br/>{{addComma data.sumSet_10yn}} </td> {{/dalbit_if}}--%>

        <td><span style="color: {{#dalbit_if data.gender '==' 'm'}} blue {{/dalbit_if}}{{#dalbit_if data.gender '==' 'f'}} red {{/dalbit_if}};"><span class="font-bold">{{addComma data.Set_11y}}</span> ({{data.rateSet_11y}})</span><br/>{{addComma data.Set_11n}} ({{data.rateSet_11n}})</td>
        {{#dalbit_if data.gender '==' 'm'}} <td rowspan="3" class="font-bold"><span style="color: #d9450c">{{addComma data.sumSet_11y}}</span><br/>{{addComma data.sumSet_11yn}} </td> {{/dalbit_if}}
    </tr>
    {{/each}}
</script>