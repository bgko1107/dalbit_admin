<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!-- 회원가입 > 총계 -->
<div class="widget widget-table mb10 col-md-7 no-padding">
    <div class="widget-content mt10">
        <span>
            · 알림 수신설정 회원들에 대한 현황입니다.<br/>
            · 알림 데이터 집계는 매일 00시에 집계되어 적용됩니다.
        </span>
        <table class="table table-bordered _tableHeight" data-height="23px">
            <colgroup>
                <col width="25%"/><col width="25%"/><col width="25%"/><col width="25%"/>
            </colgroup>
            <thead>
            <tr>
                <th colspan="4" class="thisYear _bgColor" data-bgcolor="#ffe699"></th>
            </tr>
            <tr>
                <th class="thisYear _bgColor _fontColor" data-bgcolor="black" data-fontcolor="white"></th>
                <th class="_bgColor" data-bgcolor="#fff2cc">소리<br/>(<span style="color:blue">남성</span>/<span style="color:red">여성</span>/<span>알수없음</span>)</th>
                <th class="_bgColor" data-bgcolor="#fff2cc">진동<br/>(<span style="color:blue">남성</span>/<span style="color:red">여성</span>/<span>알수없음</span>)</th>
                <th class="_bgColor" data-bgcolor="#fff2cc">무음<br/>(<span style="color:blue">남성</span>/<span style="color:red">여성</span>/<span>알수없음</span>)</th>
            </tr>
            </thead>
            <tbody id="tableYearBody"></tbody>
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

    function getYear(){
        $(".thisYear").text(moment($("#startDate").val()).add('months', 0).format('YYYY'));

        var data = {
            startDate : $("#startDate").val()
            ,endDate : $("#endDate").val()
            ,slctType : 3
        };

        util.getAjaxData("year", "/rest/status/push/year", data, fn_year_success);
    }

    function fn_year_success(data, response){

        var isDataEmpty = response.data.detailList == null;
        $("#tableYearBody").empty();
        if(!isDataEmpty){
            var template = $('#tmp_year').html();
            var templateScript = Handlebars.compile(template);
            var totalContext = response.data.totalInfo;
            var totalHtml = templateScript(totalContext);
            $("#tableYearBody").append(totalHtml);

            response.data.detailList.slctType = slctType;
        }

        response.data.detailList.nowMonth = Number(moment().format("MM"));
        response.data.detailList.nowDay = Number(moment().format("DD"));
        response.data.detailList.nowHour = Number(moment().format("HH"));

        for(var i=0;i<response.data.detailList.length;i++){
            console.log(response.data.detailList[i].the_date.substr(8,2));
            response.data.detailList[i].day = response.data.detailList[i].the_date.substr(8,2);
            response.data.detailList[i].month = response.data.detailList[i].the_date.substr(5,2);

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

        var template = $('#tmp_yearDetail').html();
        var templateScript = Handlebars.compile(template);
        var detailContext = response.data.detailList;
        var html=templateScript(detailContext);
        $("#tableYearBody").append(html);

        if(isDataEmpty){
            $("#tableYearBody td:last").remove();
        }
        ui.tableHeightSet();
    }
</script>

<script type="text/x-handlebars-template" id="tmp_year">
    <tr class="font-bold" style="background-color: #f2f2f2">
        <td style="background-color: #d9d9d9">총합</td>
        <td>{{addComma totalAlim_s}}<br/>(<span style="color:blue">{{addComma maleAlim_s}}</span> / <span style="color:red">{{addComma femaleAlim_s}}</span> / {{addComma noneAlim_s}})</td>
        <td>{{addComma totalAlim_v}}<br/>(<span style="color:blue">{{addComma maleAlim_v}}</span> / <span style="color:red">{{addComma femaleAlim_v}}</span> / {{addComma noneAlim_v}})</td>
        <td>{{addComma totalAlim_n}}<br/>(<span style="color:blue">{{addComma maleAlim_n}}</span> / <span style="color:red">{{addComma femaleAlim_n}}</span> / {{addComma noneAlim_n}})</td>
    </tr>
</script>

<script type="text/x-handlebars-template" id="tmp_yearDetail">
    {{#each this as |data|}}
    <tr {{#dalbit_if ../nowMonth '==' data.month}} class="font-bold _stateSubTh" {{/dalbit_if}} >
    <td {{#dalbit_if ../nowMonth '!=' data.month}} style="background-color: #f2f2f2" {{/dalbit_if}}>{{data.the_date}}</td>
    <td>{{#dalbit_if data.total_alim_s '!=' 0}} {{addComma data.total_alim_s}}<br/>(<span style="color:blue">{{addComma data.male_alim_s}}</span> / <span style="color:red">{{addComma data.female_alim_s}}</span> / {{addComma data.none_alim_s}}) {{/dalbit_if}}</td>
    <td>{{#dalbit_if data.total_alim_v '!=' 0}} {{addComma data.total_alim_v}}<br/>(<span style="color:blue">{{addComma data.male_alim_v}}</span> / <span style="color:red">{{addComma data.female_alim_v}}</span> / {{addComma data.none_alim_v}}) {{/dalbit_if}}</td>
    <td>{{#dalbit_if data.total_alim_n '!=' 0}} {{addComma data.total_alim_n}}<br/>(<span style="color:blue">{{addComma data.male_alim_n}}</span> / <span style="color:red">{{addComma data.female_alim_n}}</span> / {{addComma data.none_alim_n}}) {{/dalbit_if}}</td>
    </tr>
    {{/each}}
</script>
