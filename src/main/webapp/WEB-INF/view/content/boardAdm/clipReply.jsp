<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="dummyData"><%= java.lang.Math.round(java.lang.Math.random() * 1000000) %></c:set>

<!-- table -->
<div class="col-lg-12 no-padding">
    <div class="widget-content">
        <div class="col-md-12 no-padding mt10">
            <span id ="clipReplyListCnt"></span><br/>
            <select id="clipReplayStatus" name="clipReplayStatus" class="form-control searchType">
                <option value="0" selected="selected">게시글 전체</option>
                <option value="1">정상</option>
                <option value="2">삭제</option>
            </select>

            <span id="dynamicPageClipReplyArea"></span>

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
                <col width="5%"/>
                <col width="10%"/>
                <col width="8%"/>
                <col width="15%"/>
                <col width="10%"/>
                <col width="8%"/>
                <col width="25%"/>
                <col width="5%"/>
                <col width="5%"/>
                <col width="4%"/>
                <col width="5%"/>
            </colgroup>
            <thead>
                <tr>
                    <th><input type="checkbox" class="form-control" id="allChkClipReply" /></th>
                    <th>No</th>
                    <th>클립 주인</th>
                    <th>성별</th>
                    <th>클립 제목</th>
                    <th>댓글등록자</th>
                    <th>성별</th>
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
    <div class="widget-footer">
        <span>
            <button class="btn btn-danger btn-sm print-btn" type="button" id="deleteClipReplyBtn"><i class="fa fa-check"></i>선택 삭제</button>
        </span>
    </div>
</div>
<!-- //table -->

<script type="text/javascript" src="/js/code/content/contentCodeList.js?${dummyData}"></script>
<script type="text/javascript">
    var clipPagingInfo = new PAGING_INFO(0,1,$("#dynamicPageCntClipReply").val());

    $(function() {
        $("#dynamicPageClipReplyArea").html(util.renderDynamicPageCntSelect('dynamicPageCntClipReply'));
    });

    var memNo;
    function clipReplyList(pagingInfo, _tabId) {

        if(!common.isEmpty(_tabId)){
            tabId = _tabId;
        }

        $('#title').html('클립댓글');
        if(!common.isEmpty(pagingInfo)){
            clipPagingInfo.pageNo = pagingInfo;
        }else{
            clipPagingInfo.pageNo = 1;
        }

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
            , 'status' : Number($("#clipReplayStatus option:selected").val())
            , 'newSearchType' : $("#searchMember").val()
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
            util.getAjaxData("delete", "/rest/content/boardAdm/clipReplyList/del", data, function(dst_id, response){
                alert(response.message);
                clipReplyList(clipPagingInfo.pageNo);
            });
        }else return;
    });

    $('#clipReplayStatus').on('change', function () {
        clipReplyList();
    });

    $(document).on('change', '#dynamicPageCntClipReply', function () {
        clipPagingInfo.pageCnt = $(this).val();
        clipReplyList();
    });

    $(document).on('click', '#allChkClipReply', function(){
        var me = $(this);
        var checkboxs = $('._clipReply_chk:not(.disabled)');
        if(me.prop('checked')){
            checkboxs.prop('checked', true);
        }else{
            checkboxs.prop('checked', false);
        }
    });

    $(document).on('click', '#deleteClipReplyBtn', function(){
        var checkboxs = $('._clipReply_chk:checked');
        if(checkboxs.length < 1){
            alert('삭제할 회원 프로필을 선택해주세요.');
            return false;
        }

        if(confirm(checkboxs.length + '건을 삭제 하시겠습니까?')){

            var castReplyIdxs = '';
            var cast_nos = '';
            checkboxs.each(function(){
                castReplyIdxs += $(this).data('castreplyidx') + ',';
                cast_nos += $(this).data('castno') + ',';
            });
            var data = {
                castReplyIdxs : castReplyIdxs
                , cast_nos : cast_nos
            }

            util.getAjaxData('multiOperate', '/rest/content/boardAdm/clipReplyList/multi/del', data, function(dist_id, response){
                alert(response.message);
                clipReplyList(clipPagingInfo.pageNo);
            });
        }
    });
    
</script>

<script id="tmp_clipReplyTable" type="text/x-handlebars-template">
    {{#each this.data as |data|}}
        <tr {{#dalbit_if writer_inner '==' 1}} style="background-color : #dae3f3" {{/dalbit_if}}>
            <td><input type="checkbox" class="form-control _clipReply_chk {{#dalbit_if status '!=' 1}}disabled{{/dalbit_if}}" {{#dalbit_if status '!=' 1}}disabled{{/dalbit_if}} data-castno="{{data.cast_no}}" data-castreplyidx="{{data.castReplyIdx}}" /></td>
            <td>{{indexDesc ../pagingVo/totalCnt rowNum}}</td>
            <td>
                {{{memNoLink cast_mem_no cast_mem_no}}}<br/>
                {{cast_mem_nick}}
            </td>
            <td>
                {{{sexIcon cast_mem_sex cast_birth_year}}}<br/>
            </td>
            <td>{{title}}</td>
            <td>
                {{{memNoLink writer_mem_no writer_mem_no}}}<br/>
                {{writer_mem_nick}}
            </td>
            <td>
                {{{sexIcon writer_mem_sex writer_birth_year}}}
            </td>
            <td class="word-break" style="width: 350px"><span class="pull-left">{{{replaceHtml contents}}}</span></td>
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
            <td colspan="12">{{isEmptyData}}</td>
        </tr>
    {{/each}}
</script>
