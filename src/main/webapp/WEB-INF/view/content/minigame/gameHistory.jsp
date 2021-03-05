<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="dummyData"><%= java.lang.Math.round(java.lang.Math.random() * 1000000) %></c:set>

<div class="col-lg-12 no-padding mt10">
    <span id="gameTypeArea"></span>
    <span id="gameHistorySortArea"></span>
    <div class="col-lg-12 no-padding mt5">
        <div class="widget-content ">
            <div class="dataTables_paginate paging_full_numbers" id="gameHistory_paginate_top"></div>
            <table class="table table-sorting table-hover table-bordered mt10">
                <colgroup>
                    <col width="5%"/><col width="5%"/><col width="20%"/><col width="10%"/><col width="6%"/>
                    <col width="6%"/><col width="10%"/><col width="10%"/><col width="5%"/><col width="5%"/>
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
            <div class="dataTables_paginate paging_full_numbers" id="gameHistory_paginate"></div>
        </div>
    </div>
</div>

<script type="text/javascript">

    $(document).ready(function() {
    });

    var gameHistoryPagingInfo = new PAGING_INFO(0,1,40);
    function gameHistory(pagingNo) {

        if(!common.isEmpty(pagingNo)){
            gameHistoryPagingInfo.pageNo = pagingNo;
        }else{
            gameHistoryPagingInfo.pageNo = 1;
        }

        var data = {
            sortState : $("#game_history_sort").val()
            , newSearchType : $("#searchMember").val()
            , searchText : common.isEmpty($('#searchText').val()) ? '' : $('#searchText').val()
            , startDate : $("#startDate").val()
            , endDate : $("#endDate").val()
            , slctType : 1
            , pageNo : gameHistoryPagingInfo.pageNo
            , pageCnt : gameHistoryPagingInfo.pageCnt

        };

        util.getAjaxData("miniGameList", "/rest/content/boardAdm/mini/game/history/list", data, fn_success_miniGameMemberList);

        var template = $('#tmp_miniGameHistoryTable').html();
        var templateScript = Handlebars.compile(template);
        var html = templateScript();
        $('#tb_miniGameHistory').html(html);
    }

    function fn_success_miniGameMemberList(dst_id, response){


        response.pagingVo.pageNo = gameHistoryPagingInfo.pageNo;
        response.pagingVo.pageCnt = gameHistoryPagingInfo.pageCnt;

        var template = $('#tmp_miniGameHistoryTable').html();
        var templateScript = Handlebars.compile(template);
        var context = response;
        var html = templateScript(context);
        $('#tb_miniGameHistory').html(html);

        gameHistoryPagingInfo.totalCnt = response.pagingVo.totalCnt;
        util.renderPagingNavigation('gameHistory_paginate_top', gameHistoryPagingInfo);
        util.renderPagingNavigation('gameHistory_paginate', gameHistoryPagingInfo);

        if(response.data.length == 0) {
            $("#gameHistory_paginate_top").hide();
            $('#gameHistory_paginate').hide();
        } else {
            $("#gameHistory_paginate_top").show();
            $('#gameHistory_paginate').show();
        }

    }

    function handlebarsPaging(targetId, pagingInfo) {

        if(targetId == "gameHistory_paginate_top" || targetId == "gameHistory_paginate") {
            gameHistoryPagingInfo = pagingInfo;
            gameHistory(pagingInfo.pageNo);
        }
    }



</script>

<script id="tmp_miniGameHistoryTable" type="text/x-handlebars-template">
    {{#each this.data as |data|}}
        <tr>
            <td>{{rowNumDesc ../pagingVo/totalCnt @index ../pagingVo/pageNo ../pagingVo/pageCnt}}</td>
            <td>{{{getCommonCodeLabel os_type 'loginHistoryOsType'}}}</td>
            <td>{{{roomNoLink room_no room_no}}} <br/>{{title}}</td>
            <td>{{{memNoLink mem_no mem_no}}} <br/> {{mem_nick}} </td>
            <td>{{{sexIcon mem_sex mem_birth_year}}}</td>
            <td>{{{getCommonCodeLabel state 'room_state'}}}</td>
            <td>{{start_date}}</td>
            <td>{{end_date}}</td>
            <td>{{#dalbit_if pay_yn '==' 1}} ON {{else}} OFF {{/dalbit_if}}</td>
            <td>{{addComma go_cnt}}</td>
        </tr>
    {{else}}
        <tr>
            <td colspan="10">{{isEmptyData}}</td>
        </tr>
    {{/each}}
</script>
