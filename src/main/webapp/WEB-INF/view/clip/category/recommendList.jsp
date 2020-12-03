<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div class="widget widget-table">
    <div class="widget-content">
        <button type="button" class="btn btn-success btn-ms pull-left" onclick="recommendAdd();">등록</button>
        <div class="col-md-12 no-padding">
            <table class="table table-bordered _tableHeight" data-height="23px">
                <colgroup>
                </colgroup>
                <thead>
                <tr>
                    <th>선택</th>
                    <th>추천 주간</th>
                    <th>대표 클립</th>
                    <th>주제<br/>제목</th>
                    <th>첨부영상</th>
                    <th>소개글</th>
                    <th>이미지</th>
                    <th>[듣기]녹음시간</th>
                    <th>등록회원</th>
                    <th>성별(나이)</th>
                    <th>공개 혜택</th>
                    <th>인증</th>
                    <th>청취자</th>
                    <th>청취 수</th>
                    <th>선물 건</th>
                    <th>좋아요</th>
                    <th>댓글</th>
                    <th>게시상태</th>
                </tr>
                </thead>
                <tbody id="recommendListTableBody"></tbody>
            </table>
        </div>
    </div>
</div>

<script type="text/javascript">

    function getRecommendList(){
        var data = {
            yearMonth : $("#monthDate").val().replace(".","")
            ,searchText : $("#searchText").val()
        };

        console.log(data);

        util.getAjaxData("list", "/rest/clip/category/recommend/list", data, fn_getRecommendList_success);
    }

    function fn_getRecommendList_success(data, response){

        var template = $('#tableDayBody_detailDetail').html();
        var templateScript = Handlebars.compile(template);
        var context = response.data;
        var html = templateScript(context);
        $("#recommendListTableBody").html(html);

        monthRowspan("weekly");
        weeklyCheckRowspan("weeklyCheck");
    }

    function monthRowspan(className){
        $("." + className).each(function() {
            var rows = $("." + className + ":contains('" + $(this).text() + "')");
            if (rows.length > 1) {
                rows.eq(0).attr("rowspan", rows.length);
                rows.not(":eq(0)").remove();
            }
        });
    }

    function weeklyCheckRowspan(className){
        $("." + className).each(function() {
            var rows = $("." + className + ":contains('" + $(this).text() + "')");
            if (rows.length > 1) {
                rows.eq(0).attr("rowspan", rows.length);
                rows.not(":eq(0)").remove();
            }
        });
    }

    function recommendAdd(){
        location.href = "/clip/category/recommendClip";
    }

    // 댓글 목록 리스트
    $(document).on('click', '._openRecommendDetail', function() {
        location.href = "/clip/category/recommendClip?yearMonth="+$(this).data('yearmonth')+"&weekNo=" + $(this).data('weekno')+"&groupNo=" + $(this).data('groupno');
    });

</script>

<script type="text/x-handlebars-template" id="tableDayBody_detailDetail">
    {{#each this as |data|}}
    <tr>
        <td class="weeklyCheck">
            <span style="display: none">{{year_month}} {{week_no}} {{group_no}}</span>
            <input type="checkbox" class="form-control _check" />
        </td>
        <td class="weekly">
            <a href="javascript://" class="_openRecommendDetail" data-yearmonth="{{year_month}}" data-weekno="{{week_no}}" data-groupno="{{group_no}}">{{year_month}} - {{week_no}} 주차</a>
            <span style="display: none">{{group_no}}</span>
        </td>
        <td>
            {{#dalbit_if leader_yn '==' 1}}
                O
            {{/dalbit_if}}
        </td>
        <td>
            {{{getCommonCodeLabel subject_type 'clipSubjectType'}}}<br/>
            <a href="javascript://" class="_openClipInfoPop" data-clipNo="{{cast_no}}">{{title}}</a>
        </td>
        <td>{{video_url}}</td>
        <td>{{desc_msg}}</td>
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
        <td></td>
        <td>
            {{#dalbit_if confirm '==' 1}}
                Y
            {{else}}
                N
            {{/dalbit_if}}
            <br/>
            <a href="javascript:;" onclick="recommendConfirmEdit($(this).data())" data-castno="{{cast_no}}" data-confirm="{{confirm}}">
                {{#dalbit_if confirm '==' 1}}
                    [해제]
                {{else}}
                    [등록]
                {{/dalbit_if}}
            </a>
        </td>
        <td><a href="javascript://" class="_openClipInfoPop" data-clipNo="{{castNo}}" data-tabid="tab_listen">{{count_listener}}</a></td>
        <td><a href="javascript://" class="_openClipInfoPop" data-clipNo="{{castNo}}" data-tabid="tab_listen">{{count_play}}</a></td>
        <td><a href="javascript://" class="_openClipInfoPop" data-clipNo="{{castNo}}" data-tabid="tab_gift">{{count_gift}}</a></td>
        <td><a href="javascript://" class="_openClipInfoPop" data-clipNo="{{castNo}}" data-tabid="tab_good">{{count_good}}</a></td>
        <td><a href="javascript://" class="_selectReply" data-reply="{{count_reply}}" data-cast_no="{{cast_no}}">{{count_reply}}</a></td>
        <td>{{view_yn}}</td>
    </tr>
    {{/each}}
</script>