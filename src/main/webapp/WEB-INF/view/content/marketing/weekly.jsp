<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="dummyData"><%= java.lang.Math.round(java.lang.Math.random() * 1000000) %></c:set>

<!-- DATA TABLE -->
<div class="widget widget-table">
    <div class="widget-content">

        <div class="dataTables_paginate paging_full_numbers" id="weeklyList_info_paginate_top"></div>
        <div>
            <table id="weeklyList" class="table table-sorting table-hover table-bordered">
                <thead>
                <tr>
                    <th></th>
                    <th>No</th>
                    <th>회차</th>
                    <th>구분</th>
                    <th>제목</th>
                    <th>대상1</th>
                    <th class="_weekly_show">대상2</th>
                    <th>등록일시</th>
                    <th>조회수</th>
                    <th>게시상태</th>
                    <th>처리자명</th>
                </tr>
                </thead>
                <tbody id="weeklyList_tableBody"></tbody>
            </table>
        </div>
        <div class="dataTables_paginate paging_full_numbers" id="weeklyList_info_paginate"></div>
        <!-- DATA TABLE END -->
        <input type="button" value="선택 삭제" class="btn btn-danger btn-sm mb10" id="btn_delete"/>
        <input type="button" value="등록" class="btn btn-primary btn-sm mb10 pull-right" id="btn_regist"/>
    </div>
</div>

<div class="widget widget-table mt15" id="detailArea" style="display:none;">
    <div class="widget-header">
        <h3><i class="fa fa-desktop"></i> 세부사항</h3>
    </div>
    <div class="widget-content">
        <div id="wrapper">
            <form id="weeklyForm"></form>
        </div>
    </div>
</div>

<jsp:include page="/WEB-INF/view/common/util/select_memeberList.jsp"></jsp:include>

<script type="text/javascript" src="/js/code/menu/menuCodeList.js?${dummyData}"></script>
<script type="text/javascript">
    var weeklyPagingInfo = new PAGING_INFO(0,1,100);

    $(function (){
        getMarketingList();
    });

    $(document).on('click', '#btn_selectMember', function () {
        showPopMemberList(choiceMember);
    });

    function getMarketingList(tab_id){

        var is_weekly = tab_id != 'tab_second';

        util.getAjaxData("weeklyList", is_weekly ? "/rest/content/marketing/weekly/list" : "/rest/content/marketing/second/list" , dataSet(), function(data, response, params){
            var template = $('#tmp_weeklyList').html();
            var templateScript = Handlebars.compile(template);
            var context = response.data;
            var html = templateScript(context);
            $("#weeklyList_tableBody").html(html);

            if(tabId == 'tab_second'){
                $('._weekly_show').hide();
            }else{
                $('._weekly_show').show();
            }

            var pagingInfo = response.pagingVo;
            if(!common.isEmpty(pagingInfo)){
                weeklyPagingInfo.totalCnt = pagingInfo.totalCnt;
                util.renderPagingNavigation("weeklyList_info_paginate_top", weeklyPagingInfo);
                util.renderPagingNavigation("weeklyList_info_paginate", weeklyPagingInfo);
            }

        });
    }


    function handlebarsPaging(targetId, pagingInfo){
        weeklyPagingInfo = pagingInfo;
    }

    // // [수신대상 선택 - 지정회원] 회원 추가
    function choiceMember(data) {

        var html = '<a href="javascript://" class="_openMemberPop" data-memno="'+data.mem_no+'">'+data.mem_nick+'</a>';
        html += ' <a href="javascript://" class="_deleteMem _fontColor" data-fontColor="red"><i class="fa fa-trash-o"></i></a>';

        var regMemberLength = $("#weeklyForm").find('._openMemberPop').length;
        var tabId = $("#tablist_con li.active a").prop('id');

        if(tabId == 'tab_weekly' && regMemberLength == 2){
            alert("위클리픽은 최대 2명까지 지정 가능합니다.");
            return false;
        }

        if(tabId == 'tab_second' && regMemberLength == 1){
            alert("15초 광고 모델은 1명만 지정 가능합니다.");
            return false;
        }


        //이미 등록된 회원인지 체크
        if(0 < $('._openMemberPop[data-memno="'+data.mem_no+'"]').length){
            alert('이미 등록된 회원입니다.');
            return false;
        }

        $("#weeklyForm").find('._regMemberArea').each(function(){
           if($(this).find('._openMemberPop').length == 0){
               $(this).html(html);
               return false;
           }
        });

        ui.paintColor();
    }

    // [수신대상 선택 - 지정회원] 회원 삭제
    function delMember(dom) {
        dom.parent("span").remove();
    }

    function mobileBtnClick(tmp){
        if($("#mobileBtn").text() == "모바일형태"){
            $("#mobileBtn").text("PC형태");
            $('#div_editor').css({ width: 360});
        }else{
            $("#mobileBtn").text("모바일형태");
            $('#div_editor').css({ width: ''});
        }
    }
    $(document).on('click', '#deleteBtn', function(){
        $('.note-editable').empty();
    });

    $(document).on('click', '#insertBtn', function(){
        var data = generateData();
        if(confirm("등록하시겠습니까?")){
            util.getAjaxData("insert", "/rest/content/marketing/insert", data, fn_change_success);
        }
    });

    $(document).on('click', '#updateBtn', function(){
        var data = generateData();
        if(confirm("수정하시겠습니까?")){
            util.getAjaxData("update", "/rest/content/marketing/update", data, fn_change_success);
        }
    });

    function fn_change_success(dist_id, response, params){
        if(response.result == 'success'){
            alert(dist_id == 'update' ? '수정되었습니다.' : '등록되었습니다.');
            getDetail(dist_id == 'update' ? params.idx : response.data.idx);

            var tabId = $("#tablist_con li.active a").prop('id');

            getMarketingList(tabId);
        }

    }

    function generateData(){

        var notice_idx = $('#notice_idx');
        if(common.isEmpty(notice_idx.val())){
            alert('공지번호를 입력해주세요.');
            notice_idx.focus();
            return false;
        }

        var title = $("#title");
        if(common.isEmpty(title.val())){
            alert('제목을 입력해주세요.');
            title.focus();
            return false;
        }

        var round = $("#round");
        if(common.isEmpty(round.val())){
            alert('회차를 입력해주세요.');
            round.focus();
            return false;
        }


        var mem_no1 = '';
        var mem_no2 = '';

        $('._openMemberPop').each(function(){
            var mem_no = $(this).data('memno');
            if(common.isEmpty(mem_no1)){
                mem_no1 = mem_no;
            }else{
                mem_no2 = mem_no;
            }
        });

        var data = {
            idx : $('#idx').val()
            , notice_idx : notice_idx.val()
            , round : round.val()
            , title : title.val()
            , viewOn : $("#detail_viewOn").prop('checked') ? 1 : 0
            , mem_no1 : mem_no1
            , mem_no2 : mem_no2
            , slctType : $("#tablist_con li.active a").prop('id') == 'tab_weekly' ? 1 : 2
        }
        return data;
    }

    $(document).on('click', '._detail', function(){
        getDetail($(this).data('idx'))
    });

    $(document).on('click', '._deleteMem', function(){
        if(confirm('등록된 회원을 삭제하시겠습니까?')){
            $(this).parent().closest('._regMemberArea').html('회원을 검색하여 등록해주세요.');
        }
    });

    $(document).on('click', '#btn_regist', function(){
        var template = $('#tmp_weeklyForm').html();
        var templateScript = Handlebars.compile(template);

        var tabId = $("#tablist_con li.active a").prop('id');

        var data = {
            idx : ''
            , tabId : tabId
        }

        var context = data;
        var html = templateScript(context);
        $("#weeklyForm").html(html);

        $('#detailArea').show();
        if(tabId == 'tab_second'){
            $('._weekly_show').hide();
        }else{
            $('._weekly_show').show();
        }
        ui.paintColor();
    });

    $(document).on('click', '#btn_delete', function(){
        console.log('delete');
        var idxs = '';
        var checkedLength = $('._chk:checked').length;
        if(checkedLength == 0){
            alert('삭제할 게시물을 선택해주세요.');
            return false;
        }

        if(confirm(checkedLength + '건의 게시물을 삭제하시겠습니까?')){
            $('._chk:checked').each(function(){
                idxs += $(this).data('idx') + ','
            });

            var data = {
                idxs : idxs
            }
            util.getAjaxData("delete", "/rest/content/marketing/delete", data, function(data, response, params){

                if(response.result == 'success'){
                    alert('삭제되었습니다.');
                    var tabId = $("#tablist_con li.active a").prop('id');
                    getMarketingList(tabId);
                    $('#detailArea').hide();
                }

            });
        }
    });

    function getDetail(idx){
        var data = {
            idx : idx
        }
        util.getAjaxData("detail", "/rest/content/marketing/detail", data, function(data, response, params){
            var template = $('#tmp_weeklyForm').html();
            var templateScript = Handlebars.compile(template);

            var tabId = $("#tablist_con li.active a").prop('id');
            response.data.tabId = tabId;

            console.log(response.data)
            var context = response.data;
            var html = templateScript(context);
            $("#weeklyForm").html(html);

            $('#detailArea').show();
            if(tabId == 'tab_second'){
                $('._weekly_show').hide();
            }else{
                $('._weekly_show').show();
            }
            ui.paintColor();
        });
    }

</script>

<script type="text/x-handlebars-template" id="tmp_weeklyList">
    {{#each this as |user|}}
    <tr>
        <td><input type="checkbox" class="_chk" data-idx="{{idx}}" /></td>
        <td>{{rowNum}}</td>
        <td>{{round}}</td>
        <td>{{{getCommonCodeLabel slctType 'marketing_slct_type'}}}</td>
        <td><a href="javascript://" class="_detail" data-idx="{{idx}}">{{title}}</a></td>
        <td>{{mem_nick1}}</td>
        <td class="_weekly_show">{{mem_nick2}}</td>
        <td>{{writeDate}}</td>
        <td>{{addComma viewCnt}}</td>
        <td>{{viewOn}}</td>
        <td>{{opName}}</td>
    </tr>
    {{else}}
    <tr>
        <td colspan="11">{{isEmptyData}}</td>
    </tr>
    {{/each}}
</script>



<script id="tmp_weeklyForm" type="text/x-handlebars-template">
    <div class="col-md-12 no-padding">
        <span class="pull-right mt10 mb10">
            <button class="btn btn-default" type="button" id="mobileBtn" onclick="mobileBtnClick();">모바일형태</button>
            {{#if idx}}
                <button class="btn btn-default" type="button" id="updateBtn">수정하기</button>
            {{else}}
                <button class="btn btn-default" type="button" id="insertBtn">등록하기</button>
            {{/if}}
        </span>
    </div>
    <table class="table table-bordered table-dalbit">
        <colgroup>
        </colgroup>
        <tbody>
        <tr class="align-middle">
            <input type="hidden" name="idx" id="idx" value="{{idx}}" />
            <th>공지번호</th>
            <td><input class="form-control" type="text" id="notice_idx" value="{{notice_idx}}" /></td>
            <th>구분</th>
            <td>{{{getCommonCodeLabel slctType 'marketing_slct_type'}}}</td>
            <th>제목</th>
            <td>
                <input class="form-control" type="text" id="title" value="{{title}}" />
            </td>
            <th>조회수</th>
            <td>{{addComma viewCnt}}</td>
        </tr>
        <tr>
            <th>회차</th>
            <td>
                <input class="form-control" type="text" id="round" value="{{round}}" />
            </td>
            <th>등록일시<br />수정일시</th>
            <td>
                {{writeDate}} <br />
                {{updateDate}}
            </td>
            <th>등록자<br />수정자</th>
            <td>
                {{opName}}<br />
                {{lastOpName}}
            </td>
            <th>게시상태</th>
            <td>{{{getOnOffSwitch viewOn 'viewOn'}}}</td>
        </tr>
        <tr>
            <th>회원검색</th>
            <td>
                <input type="button" value="회원검색" class="btn btn-success btn-xs" id="btn_selectMember"/>
            </td>
            <th>등록회원1</th>
            <td class="_regMemberArea">
                {{#if mem_no1}}
                    <a href="javascript://" class="_openMemberPop" data-memno="{{mem_no1}}">{{mem_nick1}}</a>
                    <a href="javascript://" class="_deleteMem _fontColor" data-fontColor="red"><i class="fa fa-trash-o"></i></a>
                {{else}}
                    회원을 검색하여 등록해주세요.
                {{/if}}
            </td>

            {{#equal tabId 'tab_weekly'}}
                <th>등록회원2</th>
                <td class="_regMemberArea" colspan="3">
                    {{#if ../mem_no2}}
                        <a href="javascript://" class="_openMemberPop" data-memno="{{../mem_no2}}">{{../mem_nick2}}</a>
                        <a href="javascript://" class="_deleteMem _fontColor" data-fontColor="red"><i class="fa fa-trash-o"></i></a>
                    {{else}}
                        회원을 검색하여 등록해주세요.
                    {{/if}}
                </td>
            {{else}}
                <th></th>
                <td></td>
            {{/equal}}
        </tr>
        <tr>
            <th>내용</th>
            <td colspan="7">
                <div id="div_editor">
                    {{{replaceHtml contents}}}
                </div>
            </td>
        </tr>
        </tbody>
    </table>
</script>