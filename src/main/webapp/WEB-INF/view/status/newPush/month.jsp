<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!-- 회원가입 > 총계 -->
<div class="widget widget-table mb10">
    <div class="widget-content mt10">
        <table class="table table-bordered _tableHeight" data-height="23px">
            <colgroup>
                <col width="12.5%"/><col width="12.5%"/><col width="12.5%"/><col width="12.5%"/><col width="12.5%"/>
                <col width="12.5%"/><col width="12.5%"/><col width="12.5%"/>
            </colgroup>
            <thead>
            <tr>
                <th colspan="4" class="beforMonth _bgColor" data-bgcolor="#b4c7e7"></th>
                <th colspan="4" class="thisMonth _bgColor" data-bgcolor="#ffe699"></th>
            </tr>
            <tr>
                <th class="beforMonth _bgColor _fontColor" data-bgcolor="black" data-fontcolor="white"></th>
                <th class="_bgColor" data-bgcolor="#dae3f3">소리<br/>(<span style="color:blue">남성</span>/<span style="color:red">여성</span>/<span>알수없음</span>)</th>
                <th class="_bgColor" data-bgcolor="#dae3f3">진동<br/>(<span style="color:blue">남성</span>/<span style="color:red">여성</span>/<span>알수없음</span>)</th>
                <th class="_bgColor" data-bgcolor="#dae3f3">무음<br/>(<span style="color:blue">남성</span>/<span style="color:red">여성</span>/<span>알수없음</span>)</th>
                <th class="thisMonth _bgColor _fontColor" data-bgcolor="black" data-fontcolor="white"></th>
                <th class="_bgColor" data-bgcolor="#fff2cc">소리<br/>(<span style="color:blue">남성</span>/<span style="color:red">여성</span>/<span>알수없음</span>)</th>
                <th class="_bgColor" data-bgcolor="#fff2cc">진동<br/>(<span style="color:blue">남성</span>/<span style="color:red">여성</span>/<span>알수없음</span>)</th>
                <th class="_bgColor" data-bgcolor="#fff2cc">무음<br/>(<span style="color:blue">남성</span>/<span style="color:red">여성</span>/<span>알수없음</span>)</th>
            </tr>
            </thead>
            <tbody id="tableMonthBody"></tbody>
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

    function getMonth(){

        $(".beforMonth").text(moment($("#startDate").val()).add('months', -1).format('YYYY.MM'));
        $(".thisMonth").text(moment($("#startDate").val()).add('months', 0).format('YYYY.MM'));

        var data = {
            startDate : moment($("#startDate").val()).add('months', 0).format('YYYY.MM.01')
            ,endDate : moment($("#startDate").val()).add('months', 1).add('days', -1).format('YYYY.MM.DD')
            ,beforStartDate : moment($("#startDate").val()).add('months', -1).format('YYYY.MM.01')
            ,beforEndDate : moment($("#startDate").val()).add('months', 0).add('days', -1).format('YYYY.MM.DD')
            ,slctType : 2
        };

        console.log(data);
        util.getAjaxData("month", "/rest/status/push/month", data, fn_month_success);
    }

    function fn_month_success(data, response){

        var isDataEmpty = response.data.detailList == null;
        $("#tableMonthBody").empty();
        if(!isDataEmpty){
            var template = $('#tmp_month').html();
            var templateScript = Handlebars.compile(template);
            var totalContext = response.data.totalInfo;
            var totalHtml = templateScript(totalContext);
            $("#tableMonthBody").append(totalHtml);

            response.data.detailList.slctType = slctType;
        }

        response.data.detailList.nowMonth = Number(moment().format("MM"));
        response.data.detailList.nowDay = Number(moment().format("DD"));
        response.data.detailList.nowHour = Number(moment().format("HH"));

        for(var i=0;i<response.data.detailList.length;i++){
            response.data.detailList[i].day = response.data.detailList[i].the_date.substr(8,2);

            toDay = week[moment(response.data.detailList[i].the_date.replace(/-/gi, ".")).add('days', 0).day()];
            if (toDay == "토") {
                toDay = '<span class="_fontColor" data-fontColor="blue" style="color:blue">' + response.data.detailList[i].the_date + " (" + toDay + ")" + '</span>';
            } else if (toDay == "일") {
                toDay = '<span class="_fontColor" data-fontColor="red" style="color:red">' + response.data.detailList[i].the_date + " (" + toDay + ")" + '</span>';
            } else {
                toDay = response.data.detailList[i].the_date+ " (" + toDay + ")";
            }
            response.data.detailList[i].date = toDay;


            var btoDay = week[moment(response.data.detailList[i].bthe_date.replace(/-/gi, ".")).add('days', 0).day()];
            if (btoDay == "토") {
                btoDay = '<span class="_fontColor" data-fontColor="blue" style="color:blue">' + response.data.detailList[i].bthe_date + " (" + btoDay + ")" + '</span>';
            } else if (btoDay == "일") {
                btoDay = '<span class="_fontColor" data-fontColor="red" style="color:red">' + response.data.detailList[i].bthe_date + " (" + btoDay + ")" + '</span>';
            } else {
                btoDay = response.data.detailList[i].bthe_date+ " (" + btoDay + ")";
            }
            response.data.detailList[i].bdate = btoDay;
        }

        var template = $('#tmp_monthDetail').html();
        var templateScript = Handlebars.compile(template);
        var detailContext = response.data.detailList;
        var html=templateScript(detailContext);
        $("#tableMonthBody").append(html);

        if(isDataEmpty){
            $("#tableMonthBody td:last").remove();
        }
        ui.tableHeightSet();
    }
</script>

<script type="text/x-handlebars-template" id="tmp_month">
    <tr class="font-bold" style="background-color: #f2f2f2">
        <td style="background-color: #d9d9d9">총합</td>
        <td>{{addComma btotalAlim_s}}<br/>(<span style="color:blue">{{addComma bmaleAlim_s}}</span> / <span style="color:red">{{addComma bfemaleAlim_s}}</span> / {{addComma bnoneAlim_s}})</td>
        <td>{{addComma btotalAlim_v}}<br/>(<span style="color:blue">{{addComma bmaleAlim_v}}</span> / <span style="color:red">{{addComma bfemaleAlim_v}}</span> / {{addComma bnoneAlim_v}})</td>
        <td>{{addComma btotalAlim_n}}<br/>(<span style="color:blue">{{addComma bmaleAlim_n}}</span> / <span style="color:red">{{addComma bfemaleAlim_n}}</span> / {{addComma bnoneAlim_n}})</td>
        <td style="background-color: #d9d9d9">총합</td>
        <td>{{addComma totalAlim_s}}<br/>(<span style="color:blue">{{addComma maleAlim_s}}</span> / <span style="color:red">{{addComma femaleAlim_s}}</span> / {{addComma noneAlim_s}})</td>
        <td>{{addComma totalAlim_v}}<br/>(<span style="color:blue">{{addComma maleAlim_v}}</span> / <span style="color:red">{{addComma femaleAlim_v}}</span> / {{addComma noneAlim_v}})</td>
        <td>{{addComma totalAlim_n}}<br/>(<span style="color:blue">{{addComma maleAlim_n}}</span> / <span style="color:red">{{addComma femaleAlim_n}}</span> / {{addComma noneAlim_n}})</td>
    </tr>
</script>

<script type="text/x-handlebars-template" id="tmp_monthDetail">
    {{#each this as |data|}}
    <tr {{#dalbit_if ../nowDay '==' day}} class="font-bold _stateSubTh" {{/dalbit_if}} >
        <td {{#dalbit_if ../nowDay '!=' day}} style="background-color: #f2f2f2" {{/dalbit_if}}>{{{data.bdate}}}</td>
        <td>{{#dalbit_if data.btotal_alim_s '!=' 0}} {{addComma data.btotal_alim_s}}<br/>(<span style="color:blue">{{addComma data.bmale_alim_s}}</span> / <span style="color:red">{{addComma data.bfemale_alim_s}}</span> / {{addComma data.bnone_alim_s}}) {{/dalbit_if}}</td>
        <td>{{#dalbit_if data.btotal_alim_s '!=' 0}} {{addComma data.btotal_alim_v}}<br/>(<span style="color:blue">{{addComma data.bmale_alim_v}}</span> / <span style="color:red">{{addComma data.bfemale_alim_v}}</span> / {{addComma data.bnone_alim_v}}) {{/dalbit_if}}</td>
        <td>{{#dalbit_if data.btotal_alim_s '!=' 0}} {{addComma data.btotal_alim_n}}<br/>(<span style="color:blue">{{addComma data.bmale_alim_n}}</span> / <span style="color:red">{{addComma data.bfemale_alim_n}}</span> / {{addComma data.bnone_alim_n}}) {{/dalbit_if}}</td>
    <td {{#dalbit_if ../nowDay '!=' day}} style="background-color: #f2f2f2" {{/dalbit_if}}>{{{data.date}}}</td>
        <td>{{#dalbit_if data.total_alim_s '!=' 0}} {{addComma data.total_alim_s}}<br/>(<span style="color:blue">{{addComma data.male_alim_s}}</span> / <span style="color:red">{{addComma data.female_alim_s}}</span> / {{addComma data.none_alim_s}}) {{/dalbit_if}}</td>
        <td>{{#dalbit_if data.total_alim_v '!=' 0}} {{addComma data.total_alim_v}}<br/>(<span style="color:blue">{{addComma data.male_alim_v}}</span> / <span style="color:red">{{addComma data.female_alim_v}}</span> / {{addComma data.none_alim_v}}) {{/dalbit_if}}</td>
        <td>{{#dalbit_if data.total_alim_n '!=' 0}} {{addComma data.total_alim_n}}<br/>(<span style="color:blue">{{addComma data.male_alim_n}}</span> / <span style="color:red">{{addComma data.female_alim_n}}</span> / {{addComma data.none_alim_n}}) {{/dalbit_if}}</td>
    </tr>
    {{/each}}
</script>
