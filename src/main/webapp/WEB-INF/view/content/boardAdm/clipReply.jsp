<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="dummyData"><%= java.lang.Math.round(java.lang.Math.random() * 1000000) %></c:set>

<!-- table -->
<div class="col-lg-12 no-padding">
    <div class="widget-content">
        <div class="col-md-12 no-padding mt10">
            <span id ="clipReplyListCnt"></span>
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
        <div class="dataTables_paginate paging_full_numbers" id="clipReply_paginate_top"></div>
        <table id="noticeTable" class="table table-sorting table-hover table-bordered mt10">
            <colgroup>
                <col width="5%"/>
                <col width="10%"/>
                <col width="15%"/>
                <col width="10%"/>
                <col width="35%"/>
                <col width="10%"/>
                <col width="5%"/>
                <col width="5%"/>
                <col width="5%"/>
            </colgroup>
            <thead>
                <tr>
                    <th>No</th>
                    <th>클립 주인</th>
                    <th>클립 제목</th>
                    <th>댓글등록자</th>
                    <th>클립 댓글 내용</th>
                    <th>등록일시</th>
                    <th>수정일시</th>
                    <th>상태</th>
                    <th>관리</th>
                </tr>
            </thead>
            <tbody id="tb_clipList">
            </tbody>
        </table>
        <div class="dataTables_paginate paging_full_numbers" id="clipReply_paginate"></div>
    </div>
</div>
<!-- //table -->

<script type="text/javascript" src="/js/code/content/contentCodeList.js?${dummyData}"></script>
<script type="text/javascript">
    var clipPagingInfo = new PAGING_INFO(0,1,40);

    $(document).ready(function() {
        // clipReplyList();
    });

    var memNo;
    function clipReplyList() {

        if(!common.isEmpty(memNo) && memNo != null){
            txt_search = memNo;
        }else{
            txt_search = $('#txt_search').val();
        }
        var data = {
            'pageStart': clipPagingInfo.pageNo
            , 'pageCnt' : clipPagingInfo.pageCnt
            , 'searchText' : txt_search
            , 'sDate' : $("#startDate").val()
            , 'eDate' : $("#endDate").val()
            , 'searchType' : 0
        };

        util.getAjaxData("clipReplyList", "/rest/content/boardAdm/clipReplyList", data, fn_success_clipReplyList);
    }

    function fn_success_clipReplyList(dst_id, response, param) {

        var template = $('#tmp_clipReplyTable').html();
        var templateScript = Handlebars.compile(template);
        var context = response;
        var html = templateScript(context);

        $('#tb_clipList').html(html);

        clipPagingInfo.totalCnt = response.pagingVo.totalCnt;
        util.renderPagingNavigation('clipReply_paginate_top', clipPagingInfo);
        util.renderPagingNavigation('clipReply_paginate', clipPagingInfo);

        util.getAjaxData("clipReplySummary", "/rest/content/boardAdm/clipReplyList/summary", param, fn_success_clipReplySummary);
    }
    function fn_success_clipReplySummary(dst_id, response) {
        $("#tab_clipReply").text("클립댓글" + "(" + response.data.totalCnt +")");
        $("#clipReplyListCnt").html(
            '<span style="color:black">[검색결과 : ' +  response.data.totalCnt + ' 건]</span>' +
            '<span style="color: blue;"> [남' + response.data.maleCnt + " 건]</span>" + "," +
            '<span style="color: red;"> [여' + response.data.femaleCnt + " 건]</span>" + "," +
            '<span style="color: #555555;"> [알수없음' + response.data.noneCnt + " 건]</span>"
        );
    }

    $(document).on('click', '._clipReplyDelBtn', function() {
        if(confirm("클립 댓글을 삭제하시겠습니까?")) {
            var data = {
                castReplyIdx: $(this).data('castreplyidx'),
                cast_no: $(this).data('castno')
            };

            console.log(data);
            util.getAjaxData("delete", "/rest/content/boardAdm/clipReplyList/del", data, clipReplyDel_success);
        }else return;
    });

    function clipReplyDel_success(dst_id, response){
        alert(response.message);
        clipReplyList();
    }

</script>

<script id="tmp_clipReplyTable" type="text/x-handlebars-template">
    {{#each this.data as |data|}}
        <tr {{#dalbit_if writer_inner '==' 1}} style="background-color : #dae3f3" {{/dalbit_if}}>
            <td>{{indexDesc ../pagingVo/totalCnt rowNum}}</td>
            <td>
                {{{memNoLink_sex cast_mem_no cast_mem_no cast_mem_sex}}}<br/>
                {{{memNoLink_sex cast_mem_nick cast_mem_no cast_mem_sex}}}
            </td>
            <td>{{title}}</td>
            <td>
                {{{memNoLink_sex writer_mem_no writer_mem_no writer_mem_sex}}}<br/>
                {{{memNoLink_sex writer_mem_nick writer_mem_no writer_mem_sex}}}
            </td>
            <td>{{contents}}</td>
            <td>{{write_date}}</td>
            <td>{{last_upd_date}}</td>
            <td>
                {{#dalbit_if status '==' 1}}
                    정상
                {{else}}
                    삭제
                {{/dalbit_if}}
            </td>
            <td><a href="javascript://" class="_clipReplyDelBtn" data-castno="{{cast_no}}" data-castreplyidx="{{castReplyIdx}}">[삭제]</a></td>
        </tr>
    {{else}}
        <tr>
            <td colspan="9">{{isEmptyData}}</td>
        </tr>
    {{/each}}
</script>
