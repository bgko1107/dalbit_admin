<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div class="col-md-12 no-padding">
    <table class="table table-sorting table-bordered datatable">
        <colgroup>
        </colgroup>
        <thead>
        <tr>
            <th>순위</th>
            <th>주제<br/>제목</th>
            <th>이미지</th>
            <th>[듣기]<br/>녹음시간</th>
            <th>등록회원</th>
            <th>성별(나이)</th>
            <th>총점수</th>

            <th class="th_weekly" style="display: none">보상배지</th>
            <th class="th_weekly" style="display: none">배지시작</th>
            <th class="th_weekly" style="display: none">배지종료</th>

            <th>청취자</th>
            <th>청취수 (+1)</th>
            <th>선물 건(취소) (+2)</th>
            <th>좋아요(취소) (+3)</th>
            <th>댓글 (+10)</th>
            <th>소감</th>
        </tr>
        </thead>
        <tbody id="clipRankListTableBody"></tbody>
    </table>
</div>

<script type="text/javascript">

    function getClipRankList(){
        if(slctType == "4"){
            $(".th_weekly").show();
        }else{
            $(".th_weekly").hide();
        }

        var data = {
            startDate : $("#startDate").val()
            , endDate : $("#monthDate").val()
            , slctType : slctType
            , searchText : $("#searchText").val()
        };

        console.log(data);

        var template = $('#tmp_ClipRankListTable').html();
        var templateScript = Handlebars.compile(template);
        var html = templateScript();
        $("#clipRankListTableBody").html(html);

        util.getAjaxData("list", "/rest/clip/category/rank/list", data, fn_getClipRankList_success);
    }

    function fn_getClipRankList_success(data, response){

        response.data.slctType = slctType;

        var template = $('#tmp_ClipRankListTable').html();
        var templateScript = Handlebars.compile(template);
        var context = response.data;
        var html = templateScript(context);
        $("#clipRankListTableBody").html(html);

    }

</script>

<script type="text/x-handlebars-template" id="tmp_ClipRankListTable">
    {{#each this as |data|}}
    <tr>
        <td>{{rowNum}}</td>
        <td></td>
        <td style="width: 50px"><img class="thumbnail fullSize_background no-padding" src="{{renderProfileImage image_background}}" style='height:50px; width:50px;margin-bottom: 0px' /></td>
        <td>
            {{file_play}}<br />
            <a class="_openClipPlayerPop" id="play_{{castNo}}" data-clipNo="{{castNo}}" data-clipPath="{{file_path}}" href="javascript:;" >[ <i class="fa fa-play"></i> 듣기]</a>
        </td>
        <td>
            {{mem_nick}}<br/>
            <a href="javascript://" class="_openMemberPop" data-memno="{{memNo}}">{{mem_no}}</a>
        </td>
        <td>{{{sexIcon mem_sex mem_birth_year}}}</td>

        {{#dalbit_if ../slctType '==' 4}}<td></td>{{/dalbit_if}}
        {{#dalbit_if ../slctType '==' 4}}<td></td>{{/dalbit_if}}
        {{#dalbit_if ../slctType '==' 4}}<td></td>{{/dalbit_if}}

        <td></td>
        <td><a href="javascript://" class="_openClipInfoPop" data-clipNo="{{castNo}}" data-tabid="tab_listen">{{count_listener}}</a></td>
        <td><a href="javascript://" class="_openClipInfoPop" data-clipNo="{{castNo}}" data-tabid="tab_listen">{{count_play}}</a></td>
        <td><a href="javascript://" class="_openClipInfoPop" data-clipNo="{{castNo}}" data-tabid="tab_gift">{{count_gift}}</a></td>
        <td><a href="javascript://" class="_openClipInfoPop" data-clipNo="{{castNo}}" data-tabid="tab_good">{{count_good}}</a></td>
        <td><a href="javascript://" class="_selectReply" data-reply="{{count_reply}}" data-cast_no="{{cast_no}}">{{count_reply}}</a></td>
        <td>[소감보기]</td>
    </tr>
    {{else}}
    <tr>
        {{#dalbit_if ../slctType '==' 4}}
            <td colspan="16" class="noData">{{isEmptyData}}<td>
        {{else}}
            <td colspan="12" class="noData">{{isEmptyData}}<td>
        {{/dalbit_if}}
    </tr>
    {{/each}}
</script>