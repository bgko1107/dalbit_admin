<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!-- 회원가입 > 총계 -->
<div class="widget widget-table mb10">
    <div class="widget-content mt10">
        <span class="_searchDate"></span>
        <table class="table table-bordered _tableHeight" data-height="23px">
            <colgroup>
                <col width="6%"/><col width="4%"/><col width="4%"/><col width="4%"/><col width="4%"/>
                <col width="4%"/><col width="4%"/><col width="4%"/><col width="4%"/><col width="4%"/>
                <col width="4%"/><col width="4%"/><col width="4%"/><col width="4%"/><col width="4%"/>
                <col width="4%"/><col width="4%"/><col width="4%"/><col width="4%"/><col width="4%"/>
                <col width="4%"/><col width="4%"/><col width="4%"/>
            </colgroup>
            <thead>
            <tr class="_stateTopTh">
                <th rowspan="2"></th>
                <th colspan="2">방송시작알림</th>     <!-- 1 -->
                <th colspan="2">클립등록알림</th>     <!-- 9 -->
                <th colspan="2">방송공지등록알림</th>     <!-- 2 -->
                <th colspan="2">클립 알림</th>     <!-- 10 -->
                <th colspan="2">팬 추가 알림</th>     <!-- 3 -->
                <th colspan="2">팬보드 글 알림</th>     <!-- 4 -->
                <th colspan="2">팬보드 댓글 알림</th>     <!-- 8 -->
                <th colspan="2">선물 알림</th>     <!-- 5 -->
                <th colspan="2">1:1 알림</th>     <!-- 6 -->
                <%--<th colspan="2">공지/이벤트 알림</th>     <!-- 7 -->--%>
                <th colspan="3">합계</th>
                <th rowspan="2">총합</th>
            </tr>
            <tr class="_stateSubTh">
                <th>설정</th>
                <th>해제</th>
                <th>설정</th>
                <th>해제</th>
                <th>설정</th>
                <th>해제</th>
                <th>설정</th>
                <th>해제</th>
                <th>설정</th>
                <th>해제</th>
                <th>설정</th>
                <th>해제</th>
                <th>설정</th>
                <th>해제</th>
                <th>설정</th>
                <th>해제</th>
                <th>설정</th>
                <th>해제</th>
                <%--<th>설정</th>--%>
                <%--<th>해제</th>--%>
                <th>무음</th>
                <th>소리</th>
                <th>진동</th>
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
        getNotice();
    });

    function getNotice(){
        util.getAjaxData("notice", "/rest/status/push/notice", $("#searchForm").serialize(), fn_notice_success);
    }

    function fn_notice_success(data, response){
        $("#tableNoticeBody").empty();

        var template = $('#tmp_noticeDetail').html();
        var templateScript = Handlebars.compile(template);

        var detailContext = response.data.detailList;
        var html=templateScript(detailContext);
        $("#tableNoticeBody").append(html);

        ui.tableHeightSet();
    }
</script>
<script type="text/x-handlebars-template" id="tmp_noticeDetail">
    {{#each this as |data|}}
    <tr>
        <td class="_stateSubTh">{{the_date}}</td>
        <td>{{addComma set_1_y}}</td>
        <td>{{addComma set_1_n}}</td>
        <td>{{addComma set_9_y}}</td>
        <td>{{addComma set_9_n}}</td>
        <td>{{addComma set_2_y}}</td>
        <td>{{addComma set_2_n}}</td>
        <td>{{addComma set_10_y}}</td>
        <td>{{addComma set_10_n}}</td>
        <td>{{addComma set_3_y}}</td>
        <td>{{addComma set_3_n}}</td>
        <td>{{addComma set_4_y}}</td>
        <td>{{addComma set_4_n}}</td>
        <td>{{addComma set_8_y}}</td>
        <td>{{addComma set_8_n}}</td>
        <td>{{addComma set_5_y}}</td>
        <td>{{addComma set_5_n}}</td>
        <td>{{addComma set_6_y}}</td>
        <td>{{addComma set_6_n}}</td>
        <%--<td>{{addComma set_7_y}}</td>--%>
        <%--<td>{{addComma set_7_n}}</td>--%>
        <td>{{addComma alim_n}}</td>
        <td>{{addComma alim_s}}</td>
        <td>{{addComma alim_v}}</td>
        <td>{{addComma total}}</td>
    </tr>
    {{else}}
        <td colspan="11" class="noData">{{isEmptyData}}<td>
    {{/each}}
</script>