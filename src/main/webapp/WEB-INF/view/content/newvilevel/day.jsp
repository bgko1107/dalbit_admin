<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div class="col-md-12 no-padding">
    <table class="table table-sorting table-bordered datatable">
        <colgroup>
        </colgroup>
        <thead>
        <tr>
            <th rowspan="2" class="_bgColor" data-bgcolor="#c6d9f1"></th>
            <th rowspan="2" class="_bgColor" data-bgcolor="#c6d9f1">레벨구분</th>
            <th colspan="3" class="_bgColor _sex_male" data-bgcolor="#c6d9f1"></th>
            <th colspan="3" class="_bgColor _sex_female" data-bgcolor="#c6d9f1"></th>
            <th colspan="3" class="_bgColor" data-bgcolor="#c6d9f1"> 소계</th>
        </tr>
        <tr>
            <th class="_bgColor" data-bgcolor="#c6d9f1">인원</th>
            <th class="_bgColor" data-bgcolor="#c6d9f1">지급달</th>
            <th class="_bgColor" data-bgcolor="#c6d9f1">결제금액</th>
            <th class="_bgColor" data-bgcolor="#c6d9f1">인원</th>
            <th class="_bgColor" data-bgcolor="#c6d9f1">지급달</th>
            <th class="_bgColor" data-bgcolor="#c6d9f1">결제금액</th>
            <th class="_bgColor" data-bgcolor="#c6d9f1">인원</th>
            <th class="_bgColor" data-bgcolor="#c6d9f1">지급달</th>
            <th class="_bgColor" data-bgcolor="#c6d9f1">결제금액</th>
        </tr>
        </thead>
        <tbody id="dayTableBody"></tbody>
    </table>
</div>

<script type="text/javascript">

    function getDayList(){
        var slctType_date = [];
        for(i = Number(moment($("#startDate").val()).add('months', 1).add('days', -1).format('DD')); 0 < i; i-- ){
            slctType_date.push($("#monthDate").val().replace(".","-") + "-" + common.lpad(i,2,"0"));
        }
        var tmp_data = {
            slctType_date : slctType_date
        };

        var template = $('#tmp_dayTableBody').html();
        var templateScript = Handlebars.compile(template);
        var context = tmp_data;
        var html=templateScript(context);
        $("#dayTableBody").html(html);
        dayRowspan("day");
        ui.paintColor();

        var data = {
            startDate : $("#startDate").val()
        };
        util.getAjaxData("day", "/rest/content/newvilevel/day", data, fn_getDay_success);
    }

    function fn_getDay_success(data, response){

        if(common.isEmpty(response.data.list)){
            $("#dayTableBody").html('<td colspan="10" class="noData">'+response.message+'<td>')
            return false;
        }
        for(var i=0;i<response.data.list.length;i++){
            $("#dayTableBody tr._tr_" + response.data.list[i].theDate + "_" + response.data.list[i].eventType + " td:eq(" + 1 + ")").html(common.addComma(response.data.list[i].maleCnt));
            $("#dayTableBody tr._tr_" + response.data.list[i].theDate + "_" + response.data.list[i].eventType + " td:eq(" + 2 + ")").html(common.addComma(response.data.list[i].maleDal));
            $("#dayTableBody tr._tr_" + response.data.list[i].theDate + "_" + response.data.list[i].eventType + " td:eq(" + 3 + ")").html(common.addComma(response.data.list[i].malePay));
            $("#dayTableBody tr._tr_" + response.data.list[i].theDate + "_" + response.data.list[i].eventType + " td:eq(" + 4 + ")").html(common.addComma(response.data.list[i].femaleCnt));
            $("#dayTableBody tr._tr_" + response.data.list[i].theDate + "_" + response.data.list[i].eventType + " td:eq(" + 5 + ")").html(common.addComma(response.data.list[i].femaleDal));
            $("#dayTableBody tr._tr_" + response.data.list[i].theDate + "_" + response.data.list[i].eventType + " td:eq(" + 6 + ")").html(common.addComma(response.data.list[i].femalePay));
            $("#dayTableBody tr._tr_" + response.data.list[i].theDate + "_" + response.data.list[i].eventType + " td:eq(" + 7 + ")").html(common.addComma(response.data.list[i].maleCnt + response.data.list[i].femaleCnt));
            $("#dayTableBody tr._tr_" + response.data.list[i].theDate + "_" + response.data.list[i].eventType + " td:eq(" + 8 + ")").html(common.addComma(response.data.list[i].maleDal + response.data.list[i].femaleDal));
            $("#dayTableBody tr._tr_" + response.data.list[i].theDate + "_" + response.data.list[i].eventType + " td:eq(" + 9 + ")").html(common.addComma(response.data.list[i].malePay + response.data.list[i].femalePay));
        }

        $("#dayTableBody tr._tr_total th:eq(" + 2 + ")").html(common.addComma(response.data.summary.maleTotalCnt));
        $("#dayTableBody tr._tr_total th:eq(" + 3 + ")").html(common.addComma(response.data.summary.totalLevel5MaleDal + response.data.summary.totalLevel10MaleDal));
        $("#dayTableBody tr._tr_total th:eq(" + 4 + ")").html(common.addComma(response.data.summary.totalLevel5MalePay + response.data.summary.totalLevel10MalePay));
        $("#dayTableBody tr._tr_total th:eq(" + 5 + ")").html(common.addComma(response.data.summary.femaleTotalCnt));
        $("#dayTableBody tr._tr_total th:eq(" + 6 + ")").html(common.addComma(response.data.summary.totalLevel5FemaleDal + response.data.summary.totalLevel5FemaleDal));
        $("#dayTableBody tr._tr_total th:eq(" + 7 + ")").html(common.addComma(response.data.summary.totalLevel5FemalePay + response.data.summary.totalLevel10FemalePay));
        $("#dayTableBody tr._tr_total th:eq(" + 8 + ")").html(common.addComma(response.data.summary.maleTotalCnt + response.data.summary.femaleTotalCnt));
        $("#dayTableBody tr._tr_total th:eq(" + 9 + ")").html(common.addComma(response.data.summary.totalLevel5MaleDal + response.data.summary.totalLevel5FemaleDal + response.data.summary.totalLevel10MaleDal + response.data.summary.totalLevel10FemaleDal));
        $("#dayTableBody tr._tr_total th:eq(" + 10 + ")").html(common.addComma(response.data.summary.totalLevel5MalePay + response.data.summary.totalLevel5FemalePay + response.data.summary.totalLevel10MalePay + response.data.summary.totalLevel10FemalePay));

        $("#dayTableBody tr._tr_total_5 th:eq(" + 1 + ")").html(common.addComma(response.data.summary.totalLevel5MaleCnt));
        $("#dayTableBody tr._tr_total_5 th:eq(" + 2 + ")").html(common.addComma(response.data.summary.totalLevel5MaleDal));
        $("#dayTableBody tr._tr_total_5 th:eq(" + 3 + ")").html(common.addComma(response.data.summary.totalLevel5MalePay));
        $("#dayTableBody tr._tr_total_5 th:eq(" + 4 + ")").html(common.addComma(response.data.summary.totalLevel5FemaleCnt));
        $("#dayTableBody tr._tr_total_5 th:eq(" + 5 + ")").html(common.addComma(response.data.summary.totalLevel5FemaleDal));
        $("#dayTableBody tr._tr_total_5 th:eq(" + 6 + ")").html(common.addComma(response.data.summary.totalLevel5FemalePay));
        $("#dayTableBody tr._tr_total_5 th:eq(" + 7 + ")").html(common.addComma(response.data.summary.totalLevel5MaleCnt + response.data.summary.totalLevel5FemaleCnt));
        $("#dayTableBody tr._tr_total_5 th:eq(" + 8 + ")").html(common.addComma(response.data.summary.totalLevel5MaleDal + response.data.summary.totalLevel5FemaleDal));
        $("#dayTableBody tr._tr_total_5 th:eq(" + 9 + ")").html(common.addComma(response.data.summary.totalLevel5MalePay + response.data.summary.totalLevel5FemalePay));

        $("#dayTableBody tr._tr_total_10 th:eq(" + 1 + ")").html(common.addComma(response.data.summary.totalLevel10MaleCnt));
        $("#dayTableBody tr._tr_total_10 th:eq(" + 2 + ")").html(common.addComma(response.data.summary.totalLevel10MaleDal));
        $("#dayTableBody tr._tr_total_10 th:eq(" + 3 + ")").html(common.addComma(response.data.summary.totalLevel10MalePay));
        $("#dayTableBody tr._tr_total_10 th:eq(" + 4 + ")").html(common.addComma(response.data.summary.totalLevel10FemaleCnt));
        $("#dayTableBody tr._tr_total_10 th:eq(" + 5 + ")").html(common.addComma(response.data.summary.totalLevel10FemaleDal));
        $("#dayTableBody tr._tr_total_10 th:eq(" + 6 + ")").html(common.addComma(response.data.summary.totalLevel10FemalePay));
        $("#dayTableBody tr._tr_total_10 th:eq(" + 7 + ")").html(common.addComma(response.data.summary.totalLevel10MaleCnt + response.data.summary.totalLevel10FemaleCnt));
        $("#dayTableBody tr._tr_total_10 th:eq(" + 8 + ")").html(common.addComma(response.data.summary.totalLevel10MaleDal + response.data.summary.totalLevel10FemaleDal));
        $("#dayTableBody tr._tr_total_10 th:eq(" + 9 + ")").html(common.addComma(response.data.summary.totalLevel10MalePay + response.data.summary.totalLevel10FemalePay));

        $("[class^=_tr_]").each(function(){
            var me = $(this);
            var data = me.find('td:eq(2)').html();
            if(data == ''){
                me.hide();
            }
        });
    }

    function dayRowspan(className){
        $("." + className).each(function() {
            var rows = $("." + className + ":contains('" + $(this).text() + "')");
            if (rows.length > 1) {
                rows.eq(0).attr("rowspan", rows.length);
                rows.not(":eq(0)").remove();
            }
        });
    }
</script>

<script type="text/x-handlebars-template" id="tmp_dayTableBody">
    <tr class="_tr_total">
        <th rowspan="3" class="day _bgColor" data-bgcolor="#c6d9f1">합계</th>
        <th>총계</th>
        <th></th>
        <th></th>
        <th></th>
        <th></th>
        <th></th>
        <th></th>
        <th></th>
        <th></th>
        <th></th>
    </tr>
    <tr class="_tr_total_5">
        <th>5레벨</th>
        <th></th>
        <th></th>
        <th></th>
        <th></th>
        <th></th>
        <th></th>
        <th></th>
        <th></th>
        <th></th>
    </tr>
    <tr class="_tr_total_10">
        <th>10레벨</th>
        <th></th>
        <th></th>
        <th></th>
        <th></th>
        <th></th>
        <th></th>
        <th></th>
        <th></th>
        <th></th>
    </tr>
    {{#each this.slctType_date}}
    <tr class="_tr_{{this}}_5">
        <th class="day _bgColor" data-bgcolor="#c6d9f1">{{this}}</th>
        <td>5 레벨</td>
        <td></td>
        <td></td>
        <td></td>
        <td></td>
        <td></td>
        <td></td>
        <td></td>
        <td></td>
        <td></td>
    </tr>
    <tr class="_tr_{{this}}_10">
        <th class="day _bgColor" data-bgcolor="#c6d9f1">{{this}}</th>
        <td>10 레벨</td>
        <td></td>
        <td></td>
        <td></td>
        <td></td>
        <td></td>
        <td></td>
        <td></td>
        <td></td>
        <td></td>
    </tr>
    {{else}}
    <td colspan="9" class="noData">{{isEmptyData}}<td>
    {{/each}}
</script>