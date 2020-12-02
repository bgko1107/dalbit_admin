<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="dummyData"><%= java.lang.Math.round(java.lang.Math.random() * 1000000) %></c:set>

<!-- DATA TABLE -->
<div class="dataTables_paginate paging_full_numbers" id="secondList_info_paginate_top"></div>
<div>
    <table id="secondList" class="table table-sorting table-hover table-bordered">
        <thead>
        <tr>
            <th>No</th>
            <th>회차</th>
            <th>구분</th>
            <th>제목</th>
            <th>대상1</th>
            <th>등록일시</th>
            <th>조회수</th>
            <th>게시상태</th>
            <th>처리자명</th>
        </tr>
        </thead>
        <tbody id="secondList_tableBody"></tbody>
    </table>
</div>
<div class="dataTables_paginate paging_full_numbers" id="secondList_info_paginate"></div>
<!-- DATA TABLE END -->
<input type="button" value="선택 삭제" class="btn btn-danger btn-sm" id="btn_delete"/>

<script type="text/javascript" src="/js/code/menu/menuCodeList.js?${dummyData}"></script>
<script type="text/javascript">
    var secondPagingInfo = new PAGING_INFO(0,1,100);

    function getSecondList(){

        console.log("----------------------");

        console.log(dataSet());
        util.getAjaxData("secondList", "/rest/menu/second/list", dataSet(), fn_succ_secondList);
    }


    function fn_succ_secondList(data, response, params) {
        dalbitLog(response);

        var template = $('#tmp_secondList').html();
        var templateScript = Handlebars.compile(template);
        var context = response.data;
        var html = templateScript(context);
        $("#secondList_tableBody").html(html);

        var pagingInfo = response.pagingVo;
        secondPagingInfo.totalCnt = pagingInfo.totalCnt;
        util.renderPagingNavigation("secondList_info_paginate_top", secondPagingInfo);
        util.renderPagingNavigation("secondList_info_paginate", secondPagingInfo);
    }

    function handlebarsPaging(targetId, pagingInfo){
        console.log("---------------------------- targetId");
        console.log(targetId);
        secondPagingInfo = pagingInfo;
    }

</script>

<script type="text/x-handlebars-template" id="tmp_secondList">
    {{#each this as |user|}}
    <tr>
        <td>{{rowNum}}</td>
        <td>-</td>
        <td>-</td>
        <td>-</td>
        <td>-</td>
        <td>-</td>
        <td>-</td>
        <td>-</td>
        <td>-</td>
        <td>-</td>
    </tr>
    {{/each}}
</script>
