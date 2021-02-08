<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!-- 클립관리 > 클립내역관리 > 저작권 청취내역 -->
<div class="widget-content mt10">
    <span class="_searchDate" style="display: none;"></span>

    <div class="col-lg-12 no-padding">
        <span id="search_clipStateType" name="search_clipStateType" class="pull-left ml5"></span>
        <select id="search_clipSubjectType" name="search_clipSubjectType" class="form-control pull-left ml5"></select>
        <span id="search_clipOrderByType" name="search_clipOrderByType" class="pull-left ml5"></span>
    </div>
    <div class="col-lg-12 no-padding">
        <div class="dataTables_paginate paging_full_numbers" id="copyrightList_paginate_top"></div>
        <div id="clipCopyrightList"></div>
        <div class="dataTables_paginate paging_full_numbers" id="copyrightList_paginate"></div>
    </div>
</div>
<div class="widget-footer">
    <span>
        <button class="btn btn-default print-btn pull-right" type="button" id="excelDownBtn"><i class="fa fa-print"></i>Excel Down</button>
    </span>
</div>

<script type="text/javascript" src="/js/code/clip/clipCodeList.js?${dummyData}"></script>

<script type="text/javascript">
    var copyrightPagingInfo = new PAGING_INFO(0,1,50);

    var beforeClipStateType = 0;
    var beforeClipSubjectType = -1;
    var beforeOrderByType = 1;

    $(document).on('change', "#stateType_select, #search_clipSubjectType, #orderByType, #search_testId", function(){
        beforeClipStateType = $("#stateType_select").val();
        beforeClipSubjectType = $("#search_clipSubjectType").val();
        beforeOrderByType = $("#orderByType").val();

        initDataTable_clipCopyright();
    });

    $(function() {
    });

    function getHistoryCopyright() {

        $("#search_clipStateType").html(util.getCommonCodeSelect(beforeClipStateType, clip_copyright_searchStateType, 'N', 'stateType_select'));
        $("#search_clipOrderByType").html(util.getCommonCodeSelect(beforeOrderByType, clip_copyright_orderbyType, 'N', 'orderByType'));
        getClipSubjectCodeDefine();

        initDataTable_clipCopyright();
    }

    function initDataTable_clipCopyright() {
        var data = {
            searchDate : moment($('#startDate').val()).format("YYYY-MM-01")
            , stateType : Number($("#stateType_select").val())
            , subjectType : Number(common.isEmpty($("#search_clipSubjectType").val()) ? "-1" : $("#search_clipSubjectType").val())
            , orderType : Number($("#orderByType").val())
            , inner : $('input[name="search_testId"]').is(":checked") ? "0" : "1"
            , pageNo : copyrightPagingInfo.pageNo
            , pageCnt : copyrightPagingInfo.pageCnt
            , newSearchType : $("#searchClip").val()
        }
        util.getAjaxData("getHistoryCopyright", "/rest/clip/history/copyright/list", data, function fn_getHistoryCopyright_success(dst_id, response) {
            var template = $('#tmp_clipCopyrightList').html();
            var templateScript = Handlebars.compile(template);

            response.data.year = moment($('#startDate').val()).format("YYYY");
            response.data.month = moment($('#startDate').val()).format("MM");

            var context = response.data;
            var html = templateScript(context);

            $('#clipCopyrightList').html(html);

            copyrightPagingInfo.totalCnt = response.data.summary.totalCnt;
            util.renderPagingNavigation('copyrightList_paginate_top', copyrightPagingInfo);
            util.renderPagingNavigation('copyrightList_paginate', copyrightPagingInfo);

            if(response.data.length == 0) {
                $('#copyrightList_paginate_top').hide();
                $('#copyrightList_paginate').hide();
            } else {
                $('#copyrightList_paginate_top').show();
                $('#copyrightList_paginate').show();
            }

            selectCallback_clipHistoryCopyright(response.data.summary);
        });
    }

    function selectCallback_clipHistoryCopyright(data){
        var template = $('#tmp_headerInfo_clipHistoryCopyright').html();
        var templateScript = Handlebars.compile(template);
        var context = data;
        var html = templateScript(context);

        $("#headerInfo").html(html);
        $("#headerInfo").show();
        ui.paintColor();
    }

    $(document).on('click', '._adminCover', function() {
        var idx = $(this).data('idx');
        var clip_no = $(this).data('clipno');
        var admin_cover_title = $("#coverTitle_" + idx).val()
        var admin_cover_singer = $("#coverSinger_" + idx).val()

        function valid() {
            if(common.isEmpty(admin_cover_title)) {
                alert('수정할 커버 곡명을 입력해주세요.');
                return false;
            }
            if(common.isEmpty(admin_cover_singer)) {
                alert('수정할 커버 가수를 입력해주세요.');
                return false;
            }
            return true;
        }

        if(valid()) {
            if (confirm('수정하시겠습니까?')) {
                var data = {
                    cast_no : clip_no
                    , editSlct : 9
                    , admin_cover_title : admin_cover_title
                    , admin_cover_singer : admin_cover_singer
                }
                util.getAjaxData("saveAdminCoverInfo", "/rest/clip/history/info/edit", data, function(dist_id, response){
                    alert(response.message);
                });
            }
        }
    });

    function handlebarsPaging(targetId, pagingInfo){
        copyrightPagingInfo = pagingInfo;
        getHistoryCopyright();
    }

    function getClipSubjectCodeDefine(){
        var data = {};
        data.type="clip_type";
        data.order = "asc";
        data.is_ues = "1";
        util.getAjaxData("codeList", "/common/codeList", data, fn_ClipSubjectCode_success);
    }
    function fn_ClipSubjectCode_success(dst_id, response){
        var allData = {
            sel: ""
            , type: "clip_type"
            , value: "-1"
            , code: "주제(전체)"
            , order: "0"
            , is_use: "1"
        };
        response.data.unshift(allData);

        var template = $("#tmp_codeDefine").html();
        var templateScript = Handlebars.compile(template);
        var context = response.data;
        var html = templateScript(context);
        $("#search_clipSubjectType").html(html);

        $("#search_clipSubjectType").val(beforeClipSubjectType);
    }

    $('#excelDownBtn').on('click', function() {
        var formElement = document.querySelector("form");
        var formData = new FormData(formElement);
        formData.append("searchDate", moment($('#startDate').val()).format("YYYY-MM-01"));
        formData.append("stateType", $("#stateType_select").val());
        formData.append("subjectType", common.isEmpty($("#search_clipSubjectType").val()) ? "-1" : $("#search_clipSubjectType").val());
        formData.append("orderType", $("#orderByType").val());
        formData.append("inner", $('input[name="search_testId"]').is(":checked") ? "0" : "1");
        formData.append("pageNo", copyrightPagingInfo.pageNo);
        util.excelDownload($(this), "/rest/clip/history/copyright/listExcel", formData, function fn_success_excel() {
            console.log("fn_success_excel");
        });
    });
</script>

<script id="tmp_codeDefine" type="text/x-handlebars-template">
    <select name="slctType" id="slctType" class="form-control">
        {{#each this as |sub|}}
            <option value="{{sub.value}}">{{sub.code}}</option>
        {{/each}}
    </select>
</script>

<script id="tmp_clipCopyrightList" type="text/x-handlebars-template">
    <table id="clip_history_copyright_list_info" class="table table-sorting table-hover table-bordered">
        <colgroup>
            <col width="2%"/>
            <col width="5%"/>
            <col width="5%"/>
            <col width="5%"/>
            <col width="5%"/>
            <col width="5%"/>
            <col width="5%"/>
            <col width="5%"/>
            <col width="5%"/>
            <col width="5%"/>
            <col width="5%"/>
            <col width="5%"/>
            <col width="5%"/>
            <col width="5%"/>
        </colgroup>
        <thead>
        <tr>
            <th>No.</th>
            <th>회원번호</th>
            <th>주제</th>
            <th>녹음시간<br />[듣기]</th>
            <th>클립정보</th>
            <th>등록일시</th>
            <th>커버 곡명<br />(관리자)</th>
            <th>커버 가수<br />(관리자)</th>
            <th>저장</th>
            <th>UCI코드</th>
            <th>청취 횟수</th>
            <th>상태</th>
        </tr>
        </thead>
        <tbody>
        {{#each this.list as |data|}}
            <tr>
                <td>{{rowNum}}</td>
                <td>{{{memNoLink mem_no mem_no}}} <br />{{nickName}}</td>
                <td>{{{getCommonCodeLabel subjectType 'clip_copyright_subjectType'}}}</td>
                <td>{{playTime}}
                    <br /> <a href="javascript://" class="_openClipPlayerPop" data-clippath="{{filePath}}" data-clipno="{{cast_no}}">[ <i class="fa fa-play"></i> 듣기]</a>
                </td>
                <td>
                    <a href="javascript://" class="_openClipInfoPop" data-clipno="{{cast_no}}">{{cast_no}}</a>
                    <br />{{title}}
                </td>
                <td>{{convertToDate regDate "YYYY-MM-DD"}}</td>
                <td><input type="text" class="form-control _trim" id="coverTitle_{{clipIdx}}" value="{{{adminCoverTitle}}}" maxlength="50" /></td>
                <td><input type="text" class="form-control _trim" id="coverSinger_{{clipIdx}}" value="{{{adminCoverSinger}}}" maxlength="50" /></td>
                <td><button type="button" class="_adminCover btn btn-primary" data-idx="{{clipIdx}}" data-clipno="{{cast_no}}">저장</button></td>
                <td>{{uciAlbumCode}}</td>
                <td>
                    {{^equal playCnt '0'}}
                    <a href="javascript://" class="_openClipCopyrightDetailPop" data-clipno="{{../cast_no}}" data-year="{{../../year}}" data-month="{{../../month}}">{{addComma ../playCnt}}</a>
                    {{/equal}}
                    {{#equal playCnt '0'}}{{/equal}}
                </td>
                <td>
                    {{#dalbit_if state '==' '1'}} 정상 {{/dalbit_if}}
                    {{#dalbit_if state '==' '4'}} <span style="color:red;font-weight:bold">삭제</span> {{/dalbit_if}}
                    {{#dalbit_if state '==' '5'}} <span style="color:red;font-weight:bold">삭제</span> <br /> ({{opName}}) {{/dalbit_if}}
                </td>
            </tr>
        {{else}}
            <tr>
                <td colspan="13" class="noData">{{isEmptyData}}</td>
            </tr>
        {{/each}}
        </tbody>
    </table>
</script>

<script type="text/x-handlebars-template" id="tmp_headerInfo_clipHistoryCopyright">
    <table class="table table-bordered _tableHeight" data-height="23px">
        <colgroup>
            <col width="16%"/><col width="16%"/><col width="16%"/>
            <col width="16%"/><col width="16%"/>
        </colgroup>
        <thead>
        <tr>
            <th colspan="5" class="_bgColor _fontColor" data-bgcolor="black" data-fontcolor="white">총 예상 지불 금액 : 원 </th>
        </tr>
        <tr>
            <th class="_bgColor" data-bgcolor="#dae3f3">등록자 수</th>
            <th class="_bgColor" data-bgcolor="#dae3f3">클립 개수</th>
            <th class="_bgColor" data-bgcolor="#dae3f3">총 청취 횟수</th>
            <th class="_bgColor" data-bgcolor="#dae3f3">예상 지불 금액 <br />(음악 실연자 연합회)</th>
            <th class="_bgColor" data-bgcolor="#dae3f3">예상 지불 금액 <br />(음악 저작권 협회)</th>
        </tr>
        </thead>
        <tbody>
        <tr>
            <td>{{addComma regCnt}} 명</td>
            <td>{{addComma totalClip}} 개</td>
            <td>{{addComma totalPlayCnt}} 회</td>
            <td></td>
            <td></td>
        </tr>
        </tbody>
    </table>
</script>