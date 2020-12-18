<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div class="col-md-12 no-padding mt10 mb10">
    <a href="/content/push/list" id="tab_push" class="btn btn-default btn-ms pull-right">푸시 메시지 발송</a>
    <button type="button" class="btn btn-success btn-ms pull-right mr5" onclick="recommendAdd();">등록</button>
    <button type="button" class="btn btn-danger btn-ms pull-right mr5" onclick="recommendDel();">삭제</button>
</div>
<div class="col-md-12 no-padding">
    <table class="table table-sorting table-bordered datatable">
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
            <th>[듣기]<br/>녹음시간</th>
            <th>등록회원</th>
            <th>성별(나이)</th>
            <th>공개</th>
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
    function recommendDel(){
        var checked = $('#recommendListTableBody > tr > td > input[type=checkbox]:checked');
        if(checked.length == 0) {
            alert('삭제할 달대리 추천 클립을 선택해주세요.');
            return false;
        }
        if(confirm('선택한 달대리 추천 클립을 삭제 하시겠습니까?')) {
            var yearMonth = "";
            var weekno = "";
            var groupno = "";
            checked.each(function () {
                yearMonth += $(this).parent().parent().find('._check').data('yearmonth') + "@@";
                weekno += $(this).parent().parent().find('._check').data('weekno') + "@@";
                groupno += $(this).parent().parent().find('._check').data('groupno') + "@@";
            });

            var data = {
                yearMonthList: yearMonth
                , weekNoList: weekno
                , groupNoList: groupno
            };

            util.getAjaxData("delete", "/rest/clip/category/recommend/delete", data, fn_getRecommendDelete_success);
        }
    }

    function fn_getRecommendDelete_success(dst_id, response){
        if(response.result == "success"){
            alert("달대리 추천 클립 삭제 성공.");
        }
        $("#bt_search").click();
    }


    // 달대립 추천 클립 상세 정보
    $(document).on('click', '._openRecommendDetail', function() {
        location.href = "/clip/category/recommendClip?yearMonth="+$(this).data('yearmonth')+"&weekNo=" + $(this).data('weekno')+"&groupNo=" + $(this).data('groupno');
    });

</script>

<script type="text/x-handlebars-template" id="tableDayBody_detailDetail">
    {{#each this as |data|}}
    <tr>
        <td class="weeklyCheck">
            <span style="display: none">{{year_month}} {{week_no}} {{group_no}}</span>
            <input type="checkbox" class="form-control _check" data-yearmonth="{{year_month}}" data-weekno="{{week_no}}" data-groupno="{{group_no}}"/>
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
        <td>{{{replaceEnter desc_msg}}}</td>
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
        <td>
            {{#dalbit_if type_open '==' 1}}
                YES
            {{else}}
                NO
            {{/dalbit_if}}
        </td>
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
    {{else}}
    <tr>
        <td colspan="17" class="noData">{{isEmptyData}}<td>
    </tr>
    {{/each}}
</script>