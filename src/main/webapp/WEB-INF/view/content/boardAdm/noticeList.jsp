<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!-- table -->
<div class="col-lg-12 no-padding">
    <div class="widget-content">
        <div class="col-md-6 no-padding mt10">
            <span id="searchType_notice" onchange="noticeList();"></span>
        </div>
        <div class="col-md-6 no-padding mt10" >
            <span id="noticeTable_summary"></span>
        </div>
        <div class="dataTables_paginate paging_full_numbers" id="notice_paginate_top"></div>
        <table id="noticeTable" class="table table-sorting table-hover table-bordered mt10">
            <colgroup>
                <col width="1%"/><col width="3%"/><col width="3%"/><col width="5%"/><col width="9%"/>
                <col width="7%"/><col width="15%"/><col width="9%"/><col width="15%"/>
            </colgroup>
            <thead>
            <tr>
                <th rowspan="2"></th>
                <th rowspan="2">No</th>
                <th rowspan="3">번호</th>
                <th rowspan="2">구분</th>
                <th colspan="3">회원정보</th>
                <th rowspan="2">보낸일시</th>
                <th rowspan="2">상태</th>
                <th rowspan="2">내용</th>
            </tr>
            <tr>
                <th>닉네임</th>
                <th>성별(나이)</th>
                <th>방송제목</th>
            </tr>
            </thead>
            <tbody id="tb_noticeList">
            </tbody>
        </table>
        <div class="dataTables_paginate paging_full_numbers" id="notice_paginate"></div>
        <input type="button" value="선택삭제" class="btn btn-danger btn-sm" id="btn_noticeDelBtn" style="margin-right: 3px;"/>
    </div>
</div>
<!-- //table -->

<script type="text/javascript" src="/js/code/content/contentCodeList.js?${dummyData}"></script>
<script type="text/javascript">
    var noticePagingInfo = new PAGING_INFO(0,1,40);

    $(document).ready(function() {
        $("#searchType_notice").html(util.getCommonCodeSelect(-1, searchType_notice));
        noticeList();
    });

    var memNo;
    function noticeList(pagingInfo) {
        $('#title').html('회원/방송공지');
        if(!common.isEmpty(pagingInfo)){
            noticePagingInfo.pageNo = pagingInfo;
        }else{
            noticePagingInfo.pageNo = 1;
        }

        if(!common.isEmpty(memNo) && memNo != null){
            txt_search = memNo;
        }else{
            txt_search = $('#txt_search').val();
        }
        var data = {
            'pageNo': noticePagingInfo.pageNo
            , 'pageCnt' : noticePagingInfo.pageCnt
            , 'mem_no' : txt_search
            , 'sDate' : $("#startDate").val()
            , 'eDate' : $("#endDate").val()
            , 'searchType' : $("select[name='searchType_notice']").val()
        };

        util.getAjaxData("noticeList", "/rest/content/boardAdm/noticeList", data, fn_success_noticeList);
    }

    function fn_success_noticeList(dst_id, response, param) {

        for(var i=0 ; i<response.data.length;i++){
            response.data[i].contents = response.data[i].contents.replace(/\\n/gi,"<br/>");
        }

        var template = $('#tmp_noticeTable').html();
        var templateScript = Handlebars.compile(template);
        var context = response;
        var html = templateScript(context);

        $('#tb_noticeList').html(html);

        noticePagingInfo.totalCnt = response.pagingVo.totalCnt;
        util.renderPagingNavigation('notice_paginate_top', noticePagingInfo);
        util.renderPagingNavigation('notice_paginate', noticePagingInfo);

        if(response.data.length == 0) {
            $("noticeList").find("#notice_paginate_top").hide();
            $("noticeList").find('#notice_paginate').hide();
        } else {
            $("noticeList").find("#notice_paginate_top").show();
            $("noticeList").find('#notice_paginate').show();
        }

        util.getAjaxData("noticeListSummary", "/rest/content/boardAdm/noticeList/summary", param, fn_success_noticeSummary);
    }

    function fn_success_noticeSummary(dst_id, response) {
        var template = $('#notice_tableSummary').html();
        var templateScript = Handlebars.compile(template);
        var context = response.data;
        var html = templateScript(context);

        $('#noticeTable_summary').html(html);
    }

    $("#btn_noticeDelBtn").on("click", function () { //선택삭제
        var checkeds = $("#tb_noticeList").find('._chk:checked');
        if(0 == checkeds.length){
            alert('삭제할 공지사항을 선택해주세요.');
            return false;
        }

        if(confirm(checkeds.length +'건을 삭제하시겠습니까?')){
            var noticeIdx = [];
            var nociceType = [];
            checkeds.each(function(){
                noticeIdx.push($(this).data('noticeidx'));
                nociceType.push($(this).data('type'));
            });

            var data = {
                noticeIdx : JSON.stringify(noticeIdx),
                nociceType : JSON.stringify(nociceType)
            };

            console.log(data);
            util.getAjaxData("delete", "/rest/member/notice/delete",data, noticeDel_success);
        }
    });

    function handlebarsPaging(targetId, pagingInfo) {
        noticePagingInfo = pagingInfo;
        noticeList(pagingInfo.pageNo);
    }

    function noticeDel_success(dst_id, response){
        alert(response.message);
        noticeList();
    }

</script>

<script id="tmp_noticeTable" type="text/x-handlebars-template">
    {{#each this.data as |data|}}
        <tr>
            <td><input class="_chk" type="checkbox" data-noticeIdx="{{idx}}" data-type="{{type}}"/></td>
            <td>{{indexDesc ../pagingVo/totalCnt rowNum}}</td>
            <td>{{idx}}</td>
            <td>
                {{#equal type '1'}}
                <span style="color: blue;">회원공지</span>
                {{else}}
                <span style="color: red;">방송공지</span>
                {{/equal}}
            </td>
            <td>
                <a href="javascript://" class="_openMemberPop" data-memNo="{{mem_no}}">{{mem_no}}</a>
                <br/>
                {{mem_nick}}
            </td>
            <td>{{{sexIcon mem_sex mem_birth_year}}}</td>
            <td><a href="javascript://" class="_openBroadcastPop" data-roomNo="{{room_no}}">{{replaceHtml title}}</a></td>
            <td>{{lastUpdDateFormat}}</td>
            <td>등록</td>
            <td class="word-break" style=""><span>{{{replaceHtml contents}}}</span></td>
        </tr>
    {{else}}
        <tr>
            <td colspan="9">{{isEmptyData}}</td>
        </tr>
    {{/each}}
</script>

<script id="notice_tableSummary" type="text/x-handlebars-template">
    <table class="table table-bordered table-summary pull-right no-padding" style="width: 70%;margin-right: 0px">
        <tr>
            <th colspan="5" style="background-color: #8fabdd">팬보드 (비밀글) 현황</th>
        </tr>
        <tr>
            <th style="background-color: #7f7f7f; color: white">총합</th>
            <th style="background-color: #d9d9d9">일평균</th>
            <th style="background-color: #d9d9d9">성별-남성/여성/알수없음</th>
            <th style="background-color: #d9d9d9">총 삭제 글</th>
            <th style="background-color: #d9d9d9">총 일평균 삭제</th>
        </tr>
        <tr>
            <td class="font-bold" style="background-color: #f4b282">{{addComma totalCnt}} ({{addComma secretTotalCnt}})</td>
            <td>{{addComma avgTotalCnt}} ({{addComma secretAvgTotalCnt}})</td>
            <td><span style="color: blue"><span class="font-bold">{{addComma maleCnt}}</span> ({{addComma secretMaleCnt}})</span>
                / <span style="color: red"><span class="font-bold">{{addComma femaleCnt}}</span> ({{addComma secretFemaleCnt}})</span>
                / <span class="font-bold">{{addComma noneCnt}}</span> ({{addComma secretNoneCnt}})</td>
            <td>{{addComma totalDelCnt}} ({{addComma secretTotalDelCnt}})</td>
            <td>{{addComma avgTotalDelCnt}} ({{addComma secretAvgTotalDelCnt}})</td>
        </tr>
    </table>
</script>