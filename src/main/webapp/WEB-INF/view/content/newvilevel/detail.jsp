<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div class="col-md-12 no-padding">
    <div class="dataTables_paginate paging_full_numbers" id="detail_paginate_top"></div>
    <table class="table table-sorting table-bordered datatable">
        <colgroup>
        </colgroup>
        <thead>
        <tr>
            <th class="_bgColor" data-bgcolor="#c6d9f1"></th>
            <th class="_bgColor" data-bgcolor="#c6d9f1">이벤트 구분</th>
            <th class="_bgColor" data-bgcolor="#c6d9f1">회원 번호</th>
            <th class="_bgColor" data-bgcolor="#c6d9f1">닉네임</th>
            <th class="_bgColor" data-bgcolor="#c6d9f1">지급 달</th>
            <th class="_bgColor" data-bgcolor="#c6d9f1">지급 일시</th>
        </tr>
        </thead>
        <tbody id="detailTableBody"></tbody>
    </table>
    <div class="dataTables_paginate paging_full_numbers" id="detail_paginate"></div>
</div>

<script type="text/javascript">

    var detailPagingInfo = new PAGING_INFO(0,1,100);

    function getDetailList(pagingNo){

        if(!common.isEmpty(pagingNo)){
            detailPagingInfo.pageNo = pagingNo;
        }else{
            detailPagingInfo.pageNo = 1;
        }

        var data = {
            pageStart: detailPagingInfo.pageNo
            ,pageCnt : detailPagingInfo.pageCnt
            ,startDate : $("#startDate").val()
            ,endDate : $("#endDate").val()
            ,searchText : $("#searchText").val()
            ,slctType : slctType
        };

        console.log(data);

        // var template = $('#tmp_detailTableBody').html();
        // var templateScript = Handlebars.compile(template);
        // var html = templateScript();
        // $("#detailTableBody").html(html);

        // detailRowspan("day");

        util.getAjaxData("list", "/rest/content/newvilevel/detail", data, fn_getDetailList_success);
    }

    function fn_getDetailList_success(data, response){

        var template = $('#tmp_detailTableBody').html();
        var templateScript = Handlebars.compile(template);
        var context = response.data;
        var html = templateScript(context);
        $("#detailTableBody").html(html);

        //detailRowspan("day");


        detailPagingInfo.totalCnt = response.pagingVo.totalCnt;
        util.renderPagingNavigation('detail_paginate_top', detailPagingInfo);
        util.renderPagingNavigation('detail_paginate', detailPagingInfo);
        detailPagingInfo.pageNo=1;

        if(response.data.length == 0) {
            $("#detail_paginate_top").hide();
            $('#detail_paginate').hide();
        } else {
            $("#detail_paginate_top").show();
            $('#detail_paginate').show();
        }

        ui.paintColor();
    }

    function detailRowspan(className){
        $("." + className).each(function() {
            var rows = $("." + className + ":contains('" + $(this).text() + "')");
            if (rows.length > 1) {
                rows.eq(0).attr("rowspan", rows.length);
                rows.not(":eq(0)").remove();
            }
        });
    }
</script>

<script type="text/x-handlebars-template" id="tmp_detailTableBody">
    {{#each this as |data|}}
    <tr>
        <td class="_bgColor day" data-bgcolor="#c6d9f1">{{achieveDate}}</td>
        <td>{{level}} 레벨</td>
        <td><a href="javascript://" class="_openMemberPop" data-memNo="{{mem_no}}">{{mem_no}}</a></td>
        <td><a href="javascript://" class="_openMemberPop" data-memNo="{{mem_no}}">{{mem_nick}}</a></td>
        <td>{{addComma dal}} 달</td>
        <td>{{achieve_date}}</td>
    </tr>
    {{else}}
        <td colspan="5" class="noData">{{isEmptyData}}<td>
    {{/each}}
</script>