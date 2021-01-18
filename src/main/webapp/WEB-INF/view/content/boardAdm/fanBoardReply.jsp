<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="dummyData"><%= java.lang.Math.round(java.lang.Math.random() * 1000000) %></c:set>

<style>
    .modal-dialog {
        overflow-y: initial !important
    }
    .modal-body {
        height: 100%;
        overflow-y: auto;
    }
</style>
<!-- table -->
<div class="no-padding col-lg-12 form-inline">
    <div class="tab-content no-padding">
        <div class="tab-pane fade in active">
            <div class="widget-content">
                <div class="col-md-12 no-padding mt10">
                    <div class="col-md-3 no-padding">
                        <span id="fanboardReplyListCnt"></span><br/>
                        <span style="color: red">* 팬보드 작성 글 수(비밀글 수)를 표기한 정보입니다.</span><br/>
                        <select id="fanBoardReplayStatus" name="fanBoardReplayStatus" class="form-control searchType">
                            <option value="0" selected="selected">게시글 전체</option>
                            <option value="1">정상</option>
                            <option value="2">삭제</option>
                        </select>
                        <label class="control-inline fancy-checkbox custom-color-green ml15 mt5">
                            <input type="checkbox" name="replyIsSecret" id="replyIsSecret" value="1">
                            <span>비밀글 모아보기</span>
                        </label>
                    </div>
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
                <%--<div class="col-md-6 no-padding mt10">--%>
                    <%--<span id="searchType_boardReply" onchange="fanBoardReply();"></span>--%>
                <%--</div>--%>
                <%--<div class="col-md-6 no-padding mt10" >
                    <span id="fanBoardReplyTable_summary"></span>
                </div>--%>
                <div class="dataTables_paginate paging_full_numbers" id="fanBoardReply_paginate_top"></div>
                <div id="fanBoardReplyTable"></div>
                <div class="dataTables_paginate paging_full_numbers" id="fanBoardReply_paginate"></div>
            </div>
        </div>
    </div>
</div>
<!-- //table -->

<script type="text/javascript" src="/js/code/content/contentCodeList.js?${dummyData}"></script>
<script type="text/javascript" src="/js/code/member/memberCodeList.js?${dummyData}"></script>
<script type="text/javascript">
    var fanBoardReplyPagingInfo = new PAGING_INFO(0,1,100);

    $(document).ready(function() {
        // $("#searchType_boardReply").html(util.getCommonCodeSelect(-1, searchType_board, "N","searchType_boardReply"));
    });

    function fanBoardReply(pagingNo, _tabId) {
        if(!common.isEmpty(_tabId)){
            tabId = _tabId;
        }

        $('#title').html('팬보드 댓글');
        if(!common.isEmpty(pagingNo)){
            fanBoardReplyPagingInfo.pageNo = pagingNo;
        }else{
            fanBoardReplyPagingInfo.pageNo = 1;
        }

        if(!common.isEmpty(memNo) && memNo != null){
            txt_search = memNo;
        }else{
            txt_search = $('#txt_search').val();
        }

        var data = {
            'pageStart' : fanBoardReplyPagingInfo.pageNo
            , 'pageCnt' : fanBoardReplyPagingInfo.pageCnt
            , 'txt_search' : txt_search
            , 'start_sel' : $("#startDate").val()
            , 'end_sel' : $("#endDate").val()
            , 'searchType' : 0
            , 'boardType' : 2
            , 'status' : Number($("#fanBoardReplayStatus option:selected").val())
            , 'isSecret' : Number($('#replyIsSecret').val())
        };
        util.getAjaxData("fanBoardList", "/rest/content/boardAdm/fanBoardList", data, fn_success_fanBoardReply);
    }

    function fn_success_fanBoardReply(dst_id, response, param) {
        var template = $('#tmp_fanBoardReplyTable').html();
        var templateScript = Handlebars.compile(template);
        var context = response;
        var html = templateScript(context);

        $('#fanBoardReplyTable').html(html);

        fanBoardReplyPagingInfo.totalCnt = response.pagingVo.totalCnt;
        util.renderPagingNavigation('fanBoardReply_paginate_top', fanBoardReplyPagingInfo);
        util.renderPagingNavigation('fanBoardReply_paginate', fanBoardReplyPagingInfo);

        if(response.data.length == 0) {
            $("#fanBoardReply_paginate_top").hide();
            $('#fanBoardReply_paginate').hide();
        } else {
            $("#fanBoardReply_paginate_top").show();
            $('#fanBoardReply_paginate').show();
        }

        util.getAjaxData("fanBoardListSummary", "/rest/content/boardAdm/fanBoardList/summary", param, fn_success_fanBoardReplySummary);
    }
    function fn_success_fanBoardReplySummary(dst_id, response) {
        $("#tab_fanBoardReply").text("팬보드댓글" + "(" + response.data.totalCnt +")");
        $("#fanboardReplyListCnt").html(
            '<span style="color:black">[검색결과 : ' +  response.data.totalCnt + '(' + response.data.secretTotalCnt + ') 건]</span>' +
            '<span style="color: blue;"> [남' + response.data.maleCnt + '(' + response.data.secretMaleCnt + ') 건]</span>' + "," +
            '<span style="color: red;"> [여' + response.data.femaleCnt + '(' + response.data.secretFemaleCnt + ') 건]</span>' + "," +
            '<span style="color: #555555;"> [알수없음' + response.data.noneCnt + '(' + response.data.secretNoneCnt + ') 건]</span>'
        );

        // var template = $('#fanBoardReply_tableSummary').html();
        // var templateScript = Handlebars.compile(template);
        // var context = response.data;
        // var html = templateScript(context);
        //
        // $('#fanBoardReplyTable_summary').html(html);
    }

    $(document).on('click', '._deleteFanBoardReply', function() {
        if($(this).data('status') == 2) {
            alert('이미 삭제된 댓글입니다.');
        } else if(confirm("삭제하시겠습니까?")){
            var data = {
                'idx' : $(this).data('idx')
            };

            util.getAjaxData("deleteFanBoard", "/rest/member/fanboard/delete", data, function(dst_id, response) {
                alert(response.message);
                fanBoardReply(fanBoardReplyPagingInfo.pageNo);
            });
        }
        return false;
    });

    $('#fanBoardReplayStatus').on('change', function () {
        fanBoardReply();
    });

    $('#replyIsSecret').on('change', function() {
        if($('input:checkbox[name="replyIsSecret"]').prop('checked')) {
            $('#replyIsSecret').val(0)
        } else {
            $('#replyIsSecret').val(1)
        }
        fanBoardReply();
    });

</script>

<script id="tmp_fanBoardReplyTable" type="text/x-handlebars-template">
    <table id="tb_fanBoardReply" class="table table-sorting table-hover table-bordered mt10">
        <colgroup>
            <col width="2%"/><col width="5%"/><col width="5%"/><col width="5%"/><col width="5%"/>
            <col width="5%"/><col width="25%"/><col width="5%"/><col width="5%"/><col width="5%"/>
            <col width="25%"/><col width="5%"/>
        </colgroup>
        <thead>
        <tr>
            <th>No</th>
            <th>팬보드주인</th>
            <th>성별</th>
            <th>팬보드글등록자</th>
            <th>성별</th>
            <th>비밀 글 여부</th>
            <th class="word-break" style="width: 220px">팬보드 등록 글</th>
            <th>상태</th>
            <th>댓글등록자</th>
            <th>성별</th>
            <th class="word-break" style="width: 220px">등록된 댓글</th>
            <th>상태</th>
            <th>등록일시</th>
            <th>관리</th>
        </tr>
        </thead>
        <tbody>
        {{#each this.data as |data|}}
            <tr {{#dalbit_if fan_inner '==' 1}} style="background-color : #dae3f3" {{/dalbit_if}}>
                <td>{{indexDesc ../pagingVo.totalCnt rowNum}}</td>
                <td>
                    {{{memNoLink star_mem_no star_mem_no}}}<br/>
                    {{star_mem_nick}}
                </td>
                <td>
                    {{{sexIconBr star_mem_sex star_birth_year}}}
                </td>
                <td>
                    {{{memNoLink fan_mem_no fan_mem_no}}}<br/>
                    {{fan_mem_nick}}
                </td>
                <td>
                    {{{sexIconBr fan_mem_sex fan_birth_year}}}
                </td>
                <td>
                    {{#dalbit_if view_yn '==' 0}} 비밀 글 {{/dalbit_if}}
                </td>
                <td class="word-break" style="width: 200px">
                    <span class="pull-left">{{replaceHtml contents}}</span>
                </td>
                <td>
                    {{#dalbit_if status '==' 1}}
                        정상
                    {{else}}
                        삭제
                    {{/dalbit_if}}
                </td>
                <td>
                    {{{memNoLink fan_reply_mem_no fan_reply_mem_no}}}<br/>
                    {{fan_reply_mem_nick}}
                </td>
                <td>
                    {{{sexIconBr fan_reply_mem_sex fan_reply_birth_year}}}
                </td>
                <td class="word-break" style="width: 200px">
                    <span class="pull-left">{{replaceHtml replyContents}}</span>
                </td>
                <td>
                    {{#dalbit_if reply_status '==' 1}}
                        정상
                    {{else}}
                        삭제
                    {{/dalbit_if}}
                </td>
                <td>{{convertToDate last_upd_date 'YYYY-MM-DD HH:mm:ss'}}</td>
                <td><a href="javascript://" class="_deleteFanBoardReply" data-idx="{{idx}}" data-status="{{reply_status}}">[삭제]</a></td>
            </tr>
        {{else}}
        <tr>
            <td colspan="17">{{isEmptyData}}</td>
        </tr>
        {{/each}}
        </tbody>
    </table>
</script>

<%--
<script id="fanBoardReply_tableSummary" type="text/x-handlebars-template">
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
</script>--%>
