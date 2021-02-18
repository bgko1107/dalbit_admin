<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="dummyData"><%= java.lang.Math.round(java.lang.Math.random() * 1000000) %></c:set>

<!-- table -->
<div class="no-padding col-lg-12 form-inline">
    <div class="tab-content no-padding">
        <div class="tab-pane fade in active">
            <div class="widget-content">
                <div class="col-md-12 no-padding mt10">
                    <div class="col-md-4 no-padding">
                        <span id="noticeReplyListCnt"></span><br/>
                        <span style="color: red">* 댓글 수를 표기한 정보입니다.</span><br/>
                        <select id="noticeReplayStatus" name="noticeReplayStatus" class="form-control searchType">
                            <option value="0" selected="selected">게시글 전체</option>
                            <option value="1">정상</option>
                            <option value="2">삭제</option>
                        </select>

                        <span id="dynamicPageBroadNoticeReplyArea"></span>
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
                <div class="dataTables_paginate paging_full_numbers" id="noticeReply_paginate_top"></div>
                <div id="noticeReplyTable"></div>
                <div class="dataTables_paginate paging_full_numbers" id="noticeReply_paginate"></div>
            </div>
            <div class="widget-footer">
                <span>
                    <button class="btn btn-danger btn-sm print-btn" type="button" id="deleteBroadNoticeReplyBtn"><i class="fa fa-check"></i>선택 삭제</button>
                </span>
            </div>
        </div>
    </div>
</div>
<!-- //table -->

<script type="text/javascript" src="/js/code/content/contentCodeList.js?${dummyData}"></script>
<script type="text/javascript" src="/js/code/member/memberCodeList.js?${dummyData}"></script>
<script type="text/javascript">
    var noticeReplyPagingInfo = new PAGING_INFO(0,1,$("#dynamicPageCntBroadNoticeReply").val());

    $(document).ready(function() {
        $("#dynamicPageBroadNoticeReplyArea").html(util.renderDynamicPageCntSelect('dynamicPageCntBroadNoticeReply'));
    });

    function broadNoticeReply(pagingNo, _tabId) {
        if(!common.isEmpty(_tabId)){
            tabId = _tabId;
        }

        $('#title').html('회원공지 댓글');
        if(!common.isEmpty(pagingNo)){
            noticeReplyPagingInfo.pageNo = pagingNo;
        }else{
            noticeReplyPagingInfo.pageNo = 1;
        }

        if(!common.isEmpty(memNo) && memNo != null){
            txt_search = memNo;
        }else{
            txt_search = $('#txt_search').val();
        }


        var data = {
            'pageStart' : noticeReplyPagingInfo.pageNo
            , 'pageCnt' : noticeReplyPagingInfo.pageCnt
            , 'txt_search' : txt_search
            , 'start_sel' : $("#startDate").val()
            , 'end_sel' : $("#endDate").val()
            , 'searchType' : 0
            , 'replyStatus' : Number($("#noticeReplayStatus option:selected").val())
            , 'newSearchType' : $("#searchMember").val()
        };
        util.getAjaxData("noticeReplyList", "/rest/content/boardAdm/noticeReplyList", data, fn_success_noticeReplyList);
    }

    function fn_success_noticeReplyList(dst_id, response, param) {
        var template = $('#tmp_noticeReplyTable').html();
        var templateScript = Handlebars.compile(template);
        var context = response;
        var html = templateScript(context);

        $('#noticeReplyTable').html(html);

        noticeReplyPagingInfo.totalCnt = response.pagingVo.totalCnt;
        util.renderPagingNavigation('noticeReply_paginate_top', noticeReplyPagingInfo);
        util.renderPagingNavigation('noticeReply_paginate', noticeReplyPagingInfo);

        if(response.data.length == 0) {
            $("#noticeReply_paginate_top").hide();
            $('#noticeReply_paginate').hide();
        } else {
            $("#noticeReply_paginate_top").show();
            $('#noticeReply_paginate').show();
        }
        util.getAjaxData("fanBoardListSummary", "/rest/content/boardAdm/noticeReplyList/summary", param, fn_success_noticeReplySummary);
    }
    function fn_success_noticeReplySummary(dst_id, response) {
        $("#tab_broadNoticeReply").text("회원공지댓글" + "(" + response.data.summaryTotalCnt +")");
        $("#noticeReplyListCnt").html(
            '<span style="color:black">[검색결과 : ' +  response.data.summaryTotalCnt + ' 건]</span>' +
            '<span style="color: blue;"> [남' + response.data.maleCnt + ' 건]</span>' + "," +
            '<span style="color: red;"> [여' + response.data.femaleCnt + ' 건]</span>' + "," +
            '<span style="color: #555555;"> [알수없음' + response.data.noneCnt + ' 건]</span>'
        );
    }

    $(document).on('click', '._deleteNoticeReply', function() {
        if($(this).data('status') == 1) {
            alert('이미 삭제된 댓글입니다.');
        } else if(confirm("삭제하시겠습니까?")){
            var data = {
                'replyIdx' : $(this).data('idx')
                , 'status' : 1
            };
            util.getAjaxData("deleteFanBoard", "/rest/content/boardAdm/noticeReplyList/delete", data, function (dst_id, response) {
                alert(response.message);
                broadNoticeReply(noticeReplyPagingInfo.pageNo);
            });
        }
        return false;
    });

    $('#noticeReplayStatus').on('change', function () {
        broadNoticeReply();
    });

    $(document).on('change', '#dynamicPageCntBroadNoticeReply', function () {
        noticeReplyPagingInfo.pageCnt = $(this).val();
        broadNoticeReply();
    });

    $(document).on('click', '#allChkBroadNoticeReply', function(){
        var me = $(this);
        var checkboxs = $('._broadNoticeReply_chk:not(.disabled)');
        if(me.prop('checked')){
            checkboxs.prop('checked', true);
        }else{
            checkboxs.prop('checked', false);
        }
    });

    $(document).on('click', '#deleteBroadNoticeReplyBtn', function(){
        var checkboxs = $('._broadNoticeReply_chk:checked');
        if(checkboxs.length < 1){
            alert('삭제할 회원공지댓글을 선택해주세요.');
            return false;
        }

        if(confirm(checkboxs.length + '건을 삭제 하시겠습니까?')){

            var replyIdxs = '';
            checkboxs.each(function(){
                replyIdxs += $(this).data('idx') + ',';
            });
            var data = {
                replyIdxs : replyIdxs
            }

            util.getAjaxData('multiOperate', '/rest/content/boardAdm/noticeReplyList/multi/delete', data, function(dist_id, response){
                alert(response.message);
                broadNoticeReply(noticeReplyPagingInfo.pageNo);
            });
        }
    });
    
</script>

<script id="tmp_noticeReplyTable" type="text/x-handlebars-template">
    <table id="tb_noticeReply" class="table table-sorting table-hover table-bordered mt10">
        <colgroup>
            <col width="2%"/>
            <col width="2%"/>
            <col width="10%"/>
            <col width="5%"/>
            <col width="25%"/>
            <col width="3%"/>
            <col width="10%"/>
            <col width="5%"/>
            <col width="25%"/>
            <col width="3%"/>
            <col width="8%"/>
            <col width="4%"/>
        </colgroup>
        <thead>
        <tr>
            <th><input type="checkbox" class="form-control" id="allChkBroadNoticeReply" /></th>
            <th>No</th>
            <th>공지등록자</th>
            <th>성별</th>
            <th class="word-break" style="width: 220px">공지내용</th>
            <th>상태</th>
            <th>댓글등록자</th>
            <th>성별</th>
            <th class="word-break" style="width: 220px">댓글내용</th>
            <th>상태</th>
            <th>등록일시</th>
            <th>관리</th>
        </tr>
        </thead>
        <tbody>
        {{#each this.data as |data|}}
            <tr {{#dalbit_if replyInner '==' 1}} style="background-color : #dae3f3" {{/dalbit_if}}>
                <td><input type="checkbox" class="form-control _broadNoticeReply_chk {{#dalbit_if data.replyStatus '==' 1}}disabled{{/dalbit_if}}" {{#dalbit_if data.replyStatus '==' 1}}disabled{{/dalbit_if}} data-idx="{{replyIdx}}" /></td>
                <td>{{indexDesc ../pagingVo.totalCnt rowNum}}</td>
                <td>
                    {{{memNoLink memNo memNo}}}<br/>
                    {{memNick}}
                </td>
                <td>
                    {{{sexIconBr memSex memBirthYear}}}
                </td>
                <td class="word-break" style="width: 200px">
                    <span class="pull-left">{{replaceHtml contents}}</span>
                </td>
                <td>
                    {{#dalbit_if status '==' 0}}
                        정상
                    {{else}}
                        삭제
                    {{/dalbit_if}}
                </td>
                <td>
                    {{{memNoLink replyMemNo replyMemNo}}}<br/>
                    {{replyMemNick}}
                </td>
                <td>
                    {{{sexIconBr replyMemSex replyMemBirthYear}}}
                </td>
                <td class="word-break" style="width: 200px">
                    <span class="pull-left">{{replaceHtml replyContents}}</span>
                </td>
                <td>
                    {{#dalbit_if replyStatus '==' 0}}
                        정상
                    {{else}}
                        삭제
                    {{/dalbit_if}}
                </td>
                <td>{{writeDateFormat}}</td>
                <td><a href="javascript://" class="_deleteNoticeReply" data-idx="{{replyIdx}}" data-status="{{replyStatus}}">[삭제]</a></td>
            </tr>
        {{else}}
            <tr>
                <td colspan="12">{{isEmptyData}}</td>
            </tr>
        {{/each}}
        </tbody>
    </table>
</script>