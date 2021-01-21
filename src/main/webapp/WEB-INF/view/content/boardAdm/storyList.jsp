<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="dummyData"><%= java.lang.Math.round(java.lang.Math.random() * 1000000) %></c:set>

<!-- table -->
<div class="no-padding col-lg-12 form-inline">
    <div class="tab-content no-padding">
        <div class="col-md-12 no-padding mt10 mb5">
            <span class="mb5" id="storyListCnt"></span><br/>
            <select id="broState" name="broState" class="form-control searchType">
                <option value="0" selected="selected">방송상태 전체</option>
                <option value="1">방송 중</option>
                <option value="2">방송 종료</option>
            </select>

            <span id="dynamicPageCntArea"></span>

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
        <div class="tab-pane fade in active" id="storyList">
            <div class="widget-content">
                <div class="dataTables_paginate paging_full_numbers" id="story_paginate_top"></div>
                <div id="storyTable"></div>
                <div class="dataTables_paginate paging_full_numbers" id="story_paginate"></div>
            </div>
            <div class="widget-footer">
                <span>
                    <button class="btn btn-danger btn-sm print-btn" type="button" id="deleteStoryBtn"><i class="fa fa-check"></i>선택 삭제</button>
                </span>
            </div>
        </div>
    </div>
</div>
<!-- //table -->

<script type="text/javascript" src="/js/code/content/contentCodeList.js?${dummyData}"></script>
<script type="text/javascript">
    var StoryPagingInfo = new PAGING_INFO(0, 1, $("#dynamicPageCntStory").val());

    $(function(){
        $('#dynamicPageCntArea').html(util.renderDynamicPageCntSelect('dynamicPageCntStory'));
    });

    function storyList(pagingNo, _tabId) {

        if(!common.isEmpty(_tabId)){
            tabId = _tabId;
        }

        $('#title').html('사연검색');
        if(!common.isEmpty(pagingNo)){
            StoryPagingInfo.pageNo = pagingNo;
        }else{
            StoryPagingInfo.pageNo = 1;
        }

        if(!common.isEmpty(memNo) && memNo != null){
            txt_search = memNo;
        }else{
            txt_search = $('#txt_search').val();
        }


        var data = {
            'pageStart': StoryPagingInfo.pageNo
            , 'pageCnt' : StoryPagingInfo.pageCnt
            , 'txt_search' : txt_search
            // , 'searchType' : $('select[name="searchType"]').find('option:selected').val()
            , 'start_sel' : $("#startDate").val()
            , 'end_sel' : $("#endDate").val()
            , 'searchType' : 0
            , 'broState' : Number($("#broState option:selected").val())
        };

        util.getAjaxData("storyList", "/rest/content/boardAdm/storyList", data, function (dst_id, response, param) {
            var template = $('#tmp_storyTable').html();
            var templateScript = Handlebars.compile(template);
            var context = response;
            var html = templateScript(context);
            $('#storyTable').html(html);

            StoryPagingInfo.totalCnt = response.pagingVo.totalCnt;
            util.renderPagingNavigation('story_paginate_top', StoryPagingInfo);
            util.renderPagingNavigation('story_paginate', StoryPagingInfo);
            //StoryPagingInfo.pageNo=1;

            if(response.data.length == 0) {
                $("storyList").find("#story_paginate_top").hide();
                $("storyList").find('#story_paginate').hide();
            } else {
                $("storyList").find("#story_paginate_top").show();
                $("storyList").find('#story_paginate').show();
            }

            util.getAjaxData("storyListSummary", "/rest/content/boardAdm/storyList/summary", param, function(dst_id, response){
                $("#tab_storyList").text("사연" + "(" + response.data.totalCnt +")");
                $("#storyListCnt").html(
                    '<span style="color:black">[검색결과 : ' +  response.data.totalCnt + ' 건]</span>' +
                    '<span style="color: blue;"> [남' + response.data.maleCnt + " 건]</span>" + "," +
                    '<span style="color: red;"> [여' + response.data.femaleCnt + " 건]</span>" + "," +
                    '<span style="color: #555555;"> [알수없음' + response.data.noneCnt + " 건]</span>"
                );
            });
        });
    }

    $(document).on('click', '._deleteStory', function() {
        if(confirm('삭제하시겠습니까?')){
            var data = {
                storyIdx: $(this).data('storyidx')
                , room_no: $(this).data('roomno')
            };
            util.getAjaxData("deleteStory", "/rest/content/boardAdm/deleteStory", data, function(dst_id, response){
                alert(response.message);
                storyList(StoryPagingInfo.pageNo);
            });
        }
        return false;
    });

    $('#broState').on('change', function () {
        storyList();
    });

    $(document).on('change', '#dynamicPageCntStory', function () {
        StoryPagingInfo.pageCnt = $(this).val();
        storyList();
    });

    $(document).on('click', '#allChkStory', function(){
        var me = $(this);
        var checkboxs = $('._story_chk:not(.disabled)');
        if(me.prop('checked')){
            checkboxs.prop('checked', true);
        }else{
            checkboxs.prop('checked', false);
        }
    });

    $(document).on('click', '#deleteStoryBtn', function(){
        var checkboxs = $('._story_chk:checked');
        if(checkboxs.length < 1){
            alert('삭제할 사연을 선택해주세요.');
            return false;
        }

        if(confirm(checkboxs.length + '건을 삭제 하시겠습니까?')){

            var storyIdxs = '';
            checkboxs.each(function(){
                var idx = $(this).data('storyidx');

                storyIdxs += idx + ',';
            });
            var data = {
                storyIdxs : storyIdxs
            }

            util.getAjaxData('multiOperate', '/rest/content/boardAdm/multi/deleteStory', data, function(dist_id, response){
                alert(response.message);
                storyList(StoryPagingInfo.pageNo);
            });
        }
    });

</script>

<script id="tmp_storyTable" type="text/x-handlebars-template">
    <table id="tb_storyList" class="table table-sorting table-hover table-bordered mt10">

        <colgroup>
            <col width="3%"/><col width="5%"/><col width="17%"/><col width="7%"/><col width="5%"/>
            <col width="10%"/><col width="5%"/><col width="29%"/><col width="7%"/><col width="4%"/>
            <col width="3%"/>
        </colgroup>

        <thead>
        <tr>
            <th><input type="checkbox" class="form-control" id="allChkStory" /></th>
            <th>No</th>
            <th>방송중</th>
            <th>방송제목</th>
            <th>방송DJ</th>
            <th>DJ성별</th>
            <th>등록자</th>
            <th>성별</th>
            <th>사연내용</th>
            <th>등록일시</th>
            <th class="word-break">처리</th>
            <th class="word-break">삭제</th>
        </tr>
        </thead>

        <tbody>
        {{#each this.data as |data|}}
        <tr {{#dalbit_if send_inner '==' 1}} style="background-color : #dae3f3" {{/dalbit_if}}>
            <td><input type="checkbox" class="form-control _story_chk {{#dalbit_if status '==' 1}}disabled{{/dalbit_if}}" {{#dalbit_if status '==' 1}}disabled{{/dalbit_if}} data-storyidx="{{data.storyIdx}}" /></td>
            <td>{{indexDesc ../pagingVo.totalCnt rowNum}}</td>
            <td>
                {{#dalbit_if broState '!=' 4}}ON{{/dalbit_if}}
            </td>
            <td>
                {{{roomNoLink title room_no}}}
            </td>
            <td>
                {{^equal dj_mem_nick ''}}
                    {{{memNoLink ../dj_mem_no ../dj_mem_no}}}<br/>
                    {{../dj_mem_nick}}
                {{else}}
                (탈퇴한 회원)
                {{/equal}}
            </td>
            <td>
                {{{sexIcon dj_mem_sex dj_birth_year}}}
            </td>
            <td>
                {{^equal send_mem_nick ''}}
                    {{{memNoLink ../send_mem_no ../send_mem_no}}}<br/>
                    {{../send_mem_nick}}
                {{else}}
                (탈퇴한 회원)
                {{/equal}}
            </td>
            <td>
                {{{sexIcon send_mem_sex send_birth_year}}}
            </td>
            <td  class="word-break" style="width: 500px"><span class="pull-left">{{replaceHtml story_content}}</span></td>
            <td>{{convertToDate send_date "YYYY.MM.DD HH:mm:ss"}}</td>
            <td>
                {{#dalbit_if broState '==' 4}}
                    <span class="font-bold">종료됨</span>
                {{/dalbit_if}}
            </td>
            <td>
                <div style="width:45px;">
                    {{#dalbit_if status '==' 1}}
                        <span class="font-bold" style="color: red">삭제됨</span>
                    {{else}}
                        <a href="javascript://" class="_deleteStory" data-storyidx="{{data.storyIdx}}" data-roomno="{{data.room_no}}">[삭제]</a>
                    {{/dalbit_if}}

                </div>
            </td>
        </tr>
        {{else}}
        <tr>
            <td colspan="12">{{isEmptyData}}</td>
        </tr>
        {{/each}}
        </tbody>
    </table>
</script>