<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div class="col-md-12 no-padding">
    <table class="table table-sorting table-bordered datatable">
        <colgroup>
        </colgroup>
        <thead>
        <tr>
            <th class="_bgColor" data-bgcolor="#c6d9f1"></th>
            <th class="_bgColor" data-bgcolor="#c6d9f1">레벨구분</th>
            <th class="_bgColor" data-bgcolor="#c6d9f1">대상 인원</th>
            <th class="_bgColor" data-bgcolor="#c6d9f1">지급인원</th>
            <th class="_bgColor" data-bgcolor="#c6d9f1">지급 달</th>
        </tr>
        </thead>
        <tbody id="dayTableBody"></tbody>
    </table>
</div>

<script type="text/javascript">

    function getDayList(){
        var data = {
            startDate : $("#startDate").val()
            ,endDate : $("#endDate").val()
            ,searchText : $("#searchText").val()
            ,slctType : slctType
        };

        console.log(data);

        var template = $('#tmp_dayTableBody').html();
        var templateScript = Handlebars.compile(template);
        var html = templateScript();
        $("#dayTableBody").html(html);
        ui.paintColor();

        dayRowspan("day");

        // util.getAjaxData("list", "/rest/clip/category/recommend/list", data, fn_getDayList_success);
    }

    function fn_getDayList_success(data, response){

        var template = $('#tmp_dayTableBody').html();
        var templateScript = Handlebars.compile(template);
        var context = response.data;
        var html = templateScript(context);
        $("#dayTableBody").html(html);

        dayRowspan("day");
        ui.paintColor();
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
    {{#each this as |data|}}
    <tr>
        <td class="day _bgColor" data-bgcolor="#c6d9f1"></td>
        <td></td>
        <td></td>
        <td></td>
        <td></td>
    </tr>
    {{else}}
    <td colspan="4" class="noData">{{isEmptyData}}<td>
    {{/each}}
</script>