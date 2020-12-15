<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="dummyData"><%= java.lang.Math.round(java.lang.Math.random() * 1000000) %></c:set>

<!-- 결제/환불 > 결제내역 -->
<div class="widget-table mb10">
    <div class="col-md-12" style="background-color: #fbe5d6;padding:7px;margin-top: 8px">
        <span class="font-bold" style="color: #7792c9;">&nbsp;실시간 득표 수 상세내역</span>
    </div>
    <div class="col-md-12 no-padding mt10">
        <table class="table table-sorting table-hover table-bordered">
            <tr>
                <th class="_bgColor" data-bgcolor="#c6d9f1">회원번호</th>
                <td><span id="memNo"></span></td>
                <th class="_bgColor" data-bgcolor="#c6d9f1">닉네임</th>
                <td><span id="memNick"></span></td>
            </tr>
            <tr>
                <th class="_bgColor" data-bgcolor="#c6d9f1">현재순위</th>
                <td><span id="rank"></span></td>
                <th class="_bgColor" data-bgcolor="#c6d9f1">득표 수</th>
                <td><span id="voteCnt"></span></td>
            </tr>
        </table>
    </div>

    <div class="widget-content mt10">
        <div class="dataTables_paginate paging_full_numbers" id="list_info_paginate_top"></div>
        <table id="list_info" class="table table-sorting table-hover table-bordered">
        </table>
        <div class="dataTables_paginate paging_full_numbers" id="list_info_paginate"></div>
    </div>
</div>

<script type="text/javascript" src="/js/code/payment/payCodeList.js?${dummyData}"></script>

<script type="text/javascript">
    listPagingInfo = new PAGING_INFO(0, 1, 50);

    var memNo = '${param.memNo}';
    var memNick = '${param.memNick}';
    var selectYear = '${param.selectYear}';
    var rank = '${param.rank}';
    var voteCnt = '${param.voteCnt}';

    $(document).ready(function() {

        $("#memNo").text(memNo);
        $("#memNick").text(memNick);
        $("#rank").text(rank);
        $("#voteCnt").text(voteCnt);

        getList();
    });

    function getList() {

        var data = {
            pageStart : listPagingInfo.pageNo
            , pageCnt : listPagingInfo.pageCnt
            , mem_no :memNo
            , selectYear : selectYear
        };
        util.getAjaxData("voteDetail", "/rest/menu/rank/awards/vote/detail", data, fn_succ_list);
    }

    function fn_succ_list(dst_id, response, params) {
        dalbitLog(response);

        response.data.totalCnt = response.pagingVo.totalCnt;
        var template = $('#tmp_list_info').html();
        var templateScript = Handlebars.compile(template);
        var context = response.data;
        var html = templateScript(context);
        $("#list_info").html(html);

        if(response.result == "success") {
            var pagingInfo = response.pagingVo;
            listPagingInfo.totalCnt = pagingInfo.totalCnt;
            util.renderPagingNavigation('list_info_paginate_top', listPagingInfo);
            util.renderPagingNavigation('list_info_paginate', listPagingInfo);
        }
        ui.paintColor();
    }

    function handlebarsPaging(targetId, pagingInfo){
        listPagingInfo = pagingInfo;
        $('#bt_search').click();
    }

</script>

<script type="text/x-handlebars-template" id="tmp_list_info">
    <thead>
        <tr>
            <th>번호</th>
            <th>투표 일시</th>
            <th>투표 회원</th>
            <th>참여자 IP</th>
        </tr>
    </thead>
    <tbody id="listBody">
    {{#each this}}
        <tr {{#dalbit_if inner '==' 1}} class="bg-testMember" {{/dalbit_if}}>
        <td>{{indexDesc ../totalCnt rowNum}}</td>
        <td>{{lastUpdDate}}</td>
        <td>
            <a href="javascript://" class="_openMemberPop" data-memNo="{{memNo}}">{{memNo}}</a><br />
            {{memNick}}
        </td>
        <td>{{ip}}</td>
    </tr>
    {{else}}
    <tr>
        <td colspan="15">{{isEmptyData}}</td>
    </tr>
    {{/each}}
    </tbody>
</script>

