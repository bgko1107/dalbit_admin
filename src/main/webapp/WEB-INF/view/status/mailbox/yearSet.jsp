<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!-- 회원가입 > 총계 -->
<div class="widget widget-table mb10">
    <div class="widget-content mt10">
        <table class="table table-sorting table-hover table-bordered">
            <colgroup>
                <col width="20%"><col width="20%"><col width="20%"><col width="20%"><col width="20%">
            </colgroup>
            <thead>
                <th style="background-color: #d9d9d9">구분</th>
                <th style="background-color: #d9d9d9">성별</th>
                <th style="background-color: #c6d9f1">설정 ON(비율)</th>
                <th style="background-color: #c6d9f1">해제 OFF(비율)</th>
                <th style="background-color: #d9d9d9">설정<br/>총계</th>
            </thead>
            <tbody id="yearSetTableBody">
            </tbody>
        </table>
    </div>
</div>

<script type="text/javascript">

    function getYearSet(){
        var data = {
            slctType : slctType
            ,startDate : $("#startDate").val()
            ,endDate : $("#endDate").val()
        };
        util.getAjaxData("yearSet", "/rest/status/mailbox/month/set", data, fn_yearSet_success);

    }

    function fn_yearSet_success(dst_id, response){
        for(var i=0;i<response.data.detailList.length;i++){
            response.data.detailList[i].nowMonth = Number(moment().format("MM"));
            response.data.detailList[i].nowDay = common.lpad(Number(moment().format("DD"),2,"0"));
            response.data.detailList[i].nowHour = Number(moment().format("HH"));
            response.data.detailList[i].month = response.data.detailList[i].the_date.substr(5,6);
        }

        var isDataEmpty = response.data.detailList == null;
        $("#yearSetTableBody").empty();
        if(!isDataEmpty){
            var template = $('#tmp_yearSetTotal').html();
            var templateScript = Handlebars.compile(template);
            var totalContext = response.data.totalInfo;
            var totalHtml = templateScript(totalContext);
            $("#yearSetTableBody").append(totalHtml);
            response.data.detailList.slctType = slctType;
        }
        var template = $('#tmp_yearSet').html();
        var templateScript = Handlebars.compile(template);
        var detailContext = response.data.detailList;
        var html=templateScript(detailContext);
        $("#yearSetTableBody").append(html);
        if(isDataEmpty){
            $("#yearSetTableBody td:last").remove();
        }else{
            $("#yearSetTableBody").append(totalHtml);
        }
        ui.paintColor();
    }

</script>

<script type="text/x-handlebars-template" id="tmp_yearSetTotal">
    <tr class="font-bold" style="background-color: #f2f2f2">
        <td rowspan="3">총합</td>
        <td class="_fontColor" data-fontcolor="blue">{{{sexIcon 'm'}}}</td>
        <td class="_fontColor" data-fontcolor="blue">{{addComma sum_male_mailbox_y}} {{#dalbit_if sum_male_mailbox_y '!=' 0}}({{average sum_male_mailbox_y sum_total_mailbox_y}}%){{/dalbit_if}}</td>
        <td class="_fontColor" data-fontcolor="blue">{{addComma sum_male_mailbox_n}} {{#dalbit_if sum_male_mailbox_n '!=' 0}}({{average sum_male_mailbox_n sum_total_mailbox_n}}%){{/dalbit_if}}</td>
        <td rowspan="3"><span style="color:#af7032">{{addComma sum_total_mailbox_y}}</span><br/>{{addComma sum_total_mailbox_n}}</td>
    </tr>
    <tr class="font-bold"style="background-color: #f2f2f2">
        <td class="_fontColor" data-fontcolor="red">{{{sexIcon 'f'}}}</td>
        <td class="_fontColor" data-fontcolor="red">{{addComma sum_female_mailbox_y}} {{#dalbit_if sum_female_mailbox_y '!=' 0}}({{average sum_female_mailbox_y sum_total_mailbox_y}}%){{/dalbit_if}}</td>
        <td class="_fontColor" data-fontcolor="red">{{addComma sum_female_mailbox_n}} {{#dalbit_if sum_female_mailbox_n '!=' 0}}({{average sum_female_mailbox_n sum_total_mailbox_n}}%){{/dalbit_if}}</td>
    </tr>
    <tr class="font-bold"style="background-color: #f2f2f2">
        <td>{{{sexIcon 'n'}}}</td>
        <td>{{addComma sum_none_mailbox_y}} {{#dalbit_if sum_none_mailbox_y '!=' 0}}({{average sum_none_mailbox_y sum_total_mailbox_y}}%){{/dalbit_if}}</td>
        <td>{{addComma sum_none_mailbox_n}} {{#dalbit_if sum_none_mailbox_n '!=' 0}}({{average sum_none_mailbox_n sum_total_mailbox_n}}%){{/dalbit_if}}</td>
    </tr>
</script>

<script type="text/x-handlebars-template" id="tmp_yearSet">
    {{#each this as |data|}}
    <tr {{#dalbit_if nowMonth '==' month}} class="font-bold _bgColor" data-bgColor="#fff2cc"  {{/dalbit_if}}>
        <td rowspan="3">{{the_date}}</td>
        <td class="_fontColor" data-fontcolor="blue">{{{sexIcon 'm'}}}</td>
        <td class="_fontColor" data-fontcolor="blue">{{addComma male_mailbox_y 'Y'}} {{#dalbit_if male_mailbox_y '!=' 0}}({{average male_mailbox_y total_mailbox_y}}%){{/dalbit_if}}</td>
        <td class="_fontColor" data-fontcolor="blue">{{addComma male_mailbox_n 'Y'}} {{#dalbit_if male_mailbox_n '!=' 0}}({{average male_mailbox_n total_mailbox_n}}%){{/dalbit_if}}</td>
        <td rowspan="3"><span style="color:#af7032">{{addComma total_mailbox_y}}</span><br>{{addComma total_mailbox_n}}</td>
    </tr>
    <tr {{#dalbit_if nowMonth '==' month}} class="font-bold _bgColor" data-bgColor="#fff2cc"  {{/dalbit_if}}>
        <td class="_fontColor" data-fontcolor="red">{{{sexIcon 'f'}}}</td>
        <td class="_fontColor" data-fontcolor="red">{{addComma female_mailbox_y 'Y'}} {{#dalbit_if female_mailbox_y '!=' 0}}({{average female_mailbox_y total_mailbox_y}}%){{/dalbit_if}}</td>
        <td class="_fontColor" data-fontcolor="red">{{addComma female_mailbox_n 'Y'}} {{#dalbit_if female_mailbox_n '!=' 0}}({{average female_mailbox_n total_mailbox_n}}%){{/dalbit_if}}</td>
    </tr>
    <tr {{#dalbit_if nowMonth '==' month}} class="font-bold _bgColor" data-bgColor="#fff2cc"  {{/dalbit_if}}>
        <td>{{{sexIcon 'n'}}}</td>
        <td>{{addComma none_mailbox_y 'Y'}} {{#dalbit_if none_mailbox_y '!=' 0}}({{average none_mailbox_y total_mailbox_y}}%){{/dalbit_if}}</td>
        <td>{{addComma none_mailbox_n 'Y'}} {{#dalbit_if none_mailbox_n '!=' 0}}({{average none_mailbox_n total_mailbox_n}}%){{/dalbit_if}}</td>
    </tr>
    {{else}}
        <td colspan="11" class="noData">{{isEmptyData}}<td>
    {{/each}}
</script>

