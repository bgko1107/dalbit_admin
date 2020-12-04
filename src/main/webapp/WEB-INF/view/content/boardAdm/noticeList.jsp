<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="dummyData"><%= java.lang.Math.round(java.lang.Math.random() * 1000000) %></c:set>

<!-- table -->
<div class="col-lg-12 no-padding">
    <div class="widget-content">
        <div class="col-md-12 no-padding mt10">
            <span id="noticeListCnt"></span>
            <div class="col-md-2 no-padding pull-right">
                <table class="table table-sorting table-hover table-bordered">
                    <colgroup>
                        <col width="15%"/><col width="65%"/>
                    </colgroup>
                    <tr>
                        <td style="background-color: #dae3f3"></td><td>테스트 아이디</td>
                    </tr>
                </table>
            </div>
        </div>
        <div class="dataTables_paginate paging_full_numbers" id="notice_paginate_top"></div>
        <table id="noticeTable" class="table table-sorting table-hover table-bordered mt10">
            <colgroup>
                <col width="4%"/><col width="10%"/><col width="6%"/><col width="10%"/><col width="46%"/>
                <col width="10%"/><col width="5%"/><col width="5%"/>
            </colgroup>
            <thead>
            <tr>
                <th>No</th>
                <th>등록회원</th>
                <th>성별(나이)</th>
                <th>공지제목</th>
                <th>공지내용</th>
                <th>등록일시</th>
                <th>수정</th>
                <th>관리</th>
            </tr>
            </thead>
            <tbody id="tb_noticeList">
            </tbody>
        </table>
        <div class="dataTables_paginate paging_full_numbers" id="notice_paginate"></div>
    </div>
</div>
<!-- //table -->

<script type="text/javascript" src="/js/code/content/contentCodeList.js?${dummyData}"></script>
<script type="text/javascript">
    var noticePagingInfo = new PAGING_INFO(0,1,40);
    var tabId = 'tab_noticeBroadcastDetail';

    $(document).ready(function() {
        // noticeList();
    });

    var memNo;
    function noticeList(pagingNo, _tabId) {
        if(!common.isEmpty(_tabId)){
            tabId = _tabId;
        }

        $('#title').html('방송공지');
        if(!common.isEmpty(pagingNo)){
            noticePagingInfo.pageNo = pagingNo;
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
            , 'searchType' : tabId == "tab_noticeMemberDetail" ? 1 : 2
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
        $("#tab_noticeList").text("방송방공지" + "(" + response.data.totalCnt +")");
        $("#noticeListCnt").html(
            '<span style="color:black">[검색결과 : ' +  response.data.totalCnt + ' 건]</span>' +
            '<span style="color: blue;"> [남' + response.data.maleCnt + " 건]</span>" + "," +
            '<span style="color: red;"> [여' + response.data.femaleCnt + " 건]</span>" + "," +
            '<span style="color: #555555;"> [알수없음' + response.data.noneCnt + " 건]</span>"
        );
    }

    $(document).on('click', '._noticeDelBtn', function() {
        if(confirm("삭제하시겠습니까?")) {
            var data = {
                noticeIdx: $(this).data('noticeidx'),
                noticeType: $(this).data('type'),
                roomNo: $(this).data('roomno')
            };
            util.getAjaxData("delete", "/rest/member/notice/delete", data, noticeDel_success);
        }else return;
    });

    $(document).on('click', '._noticeEditList', function() {
        var index = $(this).data('noticeidx');
        var room_no = $(this).data('roomno');
        var url = "/content/boardAdm/popup/editList?type=1&noticeidx=" + index + "&room_no=" + room_no;

        console.log(url);
        util.windowOpen(url,"1200","450","");
    });

    function noticeDel_success(dst_id, response){
        alert(response.message);
        noticeList();
    }

    function handlebarsPaging(targetId, pagingInfo){
        noticeList(pagingInfo.pageNo);
    }

</script>

<script id="tmp_noticeTable" type="text/x-handlebars-template">
    {{#each this.data as |data|}}
        <tr {{#dalbit_if inner '==' 1}} style="background-color : #dae3f3" {{/dalbit_if}}>
            <td>{{indexDesc ../pagingVo/totalCnt rowNum}}</td>
            <td>
                {{{memNoLink mem_no mem_no}}}<br/>
                {{mem_nick}}
            </td>
            <td>{{{sexIcon mem_sex mem_birth_year}}}</td>
            <td class="word-break" style="width: 150px"><span class="pull-left">{{{replaceHtml title}}}</span></td>
            <td class="word-break" style="width: 550px"><span class="pull-left">{{{replaceHtml contents}}}</span></td>
            <td>{{lastUpdDateFormat}}</td>
            <td><a href="javascript://" class="_noticeEditList" data-noticeIdx="{{idx}}" data-type="{{type}}" data-roomno="{{room_no}}">{{addComma editCnt}}</a></td>
            <td><a href="javascript://" class="_noticeDelBtn" data-noticeIdx="{{idx}}" data-type="{{type}}" data-roomno="{{room_no}}">[삭제]</a></td>
        </tr>
    {{else}}
        <tr>
            <td colspan="7">{{isEmptyData}}</td>
        </tr>
    {{/each}}
</script>