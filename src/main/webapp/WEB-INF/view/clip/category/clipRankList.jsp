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
            <th style="color: red;">총 점수</th>

            <th class="th_weekly" style="display: none">보상배지</th>
            <th class="th_weekly" style="display: none">배지시작</th>
            <th class="th_weekly" style="display: none">배지종료</th>

            <th>청취자</th>
            <th>청취 수<br/>(+1)</th>
            <th>선물 별<br/>(+2)</th>
            <th>좋아요<br/>(+3)</th>
            <%--<th>댓글<br/>(+10)</th>--%>
            <th class="th_weekly" style="display: none">소감</th>
        </tr>
        </thead>
        <tbody id="clipRankListTableBody"></tbody>
    </table>
</div>


<div class="modal fade" id="winnerMsgModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog" style="width: 300px;">
        <div class="modal-content">
            <div class="modal-header">
                <span class="font-bold">◈ 소감보기</span>
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
            </div>
            <div class="modal-body" style="display: table">
                <span class="font-bold" id="clipName_nick"></span>
                <div class="col-md-12">
                    <textarea type="textarea" class="form-control" id="txt_winnerMsg" style="width: 200px; height: 180px; margin: 0px;"></textarea>
                </div>
            </div>
        </div>
    </div>
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
            , rankingDate : $("#startDate").val()
            , endDate : $("#monthDate").val()
            , slctType : $('input:radio[name="rankType"]:checked').val()
            , searchText : $("#searchText").val()
            , searchType : -1
            , newSearchType : $("#searchClip").val();
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
    function winnerMsgClick(data){
        console.log("------------------------------------");
        console.log(data.data('winnermsg'));
        $('#winnerMsgModal').modal("show");
        $("#clipName_nick").html(data.data('title') + " - " + data.data('nickname'));
        $("#txt_winnerMsg").val(data.data('winnermsg'));
    }

</script>

<script type="text/x-handlebars-template" id="tmp_ClipRankListTable">
    {{#each this as |data|}}
    <tr>
        <td>{{rowNum}}</td>
        <td>
            {{subjectName}}<br/>
            <a href="javascript://" class="_openClipInfoPop" data-clipNo="{{cast_no}}">{{title}}</a>
        </td>
        <td style="width: 50px"><img class="thumbnail fullSize_background no-padding" src="{{renderProfileImage backgroundImage}}" style='height:50px; width:50px;margin-bottom: 0px' /></td>
        <td>
            {{filePlay}}<br />
            <a class="_openClipPlayerPop" id="play_{{cast_no}}" data-clipNo="{{cast_no}}" data-clipPath="{{filePath}}" href="javascript:;" >[ <i class="fa fa-play"></i> 듣기]</a>
        </td>
        <td>
            {{mem_nick}}<br/>
            <a href="javascript://" class="_openMemberPop" data-memno="{{mem_no}}">{{mem_no}}</a>
        </td>
        <td>{{{sexIcon mem_sex mem_birth_year}}}</td>
        <th style="color: red;">{{clipPoint}}</th>
        {{#dalbit_if ../slctType '==' 4}}<td>{{rewardBadge}}</td>{{/dalbit_if}}
        {{#dalbit_if ../slctType '==' 4}}<td>{{startBadge}}</td>{{/dalbit_if}}
        {{#dalbit_if ../slctType '==' 4}}<td>{{endBadge}}</td>{{/dalbit_if}}

        <td><a href="javascript://" class="_openClipInfoPop" data-clipNo="{{cast_no}}" data-tabid="tab_listen">{{listenerCnt}}</a></td>
        <td><a href="javascript://" class="_openClipInfoPop" data-clipNo="{{cast_no}}" data-tabid="tab_listen">{{listenPoint}}</a></td>
        <td><a href="javascript://" class="_openClipInfoPop" data-clipNo="{{cast_no}}" data-tabid="tab_gift">{{giftPoint}}</a></td>
        <td><a href="javascript://" class="_openClipInfoPop" data-clipNo="{{cast_no}}" data-tabid="tab_good">{{goodPoint}}</a></td>
        <%--<td><a href="javascript://" class="_selectReply" data-reply="{{replyPoint}}" data-cast_no="{{cast_no}}">{{replyPoint}}</a></td>--%>
        {{#dalbit_if ../slctType '==' 4}}
        <td>
            {{#dalbit_if rowNum '<' 4}}
                <a href="javascript://" data-title="{{title}}" data-nickname="{{mem_nick}}" data-winnermsg="{{winnerMsg}}" onclick="winnerMsgClick($(this))">[소감보기]</a>
            {{else}}
                -
            {{/dalbit_if}}
        </td>
        {{/dalbit_if}}
    </tr>
    {{else}}
    <tr>
        {{#dalbit_if ../slctType '==' 4}}
            <td colspan="16" class="noData">{{isEmptyData}}<td>
        {{else}}
            <td colspan="10" class="noData">{{isEmptyData}}<td>
        {{/dalbit_if}}
    </tr>
    {{/each}}
</script>