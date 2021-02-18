<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="dummyData"><%= java.lang.Math.round(java.lang.Math.random() * 1000000) %></c:set>

<div class="col-lg-12 no-padding mt10">
    <span id="gameTypeArea"></span>
    <span id="gameHistorySortArea"></span>
    <div class="col-lg-12 no-padding mt5">
        <div class="widget-content ">
            <table class="table table-sorting table-hover table-bordered mt10">
                <colgroup>
                    <col width="10%"/><col width="10%"/><col width="10%"/><col width="10%"/><col width="10%"/>
                    <col width="10%"/><col width="10%"/><col width="10%"/><col width="10%"/><col width="10%"/>
                </colgroup>
                <thead>
                <tr>
                    <th>No</th>
                    <th>플랫폼</th>
                    <th>주제<br/>제목</th>
                    <th>회원번호<br/>닉네임</th>
                    <th>성별</th>
                    <th>상태(Mic)<br/>/숨김</th>
                    <th>시작일시</th>
                    <th>종료일시</th>
                    <th>금액설정<br/>On/Off</th>
                    <th>게임 진행 횟수<br/>(참여인원)</th>
                </tr>
                </thead>
                <tbody id="tb_miniGameHistory">
                </tbody>
            </table>
        </div>
    </div>
</div>

<script type="text/javascript">

    $(document).ready(function() {
    });

    function gameHistory() {
        $("#gameHistorySortArea").html(util.getCommonCodeSelect(0, game_history_sort));


        // var data = {
        // };

        // util.getAjaxData("miniGameList", "/rest/content/boardAdm/mini/game/list", data, fn_success_miniGameList);

        var template = $('#tmp_miniGameHistoryTable').html();
        var templateScript = Handlebars.compile(template);
        var html = templateScript();
        $('#tb_miniGameHistory').html(html);
    }
</script>

<script id="tmp_miniGameHistoryTable" type="text/x-handlebars-template">
    {{#each this.data as |data|}}
        <tr>
            <td>{{indexDesc ../pagingVo/totalCnt rowNum}}</td>
        </tr>
    {{else}}
        <tr>
            <td colspan="10">{{isEmptyData}}</td>
        </tr>
    {{/each}}
</script>
