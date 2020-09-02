<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!-- DATA TABLE -->
<div class="row col-lg-12 form-inline" id="winnerApplicant_table">
    <div class="widget widget-table">
        <input type="text" id="winner_eventIdx" name="winner_eventIdx" readonly/>
        <div class="widget-content">
            <table class="table table-bordered table-summary" id="list_winnerInfo" style="width: 500px">
                <thead></thead>
                <tbody></tbody>
            </table>

            <span id="winner_sortSlct"></span>
            <span id="winner_winSlct"></span>
            <label for="winner_duplicate"><input type="checkbox" id="winner_duplicate"/> 중복응모 숨기기</label>
            <%-- 0: 다보임, 1: 숨김 --%>

            <table id="list_eventWinnerApplicant" class="table table-sorting table-hover table-bordered">
                <thead></thead>
                <tbody></tbody>
            </table>
        </div>
    </div>
</div>

<div class="row col-lg-12 form-inline" id="winner_table">
    <div class="mt15">
        <div>• 당첨자 추가</div>
        <input type="text" class="form-control" id="registerEventWinner" style="width:50%;" placeholder="여러 회원번호를 업로드할 경우 '|'로 구분해주세요.">
        <button type="button" class="btn btn-default btn-sm mt15 mb15" id="bt_registerEventWinner">당첨자 추가</button>
    </div>
    <div>• 당첨자 리스트</div>
    <div class="widget widget-table">
        <input type="text" id="winnerList_eventIdx" name="winnerList_eventIdx" readonly/>
        <input type="text" id="winnerList_prizeIdx" name="winnerList_prizeIdx" readonly/>
        <div class="widget-content">
            <table id="list_eventWinner" class="table table-sorting table-hover table-bordered">
                <thead></thead>
                <tbody></tbody>
            </table>
        </div>
        <div class="widget-footer">
            <div class="mb15 form-inline pull-left">
                <button class="btn btn-danger btn-sm" type="button" id="bt_cancelEventWinner">당첨 취소</button>
            </div>
            <div class="mb15 form-inline pull-right">
                <button class="btn btn-default btn-sm" type="button" id="bt_tmpSaveWinner">임시저장</button>
                <button class="btn btn-default btn-sm" type="button" id="bt_completeSaveWinner"><i class="fa fa-floppy-o"></i>완료</button>
            </div>
        </div>
    </div>
</div>
<!-- DATA TABLE END -->

<script type="text/javascript" src="/js/code/content/contentCodeList.js?${dummyData}"></script>

<script type="text/javascript">

    var select_prizeRank;

    function initWinnerApplicant(index) {
        // input box에 eventIdx입력
        $('#winnerApplicant_table #winner_eventIdx').val(index);

        // 응모자/당첨자 정보
        winnerInfo(index);

        $('#winner_sortSlct').html(util.getCommonCodeSelect(0, event_winnerSortSlct));
        $('#winner_winSlct').html(util.getCommonCodeSelect(0, event_winnerWinSlct));

        var dtList_info_data = function(data) {
            data.eventIdx = index;
            data.sortSlct = $('#sortSlct').val();
            data.winSlct = $('#winSlct').val();
            data.duplicateHide = 0 // todo-수정 필요
        };
        var dtList_info = new DalbitDataTable($('#list_eventWinnerApplicant'), dtList_info_data, EventDataTableSource.eventWinnerApplicant);
        dtList_info.useCheckBox(false);
        dtList_info.useIndex(true);
        dtList_info.createDataTable();

        // 당첨자 리스트
        winnerList(index);
    }

    function winnerInfo(index) {
        var data = {
            eventIdx : index
        };
        util.getAjaxData("winnerInfo", "/rest/content/event/management/winner/info", data, function fn_eventWinnerInfo_success(dst_id, response) {
            var template = $('#tmp_list_winnerInfo').html();
            var templateScript = Handlebars.compile(template);
            var context = response.data;
            var html = templateScript(context);

            $('#list_winnerInfo').html(html);

            select_prizeRank = response.data.prizeRank;
        });
    }

    function winnerList(index) {
        $('#winner_table #winnerList_eventIdx').val(index);
        var dtList_info_data = function(data) {
            data.eventIdx = index;
        };
        var dtList_info_winner = new DalbitDataTable($('#list_eventWinner'), dtList_info_data, EventDataTableSource.eventWinner);
        dtList_info_winner.useCheckBox(false);
        dtList_info_winner.useIndex(true);
        dtList_info_winner.createDataTable();
    }


    $('#bt_registerEventWinner').on('click', function() {
        if(common.isEmpty($('#registerEventWinner').val())) {
            alert('당첨자 회원번호를 입력해주세요.');
            return false;
        }

        var winner = $('#registerEventWinner').val().split("|");
        var winnerCount = winner.length;

        if(confirm(winnerCount + "건의 당첨자 리스트를 추가하시겠습니까?")) {
            var data = {
                eventIdx : $('#winnerList_eventIdx').val()
                // , prizeIdx :
                // , applicantList : $('#registerEventWinner').val()
            };
        }
    });

</script>

<script id="tmp_list_winnerInfo" type="text/x-handlebars-template">
    <table class="table table-sorting table-hover table-bordered mt10">
        <thead>
            <tr class="align-middle">
                {{#each this as |info|}}
                    <th>{{info.prizeRank}}등 ({{info.prizeName}} / {{info.prizeIdx}})</th>
                {{/each}}
            </tr>
        </thead>
        <tbody>
            <tr class="align-middle">
                {{#each this as |info|}}
                    <td>{{info.winCnt}} / {{info.prizeCnt}}</td>
                {{/each}}
            </tr>
        </tbody>
    </table>
</script>